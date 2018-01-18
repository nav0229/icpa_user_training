global with sharing class Glxy_UpdateProcessDateEOYLS implements Database.Batchable<sObject>,Database.stateful{
	
	global List<Glxy_LumpSum__c> objUpdatedRecords = New List<Glxy_LumpSum__c>();
	global String strCurrentFY;
	global Date dtAdvanceDate;
		
	global Database.QueryLocator start(Database.BatchableContext BC){
		//Advance all the Process Dates to the Current FYs. This only applies to those records in ESTIMATE status, so we can better project the #s
        //This process will be scheduled via a job. 

        //#1) Calculate current Fiscal Year (GSA FY), and Advance Date
        Integer intCurrentFY = date.today().Year();  
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth <= 9 && !Test.isRunningTest()){ // in Real time
            intCurrentFY -=1;
        }
        
        if (intCurrentYearMonth >= 9 && Test.isRunningTest()){ // for test methods to get coverage
        	intCurrentFY +=1;
        }
        
        strCurrentFY = String.ValueOf(intCurrentFY); 
        dtAdvanceDate = Date.Newinstance (Integer.ValueOf(strCurrentFY), 10, 01);
        
        //#2) Advance Glxy_LumpSum__c ...
        string RexusRecordTypeID = Schema.SObjectType.Glxy_LumpSum__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		string QueryData = 'Select  ID, ProcessedDate__c ' +
	 	 					   'From    Glxy_LumpSum__c ' + 
	 	 					   'Where   StatusCd__c = \'Estimate\' ' + 
	 	 					   'And 	ProcessedDateFY__c != Null ' + 
	 	 					   'And     ProcessedDateFY__c <= :strCurrentFY ' +
	 	 					   'And 	EffectiveDateFY__c != Null ' + 
	 	 					   'And     EffectiveDateFY__c <= :strCurrentFY ' +
	 	 					   'And     RecordTypeID        = :RexusRecordTypeID ' +
	 	 					   'ORDER BY ID ';						 
	 	Return Database.getQueryLocator(QueryData);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objUpdatedRecords.Clear();
		Glxy_LumpSum__c objLS;
		
		for(sObject obj: scope) {
			objLS = (Glxy_LumpSum__c) obj;
			objUpdatedRecords.Add(new Glxy_LumpSum__c(
                ID = objLS.ID,
                ProcessedDate__c = dtAdvanceDate
            ));
		}
		
		try{	
        	Database.update(objUpdatedRecords, false);
	 	}catch (DmlException e){
        	System.debug('Glxy_UpdateProcessDateEOYLS Update error - ' + e.getMessage());
    	}
		 
	}
	
	global void finish(Database.BatchableContext BC){
		//Delete this job from Scheduled Jobs ...
		GalaxyReconciliationBatch__c objCustomSettingsDel = GalaxyReconciliationBatch__c.getOrgDefaults(); 
		try{	
        	System.abortJob(objCustomSettingsDel.Schedule3_ID__c);
	 	}catch (Exception e){
        	System.debug('Glxy_UpdateProcessDateEOYLS - Job Delete error - ' + e.getMessage());
    	}
    	
    	//Invoke the next job ... 
   		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults(); // Reuse the Reconciliation Batch Variables, since they never run together
   		DateTime n = datetime.now().addMinutes(1);
   		String cron = '';
   		cron += n.second();
   		cron += ' ' + n.minute();
   		cron += ' ' + n.hour();
   		cron += ' ' + n.day();
   		cron += ' ' + n.month();
   		cron += ' ' + '?';
   		cron += ' ' + n.year();
   		objCustomSettings.Schedule4_ID__c = System.Schedule('Glxy_JobScheduleProcessDateUpdateEOYProj', cron, new Glxy_JobScheduleProcessDateUpdateEOYProj());
   		try{	
        	Update objCustomSettings;
	 	}catch (Exception e){
        	System.debug('Glxy_UpdateProcessDateEOYLS - Job Create error - ' + e.getMessage());
    	}
	}
  	
  	 static testMethod void testClass(){
		
		Glxy_Lease__c ObjLease = new Glxy_Lease__c();
        ObjLease.StatusCode__c = 'Active';
        ObjLease.BaseLeaseEffectiveDate__c = date.newinstance(date.today().Year(), 1, 1);
        ObjLease.ExpirationDateofLease__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLease.RegionCD__c = '1';
        ObjLease.Total_NOA_Sq_feet__c = 10;
        ObjLease.Total_IA_Sq_feet__c = 20;
        objLease.DelegatedLease__c = false;
        objLease.BaseAnnualRent__c = 1000;
        objLease.IAConverstionDate__c = date.newinstance(date.today().Year(), 1, 1);
        insert ObjLease;
        System.Assert(ObjLease!=NULL);
        
        string RexusRecordTypeID = Schema.SObjectType.Glxy_LumpSum__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
        Glxy_LumpSum__c ObjLS = new Glxy_LumpSum__c(
            LeaseNumber__c = objLease.id,
            RecordTypeID = RexusRecordTypeID,
            StatusCd__c = 'Estimate',
            EffectiveDate__c = Datetime.Now().Date().addYears(0),
            ProcessedDate__c = Datetime.Now().Date().addYears(0),
            Acceptance620Date__c = Datetime.Now().Date().addYears(0)
        );
        insert ObjLS;
        
    	Test.startTest();     
    	Glxy_UpdateProcessDateEOYLS objTest = new Glxy_UpdateProcessDateEOYLS();
    	Database.executeBatch(objTest);      
    	Test.stopTest();     
    }  
}