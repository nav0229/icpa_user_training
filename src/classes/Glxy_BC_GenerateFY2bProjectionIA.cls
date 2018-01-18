global with sharing class Glxy_BC_GenerateFY2bProjectionIA implements Database.Batchable<AggregateResult>,Database.stateful{
	
	global List<Glxy_BudgetCallLineItem__c> objInsertRecords = New List<Glxy_BudgetCallLineItem__c>();
	AggregateResult objLeaseBudgetCallLineItem;
	Integer intCurrentFY;
	String 	strCurrentFY;
	
	global Iterable<AggregateResult> start(Database.batchableContext info){
	 	return new GLXY_BC_AggregateResultIterableFY2bIA(); 
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
    	
    	objInsertRecords.Clear();
    	Decimal dblMonthlyAmount;
    	Decimal dblAnnualAmount;
    	Decimal dblSquareFeet;
    	
    	intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
    	string strDataGroup;
    	
    	for(sObject obj: scope) {
    		objLeaseBudgetCallLineItem = (AggregateResult) obj;
    		
    		dblAnnualAmount = (Decimal) objLeaseBudgetCallLineItem.get('AnnualAmount');
	    	dblMonthlyAmount = (Decimal) objLeaseBudgetCallLineItem.get('AnnualAmount')/12;
	    	dblSquareFeet = (Decimal) objLeaseBudgetCallLineItem.get('SquareFeet') + (Decimal) objLeaseBudgetCallLineItem.get('CancelSquareFeet') + (Decimal) objLeaseBudgetCallLineItem.get('ExpanSquareFeet');
    		
    		//strDataGroup = String.valueOf(objLeaseBudgetCallLineItem.get('DataGroup__c'));
    		//If (strDataGroup == 'IA' && String.valueOf(intCurrentFY + 1) > String.valueOf(objLeaseBudgetCallLineItem.get('IAConversionFY'))){
    		//	strDataGroup = 'NOA';
    		//}
    		
    		objInsertRecords.Add(new Glxy_BudgetCallLineItem__c(
    			FiscalYear__c = String.valueOf(intCurrentFY + 2),
    			LeaseNumber__c = String.valueOf(objLeaseBudgetCallLineItem.get('LeaseNumber__c')),
                BudgetCategory__c = 'Base Rent',
                DataGroup__c = 'IA',
                Status__c = 'Estimate',
                Lease_Expiration_Date__c = Date.valueOf(objLeaseBudgetCallLineItem.get('LeaseExpirationDate')),
                DelegatedLease__c = String.valueOf(objLeaseBudgetCallLineItem.get('DelegatedLease')),
                RegionCode__c = String.valueOf(objLeaseBudgetCallLineItem.get('RegionCode')),
                LeaseStatus__c = String.valueOf(objLeaseBudgetCallLineItem.get('LeaseStatus')),
                TeamCode__c = String.valueOf(objLeaseBudgetCallLineItem.get('TeamCode')),
                AnnualAmount__c = dblAnnualAmount,
                SquareFeet__c = dblSquareFeet,
                Jan__c = dblMonthlyAmount, Feb__c = dblMonthlyAmount, Mar__c = dblMonthlyAmount, Apr__c = dblMonthlyAmount, May__c = dblMonthlyAmount, Jun__c = dblMonthlyAmount,
                Jul__c = dblMonthlyAmount, Aug__c = dblMonthlyAmount, Sep__c = dblMonthlyAmount, Oct__c = dblMonthlyAmount, Nov__c = dblMonthlyAmount, Dec__c = dblMonthlyAmount
            )); 	
    	}
    	
        try{    
            Database.Insert(objInsertRecords, false);
        }catch (DmlException e){
            System.debug('Glxy_BC_GenerateFY2bProjectionIA Insert error - ' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
    	//Invoke the next batch
    	database.executeBatch(new Glxy_BC_GenerateFYTotals3());
    }
    
}