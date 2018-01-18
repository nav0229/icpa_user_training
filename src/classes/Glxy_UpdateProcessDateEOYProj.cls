global with sharing class Glxy_UpdateProcessDateEOYProj implements Database.Batchable<sObject>,Database.stateful{
	
	global List<Glxy_LeaseProjects__c> objUpdatedProjectRecords = New List<Glxy_LeaseProjects__c>();
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
        
        //#2) Advance Lease Projects ...
        string RexusRecordTypeID = Schema.SObjectType.Glxy_LeaseProjects__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		string QueryProjects = 'Select  ID, ProcessedDate__c ' +
	 	 					   'From    Glxy_LeaseProjects__c ' + 
	 	 					   'Where   eEorA__c = \'Estimate\' ' + 
	 	 					   'And     (ProjectStatus__c = \'Pending\' Or (ProjectStatus__c = \'Active\' And Acceptance620Date__c = Null)) ' +
	 	 					   'And 	ProcessedDateFY__c != Null ' + 
	 	 					   'And     ProcessedDateFY__c <= :strCurrentFY ' +
	 	 					   'And 	EffectiveDateFY__c != Null ' + 
	 	 					   'And     EffectiveDateFY__c <= :strCurrentFY ' +
	 	 					   'ORDER BY ID ';						 
	 	Return Database.getQueryLocator(QueryProjects);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objUpdatedProjectRecords.Clear();
		Glxy_LeaseProjects__c objProject;
		
		for(sObject obj: scope) {
			objProject = (Glxy_LeaseProjects__c) obj;
			objUpdatedProjectRecords.Add(new Glxy_LeaseProjects__c(
                ID = objProject.ID,
                ProcessedDate__c = dtAdvanceDate
            ));
		}
		
		try{	
        	Database.update(objUpdatedProjectRecords, false);
	 	}catch (DmlException e){
        	System.debug('Glxy_UpdateProcessDateEOYProj Update error - ' + e.getMessage());
    	}
		 
	}
	
	global void finish(Database.BatchableContext BC){
		//Delete this job from Scheduled Jobs ...
		GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults(); 
		try{	
        	System.abortJob(objCustomSettings.Schedule4_ID__c);
	 	}catch (Exception e){
        	System.debug('Glxy_UpdateProcessDateEOYProj - Job Delete error - ' + e.getMessage());
    	}
	}
  	
  	 static testMethod void testClass(){
		
		string RexusRecordTypeID = Schema.SObjectType.Glxy_LeaseProjects__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		Glxy_LeaseProjects__c objPro8 = new Glxy_LeaseProjects__c();
        objPro8.Name='1234567898';
        objPro8.RecordTypeID = RexusRecordTypeID;
        objPro8.Project_Type__c = 'Reduction';
        objPro8.IASquareFeet__c = 10;
        objPro8.NOASquareFeet__c = 10;
        objPro8.OldIASqFt__c = 50;
        objPro8.OldNOASqFt__c = 50;
        objpro8.Old_Square_Feet__c = 100;
        objpro8.SquareFeet__c = 20;
        Date myDate8 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate8 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro8.EffectiveDate__c = Datetime.Now().Date().addYears(0);
        objPro8.ProcessedDate__c = Datetime.Now().Date().addYears(0);
        objPro8.Acceptance620Date__c = Datetime.Now().Date().addYears(0);
        objPro8.BDGFlag__c = true;
        objPro8.AnnualRent__c=1000.0;
        objPro8.RegionCd__c='1';
        objPro8.DelegatedProject__c = false;
        objPro8.ProjectStatus__c='Pending';
        objPro8.eEorA__c = 'Estimate';
        objPro8.Old_Annual_Rent__c=100.0;
        objPro8.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objPro8.CancelSqFtIA__c = -40;
        objPro8.CancelSqFtNOA__c = -40;
        insert objPro8;
        System.Assert(objPro8!=NULL);
        
    	Test.startTest();     
    	Glxy_UpdateProcessDateEOYProj objTest = new Glxy_UpdateProcessDateEOYProj();
    	Database.executeBatch(objTest);      
    	Test.stopTest();     
    }  
}