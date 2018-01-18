global with sharing class GLXY_BC_QueryLocatorAggregatorFY2 implements Iterator<AggregateResult> {
	
	AggregateResult [] DataPage {get;set;} 
	Integer pageindex {get; set;}  
	Integer intCurrentFY;
	String 	strCurrentFY;
	String 	strNextFiscalYear;
	String 	strNextFiscalYear2;
			
	global GLXY_BC_QueryLocatorAggregatorFY2() { 
		intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
	 	strCurrentFY = String.ValueOf(intCurrentFY);      
		strNextFiscalYear = String.ValueOf(intCurrentFY + 1);
		strNextFiscalYear2 = String.ValueOf(intCurrentFY + 2);
		
		pageindex = 0;
		string Query =  'SELECT   LeaseNumber__c, Sum(AnnualAmount__c) AnnualAmount, ' + 
				'		  Sum(SquareFeet__c) SquareFeet, Sum(CancellationSqFt__c) CancelSquareFeet, Sum(ExpansionSqFt__c) ExpanSquareFeet, ' +  
				'		  Max(IAConversionFY__c) IAConversionFY, Max(DelegatedLease__c) DelegatedLease, ' + 
				'		  Max(RegionCode__c) RegionCode, Max(Lease_Expiration_Date__c) LeaseExpirationDate, Max(TeamCode__c) TeamCode, Max(LeaseStatus__c) LeaseStatus ' + 
		        'FROM  	  Glxy_BudgetCallLineItem__c ' +
		        'Where   ((BudgetCategory__c  = \'Base Rent\' And FiscalYear__c = :strCurrentFY) ' +  
		        'OR    	 (BudgetCategory__c  in (\'Step Rent\', \'Project Step Rent\', \'Operating Cost Escalation (CPI)\') And FiscalYear__c <= :strNextFiscalYear) ' +  
		        'OR    	 (BudgetCategory__c Like \'Project - %\' And FiscalYear__c <= :strNextFiscalYear)) ' +
	        	'And      RegionCode__c in (\'1\',\'2\',\'3\',\'4\',\'5\',\'6\') ' +
		        'And      LeaseNumber__c != null ' +
		        'And      (DataGroup__c = \'NOA\' Or (DataGroup__c = \'IA\' And IAConversionFY__c != Null And IAConversionFY__c <= :strNextFiscalYear2)) ' +
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