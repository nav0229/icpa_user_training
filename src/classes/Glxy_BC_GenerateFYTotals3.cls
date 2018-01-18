global with sharing class Glxy_BC_GenerateFYTotals3 implements Database.Batchable<AggregateResult>,Database.stateful{	
	global List<Glxy_BudgetCallLineItem__c> objInsertRecords = New List<Glxy_BudgetCallLineItem__c>();
	AggregateResult objLeaseBudgetCallLineItem;
	Integer intCurrentFY;
	String 	strCurrentFY;
	String 	strCurrentFY2;
	
	global Iterable<AggregateResult> start(Database.batchableContext info){
	 	return new GLXY_BC_AggregateResultIterableTotals3(); 
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
    	
    	objInsertRecords.Clear();
    	String strStatus, strLeaseNumber, strDelegatedLease;
    	strCurrentFY = String.valueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year());
    	
    	for(sObject obj: scope) {
    		objLeaseBudgetCallLineItem = (AggregateResult) obj;
    		strStatus = 'Estimate';
    		If (String.valueOf(objLeaseBudgetCallLineItem.get('FiscalYear__c')) == strCurrentFY) strStatus = 'Actual';
    		strLeaseNumber = String.valueOf(objLeaseBudgetCallLineItem.get('LeaseNumber__c')); 
    		If(String.isEmpty(String.valueOf(objLeaseBudgetCallLineItem.get('LeaseNumber__c')))){
        		strLeaseNumber = 'Unassigned'; 
        	}
        	
        	strDelegatedLease = String.valueOf(objLeaseBudgetCallLineItem.get('DelegatedLease')); 
    		If(String.isEmpty(String.valueOf(objLeaseBudgetCallLineItem.get('DelegatedLease')))){
        		strDelegatedLease = 'False'; 
        	}
        	
    		objInsertRecords.Add(new Glxy_BudgetCallLineItem__c(
    			LeaseNumber__c = String.valueOf(objLeaseBudgetCallLineItem.get('LeaseNumber__c')),
    			FiscalYear__c = String.valueOf(objLeaseBudgetCallLineItem.get('FiscalYear__c')),
    			DataGroup__c = String.valueOf(objLeaseBudgetCallLineItem.get('DataGroup__c')),
    			DelegatedLease__c = strDelegatedLease,
                RegionCode__c = String.valueOf(objLeaseBudgetCallLineItem.get('RegionCode')),
                TeamCode__c = String.valueOf(objLeaseBudgetCallLineItem.get('TeamCode')), 
                Lease_Expiration_Date__c = Date.valueOf(objLeaseBudgetCallLineItem.get('LeaseExpirationDate')),
                LeaseStatus__c = String.valueOf(objLeaseBudgetCallLineItem.get('LeaseStatus')), 
                BudgetCategory__c = 'Total',
                Status__c = strStatus,
                State__c = String.valueOf(objLeaseBudgetCallLineItem.get('LeaseNumber__c')).substring(1,3),
                RecordIdentifier__c = (String.valueOf(objLeaseBudgetCallLineItem.get('FiscalYear__c')) + strLeaseNumber + 'Total' + String.valueOf(objLeaseBudgetCallLineItem.get('DataGroup__c'))),
                AnnualAmount__c = (Decimal) objLeaseBudgetCallLineItem.get('AnnualAmount'),
                SquareFeet__c = (Decimal) objLeaseBudgetCallLineItem.get('SquareFeet'),
                Jan__c = 0, 
                Feb__c = 0,
                Mar__c = 0,
                Apr__c = 0,
                May__c = 0,
                Jun__c = 0,
                Jul__c = 0,
                Aug__c = 0,
                Sep__c = 0,
                Oct__c = 0, 
                Nov__c = 0,
                Dec__c = 0,
                CancellationAnnualRent__c = (Decimal) objLeaseBudgetCallLineItem.get('CancellationAnnualRent'),
                CancellationPartYearCost__c = (Decimal) objLeaseBudgetCallLineItem.get('CancellationPartYearCost'),
                CancellationSqFt__c = (Decimal) objLeaseBudgetCallLineItem.get('CancellationSqFt'),
                EscalationAnnualRent__c = (Decimal) objLeaseBudgetCallLineItem.get('EscalationAnnualRent'),
                EscalationPartYearCost__c = (Decimal) objLeaseBudgetCallLineItem.get('EscalationPartYearCost'),
                EscalationSqFt__c = (Decimal) objLeaseBudgetCallLineItem.get('EscalationSqFt'),
                ExpansionAnnualRent__c = (Decimal) objLeaseBudgetCallLineItem.get('ExpansionAnnualRent'),
                ExpansionPartYearCost__c = (Decimal) objLeaseBudgetCallLineItem.get('ExpansionPartYearCost'),
                ExpansionSqFt__c = (Decimal) objLeaseBudgetCallLineItem.get('ExpansionSqFt')
            )); 	
    	}
    	
        try{    
            Database.Insert(objInsertRecords, false);
        }catch (DmlException e){
            System.debug('Glxy_BC_GenerateFYTotals Insert error - ' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
        /*//Delete this job from Scheduled Jobs ...
		GalaxyBudgetCall__c objCustomSettings = GalaxyBudgetCall__c.getOrgDefaults();
		try{	
        	System.abortJob(objCustomSettings.Schedule5_ID__c);
	 	}catch (Exception e){
        	System.debug('Glxy_BC_GenerateFYTotals3 - Job Delete error - ' + e.getMessage());
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
   		objCustomSettings2.Schedule6_ID__c = System.Schedule('GLXY_BC_ComputeLeaseTotals', cron, new GLXY_BC_JobSchedule16());
   		try{	
        	Update objCustomSettings2;
	 	}catch (Exception e){
        	System.debug('Glxy_BC_GenerateFYTotals3 Job Create error - ' + e.getMessage());
    	}*/
    	
    	//Invoke the next batch
    	database.executeBatch(new GLXY_BC_ComputeLeaseTotals3());
    }
    
    @isTest (SeeAllData=false) static void testClass(){
        
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'Unassigned',
            BudgetCategory__c = 'Base Rent',
            SquareFeet__c = 10,
            DataGroup__c = 'IA',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 3 : Datetime.Now().Date().Year() + 2));
        insert objBCEntry;
        System.Assert(objBCEntry!=NULL);
        
        //Test.startTest();     
        Glxy_BC_GenerateFYTotals3 objTest = new Glxy_BC_GenerateFYTotals3();
        Database.executeBatch(objTest);      
        //Test.stopTest();     
    } 
}