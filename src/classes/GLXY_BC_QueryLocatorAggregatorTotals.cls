global with sharing class GLXY_BC_QueryLocatorAggregatorTotals implements Iterator<AggregateResult> {
	
	AggregateResult [] DataPage {get;set;} 
	Integer pageindex {get; set;}  
	//Integer intCurrentFY = 0;
	//String 	strCurrentFY, strCurrentFY2;
			
	global GLXY_BC_QueryLocatorAggregatorTotals(string strFiscalYear) { 
		//intCurrentFY += Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
	 	//strCurrentFY = String.ValueOf(intCurrentFY);
		//strCurrentFY2 = String.ValueOf(intCurrentFY + 2);
		
		pageindex = 0; 
		string Query =  'SELECT  LeaseNumber__c, FiscalYear__c, RegionCode__c RegionCode, DataGroup__c, ' +  
        				'		 Max(IAConversionFY__c) IAConversionFY, Max(DelegatedLease__c) DelegatedLease, ' + 
        				'		 Max(TeamCode__c) TeamCode, Max(Lease_Expiration_Date__c) LeaseExpirationDate, Max(LeaseStatus__c) LeaseStatus, ' + 
        				' 		 Sum(AnnualAmount__c) AnnualAmount, Sum(SquareFeet__c) SquareFeet, ' + 
        				'		 Sum(Apr__c) April, Sum(Aug__c) August, Sum(CancellationAnnualRent__c) CancellationAnnualRent, ' +  
        				'		 Sum(CancellationPartYearCost__c) CancellationPartYearCost,  Sum(CancellationSqFt__c) CancellationSqFt, ' +  
        				'		 Sum(Dec__c) December, Sum(EscalationAnnualRent__c) EscalationAnnualRent, ' +  
        				'		 Sum(EscalationPartYearCost__c) EscalationPartYearCost, Sum(EscalationSqFt__c) EscalationSqFt, ' +  
        				'		 Sum(ExpansionAnnualRent__c) ExpansionAnnualRent, Sum(ExpansionPartYearCost__c) ExpansionPartYearCost, ' +  
        				'		 Sum(ExpansionSqFt__c) ExpansionSqFt, Sum(Feb__c) February, ' +  
        				'		 Sum(Jan__c) January, ' +  
    				    '		 Sum(Jul__c) July, Sum(Jun__c) June, Sum(Mar__c) March, ' +  
        				'		 Sum(May__c) May, Sum(Nov__c) November, Sum(Oct__c) October, Sum(Sep__c) September ' + 
                        'FROM  	 Glxy_BudgetCallLineItem__c ' +
                        'Where 	 FiscalYear__c = :strFiscalYear ' +
                        'And  	 ( BudgetCategory__c Like \'Base Rent%\' OR BudgetCategory__c Like \'Project - %\' ) ' +
                        'Group by FiscalYear__c, RegionCode__c, LeaseNumber__c, DataGroup__c ' + 
                        'ORDER BY FiscalYear__c, RegionCode__c, LeaseNumber__c, DataGroup__c';
		DataPage = Database.query(Query);             
	}
	
	global boolean hasNext(){  
		return DataPage != null && !DataPage.isEmpty() && pageindex < DataPage.size();  
	}
	
	global AggregateResult next(){
		return DataPage[pageindex++];
	}
	
}