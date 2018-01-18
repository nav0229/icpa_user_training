global with sharing class GLXY_BC_LoadProjectLumpSum implements Database.Batchable<AggregateResult>,Database.stateful{
	
	global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();
	global Integer intCurrentFY;
	global Integer intLoopFY;
	global Date	   dtLeaseExpirationDate;
	GalaxyBudgetCall__c objCustomSettingsYears = GalaxyBudgetCall__c.getOrgDefaults();
	Integer intYearLimit = Integer.ValueOf(objCustomSettingsYears.DataToStoreforXFYs__c);
	//Integer intAdjustFY = Integer.ValueOf(objCustomSettingsYears.AdjustFiscalYear__c);
	Set<string> setLeases = new Set<string> ();
	Map<String,Date> LeaseMap = new Map<String,Date>(); 
	string strLeaseNumber;
	 
	global Iterable<AggregateResult> start(Database.batchableContext info){ 
		for (Glxy_Lease__c objLease : [select Name, ExpirationDateofLease__c From Glxy_Lease__c Where StatusCode__c = 'Active' And Next_FY_Leases__c = False Limit 20000]){
			setLeases.Add(objLease.name);
			LeaseMap.put(objLease.Name,objLease.ExpirationDateofLease__c);
		}
		return new GLXY_BC_AggregateResultIterableProjectLS(); 
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objBudgetCallRecords.clear();
		intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		
		for(sObject obj: scope) {
			AggregateResult RowData = (AggregateResult) obj; 
			intLoopFY = 9999;
			
			// We need information for Current FY +- 3 years
			If(!String.isEmpty(String.ValueOf(RowData.get('FiscalYear')))){
				intLoopFY = Integer.valueOf(String.ValueOf(RowData.get('FiscalYear')));
			}
			If ((intLoopFY > (intCurrentFY + intYearLimit)) || (intLoopFY < intCurrentFY)){
            	continue;
        	} 
        	
        	strLeaseNumber = String.ValueOf(RowData.get('LeaseNumber'));
        	//If(!setLeases.Contains(String.ValueOf(RowData.get('LeaseNumber')))){
        	If(strLeaseNumber == null){
        		strLeaseNumber = 'NA-R' + String.ValueOf(RowData.get('Region')); 
        	}
        	
        	//dtLeaseExpirationDate = date.valueof(setLeasesExpirationDate);
        	If(LeaseMap.Containskey(String.ValueOf(RowData.get('LeaseNumber')))){
        		dtLeaseExpirationDate = Date.valueof(LeaseMap.get(String.ValueOf(RowData.get('LeaseNumber'))));
        	}else{
        		dtLeaseExpirationDate = null;
        	}
        	
			objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(RowData.get('FiscalYear')),
	            LeaseNumber__c = strLeaseNumber,
	            BudgetCategory__c = 'Project Lump Sums', 
	            DataGroup__c = 'IA' ,
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				Lease_Expiration_Date__c = dtLeaseExpirationDate,
				AnnualAmount__c = (Decimal) RowData.get('AnnualAmountIA'),
	            Jan__c = (Decimal) RowData.get('JANIA'), 
	            Feb__c = (Decimal) RowData.get('FEBIA'), 
	            Mar__c = (Decimal) RowData.get('MARIA'), 
	            Apr__c = (Decimal) RowData.get('APRIA'), 
	            May__c = (Decimal) RowData.get('MAYIA'), 
	            Jun__c = (Decimal) RowData.get('JUNIA'),
	            Jul__c = (Decimal) RowData.get('JULIA'), 
	            Aug__c = (Decimal) RowData.get('AUGIA'), 
	            Sep__c = (Decimal) RowData.get('SEPIA'), 
	            Oct__c = (Decimal) RowData.get('OCTIA'), 
	            Nov__c = (Decimal) RowData.get('NOVIA'), 
	            Dec__c = (Decimal) RowData.get('DECIA')
        	));
        	
        	objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(RowData.get('FiscalYear')),
	            LeaseNumber__c = strLeaseNumber,
	            BudgetCategory__c = 'Project Lump Sums', 
	            DataGroup__c = 'NOA' ,
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				Lease_Expiration_Date__c = dtLeaseExpirationDate,
				AnnualAmount__c = (Decimal) RowData.get('AnnualAmountNOA'),
	            Jan__c = (Decimal) RowData.get('JANNOA'), 
	            Feb__c = (Decimal) RowData.get('FEBNOA'), 
	            Mar__c = (Decimal) RowData.get('MARNOA'), 
	            Apr__c = (Decimal) RowData.get('APRNOA'), 
	            May__c = (Decimal) RowData.get('MAYNOA'), 
	            Jun__c = (Decimal) RowData.get('JUNNOA'),
	            Jul__c = (Decimal) RowData.get('JULNOA'), 
	            Aug__c = (Decimal) RowData.get('AUGNOA'), 
	            Sep__c = (Decimal) RowData.get('SEPNOA'), 
	            Oct__c = (Decimal) RowData.get('OCTNOA'), 
	            Nov__c = (Decimal) RowData.get('NOVNOA'), 
	            Dec__c = (Decimal) RowData.get('DECNOA')
        	));
		} 
		
		Database.SaveResult[] result = Database.Insert(objBudgetCallRecords);
	}
	
	global void finish(Database.BatchableContext BC){
		/*//Delete this job from Scheduled Jobs ...
		GalaxyBudgetCall__c objCustomSettings = GalaxyBudgetCall__c.getOrgDefaults();
		try{	
        	System.abortJob(objCustomSettings.Schedule10_ID__c);
	 	}catch (Exception e){
        	System.debug('GLXY_BC_LoadProjectLumpSum - Job Delete error - ' + e.getMessage());
    	}
		
		//Invoke the NEXT job ...
		GalaxyBudgetCall__c objCustomSettings2 = GalaxyBudgetCall__c.getOrgDefaults();
   		DateTime n = datetime.now().addMinutes(1);
   		String cron = '';
   		cron += n.second();
   		cron += ' ' + n.minute();
   		cron += ' ' + n.hour();
   		cron += ' ' + n.day();
   		cron += ' ' + n.month();
   		cron += ' ' + '?';
   		cron += ' ' + n.year();
   		objCustomSettings2.Schedule11_ID__c = System.Schedule('GLXY_BC_LoadProjectStepRent', cron, new GLXY_BC_JobSchedule11());
   		try{	
        	Update objCustomSettings2;
	 	}catch (Exception e){
        	System.debug('GLXY_BC_LoadProjectLumpSum Job Create error - ' + e.getMessage());
    	}*/
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_LoadProjectStepRent());
  	}
    
    @isTest static void testClass(){
    	
    	Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        Date myDate = Datetime.Now().Date();
        objPro.EffectiveDate__c=myDate;
        objPro.AnnualRent__c=1000.0;
        objPro.RegionCd__c='1';
        objPro.ProjectStatus__c='Active';
        objPro.Old_Annual_Rent__c=1000.0;
        insert objPro;
 		System.Assert(objPro!=NULL);
 		
		Glxy_LPLumpSum__c objTest = new Glxy_LPLumpSum__c();
		objTest.ProjectNumber__c = objPro.id;
		objTest.EffectiveDate__c = myDate;
		objTest.ExpirationDate__c = myDate;
		insert objTest;
		System.Assert(objTest!=NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
                    
    	Test.startTest();     
    	GLXY_BC_LoadProjectLumpSum objTest2 = new GLXY_BC_LoadProjectLumpSum();
    	Database.executeBatch(objTest2);      
    	Test.stopTest();     
    } 
    
}