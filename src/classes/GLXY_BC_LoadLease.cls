global with sharing class GLXY_BC_LoadLease implements Database.Batchable<sObject>,Database.stateful{
    
    global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();
    global Integer intLeaseEffectiveFY;
    global Integer intLeaseExpirationFY;
    global Integer intCurrentFY;
    global Integer intIAConversionFY;
    
    global decimal dbMonthlyIA = 0.0;
    global decimal dbMonthlyNOA = 0.0;
    global decimal dbMonthlyTotal = 0.0;
    global decimal dbSqFtIA = 0.0;
    global decimal dbSqFtNOA = 0.0;
    global decimal dbSqFtTotal = 0.0;
    global decimal dblAnnualRentIA = 0.0;
    global decimal dblAnnualRentNOA = 0.0;
    
    GalaxyBudgetCall__c objCustomSettingsYears = GalaxyBudgetCall__c.getOrgDefaults();
	//Integer intYearLimit = Integer.ValueOf(objCustomSettingsYears.DataToStoreforXFYs__c);
	//Integer intAdjustFY = Integer.ValueOf(objCustomSettingsYears.AdjustFiscalYear__c);
	
    global Database.QueryLocator start(Database.BatchableContext BC){
        string QueryAllLeases =  'SELECT Id, Name, StatusCode__c, IAConverstionFY__c, Total_IA_Annual_Rent__c, Total_NOA_Annual_Rent__c, BaseAnnualRent__c, CostPerSqFt__c, BaseSquareFeet__c, ParkingOnly__c, Apr_IA__c, Apr_NOA__c, ' +
                                 'Total_NOA_Sq_feet__c, Total_IA_Sq_feet__c, RegionCD__c, TeamCode__c, BaseStructuredParkingSpaces__c,  BaseSurfaceParkingSpaces__c, ' +
                                 'ExpirationDateofLease__c, IAConverstionDate__c, BaseLeaseEffectiveDate__c ' +
                                 'FROM  Glxy_Lease__c  ' + 
                                 //'Where StatusCode__c = \'Active\' ' + 
                                 //'And   Next_FY_Leases__c = False ' +  
                                 'ORDER BY Name ';
        Return Database.getQueryLocator(QueryAllLeases);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        
        objBudgetCallRecords.clear();
        Glxy_Lease__c objLease = null;
        intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
        
        for(sObject obj: scope) {
        	objLease = (Glxy_Lease__c) obj;
        	
        	dbMonthlyIA = 0.0;
	        dbMonthlyNOA = 0.0;
	        dbMonthlyTotal = 0.0;
	        dbSqFtIA = 0.0;
	        dbSqFtNOA = 0.0;
	        dbSqFtTotal = 0.0;
			dblAnnualRentIA = 0.0;
    		dblAnnualRentNOA = 0.0;
	    		
        	If (objLease.StatusCode__c == 'Active') { 
        		dbMonthlyIA = objLease.Apr_IA__c;
		        dbMonthlyNOA = objLease.Apr_NOA__c; 		// April NOA Formula accounts for parking Only Leases ...
		        dbMonthlyTotal = dbMonthlyNOA + dbMonthlyIA;
		        dbSqFtIA = objLease.Total_IA_Sq_feet__c;
		        dbSqFtNOA = objLease.Total_NOA_Sq_feet__c;
		        dbSqFtTotal = dbSqFtNOA + dbSqFtIA;
				dblAnnualRentIA = objLease.Total_IA_Annual_Rent__c;
	    		dblAnnualRentNOA = objLease.Total_NOA_Annual_Rent__c;
        	}
    
	        //Insert Base Rent IA
	        objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.valueOf(intCurrentFY),
	            LeaseNumber__c = objLease.Name,
	            BudgetCategory__c = 'Base Rent', 
	            DataGroup__c = 'IA',
	            Status__c = 'Actual',
	            LeaseStatus__c = objLease.StatusCode__c, 
	            Lease_Expiration_Date__c = objLease.ExpirationDateofLease__c,
	            IAConversionFY__c = objLease.IAConverstionFY__c,
	            Jan__c = dbMonthlyIA, Feb__c = dbMonthlyIA, Mar__c = dbMonthlyIA, Apr__c = dbMonthlyIA, May__c = dbMonthlyIA, Jun__c = dbMonthlyIA,
	            Jul__c = dbMonthlyIA, Aug__c = dbMonthlyIA, Sep__c = dbMonthlyIA, Oct__c = dbMonthlyIA, Nov__c = dbMonthlyIA, Dec__c = dbMonthlyIA,
	            SquareFeet__c = dbSqFtIA,
	            AnnualAmount__c = dblAnnualRentIA,
	            RegionCode__c = objLease.RegionCD__c,
	            TeamCode__c = objLease.TeamCode__c
	        ));
	        //Insert Base Rent NOA
	        objBudgetCallRecords.Add(new Glxy_BudgetCallLineItem__c(
	            FiscalYear__c = String.valueOf(intCurrentFY),
	            LeaseNumber__c = objLease.Name,
	            BudgetCategory__c = 'Base Rent', 
	            DataGroup__c = 'NOA',
	            Status__c = 'Actual',
	            LeaseStatus__c = objLease.StatusCode__c,
	            Lease_Expiration_Date__c = objLease.ExpirationDateofLease__c, 
	            IAConversionFY__c = objLease.IAConverstionFY__c,
	            Jan__c = dbMonthlyNOA, Feb__c = dbMonthlyNOA, Mar__c = dbMonthlyNOA, Apr__c = dbMonthlyNOA, May__c = dbMonthlyNOA, Jun__c = dbMonthlyNOA,
	            Jul__c = dbMonthlyNOA, Aug__c = dbMonthlyNOA, Sep__c = dbMonthlyNOA, Oct__c = dbMonthlyNOA, Nov__c = dbMonthlyNOA, Dec__c = dbMonthlyNOA,
	            SquareFeet__c = dbSqFtNOA,
	            AnnualAmount__c = dblAnnualRentNOA,
	            RegionCode__c = objLease.RegionCD__c,
	            TeamCode__c = objLease.TeamCode__c
	        ));
        }
        Database.SaveResult[] result = Database.Insert(objBudgetCallRecords);
    }
    
    global void finish(Database.BatchableContext BC){
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_LoadCPI());
    }
    
}