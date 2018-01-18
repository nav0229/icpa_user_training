global with sharing class GLXY_ReconciliationMonthly implements Database.Batchable<sObject>,Database.stateful{
    
    global List<Glxy_Reconciliation__c> objReconciliationUpdatedRecords = New List<Glxy_Reconciliation__c>();
    global Date dtProcessRunDate = Datetime.Now().Date();
    global string strCurrentMonth = String.valueOf(dtProcessRunDate.addMonths(-1).Month());
    global string strPreviousMonth = String.valueOf(dtProcessRunDate.addMonths(-2).Month());
    global Decimal dblCommonFields;
    global AggregateResult[] AgR;
    global string strSOQL;
    global Decimal dblGalaxyYTDAmount;
    
    global Database.QueryLocator start(Database.BatchableContext BC){
    	//Galaxy 2.2 - Provide capability to run the process for previous months
   		GalaxyReconciliationBatch__c objCustomSettings1 = GalaxyReconciliationBatch__c.getOrgDefaults();
   		if (objCustomSettings1.CustomRunDate__c != null){
   			dtProcessRunDate = objCustomSettings1.CustomRunDate__c.addMonths(-1);
   			strCurrentMonth = String.valueOf(dtProcessRunDate.Month());
   		}
   		//Galaxy 2.2 - Provide capability to run the process for previous months
        string Query =  'SELECT  LeaseNumber__c, LeaseNumberMonth__c, AnnualRent__c, RentDifference__c, CPIAmount__c, SRAmount__c, RWAsAmount__c, ' + 
                        'Tax__c, CancelAnnualRentIA__c, CancelAnnualRentNOA__c, LumpSumTotal__c, ChangeInSFRent__c ' +
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
            //Calculate the YTD values for this Lease
            dblGalaxyYTDAmount = 0.0;
            strSOQL =   'Select Sum(YearToDate__c) YearToDate__c ' + 
                        'From   Glxy_Reconciliation__c  ' +
                        'Where  LeaseNumber__c = \'' + objReconciliation.LeaseNumber__c + '\' ' +
                        'And    Month__c = \'' + strPreviousMonth + '\' ' +
                        'Group by LeaseNumber__c';
            AgR = Database.Query(strSOQL);      
            for (AggregateResult RowData : AgR) { 
             	If (RowData.get('YearToDate__c') != null)
                	dblGalaxyYTDAmount = (Decimal) RowData.get('YearToDate__c');
            	//System.debug('MyDebug = ' + YearToDate__c);  
            }
            
            // Update Current Month Galaxy, Next Month Rent, and YTD fields ...     
            dblCommonFields = ((objReconciliation.AnnualRent__c/12)  + objReconciliation.RentDifference__c + objReconciliation.CPIAmount__c + objReconciliation.SRAmount__c + objReconciliation.CancelAnnualRentIA__c + objReconciliation.CancelAnnualRentNOA__c + objReconciliation.ChangeInSFRent__c);
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = objReconciliation.LeaseNumberMonth__c,
                CurrentMonthGalaxy__c = (dblCommonFields + objReconciliation.LumpSumTotal__c + objReconciliation.Tax__c + objReconciliation.RWAsAmount__c),
                NextMonthRent__c = dblCommonFields, 
                YearToDate__c = dblGalaxyYTDAmount + (dblCommonFields + objReconciliation.LumpSumTotal__c + objReconciliation.Tax__c)
            ));
            
        }
        
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationMonthly Upsert error - ' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
        //Delete this job from Scheduled Jobs ...
        GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
        try{    
            System.abortJob(objCustomSettings.Schedule5_ID__c);
        }catch (Exception e){
            System.debug('GLXY_ReconciliationMonthly Job Delete error - ' + e.getMessage());
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
        objCustomSettings2.Schedule6_ID__c = System.Schedule('GLXY_ReconciliationLocationsUpdate', cron, new GLXY_ReconciliationJobSchedule6());
        try{    
            Update objCustomSettings2;
        }catch (Exception e){
            System.debug('GLXY_ReconciliationMonthly Job Create error - ' + e.getMessage());
        }
    }
    
    static testMethod void testClass(){
    	
        Test.startTest();
        Date dtProcessRunDate = Datetime.Now().Date();        
        string strCurrentMonth = String.valueOf(dtProcessRunDate.Month() - 1);
        
        GalaxyReconciliationBatch__c objCustomSettings = New GalaxyReconciliationBatch__c(
    		CustomRunDate__c = Datetime.Now().Date()
    	);
    	insert objCustomSettings;
    	
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
        System.Assert(objReconciliation!=NULL);
        
        GLXY_ReconciliationMonthly objTest = new GLXY_ReconciliationMonthly();
        Database.executeBatch(objTest);      
        Test.stopTest();     
    } 
}