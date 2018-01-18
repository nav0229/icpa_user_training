global with sharing class GLXY_BC_LoadTaxes implements Database.Batchable<AggregateResult>,Database.stateful{
	
	global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();
	global Integer intCurrentFY;
	global Integer intLoopFY;
	GalaxyBudgetCall__c objCustomSettingsYears = GalaxyBudgetCall__c.getOrgDefaults();
	Integer intYearLimit = Integer.ValueOf(objCustomSettingsYears.DataToStoreforXFYs__c);
	//Integer intAdjustFY = Integer.ValueOf(objCustomSettingsYears.AdjustFiscalYear__c);
	 
	global Iterable<AggregateResult> start(Database.batchableContext info){ 
		return new GLXY_BC_AggregateResultIterableTaxes(); 
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objBudgetCallRecords.clear();
		intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		
		for(sObject obj: scope) {
			AggregateResult RowData = (AggregateResult) obj; 
			intLoopFY = 9999;
			
			// We need information for Current FY + 3 years
			If(!String.isEmpty(String.ValueOf(RowData.get('FiscalYear')))){
				intLoopFY = Integer.valueOf(String.ValueOf(RowData.get('FiscalYear')));
			}
			If ((intLoopFY > (intCurrentFY + intYearLimit)) || (intLoopFY < intCurrentFY)){
            	continue;
        	} 
        	
			objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(RowData.get('FiscalYear')),
	            LeaseNumber__c = String.ValueOf(RowData.get('LeaseNumber')),
	            BudgetCategory__c = 'Taxes',
	            DataGroup__c = 'IA',
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				Lease_Expiration_Date__c = Date.ValueOf(RowData.get('LeaseExpirationDate')),
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
	            LeaseNumber__c = String.ValueOf(RowData.get('LeaseNumber')),
	            BudgetCategory__c = 'Taxes',
	            DataGroup__c = 'NOA' ,
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				Lease_Expiration_Date__c = Date.ValueOf(RowData.get('LeaseExpirationDate')),
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
        	System.abortJob(objCustomSettings.Schedule12_ID__c);
	 	}catch (Exception e){
        	System.debug('GLXY_BC_LoadTaxes - Job Delete error - ' + e.getMessage());
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
   		objCustomSettings2.Schedule13_ID__c = System.Schedule('Glxy_BC_UpdateDelegatedFlag', cron, new GLXY_BC_JobSchedule12());
   		try{	
        	Update objCustomSettings2;
	 	}catch (Exception e){
        	System.debug('GLXY_BC_LoadTaxes Job Create error - ' + e.getMessage());
    	}*/
    	//Invoke the next batch
    	database.executeBatch(new Glxy_BC_UpdateDelegatedFlag());
  	}
    
    @isTest static void testClass(){
    	
    	Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
 	  	 	StatusCode__c='Active',
	   		BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
	 		ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
	 		IAConverstionDate__c=Datetime.Now().Date().addYears(5),
	 		RegionCD__c='11',
	 		Total_NOA_Sq_feet__c = 0,
	 		Total_IA_Sq_feet__c = 0,
	  		name='testte',
	  		Next_FY_Leases__c = False,
	 		BaseAnnualRent__c = 2222);
 		insert objleaseEntry;
 		System.Assert(objleaseEntry!=NULL);
 		
 		Glxy_LumpSum__c objLS = new Glxy_LumpSum__c (
	        LeaseNumber__c = objleaseEntry.id,
	        LumSumType__c = 'Tax Escalation',
	        FY_Obligation__c = 0,
	        EffectiveDate__c = Datetime.Now().Date(),
	        ExpirationDate__c = Datetime.Now().Date().addYears(2),
	        Acceptance620Date__c = Datetime.Now().Date(),
	        BDGFlag__c = true
        );
        insert objLS;
        System.AssertNotEquals(objLS,NULL);
        
        Glxy_LumpSumObligations__c objLSO = new Glxy_LumpSumObligations__c (
            LumpSum__c = objLS.id,
            FiscalYear__c = '2014',
            FYAndLSId__c = '2014qqqqqqq'
        );
        insert objLSO;
        System.AssertNotEquals(objLSO,NULL);
        
        Glxy_LumpSumObligations__c objLSO2 = new Glxy_LumpSumObligations__c (
            LumpSum__c = objLS.id,
            FiscalYear__c = '2018',
            FYAndLSId__c = '2018qqqqqqq'
        );
        insert objLSO2;
        System.AssertNotEquals(objLSO2,NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
            
    	Test.startTest();     
    	GLXY_BC_LoadTaxes objTest = new GLXY_BC_LoadTaxes();
    	Database.executeBatch(objTest);      
    	Test.stopTest();     
    } 
    
}