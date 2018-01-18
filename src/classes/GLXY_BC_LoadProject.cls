//global with sharing class GLXY_BC_LoadProject implements Database.Batchable<AggregateResult>,Database.stateful{

global with sharing class GLXY_BC_LoadProject implements Database.Batchable<sObject>,Database.stateful{	
	
	global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();
	global Integer 	intCurrentFY;
	global Integer 	intLoopFY;
	global Date 	dtProcessDate;
	global Date		dtIAConversionDate;
	global Date		dtLeaseExpirationDate;
	global Integer 	intIANOAConversionFY;
	//Set<string> setLeases = new Set<string> ();
	Map<String,Date> LeaseMap = new Map<String,Date>(); 
	Glxy_LeaseProjects__c RowData;
	string strLeaseNumber;
	//boolean blnDelegated; 
	
	GalaxyBudgetCall__c objCustomSettingsYears = GalaxyBudgetCall__c.getOrgDefaults();
	Integer intYearLimit = Integer.ValueOf(objCustomSettingsYears.DataToStoreforXFYs__c);
	Integer intAdjustFY = Integer.ValueOf(objCustomSettingsYears.AdjustFiscalYear__c);
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		for (Glxy_Lease__c objLease : [select Name, ExpirationDateofLease__c From Glxy_Lease__c Where StatusCode__c = 'Active' And Next_FY_Leases__c = False Limit 20000]){
			//setLeases.Add(objLease.name);
			LeaseMap.put(objLease.Name,objLease.ExpirationDateofLease__c);
		}
		
		Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		Integer intCurrentFY2 = intCurrentFY + 2;
		
		string Query =   'Select NewLease__c, Name, RegionCD__c, eEorA__c, TeamCode__c, DelegatedReturn__c, IAConversionDate__c, ' + 
						 '       ProcessedDate__c, ChangeinNOASQFt__c, ChangeinIASQFt__c, ' +
						 '       JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                		 '       JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, ' + 
               			 '		 CancelARentIA__c, CancelARentNOA__c, ' +
						 '		 CancelPYCostIA__c, CancelPYCostNOA__c, ' +
						 '		 CancelSqFtIA__c, CancelSqFtNOA__c, ' +
						 ' 		 EscalARentIA__c, EscalARentNOA__c, ' + 
						 '		 EscalPYCostIA__c, EscalPYCostNOA__c, ' +
						 '		 EscalSqFtIA__c, EscalSqFtNOA__c, ' +
						 '		 ExpanARentIA__c, ExpanARentNOA__c, ' +
						 '		 ExpanPYCostIA__c, ExpanPYCostNOA__c, ' +
						 '		 ExpanSqFtIA__c, ExpanSqFtNOA__c ' + 
               			 'From   Glxy_LeaseProjects__c ' +
 	 					 'Where  BDGFlag__c = true ' + 
 	 					 'And    ProjectStatus__c <> \'Cancelled\' ' +
 	 					 'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
 	 					 'AND    FISCAL_YEAR(ProcessedDate__c) >= :intCurrentFY ' +
                         'AND    FISCAL_YEAR(ProcessedDate__c) <= :intCurrentFY2 ' +
 	 					 'ORDER BY Name';

         Return Database.getQueryLocator(Query);
    }
    
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		objBudgetCallRecords.clear();
		intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		
		for(sObject obj: scope) {
			RowData = (Glxy_LeaseProjects__c) obj;
			intIANOAConversionFY = null;
			
			dtProcessDate = Date.ValueOf(RowData.get('ProcessedDate__c'));
			intLoopFY = dtProcessDate.Month() > 9? dtProcessDate.Year() + 1 : dtProcessDate.Year();
			
        	If(!String.isEmpty(String.ValueOf(RowData.get('IAConversionDate__c')))){
        		dtIAConversionDate = Date.ValueOf(RowData.get('IAConversionDate__c'));
        		intIANOAConversionFY = dtIAConversionDate.Month() > 9? dtIAConversionDate.Year() + 1 : dtIAConversionDate.Year();
				intIANOAConversionFY += intAdjustFY; 
        	}
        	
        	strLeaseNumber = String.ValueOf(RowData.get('NewLease__c'));
        	//If(!setLeases.Contains(String.ValueOf(RowData.get('NewLease__c')))){
        	If(strLeaseNumber == null){
        		strLeaseNumber = 'NA-R' + String.ValueOf(RowData.get('RegionCD__c')); 
        	}
        	
        	/*blnDelegated = false;
        	If(!String.isEmpty(String.ValueOf(RowData.get('DelegatedReturn__c')))){
        		blnDelegated = true; 
        	}*/
        	
        	//dtLeaseExpirationDate = date.valueof(setLeasesExpirationDate);
        	If(LeaseMap.Containskey(String.ValueOf(RowData.get('NewLease__c')))){
        		dtLeaseExpirationDate = Date.valueof(LeaseMap.get(String.ValueOf(RowData.get('NewLease__c'))));
        	}else{
        		dtLeaseExpirationDate = null;
        	}
        	
			CreateRecords();
		} 
		Database.SaveResult[] result = Database.Insert(objBudgetCallRecords);
	}
	
	global void CreateRecords(){
		
		//Assign the monthly amounts to temp varaibles ...
		Decimal dblJanNOA = (Decimal) RowData.get('JAN_NOA__c');
		Decimal dblFebNOA = (Decimal) RowData.get('FEB_NOA__c');
		Decimal dblMarNOA = (Decimal) RowData.get('MAR_NOA__c');
		Decimal dblAprNOA = (Decimal) RowData.get('APR_NOA__c');
		Decimal dblMayNOA = (Decimal) RowData.get('MAY_NOA__c');
		Decimal dblJunNOA = (Decimal) RowData.get('JUN_NOA__c');
		Decimal dblJulNOA = (Decimal) RowData.get('JUL_NOA__c');
		Decimal dblAugNOA = (Decimal) RowData.get('AUG_NOA__c');
		Decimal dblSepNOA = (Decimal) RowData.get('SEP_NOA__c');
		Decimal dblOctNOA = (Decimal) RowData.get('OCT_NOA__c');
		Decimal dblNovNOA = (Decimal) RowData.get('NOV_NOA__c');
		Decimal dblDecNOA = (Decimal) RowData.get('DEC_NOA__c');
		
		Decimal dblJanIA = (Decimal) RowData.get('JAN_IA__c');
		Decimal dblFebIA = (Decimal) RowData.get('FEB_IA__c');
		Decimal dblMarIA = (Decimal) RowData.get('MAR_IA__c');
		Decimal dblAprIA = (Decimal) RowData.get('APR_IA__c');
		Decimal dblMayIA = (Decimal) RowData.get('MAY_IA__c');
		Decimal dblJunIA = (Decimal) RowData.get('JUN_IA__c');
		Decimal dblJulIA = (Decimal) RowData.get('JUL_IA__c');
		Decimal dblAugIA = (Decimal) RowData.get('AUG_IA__c');
		Decimal dblSepIA = (Decimal) RowData.get('SEP_IA__c');
		Decimal dblOctIA = (Decimal) RowData.get('OCT_IA__c');
		Decimal dblNovIA = (Decimal) RowData.get('NOV_IA__c');
		Decimal dblDecIA = (Decimal) RowData.get('DEC_IA__c');

		// Assign the Buckets to temp variables
		Decimal dblCancelAnnualRentIA = (Decimal) RowData.get('CancelARentIA__c');
		Decimal dblCancelAnnualRentNOA = (Decimal) RowData.get('CancelARentNOA__c');
		Decimal dblCancelPartYearRentIA = (Decimal) RowData.get('CancelPYCostIA__c');
		Decimal dblCancelPartYearRentNOA = (Decimal) RowData.get('CancelPYCostNOA__c');
		Decimal dblCancelSqFtIA = (Decimal) RowData.get('CancelSqFtIA__c');
		Decimal dblCancelSqFtNOA = (Decimal) RowData.get('CancelSqFtNOA__c');
		Decimal dblEscalAnnualRentIA = (Decimal) RowData.get('EscalARentIA__c');
		Decimal dblEscalAnnualRentNOA = (Decimal) RowData.get('EscalARentNOA__c');
		Decimal dblEscalPartYearRentIA = (Decimal) RowData.get('EscalPYCostIA__c');
		Decimal dblEscalPartYearRentNOA = (Decimal) RowData.get('EscalPYCostNOA__c');
		Decimal dblEscalSqFtIA = (Decimal) RowData.get('EscalSqFtIA__c');
		Decimal dblEscalSqFtNOA = (Decimal) RowData.get('EscalSqFtNOA__c');
		Decimal dblExpanAnnualRentIA = (Decimal) RowData.get('ExpanARentIA__c');
		Decimal dblExpanAnnualRentNOA = (Decimal) RowData.get('ExpanARentNOA__c');
		Decimal dblExpanPartYearRentIA = (Decimal) RowData.get('ExpanPYCostIA__c');
		Decimal dblExpanPartYearRentNOA = (Decimal) RowData.get('ExpanPYCostNOA__c');
		Decimal dblExpanSqFtRentIA = (Decimal) RowData.get('ExpanSqFtIA__c');
		Decimal dblExpanSqFtRentNOA = (Decimal) RowData.get('ExpanSqFtNOA__c');
		
		if (intLoopFY >= intIANOAConversionFY){ // *** Roll Over all IA data into NOA ...
			objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(intLoopFY),
	            LeaseNumber__c = strLeaseNumber, 
	            BudgetCategory__c = 'Project - ' + String.ValueOf(RowData.get('Name')), 
	            DataGroup__c = 'NOA',
	            RegionCode__c = String.ValueOf(RowData.get('RegionCD__c')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode__c')),
				Delegated_Return__c = (Boolean) RowData.get('DelegatedReturn__c'),
				Lease_Expiration_Date__c = dtLeaseExpirationDate,
				Status__c = String.ValueOf(RowData.get('eEorA__c')),
				SquareFeet__c = 0.00,
				IAConversionFY__c = String.ValueOf(intIANOAConversionFY),
				AnnualAmount__c = (dblCancelAnnualRentIA + dblCancelAnnualRentNOA + dblEscalAnnualRentIA + dblEscalAnnualRentNOA + dblExpanAnnualRentIA + dblExpanAnnualRentNOA),
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
	            Dec__c = dblDecNOA + dblDecIA,
	            CancellationAnnualRent__c = dblCancelAnnualRentIA + dblCancelAnnualRentNOA, 
	            CancellationPartYearCost__c = dblCancelPartYearRentIA + dblCancelPartYearRentNOA, 
	            CancellationSqFt__c = dblCancelSqFtIA + dblCancelSqFtNOA, 
	            EscalationAnnualRent__c = dblEscalAnnualRentIA + dblEscalAnnualRentNOA, 
	            EscalationPartYearCost__c = dblEscalPartYearRentIA + dblEscalPartYearRentNOA, 
	            EscalationSqFt__c = dblEscalSqFtIA + dblEscalSqFtNOA, 
	            ExpansionAnnualRent__c = dblExpanAnnualRentIA + dblExpanAnnualRentNOA, 
	            ExpansionPartYearCost__c = dblExpanPartYearRentIA + dblExpanPartYearRentNOA, 
	            ExpansionSqFt__c = dblExpanSqFtRentIA + dblExpanSqFtRentNOA
        	));
		} else { // leave it as-is, no rollover
			objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(intLoopFY),
	            LeaseNumber__c = strLeaseNumber, 
	            BudgetCategory__c = 'Project - ' + String.ValueOf(RowData.get('Name')), 
	            DataGroup__c = 'IA',
	            RegionCode__c = String.ValueOf(RowData.get('RegionCD__c')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode__c')),
				Delegated_Return__c = (Boolean) RowData.get('DelegatedReturn__c'),
				Lease_Expiration_Date__c = dtLeaseExpirationDate,
				Status__c = String.ValueOf(RowData.get('eEorA__c')),
				SquareFeet__c = 0.00,
				IAConversionFY__c = String.ValueOf(intIANOAConversionFY),
				AnnualAmount__c = (dblCancelAnnualRentIA + dblEscalAnnualRentIA+ dblExpanAnnualRentIA),
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
	            Dec__c = dblDecIA,
	            CancellationAnnualRent__c = dblCancelAnnualRentIA, 
	            CancellationPartYearCost__c = dblCancelPartYearRentIA, 
	            CancellationSqFt__c = dblCancelSqFtIA, 
	            EscalationAnnualRent__c = dblEscalAnnualRentIA, 
	            EscalationPartYearCost__c = dblEscalPartYearRentIA, 
	            EscalationSqFt__c = dblEscalSqFtIA, 
	            ExpansionAnnualRent__c = dblExpanAnnualRentIA, 
	            ExpansionPartYearCost__c = dblExpanPartYearRentIA, 
	            ExpansionSqFt__c = dblExpanSqFtRentIA
        	));
    		objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.ValueOf(intLoopFY),
	            LeaseNumber__c = strLeaseNumber, 
	            BudgetCategory__c = 'Project - ' + String.ValueOf(RowData.get('Name')), 
	            DataGroup__c = 'NOA',
	            RegionCode__c = String.ValueOf(RowData.get('RegionCD__c')),
				TeamCode__c = String.ValueOf(RowData.get('TeamCode__c')),
				Delegated_Return__c = (Boolean) RowData.get('DelegatedReturn__c'),
				Lease_Expiration_Date__c = dtLeaseExpirationDate,
				Status__c = String.ValueOf(RowData.get('eEorA__c')),
				SquareFeet__c = 0.00,
				IAConversionFY__c = String.ValueOf(intIANOAConversionFY),
				AnnualAmount__c = (dblCancelAnnualRentNOA + dblEscalAnnualRentNOA + dblExpanAnnualRentNOA),
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
	            Dec__c = dblDecNOA,
	            CancellationAnnualRent__c = dblCancelAnnualRentNOA, 
	            CancellationPartYearCost__c = dblCancelPartYearRentNOA, 
	            CancellationSqFt__c = dblCancelSqFtNOA, 
	            EscalationAnnualRent__c = dblEscalAnnualRentNOA, 
	            EscalationPartYearCost__c = dblEscalPartYearRentNOA, 
	            EscalationSqFt__c = dblEscalSqFtNOA, 
	            ExpansionAnnualRent__c = dblExpanAnnualRentNOA, 
	            ExpansionPartYearCost__c = dblExpanPartYearRentNOA, 
	            ExpansionSqFt__c = dblExpanSqFtRentNOA
        	));
		}
	}
	
	global void finish(Database.BatchableContext BC){
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_LoadProjectLumpSum());
  	}
    
}