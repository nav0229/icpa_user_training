global with sharing class GLXY_BC_ComputeLeaseTotals3 implements Database.Batchable<AggregateResult>,Database.stateful{
    
    global List<Glxy_BudgetCallLineItem__c> objBudgetCallRecords = New List<Glxy_BudgetCallLineItem__c>();

    global Iterable<AggregateResult> start(Database.batchableContext info){
       return new GLXY_BC_AggregateResultIterableCT3(); 
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        
        objBudgetCallRecords.clear();
        AggregateResult objBC = null;
        //intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
        
        boolean blnHasData = false;
        string strLoopCurrentLease;
        string strLoopPreviousLease = '-';
        string strRecordIdentifier;
        Glxy_BudgetCallLineItem__c objTotalRecord = New Glxy_BudgetCallLineItem__c();
        
        for(sObject obj: scope) {
            blnHasData = true;
            objBC = (AggregateResult) obj;
            
            strLoopCurrentLease = String.valueOf(objBC.get('FiscalYear')) + String.valueOf(objBC.get('LeaseNumber')) + String.valueOf(objBC.get('DataGroup'));
                    
            //Lease changed, add to list of records to be updated ...
            if ((strLoopCurrentLease <> strLoopPreviousLease) && (strLoopPreviousLease <> '-')){
                objTotalRecord.put('RecordIdentifier__c', strRecordIdentifier);
                objBudgetCallRecords.Add(objTotalRecord);
                objTotalRecord = New Glxy_BudgetCallLineItem__c();
            }
            
            strRecordIdentifier = String.valueOf(objBC.get('FiscalYear')) + String.valueOf(objBC.get('LeaseNumber')) + 'Total' + String.valueOf(objBC.get('DataGroup'));
            
            if (String.valueOf(objBC.get('BudgetCategory')) == 'Step Rent'){
                objTotalRecord.put('Oct__c', (Decimal) objBC.get('FYTotal'));
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Operating Cost Escalation (CPI)'){
                objTotalRecord.put('Nov__c', (Decimal) objBC.get('FYTotal'));   
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Taxes'){
                objTotalRecord.put('Dec__c', (Decimal) objBC.get('FYTotal'));   
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Lump Sums'){
                objTotalRecord.put('Jan__c', (Decimal) objBC.get('FYTotal'));
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'IBAA'){
                objTotalRecord.put('Feb__c', (Decimal) objBC.get('FYTotal'));           
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'RWA'){
                objTotalRecord.put('Mar__c', (Decimal) objBC.get('FYTotal'));   
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Double Rent'){
                objTotalRecord.put('Apr__c', (Decimal) objBC.get('FYTotal'));   
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Base Rent'){
                objTotalRecord.put('May__c', (Decimal) objBC.get('FYTotal'));
                //objTotalRecord.put('Aug__c', (Decimal) objBC.get('SquareFeet'));
                /*
                if (String.valueOf(objBC.get('LeaseStatus')) == 'Active'){
                    objTotalRecord.put('May__c', (Decimal) objBC.get('FYTotal'));
                    objTotalRecord.put('SquareFeet__c', (Decimal) objBC.get('SquareFeet')); 
                } else {
                    objTotalRecord.put('May__c', 0.00);
                    objTotalRecord.put('SquareFeet__c', 0.00);
                    objTotalRecord.put('AnnualAmount__c', 0.00);    
                }*/
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Project Lump Sums'){
                objTotalRecord.put('Jun__c', (Decimal) objBC.get('FYTotal'));   
            } else if (String.valueOf(objBC.get('BudgetCategory')) == 'Project Step Rent'){
                objTotalRecord.put('Jul__c', (Decimal) objBC.get('FYTotal'));           
            }
            
            strLoopPreviousLease = strLoopCurrentLease;
        }
        
        //One Last lease ...
        if (blnHasData = true){
            objTotalRecord.put('RecordIdentifier__c', strRecordIdentifier);
            objBudgetCallRecords.Add(objTotalRecord);   
        }
        try{    
            Database.UpsertResult[] results = Database.Upsert(objBudgetCallRecords, Schema.Glxy_BudgetCallLineItem__c.RecordIdentifier__c, false);
        }catch (Exception e){
            System.debug('GLXY_BC_ComputeLeaseTotals3 Upsert error - ' + e.getMessage());
        }   
    }
    
    global void finish(Database.BatchableContext BC){
        /*//Delete this job from Scheduled Jobs ...
        GalaxyBudgetCall__c objCustomSettings = GalaxyBudgetCall__c.getOrgDefaults();
        try{    
            System.abortJob(objCustomSettings.Schedule8_ID__c);
        }catch (Exception e){
            System.debug('GLXY_BC_ComputeLeaseTotals - Job Delete error - ' + e.getMessage());
        }*/
        
        // Update the Process Completion Date ...
        /*GalaxyBudgetCall__c objCustomSettings2 = GalaxyBudgetCall__c.getOrgDefaults();
        objCustomSettings2.Apex_Jobs_Run_Date__c = datetime.now();
        try{    
            Update objCustomSettings2;
        }catch (Exception e){
            System.debug('GLXY_BC_ComputeLeaseTotals Custom Setting update error - ' + e.getMessage());
        }*/
        //Invoke the next batch
      database.executeBatch(new GLXY_BC_ComputeLeaseTotals3a());
    }
    
    @isTest (SeeAllData=false) static void testGLXY_BC_ComputeLeaseTotals3(){
        
        integer intFiscalYear = (Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year());
        intFiscalYear += 2;
        string  strFiscalYear = String.ValueOf(intFiscalYear);
        List<Glxy_BudgetCallLineItem__c> objBCRecords = New List<Glxy_BudgetCallLineItem__c>();
        
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry); 
        
        Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry2); 
        
        Glxy_BudgetCallLineItem__c objBCEntry3 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry3); 
        
        Glxy_BudgetCallLineItem__c objBCEntry4 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry4); 
        
        Glxy_BudgetCallLineItem__c objBCEntry5 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry5); 
        
        Glxy_BudgetCallLineItem__c objBCEntry6 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry6); 
        
        Glxy_BudgetCallLineItem__c objBCEntry7 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry7); 
        
        Glxy_BudgetCallLineItem__c objBCEntry8 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry8); 
        
        Glxy_BudgetCallLineItem__c objBCEntry9 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry9); 
        
        Glxy_BudgetCallLineItem__c objBCEntry10 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry10); 
        
        Glxy_BudgetCallLineItem__c objBCEntry11 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry11);
        
        insert objBCRecords;
        System.Assert(objBCRecords!=NULL);
        
        //Test.startTest();     
        GLXY_BC_ComputeLeaseTotals3 objTest = new GLXY_BC_ComputeLeaseTotals3();
        Database.executeBatch(objTest);      
        //Test.stopTest();     
    } 
    
}