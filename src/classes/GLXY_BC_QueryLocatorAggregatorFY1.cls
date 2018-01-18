global with sharing class GLXY_BC_QueryLocatorAggregatorFY1 implements Iterator<AggregateResult> {
	
	AggregateResult [] DataPage {get;set;} 
	Integer pageindex {get; set;}  
	Integer intCurrentFY = 0;
	String 	strCurrentFY;
	String 	strNextFiscalYear;
			
	global GLXY_BC_QueryLocatorAggregatorFY1() { 
		intCurrentFY += Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
	 	strCurrentFY = String.ValueOf(intCurrentFY);
	 	strNextFiscalYear = String.ValueOf(intCurrentFY + 1);
		
		pageindex = 0; 
		string Query =  'SELECT   LeaseNumber__c, Sum(AnnualAmount__c) AnnualAmount, ' + 
						'		  Sum(SquareFeet__c) SquareFeet, Sum(CancellationSqFt__c) CancelSquareFeet, Sum(ExpansionSqFt__c) ExpanSquareFeet, ' +  
        				'		  Max(IAConversionFY__c) IAConversionFY, Max(Lease_Expiration_Date__c) LeaseExpirationDate, Max(DelegatedLease__c) DelegatedLease, ' + 
        				'		  Max(RegionCode__c) RegionCode, Max(TeamCode__c) TeamCode, Max(LeaseStatus__c) LeaseStatus ' + 
                        'FROM  	  Glxy_BudgetCallLineItem__c ' +
                        'Where    (BudgetCategory__c  in (\'Base Rent\', \'Step Rent\', \'Project Step Rent\', \'Operating Cost Escalation (CPI)\') or BudgetCategory__c Like \'Project - %\')' +
                        'And      FiscalYear__c = :strCurrentFY ' +
                        'And      LeaseNumber__c != null ' +
                        'And      (DataGroup__c = \'NOA\' Or (DataGroup__c = \'IA\' And IAConversionFY__c != Null  And IAConversionFY__c <= :strNextFiscalYear)) ' + 
                        'Group by LeaseNumber__c ' + 
                        'ORDER BY LeaseNumber__c ';                       
        DataPage = Database.query(Query);                             
	}
	
	global boolean hasNext(){  
		return DataPage != null && !DataPage.isEmpty() && pageindex < DataPage.size();  
	}
	
	global AggregateResult next(){
		return DataPage[pageindex++];
	}
	
}