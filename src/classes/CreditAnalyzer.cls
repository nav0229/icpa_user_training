/****************************************************************
 Name:  CreditAnalyzer()
============================================================
Author:Kevin/Prathyusha/Lenny
Purpose: JIRA#1336 
Evaluates Credit Anlysis Test. This class is invoked from the Process Builder
when the Application status is updated to Exception Testing
============================================================

****************************************************************/

public with sharing class CreditAnalyzer {

    private static final String CREDIT_ANALYSIS_TEST_PASS = 'Pass';
    private static final String CREDIT_ANALYSIS_TEST_FAIL = 'Fail';

    private static final String ACCOUNT_CONDITION_DEEDLIEU = 'DEEDLIEU';
    private static final String ACCOUNT_CONDITION_FORECLOS = 'FORECLOS';
    private static final String ACCOUNT_CONDITION_CHSUPJUDG = 'CH SUP JUDG';
    private static final String ACCOUNT_CONDITION_FEDTAX_LIEN = 'FED TAX LIEN';
    private static final String ACCOUNT_CONDITION_OPEN_CODE = 'A1'; 
    private static final String IRS_ISSUE_TEXT_IRS_OFFSET = 'IRS Offset';
    private static final String CBR_LINE_ITEM_TYPE ='Public Record';    
    private static final String PAYMENT_STATUS_FORECLOS= 'FORECLOS';    
    

    private static final Set<String> brAccountConditionCodes = new Set<String>{
        'BK 7-PETIT',
        'BK 13-PETIT',
        'BK 7-DISCHG',
        'BK 13-DISCHG'
    };

    private static final Set<String> paymentStatusCodes = new Set<String>{      
        '71',
        '72',
        '73',
        '74',
        '75',
        '76',
        '77',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '79',
        '80',
        '81',
        '82',
        '83',
        '84'
    };

    private static final Set<String> purposeOfAccountCodes = new Set<String>{       
        '12',
        '93',
        '50'
    };

    private static final Set<String> accountConditionCodes = new Set<String>{       
        'CH SUP JUDG',
        'FED TAX LIEN',
        'BK 7-PETIT',
        'BK 13-PETIT',
        'BK 7-DISCHG',
        'BK 13-DISCHG',
        '89',
        '94',
        '97'
    };

    @TestVisible
    private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

    @TestVisible
    private static CreditBureauLineItemDAO creditBureauLineItemDA = new CreditBureauLineItemDataAccessor();

    @TestVisible
    private static ProcessingApplicationReviewDAO processingApplicationReviewDA = new ProcessingApplicationReviewDataAccessor();

    /****************************************************************
        Purpose:  Main method that runs business logic to evaluate credit analysis test. 
        The data is pulled from CBR Line Items, SBA Loan History, Application questions , IRS transcripts Data entities.                                                     
        Parameters: List of Application Ids
        Returns: N/A
     ****************************************************************/

    @InvocableMethod(label='Run Credit Analysis' description='Runs tests to determine credit eligibility')
    public static void runCreditAnalysis(List<Id> appIds){
        if(appIds.isEmpty()){
            return ;
        }
       
        Map<Id,Boolean> appIDCreditAnalysisTestResultMap =  runCreditAnalysisBulkTest(appIds);

        System.debug('Map----'+appIDCreditAnalysisTestResultMap);
        
        if(appIDCreditAnalysisTestResultMap!=null && appIDCreditAnalysisTestResultMap.keyset().size()>0){
            updateCreditAnalysisResults(appIDCreditAnalysisTestResultMap);
        }
        else{
            throw new applicationException('There are no applications to update. An error occurred during Credit Anaysis test'); 
        }
    }

     /****************************************************************
        Purpose:  This method updates the credit analysis test results on the Application record 
        Parameters: Map of Application Id TO Test result
        Returns: N/A
     ****************************************************************/
    private static void updateCreditAnalysisResults(Map<Id,Boolean> appIDCreditAnalysisTestResultMap){
        try{
            List<Id> appIds = new List<Id>(appIDCreditAnalysisTestResultMap.keyset());
            List<Processing_Application_Review__c> updatedProcessingAppReview = 
                    processingApplicationReviewDA.getProcessingApplicationReviewsByAppIds(appIds);
            for(Processing_Application_Review__c review: updatedProcessingAppReview){   
                String resultText =appIDCreditAnalysisTestResultMap.get(review.Application__c)?CREDIT_ANALYSIS_TEST_PASS:CREDIT_ANALYSIS_TEST_FAIL;  
                review.Credit_Analysis_Test__c=resultText;
                review.Credit_Analysis_Result_Date__c=System.NOW();
            }
            processingApplicationReviewDA.updateProcessingApplicationReviews(updatedProcessingAppReview); 
        }catch (QueryException e) {
            throw new QueryException('An error occurred during Credit Analysis test update of Processing Application Review : '+e.getMessage());
        }
    } 

    /****************************************************************
        Purpose:  This method queries Credit Line Item records by App Ids
        Parameters: List of Application IDs
        Returns: Map<ApplicationId,List<Credit_Bureau_Line_Item__c>>
     ****************************************************************/
    private static Map<Id,List<Credit_Bureau_Line_Item__c>> getAppIdCreditBureauLineItemsMap(List<Id> appIds){
        Map<Id,List<Credit_Bureau_Line_Item__c>> appIdToCBRLineItemsMap = new Map<Id,List<Credit_Bureau_Line_Item__c>>();
        try{
            for(Credit_Bureau_Line_Item__c cli:creditBureauLineItemDA.getActiveCreditBureauLineItemsByApplicationIds(appIds, purposeOfAccountCodes, 
                paymentStatusCodes, accountConditionCodes, PAYMENT_STATUS_FORECLOS))
            {
                if(appIdToCBRLineItemsMap.containsKey(cli.Credit_Bureau__r.Application__c)){
                    appIdToCBRLineItemsMap.get(cli.Credit_Bureau__r.Application__c).add(cli);
                }
                else{
                    appIdToCBRLineItemsMap.put(cli.Credit_Bureau__r.Application__c,new List<Credit_Bureau_Line_Item__c>{cli});
                }
            } 
            return  appIdToCBRLineItemsMap;
        }
        catch(Exception e){
            throw new applicationException('An error occurred retrieving Credit Bureau Line Items data'+e.getMessage()); 
            return null;
        }   
    }            

     /****************************************************************
        Purpose:  This method runs the credit analysis test from data retrieved from SF
        Parameters: List of Application IDs
        Returns: Map<ApplicationId,Boolean Test Result>
     ****************************************************************/
    @TestVisible
    private static Map<Id,Boolean> runCreditAnalysisBulkTest(List<Id> appIds){
        Map<Id,Boolean> appIDCreditAnalysisTestResultMap = new Map<Id,Boolean>();
        List<Application__c> applications;
        Map<Id,List<Credit_Bureau_Line_Item__c>> appIdToCBRLineItemsMap;
        
        try{
            applications = applicationDA.getApplicationsAndActiveIRSTranscriptsByApplicationIds(appIds);
            appIdToCBRLineItemsMap = getAppIdCreditBureauLineItemsMap(appIds);
            if(applications.isEmpty()){
                return null;
            }     
            for(Application__c app: applications){
                if(app.Has_Delinquencies__c || !app.IRS_Transcripts__r.isEmpty() || !app.SBA_Loan_History__r.isEmpty()){
                    appIDCreditAnalysisTestResultMap.put(app.Id, false);
                    continue;
                }
                else if(appIdToCBRLineItemsMap.containskey(app.Id)){
                    for(Credit_Bureau_Line_Item__c cli:appIdToCBRLineItemsMap.get(app.Id)){
                        if((purposeOfAccountCodes.contains(cli.Purpose_of_Account_Code__c) 
                            && cli.Account_Condition_Code__c==ACCOUNT_CONDITION_OPEN_CODE)
                            ||   (paymentStatusCodes.contains(cli.Payment_Status_Code__c))
                            ||   (cli.Account_Condition_Code__c==ACCOUNT_CONDITION_CHSUPJUDG)
                            ||   (cli.Account_Condition_Code__c ==ACCOUNT_CONDITION_FEDTAX_LIEN)
                        ){
                            appIDCreditAnalysisTestResultMap.put(app.Id, false);
                            break;
                        }
                        //PU: Begin Active_Chapter_7/13__c test Rule 1   
                        else if((cli.Credit_Bureau_Line_Item_Type__c==CBR_LINE_ITEM_TYPE) 
                                &&(cli.Public_Record_Satisified_Date__c< app.Original_Submission_Date__c.addYears(-2)) 
                                &&(brAccountConditionCodes.contains(cli.Account_Condition_Code__c))
                                ){
                                    appIDCreditAnalysisTestResultMap.put(app.Id, false);
                                    break;
                        }
                        //PU: Begin Active_Chapter_7/13__c test Rule 2 & 3 from JIRA
                        else if((cli.Balance_Date__c< app.Original_Submission_Date__c.addYears(-2))
                                &&((cli.Account_Condition_Code__c==ACCOUNT_CONDITION_DEEDLIEU || cli.Account_Condition_Code__c==ACCOUNT_CONDITION_FORECLOS)
                                ||(cli.Account_Condition_Code__c==null && cli.Payment_Status_Code__c==PAYMENT_STATUS_FORECLOS))){
                                    appIDCreditAnalysisTestResultMap.put(app.Id, false);
                                    break;
                        }                  
                    }
                }
                else{
                    appIDCreditAnalysisTestResultMap.put(app.Id, true);
                }
            }                              
            return appIDCreditAnalysisTestResultMap;
        }
        catch(Exception e){
            throw new applicationException('An error occurred during Credit Anaysis test'+e.getMessage()); 
            return null;
        }

    }

    public class applicationException extends Exception {}
}