public with sharing class GLXY_FutureMethods {
	
    @future public static void AddRegionalBudgetSubmissions(String strReportingFiscalYear, String strSubmissionType){
    	
    	List<Glxy_BudgetSubmission__c> objBudgetSubmissionRecords = New List<Glxy_BudgetSubmission__c>();
    	List<Glxy_BudgetSubmissionData__c> objBudgetSubmissionDataRecords = New List<Glxy_BudgetSubmissionData__c>();
    	Integer intFiscalYearStart;
    	Integer intReportColumnIdentifier;
    	
    	//Before we perform this update we want to set the isFutureUpdate boolean in our Glxy_RecursiveBlocker class to true */
        Glxy_RecursiveBlocker.isFutureUpdate = true;
        
        //Create Budget Submission records ...
        For (Integer intRegion = 1; intRegion <= 11; intRegion ++){
        	objBudgetSubmissionRecords.Add(new Glxy_BudgetSubmission__c(
		        ReportingFiscalYear__c = strReportingFiscalYear,
		       	SubmissionType__c = strSubmissionType,
		       	RegionCD__c = String.ValueOf(intRegion)
	   		));
        }
        Insert objBudgetSubmissionRecords;
        
        //Create Budget Submission DATA records - Template ...
        for (Glxy_BudgetSubmission__c ObjMaster : [SELECT ID, ReportingFiscalYear__c 
        											 From   Glxy_BudgetSubmission__c
                  									 Where  ReportingFiscalYear__c = :strReportingFiscalYear
                  									 And 	SubmissionType__c = :strSubmissionType]){
			 
			 intFiscalYearStart = Integer.ValueOf(ObjMaster.ReportingFiscalYear__c);
			 intReportColumnIdentifier = 1;
			 
			 For (Integer intFY = intFiscalYearStart; intFY <= intFiscalYearStart + 2; intFY ++){    		     
    		     objBudgetSubmissionDataRecords.Add(new Glxy_BudgetSubmissionData__c(
    		     			BudgetSubmissionID__c = ObjMaster.ID,
					        FiscalYear__c = String.ValueOf(intFY),
					       	DataFormat__c = 'RAW',
					       	ReportColumnIdentifier__c = intReportColumnIdentifier
				 ));
				 objBudgetSubmissionDataRecords.Add(new Glxy_BudgetSubmissionData__c(
    		     			BudgetSubmissionID__c = ObjMaster.ID,
					        FiscalYear__c = String.ValueOf(intFY),
					       	DataFormat__c = 'Adjustment',
					       	ReportColumnIdentifier__c = intReportColumnIdentifier
				 ));
				 intReportColumnIdentifier ++;
			 }		 
			 
		}
   		Insert objBudgetSubmissionDataRecords;
   		
   		//Calculate the RAW data  ...
   		GLXY_BC_RefreshBudgetData objRefreshBudgetData = new GLXY_BC_RefreshBudgetData();
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '1');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '2');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '3');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '4');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '5');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '6');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '7');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '8');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '9');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '10');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, '11');
   		objRefreshBudgetData.CalculateNumbers(strReportingFiscalYear, strSubmissionType, 'CO');
   		
    }
}