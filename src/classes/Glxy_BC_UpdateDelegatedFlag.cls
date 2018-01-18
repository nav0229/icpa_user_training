global with sharing class Glxy_BC_UpdateDelegatedFlag implements Database.Batchable<sObject>,Database.stateful{
    
    global List<Glxy_BudgetCallLineItem__c> objUpdatedRecords = New List<Glxy_BudgetCallLineItem__c>();
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        string Query =  'SELECT  ID, Name, LeaseID__c, Delegated_Lease_Rep_lkp__c, StatusCode__c, ExpirationDateofLease__c ' + 
                        'FROM  Glxy_Lease__c  ' + 
                        //'Where StatusCode__c = \'Active\' ' + 
                        //'AND   Next_FY_Leases__c = False ' +  
                        'ORDER BY Name ';
        Return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        objUpdatedRecords.Clear();
        Set<String> objSetLeases = New Set<String>(); 
        objSetLeases.Clear();
        Map<String, Glxy_Lease__c> objMapLeases = new Map<String, Glxy_Lease__c>();
        objMapLeases.Clear();
        
        Glxy_Lease__c objLease = null;
        for(sObject obj: scope) {
        	objLease = (Glxy_Lease__c) obj;
        	System.Debug('Lease = ' + objLease.Name);
            objSetLeases.add(objLease.Name);
            objMapLeases.put(objLease.Name, objLease);
        }
        
        List<Glxy_BudgetCallLineItem__c> objBudgetCallLineItems = [    
            Select  ID, LeaseNumber__c
            From    Glxy_BudgetCallLineItem__c  
            Where   LeaseNumber__c in :objSetLeases
            Order by LeaseNumber__c];
                
        for (Glxy_BudgetCallLineItem__c RowData : objBudgetCallLineItems) { 
        	System.Debug('LeaseLoop = ' + objLease.LeaseID__c);
        	System.Debug('LeaseLoopFlag = ' + objMapLeases.get(RowData.LeaseNumber__c));
            objUpdatedRecords.Add(new Glxy_BudgetCallLineItem__c(
                ID = RowData.ID,
                State__c = String.valueOf(RowData.LeaseNumber__c).substring(1,3),
                DelegatedLease__c = objMapLeases.get(RowData.LeaseNumber__c).Delegated_Lease_Rep_lkp__c,
                LeaseStatus__c = objMapLeases.get(RowData.LeaseNumber__c).StatusCode__c
                //Lease_Expiration_Date__c = objMapLeases.get(RowData.LeaseNumber__c).ExpirationDateofLease__c
            ));
        }  
     
        try{    
            Database.update(objUpdatedRecords, false);
        }catch (DmlException e){
            System.debug('Glxy_UpdateDelegatedFlag Update error - ' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
 		
    	//Invoke the next batch
    	database.executeBatch(new Glxy_BC_GenerateFYTotals());
    	
    }
    
    @isTest (SeeAllData=false) static void testClass(){
        
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c = Datetime.Now().Date().addYears(-5),
            ExpirationDateofLease__c = Datetime.Now().Date().addYears(+5),
            IAConverstionDate__c = Datetime.Now().Date().addYears(+2),
            RegionCD__c = '11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='LDE00374',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374');
        insert objBCEntry;
        
        //Test.startTest();     
        Glxy_BC_UpdateDelegatedFlag objTest = new Glxy_BC_UpdateDelegatedFlag();
        Database.executeBatch(objTest);      
        //Test.stopTest();     
    } 
}