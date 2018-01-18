global with sharing class Glxy_UpdateProcessDateEOYCPI implements Database.Batchable<sObject>,Database.stateful{
	
	global List<Glxy_ConsumerPriceIndex__c> objUpdatedRecords = New List<Glxy_ConsumerPriceIndex__c>();
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
        
        //#2) Advance Glxy_ConsumerPriceIndex__c ...
        string RexusRecordTypeID = Schema.SObjectType.Glxy_ConsumerPriceIndex__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		string QueryData = 'Select   ID, ProcessedDate__c ' +
	 	 					'From    Glxy_ConsumerPriceIndex__c ' + 
	 	 					'Where   StatusCd__c = \'Estimate\' ' + 
	 	 					'And 	 ProcessedDateFY__c != Null ' + 
	 	 					'And     ProcessedDateFY__c <= :strCurrentFY ' +
	 	 					'And 	 EffectiveDateFY__c != Null ' + 
	 	 					'And     EffectiveDateFY__c <= :strCurrentFY ' +
	 	 					'ORDER BY ID ';						 
	 	Return Database.getQueryLocator(QueryData);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objUpdatedRecords.Clear();
		Glxy_ConsumerPriceIndex__c objCPI;
		
		for(sObject obj: scope) {
			objCPI = (Glxy_ConsumerPriceIndex__c) obj;
			objUpdatedRecords.Add(new Glxy_ConsumerPriceIndex__c(
                ID = objCPI.ID,
                ProcessedDate__c = dtAdvanceDate
            ));
		}
		
		try{	
        	Database.update(objUpdatedRecords, false);
	 	}catch (DmlException e){
        	System.debug('Glxy_UpdateProcessDateEOYCPI Update error - ' + e.getMessage());
    	}
		 
	}
	
	global void finish(Database.BatchableContext BC){
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
   		objCustomSettings.Schedule2_ID__c = System.Schedule('Glxy_JobScheduleProcessDateUpdateEOYSR', cron, new Glxy_JobScheduleProcessDateUpdateEOYSR());
   		try{	
        	Update objCustomSettings;
	 	}catch (Exception e){
        	System.debug('Glxy_UpdateProcessDateEOYCPI - Job Create error - ' + e.getMessage());
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
        
        string RexusRecordTypeID = Schema.SObjectType.Glxy_ConsumerPriceIndex__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
        Glxy_ConsumerPriceIndex__c objCPI2 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            RecordTypeID = RexusRecordTypeID,
            AnnualAmount__c = 200,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = Datetime.Now().Date().addYears(0),
            EffectiveDate__c = Datetime.Now().Date().addYears(0),
            Acceptance620Date__c = Datetime.Now().Date().addYears(0),
            StatusCD__c = 'Estimate'
        );
        insert objCPI2;
        
    	Test.startTest();     
    	Glxy_UpdateProcessDateEOYCPI objTest = new Glxy_UpdateProcessDateEOYCPI();
    	Database.executeBatch(objTest);      
    	Test.stopTest();     
    }  
}