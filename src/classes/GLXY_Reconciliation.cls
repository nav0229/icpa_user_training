global with sharing class GLXY_Reconciliation implements Database.Batchable<sObject>,Database.stateful{
	
	global List<Glxy_Reconciliation__c> objReconciliationRecords = New List<Glxy_Reconciliation__c>();
	global Date dtProcessRunDate = Datetime.Now().Date().addMonths(-1);
	global string strCurrentMonth = String.valueOf(dtProcessRunDate.Month());
	global string strPegasysLeaseNumber;
	global decimal dbBaseAnnualRent;
	 	
	global Database.QueryLocator start(Database.BatchableContext BC){
		//Release 2.2 - Add the Status Code Filter. The users want to see only Active projects.
		//Galaxy 2.2 - Provide capability to run the process for previous months
   		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
   		if (objCustomSettings.CustomRunDate__c != null){
   			dtProcessRunDate = objCustomSettings.CustomRunDate__c.addMonths(-1);
   			strCurrentMonth = String.valueOf(dtProcessRunDate.Month());
   		}
   		//Galaxy 2.2 - Provide capability to run the process for previous months
		string QueryAllLeases =  'SELECT Id, Name, BaseAnnualRent__c, DelegatedLease__c, RegionCD__c, StatusCode__c, TeamCode__c ' +
	 	 						 'FROM  Glxy_Lease__c  ' +
	 	 						 'Where  REXUSStatusCode__c  = \'Active\' ' + 
	 	 						 'ORDER BY Name ';
	 	//System.Debug('MyDebug = ' + QueryAllLeases); 						 
	 	Return Database.getQueryLocator(QueryAllLeases);
	 	
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objReconciliationRecords.clear();
		Glxy_Lease__c objLease = null;
		strPegasysLeaseNumber = '';
		for(sObject obj: scope) {
			objLease = (Glxy_Lease__c) obj;
			if (objLease.RegionCD__c == Null){
				strPegasysLeaseNumber = 'B' + objLease.Name.Right(5);
			}else {
				strPegasysLeaseNumber = objLease.RegionCD__c + 'B' + objLease.Name.Right(5);
			}
			If (objLease.BaseAnnualRent__c == Null){
				dbBaseAnnualRent = 0.0;
			}else {
				dbBaseAnnualRent = objLease.BaseAnnualRent__c;
			}
	        
			objReconciliationRecords.Add(new Glxy_Reconciliation__c(
            	LeaseNumber__c = objLease.Name,
               	Month__c = strCurrentMonth,
               	LeaseNumberMonth__c = strCurrentMonth + objLease.Name,
                RegionCD__c = objLease.RegionCD__c, 
                StatusCode__c = objLease.StatusCode__c,
                DelegatedFlag__c = objLease.DelegatedLease__c,
                TeamCode__c = objLease.TeamCode__c,
                AnnualRent__c = dbBaseAnnualRent,
                MonthlyRent__c = dbBaseAnnualRent/12,
               	PegasysLeaseNumber__c = strPegasysLeaseNumber
            ));
        } 
		Database.SaveResult[] result = Database.Insert(objReconciliationRecords);
	}
	
	global void finish(Database.BatchableContext BC){
		//Delete this job from Scheduled Jobs ...
		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
		try{	
        	System.abortJob(objCustomSettings.Schedule2_ID__c);
	 	}catch (Exception e){
        	System.debug('GLXY_Reconciliation Job Delete error - ' + e.getMessage());
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
   		objCustomSettings2.Schedule3_ID__c = System.Schedule('GLXY_ReconciliationSummaryTotal', cron, new GLXY_ReconciliationJobSchedule3());
   		try{	
        	Update objCustomSettings2;
	 	}catch (Exception e){
        	System.debug('GLXY_Reconciliation Job Create error - ' + e.getMessage());
    	}
  	}
    
    static testMethod void testClass(){
    	
    	GalaxyReconciliationBatch__c objCustomSettings = New GalaxyReconciliationBatch__c(
    		CustomRunDate__c = Datetime.Now().Date()
    	);
    	insert objCustomSettings;
    	
    	Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
 	  	 	StatusCode__c='Active',
	   		BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
	 		ExpirationDateofLease__c=Datetime.Now().Date(),
	 		RegionCD__c='11',
	 		Total_NOA_Sq_feet__c = 0,
	 		Total_IA_Sq_feet__c = 0,
	  		name='testte',
	 		BaseAnnualRent__c =2222,
	 		REXUSStatusCode__c = 'Active');
 		insert objleaseEntry;
 		System.Assert(objleaseEntry!=NULL);
 		
    	Test.startTest();     
    	GLXY_Reconciliation objTest = new GLXY_Reconciliation();
    	Database.executeBatch(objTest);      
    	Test.stopTest();     
    } 
    
}