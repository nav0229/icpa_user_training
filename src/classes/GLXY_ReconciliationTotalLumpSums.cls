global with sharing class GLXY_ReconciliationTotalLumpSums implements Database.Batchable<sObject>,Database.stateful{
    
    global List<Glxy_Reconciliation__c> objReconciliationUpdatedRecords = New List<Glxy_Reconciliation__c>();
   	global Date dtProcessRunDate = Datetime.Now().Date().addMonths(-1);
	global string strCurrentMonth = String.valueOf(dtProcessRunDate.Month());
	
    global Database.QueryLocator start(Database.BatchableContext BC){
    	//Galaxy 2.2 - Provide capability to run the process for previous months
   		GalaxyReconciliationBatch__c objCustomSettings1 = GalaxyReconciliationBatch__c.getOrgDefaults();
   		if (objCustomSettings1.CustomRunDate__c != null){
   			dtProcessRunDate = objCustomSettings1.CustomRunDate__c.addMonths(-1);
   			strCurrentMonth = String.valueOf(dtProcessRunDate.Month());
   		}
   		//Galaxy 2.2 - Provide capability to run the process for previous months
   		
        string Query =  'SELECT  LeaseNumber__c, LeaseNumberMonth__c, LumpSumsAmount__c, RentIncreaseLumpSum__c, CPILumpSum__c, SRLumpSum__c ' +
                        'FROM  Glxy_Reconciliation__c  ' + 
                        'WHERE Month__c = \'' + strCurrentMonth + '\' ' +
                        'ORDER BY LeaseNumber__c ';
        Return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        objReconciliationUpdatedRecords.Clear();
        Glxy_Reconciliation__c objReconciliation = null;
        for(sObject obj: scope) {
            objReconciliation = (Glxy_Reconciliation__c) obj;
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = objReconciliation.LeaseNumberMonth__c,
                LumpSumTotal__c = (objReconciliation.LumpSumsAmount__c  + objReconciliation.RentIncreaseLumpSum__c  + objReconciliation.CPILumpSum__c + + objReconciliation.SRLumpSum__c)
            ));
        }
        
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationTotalLumpSums Upsert error - ' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
        //Delete this job from Scheduled Jobs ...
        GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
        try{    
            System.abortJob(objCustomSettings.Schedule4_ID__c);
        }catch (Exception e){
            System.debug('GLXY_ReconciliationTotalLumpSums Job Delete error - ' + e.getMessage());
        }
        //Invoke the NEXT job ...
        GalaxyReconciliationBatch__c objCustomSettings2 = GalaxyReconciliationBatch__c.getOrgDefaults();
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        objCustomSettings2.Schedule5_ID__c = System.Schedule('GLXY_ReconciliationMonthly', cron, new GLXY_ReconciliationJobSchedule5());
        try{    
            Update objCustomSettings2;
        }catch (Exception e){
            System.debug('GLXY_ReconciliationTotalLumpSums Job Create error - ' + e.getMessage());
        }
    }
    
    static testMethod void testClass(){
        
        GalaxyReconciliationBatch__c objCustomSettings = New GalaxyReconciliationBatch__c(
    		CustomRunDate__c = Datetime.Now().Date()
    	);
    	insert objCustomSettings;
    	
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
        
        Test.startTest();  
        GLXY_ReconciliationTotalLumpSums objTest = new GLXY_ReconciliationTotalLumpSums();
        System.Assert(objTest!=NULL);
        Database.executeBatch(objTest);      
        Test.stopTest();     
    } 
}