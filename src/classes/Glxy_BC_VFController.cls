public with sharing class Glxy_BC_VFController {
	
	// Constructor - this only really matters if the autoRun function doesn't work right
    private final Glxy_BudgetSubmission__c objRecord;
    String strSOQL;
    
    public Glxy_BC_VFController(ApexPages.StandardController stdController) {
        this.objRecord = (Glxy_BudgetSubmission__c)stdController.getRecord();
    }
     
    // Code we will invoke on page load ...
 	public PageReference autoRun(){
 		
        String RecordID = String.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'));
 		PageReference pageRef;
 		String strSOQL;
 		
 		if (RecordID == null) {
            // Display the Visualforce page's content if no Id is passed over
            return null;
        }
 		
 		strSOQL = 'SELECT ID, RegionCD__c, ReportingFiscalYear__c, SubmissionType__c, LockRAWData__c ' +
				  'From   Glxy_BudgetSubmission__c ' +
	              'Where  ID = :RecordID ';
	                    
        Glxy_BudgetSubmission__c Obj = Database.Query(strSOQL);
		System.debug('MyDebug - VF Controller - Record ID = ' + RecordID);
                          						
        //Calculate, or Refresh Numbers only if the data is unlocked.
        GLXY_BC_RefreshBudgetData objRefreshBudgetData = new GLXY_BC_RefreshBudgetData();
        If (Obj.LockRAWData__c == false){
        	objRefreshBudgetData.CalculateNumbers(Obj.ReportingFiscalYear__c, Obj.SubmissionType__c, Obj.RegionCD__c);
        	pageRef = new PageReference('/Apex/Glxy_BC_BudgetCallStatus?ID=' + RecordID + '&Msg=DataRefreshed');
        } else {
        	pageRef = new PageReference('/Apex/Glxy_BC_BudgetCallStatus?ID=' + RecordID + '&Msg=RecordLocked');
        }
        
       	pageRef.setRedirect(true);
       	return pageRef;

    }
    
     // **** RUN all the TEST methods for code coverage ... ****//    
    private static testmethod void testGlxy_BC_VFController() {
    	
    	GLXY_BudgetSubmission__c objTest = new GLXY_BudgetSubmission__c (
	        ReportingFiscalYear__c = '2014',
	        SubmissionType__c = 'Congressional Justification'
	    );
	    
	    Test.startTest(); 
		insert objTest;
		Test.stopTest();
	    
	    PageReference pageRef = Page.GLXY_BC_RecalculateNumbers;
        Test.setCurrentPage(pageRef);
        GLXY_BudgetSubmission__c objTest3 = [select id, name from GLXY_BudgetSubmission__c where RegionCD__c = 'CO' and LockAdjustmentData__c = false limit 1];
        ApexPages.currentPage().getParameters().put('id', objTest3.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(objTest3);
        Glxy_BC_VFController objTest2 = new Glxy_BC_VFController(sc);
        objTest2.autorun();
    
        objTest.LockRAWData__c = true;
        Update objTest;
        objTest2.autorun();
        
        System.AssertNotEquals(objTest,NULL);
        
    }
    
}