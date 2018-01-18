global with sharing class GLXY_ReconciliationCleanUp implements Database.Batchable<sObject> {
   public String Query;

	global GLXY_ReconciliationCleanUp(){
	}
	
   	global Database.QueryLocator start(Database.BatchableContext BC){
   		Date dtProcessRunDate = Datetime.Now().Date().addMonths(-1);
   		//Galaxy 2.2 - Provide capability to run the process for previous months
   		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
   		if (objCustomSettings.CustomRunDate__c != null){
   			dtProcessRunDate = objCustomSettings.CustomRunDate__c.addMonths(-1);
   		}
   		//Galaxy 2.2 - Provide capability to run the process for previous months
		string strCurrentMonth = String.valueOf(dtProcessRunDate.Month());
   		string Query = 'Select Name from Glxy_Reconciliation__c where Month__c = \'' + strCurrentMonth + '\'';
   		//Galaxy 2.2 - October, clean up all the data
   		If (strCurrentMonth == '10'){
   			Query = 'Select Name from Glxy_Reconciliation__c';
   		}
   		//Galaxy 2.2 - October, clean up all the data
   		Return Database.getQueryLocator(Query);
   	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope){
		Delete scope;
      	DataBase.emptyRecycleBin(scope);
   	}

   	global void finish(Database.BatchableContext BC){
   		//Invoke the next job ... 
   		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
   		DateTime n = datetime.now().addMinutes(1);
   		String cron = '';
   		cron += n.second();
   		cron += ' ' + n.minute();
   		cron += ' ' + n.hour();
   		cron += ' ' + n.day();
   		cron += ' ' + n.month();
   		cron += ' ' + '?';
   		cron += ' ' + n.year();
   		objCustomSettings.Schedule2_ID__c = System.Schedule('GLXY_Reconciliation', cron, new GLXY_ReconciliationJobSchedule2());
   		try{	
        	Update objCustomSettings;
	 	}catch (Exception e){
        	System.debug('GLXY_ReconciliationCleanUp Job Create error - ' + e.getMessage());
    	}
   	}
   	
   static testMethod void testClass(){
   		
   		Test.startTest();    
   		
   		Date dtProcessRunDate = Datetime.Now().Date();                
        String strCurrentMonth = String.valueOf(dtProcessRunDate.Month() - 1);
        
   		Glxy_Reconciliation__c objReconciliation = new Glxy_Reconciliation__c(
            LeaseNumberMonth__c = strCurrentMonth + 'LDE0034',
            LeaseNumber__c = 'LDE0034',
            Month__c = strCurrentMonth,
            CurrentMonthGalaxy__c = 0.0,
            AnnualRent__c = 0.0,
            RentDifference__c = 0.0,
            CPIAmount__c = 0.0,
            CancelAnnualRentIA__c = 0.0,
            CancelAnnualRentNOA__c = 0.0,
            ChangeInSFRent__c = 0.0,
            LumpSumTotal__c = 0.0,
            Tax__c = 0.0
            );
        insert objReconciliation;
                 
        GLXY_ReconciliationCleanUp objTest = new GLXY_ReconciliationCleanUp();
        Database.executeBatch(objTest);
        System.Assert(objTest!=NULL);     
        Test.stopTest();     
    }   
}