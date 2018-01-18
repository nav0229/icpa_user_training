global with sharing class GLXY_ReconciliationLocationsUpdate implements Database.Batchable<sObject>,Database.stateful{
	
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
		string QueryAllLocations =  'SELECT LeaseNumber__r.Name, Location_Code__c ' +
	 	 						 	'FROM   Glxy_LeaseLocation__c  ' + 
	 	 						 	'Where  LeaseNumber__r.REXUSStatusCode__c  = \'Active\' ' + 
	 	 						 	'ORDER BY LeaseNumber__r.Name ';
	 	//System.Debug('MyDebug = ' + QueryAllLocations); 						 
	 	Return Database.getQueryLocator(QueryAllLocations);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objReconciliationUpdatedRecords.Clear();
		string strLoopCurrentLease;
		string strLoopPreviousLease = '-';
		string strBuildingIDs = '';
		boolean blnHasData = false;
		
		Glxy_LeaseLocation__c objLeaseLocation = null;
		for(sObject obj: scope) {
			blnHasData = true;
			objLeaseLocation = (Glxy_LeaseLocation__c) obj;
			strLoopCurrentLease = objLeaseLocation.LeaseNumber__r.Name;
			if ((strLoopCurrentLease <> strLoopPreviousLease) && (strLoopPreviousLease <> '-')){
				if (strBuildingIDs.LastIndexOf(',') > 0)
					strBuildingIDs = strBuildingIDs.Left(strBuildingIDs.LastIndexOf(','));
				objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
            		LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                	BuildingNumber__c = strBuildingIDs
            	));
            	strBuildingIDs = '';	
			}
			strBuildingIDs = strBuildingIDs + objLeaseLocation.Location_Code__c + ',';
			strLoopPreviousLease = strLoopCurrentLease;
        } 
		
		if (blnHasData = true){
			if (strBuildingIDs.LastIndexOf(',') > 0)
				strBuildingIDs = strBuildingIDs.Left(strBuildingIDs.LastIndexOf(','));
			objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
        		LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
            	BuildingNumber__c = strBuildingIDs
        	));
		}
		
		try{	
        	Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
	 	}catch (DmlException e){
        	System.debug('GLXY_ReconciliationLocationsUpdate Upsert error - ' + e.getMessage());
    	}
	}
	
	global void finish(Database.BatchableContext BC){
		//Delete this job from Scheduled Jobs ...
		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
		try{	
        	System.abortJob(objCustomSettings.Schedule6_ID__c);
	 	}catch (Exception e){
        	System.debug('GLXY_ReconciliationLocationsUpdate Job Delete error - ' + e.getMessage());
    	}
		// Update the Process Completion Date ...
		GalaxyReconciliationBatch__c objCustomSettings2 = GalaxyReconciliationBatch__c.getOrgDefaults();
   		objCustomSettings2.Apex_Jobs_Run_Date__c = datetime.now();
   		objCustomSettings2.CustomRunDate__c = Null;//G2 Release 2.2 - If it was scheduled for a particular month, clear the month off; 
   		try{	
        	Update objCustomSettings2;
	 	}catch (Exception e){
        	System.debug('GLXY_ReconciliationLocationsUpdate Job Create error - ' + e.getMessage());
    	}
	}
  	
  	 static testMethod void testClass(){
  	 	
  	 	Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
 	  	 	StatusCode__c='Active',
 	  	 	REXUSStatusCode__c='Active',
	   		BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
	 		ExpirationDateofLease__c=Datetime.Now().Date(),
	 		RegionCD__c='11',
	 		Total_NOA_Sq_feet__c=4444,
	 		Total_IA_Sq_feet__c=3333333,
	  		name='testte',
	 		BaseAnnualRent__c =2222);
 		insert objleaseEntry;
		System.Assert(objleaseEntry!=NULL);
		
		Glxy_Lease__c objleaseEntry2 = new Glxy_Lease__c(
 	  	 	StatusCode__c='Active',
 	  	 	REXUSStatusCode__c='Active',
	   		BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
	 		ExpirationDateofLease__c=Datetime.Now().Date(),
	 		RegionCD__c='11',
	 		Total_NOA_Sq_feet__c=4444,
	 		Total_IA_Sq_feet__c=3333333,
	  		name='testte2',
	 		BaseAnnualRent__c =2222);
 		insert objleaseEntry2;
		System.Assert(objleaseEntry2!=NULL);
		
		PBS_Building__c objBuildingEntry = new PBS_Building__c(
 	  	 	Location_Code_Plus__c = 'DC0021ZZ',
 	  	 	Building_ID__c = 123);
 		insert objBuildingEntry;
 		System.Assert(objBuildingEntry!=NULL);
 		
 		PBS_Building__c objBuildingEntry2 = new PBS_Building__c(
 	  	 	Location_Code_Plus__c = 'DC0022ZZ',
 	  	 	Building_ID__c = 12334);
 		insert objBuildingEntry2;
 		System.Assert(objBuildingEntry2!=NULL);
 		
  	 	Glxy_Lease__c objLease = [Select id from Glxy_Lease__c Limit 1];
  	 	PBS_Building__c objBuilding = [Select id from PBS_Building__c Limit 1];
  	 	
  	 	Glxy_LeaseLocation__c objLeaseLocation = new Glxy_LeaseLocation__c (
            LeaseNumber__c = objLease.id,
            BuildingNumber__c = objBuilding.id
        );
        insert objLeaseLocation;
 		
 		Glxy_LeaseLocation__c objLeaseLocation2 = new Glxy_LeaseLocation__c (
            LeaseNumber__c = objleaseEntry2.id,
            BuildingNumber__c = objBuildingEntry2.id
        );
        insert objLeaseLocation2;

    	Test.startTest();     
    	GLXY_ReconciliationLocationsUpdate objTest = new GLXY_ReconciliationLocationsUpdate();
    	Database.executeBatch(objTest);      
    	Test.stopTest();     
    }  
}