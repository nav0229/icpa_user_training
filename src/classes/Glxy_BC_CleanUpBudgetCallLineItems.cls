global with sharing class Glxy_BC_CleanUpBudgetCallLineItems implements Database.Batchable<sObject> {
   public String Query;

	global Glxy_BC_CleanUpBudgetCallLineItems(){
	}
	
   	global Database.QueryLocator start(Database.BatchableContext BC){
   		Date dtProcessRunDate = Datetime.Now().Date();
		string Query = 'Select Name from Glxy_BudgetCallLineItem__c';
   		Return Database.getQueryLocator(Query);
   	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope){
		Delete scope;
      	DataBase.emptyRecycleBin(scope);
   	}

   	global void finish(Database.BatchableContext BC){
   		/*
   		//Invoke the next job ... 
   		GalaxyBudgetCall__c objCustomSettings = GalaxyBudgetCall__c.getOrgDefaults();
   		DateTime n = datetime.now().addMinutes(1);
   		String cron = '';
   		cron += n.second();
   		cron += ' ' + n.minute();
   		cron += ' ' + n.hour();
   		cron += ' ' + n.day();
   		cron += ' ' + n.month();
   		cron += ' ' + '?';
   		cron += ' ' + n.year();
   		objCustomSettings.Schedule2_ID__c = System.Schedule('Glxy_BC_LoadLease', cron, new GLXY_BC_JobSchedule2());
   		try{	
        	Update objCustomSettings;
	 	}catch (Exception e){
        	System.debug('Glxy_BC_CleanUpBudgetCallLineItems - Job Create error - ' + e.getMessage());
    	}*/
    	
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_LoadLease());
    	
   	}
   	
   @isTest static void testClass(){
   		
   		Test.startTest();    
   		
   		Glxy_Lease__c objLease = new Glxy_Lease__c();
		objLease.Name = 'LAK05855';
		objLease.BaseLeaseEffectiveDate__c = Datetime.Now().Date();
		objLease.ExpirationDateofLease__c =Datetime.Now().Date();
		insert objLease;
		
   		Glxy_BudgetCallLineItem__c objBudgetCall = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LAK05855',
            BudgetCategory__c = 'Base Rent'
            );
        insert objBudgetCall;
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
                
        Glxy_BC_CleanUpBudgetCallLineItems objTest = new Glxy_BC_CleanUpBudgetCallLineItems();
        Database.executeBatch(objTest);
        System.Assert(objTest!=NULL);     
        Test.stopTest();     
    }   
}