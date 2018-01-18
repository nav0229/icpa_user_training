global with sharing class GLXY_BC_LoadStepRent implements Database.Batchable<AggregateResult>,Database.stateful{
	
	global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();
	global Integer intCurrentFY;
	global Integer intLoopFY;
	global string  strIANOAConversionDate;
	global Integer intIANOAConversionFY;
	AggregateResult RowData;
	
	GalaxyBudgetCall__c objCustomSettingsYears = GalaxyBudgetCall__c.getOrgDefaults();
	Integer intYearLimit = Integer.ValueOf(objCustomSettingsYears.DataToStoreforXFYs__c);
	Integer intAdjustFY = Integer.ValueOf(objCustomSettingsYears.AdjustFiscalYear__c);
	 
	global Iterable<AggregateResult> start(Database.batchableContext info){ 
		return new GLXY_BC_AggregateResultIterableStepRent(); 
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objBudgetCallRecords.clear();
		intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		
		for(sObject obj: scope) {
			RowData = (AggregateResult) obj; 
			intLoopFY = 9999;
			intIANOAConversionFY = 9999;
			
			// We need information for Current FY + 3 years
			If(!String.isEmpty(String.ValueOf(RowData.get('FiscalYear')))){
				intLoopFY = (Integer) RowData.get('FiscalYear');
				intLoopFY += intAdjustFY; 
			}
			If ((intLoopFY > (intCurrentFY + intYearLimit)) || (intLoopFY < intCurrentFY)){
            	continue;
        	}
        	If(!String.isEmpty(String.ValueOf(RowData.get('IANOAConversionDate')))){
        		strIANOAConversionDate = string.valueOf(RowData.get('IANOAConversionDate'));
				intIANOAConversionFY = Integer.valueOf(strIANOAConversionDate.trim());
        	}
        	CreateRecords();
		} 
		
		Database.SaveResult[] result = Database.Insert(objBudgetCallRecords);
	}
	
	global void CreateRecords(){
		//Assign the monthly amounts to temp variables ...
		Decimal dblJanNOA = (Decimal) RowData.get('JANNOA');
		Decimal dblFebNOA = (Decimal) RowData.get('FEBNOA');
		Decimal dblMarNOA = (Decimal) RowData.get('MARNOA');
		Decimal dblAprNOA = (Decimal) RowData.get('APRNOA');
		Decimal dblMayNOA = (Decimal) RowData.get('MAYNOA');
		Decimal dblJunNOA = (Decimal) RowData.get('JUNNOA');
		Decimal dblJulNOA = (Decimal) RowData.get('JULNOA');
		Decimal dblAugNOA = (Decimal) RowData.get('AUGNOA');
		Decimal dblSepNOA = (Decimal) RowData.get('SEPNOA');
		Decimal dblOctNOA = (Decimal) RowData.get('OCTNOA');
		Decimal dblNovNOA = (Decimal) RowData.get('NOVNOA');
		Decimal dblDecNOA = (Decimal) RowData.get('DECNOA');
		
		Decimal dblJanIA = (Decimal) RowData.get('JANIA');
		Decimal dblFebIA = (Decimal) RowData.get('FEBIA');
		Decimal dblMarIA = (Decimal) RowData.get('MARIA');
		Decimal dblAprIA = (Decimal) RowData.get('APRIA');
		Decimal dblMayIA = (Decimal) RowData.get('MAYIA');
		Decimal dblJunIA = (Decimal) RowData.get('JUNIA');
		Decimal dblJulIA = (Decimal) RowData.get('JULIA');
		Decimal dblAugIA = (Decimal) RowData.get('AUGIA');
		Decimal dblSepIA = (Decimal) RowData.get('SEPIA');
		Decimal dblOctIA = (Decimal) RowData.get('OCTIA');
		Decimal dblNovIA = (Decimal) RowData.get('NOVIA');
		Decimal dblDecIA = (Decimal) RowData.get('DECIA');
		
		Decimal dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
		Decimal dblIAAnnualAmount = ((Decimal) RowData.get('IASqFt') * (Decimal) RowData.get('AnnualAmount'))/dbTotalSqFt;
		Decimal dblNOAAnnualAmount = ((Decimal) RowData.get('NOASqFt') * (Decimal) RowData.get('AnnualAmount'))/dbTotalSqFt;
		
		If (((Decimal) RowData.get('AnnualAmount') != 0.00) && (dblIAAnnualAmount == 0.00) && (dblNOAAnnualAmount == 0.00)) {
			dblNOAAnnualAmount = (Decimal) RowData.get('AnnualAmount');
		}
			
		if (intLoopFY >= intIANOAConversionFY){ // *** Roll Over all IA data into NOA ...
			objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(intLoopFY),
	            LeaseNumber__c = String.ValueOf(RowData.get('LeaseNumber')),
	            BudgetCategory__c = 'Step Rent', 
	            DataGroup__c = 'NOA',
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				Lease_Expiration_Date__c = Date.ValueOf(RowData.get('LeaseExpirationDate')),
				AnnualAmount__c = dblIAAnnualAmount + dblNOAAnnualAmount,
				IAConversionFY__c = strIANOAConversionDate,
	            Jan__c = dblJanNOA + dblJanIA, 
	            Feb__c = dblFebNOA + dblFebIA, 
	            Mar__c = dblMarNOA + dblMarIA, 
	            Apr__c = dblAprNOA + dblAprIA, 
	            May__c = dblMayNOA + dblMayIA, 
	            Jun__c = dblJunNOA + dblJunIA,
	            Jul__c = dblJulNOA + dblJulIA, 
	            Aug__c = dblAugNOA + dblAugIA, 
	            Sep__c = dblSepNOA + dblSepIA, 
	            Oct__c = dblOctNOA + dblOctIA, 
	            Nov__c = dblNovNOA + dblNovIA, 
	            Dec__c = dblDecNOA + dblDecIA
        	));	
		} else {
				objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(intLoopFY),
	            LeaseNumber__c = String.ValueOf(RowData.get('LeaseNumber')),
	            BudgetCategory__c = 'Step Rent', 
	            DataGroup__c = 'IA' ,
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				Lease_Expiration_Date__c = Date.ValueOf(RowData.get('LeaseExpirationDate')),
				AnnualAmount__c = dblIAAnnualAmount,
				IAConversionFY__c = strIANOAConversionDate,
	            Jan__c = dblJanIA, 
	            Feb__c = dblFebIA, 
	            Mar__c = dblMarIA, 
	            Apr__c = dblAprIA, 
	            May__c = dblMayIA, 
	            Jun__c = dblJunIA,
	            Jul__c = dblJulIA, 
	            Aug__c = dblAugIA, 
	            Sep__c = dblSepIA, 
	            Oct__c = dblOctIA, 
	            Nov__c = dblNovIA, 
	            Dec__c = dblDecIA
        	));
        	objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(intLoopFY),
	            LeaseNumber__c = String.ValueOf(RowData.get('LeaseNumber')),
	            BudgetCategory__c = 'Step Rent', 
	            DataGroup__c = 'NOA' ,
	            Status__c = String.ValueOf(RowData.get('StatusCode')), 
	            RegionCode__c = String.ValueOf(RowData.get('Region')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode')),
				AnnualAmount__c = dblNOAAnnualAmount,
				IAConversionFY__c = strIANOAConversionDate,
	            Jan__c = dblJanNOA, 
	            Feb__c = dblFebNOA, 
	            Mar__c = dblMarNOA, 
	            Apr__c = dblAprNOA, 
	            May__c = dblMayNOA, 
	            Jun__c = dblJunNOA,
	            Jul__c = dblJulNOA, 
	            Aug__c = dblAugNOA, 
	            Sep__c = dblSepNOA, 
	            Oct__c = dblOctNOA, 
	            Nov__c = dblNovNOA, 
	            Dec__c = dblDecNOA
        	));
		}	
	}
	
	global void finish(Database.BatchableContext BC){
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_LoadIBAA());
  	}
    
}