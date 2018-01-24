//TO BE DELETED, REPLACED BY ChecklistItemGeneratorByDocRequestCase and ChecklistItemGeneratorByClosingDocCase
/****************************************************************
 Name:  ChecklistItemGeneratorByCase
============================================================
Author: Lenny
Purpose: JIRA#1293                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemGeneratorByCase extends ChecklistItemGenerator {

    private final Integer LEGAL_REPRESENTATIVE_FEE_THRESHOLD = 500;

    @TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
    @TestVisible private static ApplicantDAO applicantDA = new ApplicantDataAccessor();
    @TestVisible private static CreditBureauDAO creditBureauDA = new CreditBureauDataAccessor();
    @TestVisible private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();
    @TestVisible private static InsuranceDAO insuranceDA = new InsuranceDataAccessor();
    @TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();
    @TestVisible private static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();

    public ChecklistItemGeneratorByCase(){}

    public void handleChecklistGeneration(List<SObject> caseSobjects){
        if(caseSobjects == null || caseSobjects.isEmpty()){
            return;
        }

        List<Case> cases;
        try{
            cases = (List<Case>)caseSobjects;
        } 
        catch (TypeException e) {
            System.debug(e);
            throw new ChecklistItemGeneratorByCaseException('handleChecklistGeneration requires a List of Cases as input. ', e);
        }

        Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
        Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
        Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();
        Id closingDocRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_CLOSING_DOCUMENT).getRecordTypeId();

        List<Case> docRequestCases = new List<Case>();
        List<Case> loanClosingCases = new List<Case>();

        for(Case cas : cases){
            if(cas.RecordTypeId == docRequestRecordTypeId){
                docRequestCases.add(cas);
            }
            if(cas.RecordTypeId == closingDocRecordTypeId){
                loanClosingCases.add(cas);
            }
        }

        if(!docRequestCases.isEmpty()) {
            generateChecklistItems(docRequestCases);
        }

        if(!loanClosingCases.isEmpty()) {
            generateLoanClosingChecklistItems(loanClosingCases);
        }
    }

    private void generateChecklistItems(List<Case> cases){
        List<Id> applicationIds = new List<Id>();
        for(Case cas : cases){
            applicationIds.add(cas.Application__c);
        }
        if(applicationIds.isEmpty()){
            return;
        }

        Map<Id,Application__c> relatedApplicationIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);
        Map<Id,List<Applicant__c>> applicationIdToApplicantListMap = buildApplicationIdToApplicantListMap(applicationIds);
        Map<Id,List<Insurance__c>> applicationIdToInsuranceListMap = buildApplicationIdToInsuranceListMap(applicationIds);
        Map<Id,List<Credit_Bureau__c>> applicationIdToCBRListMap = buildApplicationIdToCBRListMap(applicationIds);
        Map<Id,Event_Request__c> applicationIdToEventRequestMap = buildApplicationIdToEventRequestMap(relatedApplicationIdToApplicationMap.values());
        List<Checklist_Item__c> checklistItemsToInsert = new List<Checklist_Item__c>();
        
        Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();
        for(Case cas : cases) {
            checklistItemsToInsert.addAll(
                createApplicableChecklistItemsForCases(
                    cas, 
                    applicationIdToApplicantListMap.containsKey(cas.Application__c) ? applicationIdToApplicantListMap.get(cas.Application__c) : new List<Applicant__c>(),
                    relatedApplicationIdToApplicationMap.get(cas.Application__c), 
                    applicationIdToInsuranceListMap.containsKey(cas.Application__c) ? applicationIdToInsuranceListMap.get(cas.Application__c) : new List<Insurance__c>(),
                    applicationIdToCBRListMap.containsKey(cas.Application__c) ? applicationIdToCBRListMap.get(cas.Application__c) : new List<Credit_Bureau__c>(),
                    applicationIdToEventRequestMap.get(cas.Application__c),
                    checklistCodeToMasterChecklistMap
                )
            );
        }

        try {
            checklistItemDA.insertChecklistItems(checklistItemsToInsert);
        } catch(DmlException e) {
            System.debug(e);
            throw new ChecklistItemGeneratorByCaseException('Error occurred while attempting to insert new Checklist_Item__c.', e);
        }
    }


    private void generateLoanClosingChecklistItems(List<Case> cases){
        List<Id> applicationIds = new List<Id>();
        for(Case cas : cases){
            applicationIds.add(cas.Application__c);
        }
        if(applicationIds.isEmpty()){
            return;
        }

        Map<Id,Application__c> relatedApplicationIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);

        List<Checklist_Item__c> checklistItemsToInsert = new List<Checklist_Item__c>();
        Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();
        for(Case cas : cases) {
            checklistItemsToInsert.addAll(
                createApplicableChecklistItemsForClosingDocumentCase(
                    cas,
                    relatedApplicationIdToApplicationMap.get(cas.Application__c),
                    checklistCodeToMasterChecklistMap
                )
            );
        }

        try {
            checklistItemDA.insertChecklistItems(checklistItemsToInsert);
        } catch(DmlException e) {
            System.debug(e);
            throw new ChecklistItemGeneratorByCaseException('Error occurred while attempting to insert new Checklist_Item__c.', e);
        }
    }


    @TestVisible
    private List<Checklist_Item__c> createApplicableChecklistItemsForCases(
        Case cas,
        List<Applicant__c> applicants,
        Application__c relatedApplication,
        List<Insurance__c> insurances,
        List<Credit_Bureau__c> creditBureaus,
        Event_Request__c relatedRequest,
        Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap
    ){
        List<Checklist_Item__c> newChecklistItems = new List<Checklist_Item__c>();

        for(Applicant__c applicant : applicants){
            if(applicant.Years_Employed__c < 2 
                && checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.PAYSTUB_CODE)
            ){
                newChecklistItems.add(
                    generateNewApplicantLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.PAYSTUB_CODE), 
                        cas, 
                        applicant
                    )
                );
            }

            if(!applicant.U_S_Citizen__c 
                && checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.RESIDENT_CARD_REQUEST_CODE)
            ){
                newChecklistItems.add(
                    generateNewApplicantLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.RESIDENT_CARD_REQUEST_CODE), 
                        cas, 
                        applicant
                    )
                );
            }

            if(relatedApplication.Legal_Representative_Fee__c > LEGAL_REPRESENTATIVE_FEE_THRESHOLD 
                && String.isBlank(relatedApplication.Legal_Representative_Name__c)
                && checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.REPRESENTATIVE_NAME_CODE)
            ){
                newChecklistItems.add(
                    generateNewApplicantLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.REPRESENTATIVE_NAME_CODE), 
                        cas, 
                        applicant
                    )
                );
            }

            if(checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.INSURANCE_INFO_CODE)){
                for(Insurance__c insurance : insurances){
                    if(isInsuranceInfoIncomplete(insurance)){
                        newChecklistItems.add(
                            generateNewApplicantLevelChecklistItem(
                                checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.INSURANCE_INFO_CODE), 
                                cas, 
                                applicant
                            )
                        );
                        break;
                    }
                }
            }

        }
        
        if(relatedApplication != null
            && checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.CBR_CODE)
        ){
            if(validCreditBureausCheck(creditBureaus, relatedRequest)){
                newChecklistItems.add(
                    generateNewApplicationLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE), 
                        cas, 
                        relatedApplication, 
                        ChecklistItemDataAccessor.RECEIVED_STATUS, 
                        ChecklistItemDataAccessor.INTERFACE_TYPE
                    )
                );
            }
            else {
                newChecklistItems.add(
                    generateNewApplicationLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE), 
                        cas, 
                        relatedApplication, 
                        ChecklistItemDataAccessor.FAILED_STATUS,
                        ChecklistItemDataAccessor.INTERFACE_TYPE
                    )
                );  
            }

            if(checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.IRS_TRANSCRIPT_CODE)){
                newChecklistItems.add(
                    generateNewApplicationLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.IRS_TRANSCRIPT_CODE), 
                        cas, 
                        relatedApplication, 
                        ChecklistItemDataAccessor.REQUESTED_STATUS, 
                        ChecklistItemDataAccessor.INTERFACE_TYPE
                    )
                );
            }
        }

        return newChecklistItems;
    }


    private List<Checklist_Item__c> createApplicableChecklistItemsForClosingDocumentCase(
        Case cas, 
        Application__c application,
        Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap
    ){
        List<Checklist_Item__c> newChecklistItems = new List<Checklist_Item__c>();

        if(application != null){
            if(checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.TILA_CODE)){
                newChecklistItems.add(
                    generateNewApplicationLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.TILA_CODE), 
                        cas, 
                        application, 
                        ChecklistItemDataAccessor.RECEIVED_STATUS, 
                        ChecklistItemDataAccessor.CLOSING_DOC_TYPE
                    )
                );
            }

            if(checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.HAPPY_LETTER_CODE)){
                newChecklistItems.add(
                    generateNewApplicationLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.HAPPY_LETTER_CODE), 
                        cas, 
                        application, 
                        ChecklistItemDataAccessor.RECEIVED_STATUS, 
                        ChecklistItemDataAccessor.CLOSING_DOC_TYPE
                    )
                );
            }

            if(checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.PROMISSORY_NOTE_CODE)){
                newChecklistItems.add(
                    generateNewApplicationLevelChecklistItem(
                        checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.PROMISSORY_NOTE_CODE), 
                        cas, 
                        application, 
                        ChecklistItemDataAccessor.RECEIVED_STATUS, 
                        ChecklistItemDataAccessor.CLOSING_DOC_TYPE
                    )
                );
            }
        }

        return newChecklistItems;
    }


    private Boolean validCreditBureausCheck(List<Credit_Bureau__c> relatedCBRs, Event_Request__c cbrEventRequest) {
        if(cbrEventRequest != null && cbrEventRequest.Status__c == EventRequestDataAccessor.STATUS_FAILURE) {
            return false;
        }

        if(relatedCBRs == null || relatedCBRs.isEmpty()){
            return false;
        }

        for(Credit_Bureau__c cbr : relatedCBRs) {
            if(cbr.CBR_Request_Result__c == 'Error' || cbr.CBR_Request_Result__c == null) {
                return false;
            }
        }
        return true;
    }


    private Checklist_Item__c generateNewApplicantLevelChecklistItem(Master_Checklist__c masterChecklist, Case cas, Applicant__c applicant){
        return new Checklist_Item__c(
            Name = applicant.Name + '-' + masterChecklist.Name,
            Applicant__c = applicant.Id,
            Application__c = applicant.Application__c,
            Master_Checklist__c = masterChecklist.Id,
            Case__c = cas.Id,
            Checklist_Item_Status__c = ChecklistItemDataAccessor.REQUESTED_STATUS,
            //Checklist_Item_Text__c = masterChecklist.Checklist_Description__c,
            Type__c = ChecklistItemDataAccessor.DOC_GATHERING_TYPE,
            Last_Action_Date__c = System.Now()
        );
    }


    private Map<Id,List<Insurance__c>> buildApplicationIdToInsuranceListMap(List<Id> applicationIds){
        Map<Id,List<Insurance__c>> applicationIdToInsuranceListMap = new Map<Id,List<Insurance__c>>();

        List<Insurance__c> relatedInsurances = insuranceDA.getInsuranceByApplicationIds(applicationIds);
        for(Insurance__c insurance : relatedInsurances){
            if(applicationIdToInsuranceListMap.containsKey(insurance.Application__c)){
                applicationIdToInsuranceListMap.get(insurance.Application__c).add(insurance);
            } else {
                applicationIdToInsuranceListMap.put(insurance.Application__c, new List<Insurance__c>{insurance});
            }
        }

        return applicationIdToInsuranceListMap;
    }


    private Map<Id,List<Applicant__c>> buildApplicationIdToApplicantListMap(List<Id> applicationIds){
        Map<Id,List<Applicant__c>> applicationIdToApplicantListMap = new Map<Id,List<Applicant__c>>();

        List<Applicant__c> relatedApplicants = applicantDA.getApplicantsByApplicationIds(applicationIds);

        for(Applicant__c applicant : relatedApplicants){
            if(applicationIdToApplicantListMap.containsKey(applicant.Application__c)){
                applicationIdToApplicantListMap.get(applicant.Application__c).add(applicant);
            } else {
                applicationIdToApplicantListMap.put(applicant.Application__c, new List<Applicant__c>{applicant});
            }
        }

        return applicationIdToApplicantListMap;
    }


    private Map<Id,List<Credit_Bureau__c>> buildApplicationIdToCBRListMap(List<Id> applicationIds) {
        Map<Id,List<Credit_Bureau__c>> applicationIdToCBRListMap = new Map<Id,List<Credit_Bureau__c>>();

        List<Credit_Bureau__c> relatedCBRs = creditBureauDA.getActiveCreditBureausByApplicationIds(applicationIds);

        for(Credit_Bureau__c cbr : relatedCBRs) {
            if(applicationIdToCBRListMap.containsKey(cbr.Application__c)) {
                applicationIdToCBRListMap.get(cbr.Application__c).add(cbr);
            }
            else {
                applicationIdToCBRListMap.put(cbr.Application__c, new List<Credit_Bureau__c>{cbr});
            }
        }
        
        return applicationIdToCBRListMap;
    }


    //private Map<String, Master_Checklist__c> buildChecklistCodeToMasterChecklistMap(){
    //  Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = new Map<String, Master_Checklist__c>();
    //  List<String> checklistCodes = new List<String>();
    //  checklistCodes.addAll(MasterChecklistDataAccessor.CHECKLIST_CODES);
    //  List<Master_Checklist__c> masterChecklists = masterChecklistDA.getMasterChecklistsByChecklistCodes(checklistCodes);
    //  for(Master_Checklist__c checklist : masterChecklists) {
    //      checklistCodeToMasterChecklistMap.put(checklist.Checklist_Code__c, checklist);
    //  }
    //  return checklistCodeToMasterChecklistMap;
    //}


    private Map<Id,Event_Request__c> buildApplicationIdToEventRequestMap(List<Application__c> relatedApplications){
        Map<Id,Event_Request__c> applicationIdToEventRequestMap = new Map<Id,Event_Request__c>();
        List<String> applicationNumbers = new List<String>();

        for(Application__c application : relatedApplications) {
            applicationNumbers.add(application.Name);
        }

        List<Event_Request__c> relatedCBRRequests = eventRequestDA.getEventRequestsByStageAndApplicationNumbers(
            applicationNumbers, 
            EventRequestDataAccessor.STAGE_RECEIVED_CBR
        );

        for(Application__c application : relatedApplications) {
            for(Event_Request__c request : relatedCBRRequests) {
                if(request.Application_Number__c == application.Name){
                    applicationIdToEventRequestMap.put(application.Id, request);
                }
            }
        }

        return applicationIdToEventRequestMap;
    }


    private Boolean isInsuranceInfoIncomplete(Insurance__c insurance){
        return (
            String.isNotBlank(insurance.Name)
            && String.isNotBlank(insurance.Type_of_Insurance_Coverage__c)
            && (String.isBlank(insurance.Insurance_Company_Name__c)
                || String.isBlank(insurance.Insurance_Agent_Phone_Number__c)
                || String.isBlank(insurance.Insurance_Policy_Number__c)
            )
        );
    }

    public class ChecklistItemGeneratorByCaseException extends Exception {}
}