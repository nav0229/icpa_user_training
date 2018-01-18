global with sharing class GLXY_BC_LoadLumpSum implements Database.Batchable<AggregateResult>,Database.stateful{
	
	global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();
	global Integer intCurrentFY;
	global Integer intLoopFY;
	GalaxyBudgetCall__c objCustomSettingsYears = GalaxyBudgetCall__c.getOrgDefaults();
	Integer intYearLimit = Integer.ValueOf(objCustomSettingsYears.DataToStoreforXFYs__c);
	//Integer intAdjustFY = Integer.ValueOf(objCustomSettingsYears.AdjustFiscalYear__c);
	 
	global Iterable<AggregateResult> start(Database.batchableContext info){ 
		return new GLXY_BC_AggregateResultIterableLumpSum(); 
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
	            BudgetCategory__c = 'Lump Sums',
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
	            BudgetCategory__c = 'Lump Sums',
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
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_LoadStepRent());
  	}

}