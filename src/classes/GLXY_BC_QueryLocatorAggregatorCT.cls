global with sharing class GLXY_BC_QueryLocatorAggregatorCT implements Iterator<AggregateResult> {
    
    AggregateResult [] DataPage {get;set;} 
    Integer pageindex {get; set;}  
    string strLeaseActive = ' ';
            
    global GLXY_BC_QueryLocatorAggregatorCT(string strFiscalYear) { 
        
        Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
        Integer intFiscalYearParameter = Integer.valueof(strFiscalYear);
        
        If (intFiscalYearParameter == intCurrentFY){
            strLeaseActive = ' And LeaseStatus__c = \'Active\' ';
        }
  
        pageindex = 0; 
        //string Query =  'SELECT  FiscalYear__c FiscalYear, LeaseNumber__c LeaseNumber, DataGroup__c DataGroup, BudgetCategory__c BudgetCategory, ' + 
        //                '        Sum(FYTotal__c) FYTotal, Sum(SquareFeet__c) SquareFeet, Max(LeaseStatus__c) LeaseStatus ' +  
        //                'FROM    Glxy_BudgetCallLineItem__c ' +
        //                'Where   (BudgetCategory__c in(\'Operating Cost Escalation (CPI)\', \'Lump Sums\', \'Taxes\', \'Step Rent\', \'IBAA\', \'RWA\', \'Double Rent\', \'Project Lump Sums\', \'Project Step Rent\') OR ' +
        //                '        (BudgetCategory__c = \'Base Rent\' And LeaseStatus__c = \'Active\')) ' +
        //                'And     FiscalYear__c = :strFiscalYear ' +
        //                'And     LeaseNumber__c != null ' +
        //                'Group by FiscalYear__c, LeaseNumber__c, DataGroup__c, BudgetCategory__c ' + 
        //                'ORDER BY FiscalYear__c, LeaseNumber__c, DataGroup__c, BudgetCategory__c ';
                        
        string Query =  'SELECT  FiscalYear__c FiscalYear, LeaseNumber__c LeaseNumber, DataGroup__c DataGroup, BudgetCategory__c BudgetCategory, ' + 
                        '        Sum(FYTotal__c) FYTotal, Sum(SquareFeet__c) SquareFeet, Max(LeaseStatus__c) LeaseStatus ' +  
                        'FROM    Glxy_BudgetCallLineItem__c ' +
                        'Where   (BudgetCategory__c in(\'Operating Cost Escalation (CPI)\', \'Lump Sums\', \'Taxes\', \'Step Rent\', \'IBAA\', \'RWA\', \'Double Rent\', \'Project Lump Sums\', \'Project Step Rent\') OR ' +
                        '        (BudgetCategory__c = \'Base Rent\' ' + strLeaseActive + ')  ) ' +
                        'And     FiscalYear__c = :strFiscalYear ' +
                        'And     LeaseNumber__c != null ' +
                        'And      RegionCode__c in (\'1\',\'2\',\'3\',\'4\',\'5\',\'6\') ' +
                        'Group by FiscalYear__c, LeaseNumber__c, DataGroup__c, BudgetCategory__c ' + 
                        'ORDER BY FiscalYear__c, LeaseNumber__c, DataGroup__c, BudgetCategory__c ';
        DataPage = Database.query(Query);                 
    }
    
    global boolean hasNext(){  
        return DataPage != null && !DataPage.isEmpty() && pageindex < DataPage.size();  
    }
    
    global AggregateResult next(){
        return DataPage[pageindex++];
    }
    
}