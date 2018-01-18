/*-------------------------------------------------------------------------------------
  TestTSSActionItemTrigger.cls
  Class for testing the apex trigger on TSS_Action_Item__c custom object
  -------------------------------------------------------------------------------------
   Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------------
   Rajakumar              11/05/2014  1.0       Created.
   
  -------------------------------------------------------------------------------------
  
  -------------------------------------------------------------------------------------
*/  
@isTest
private class TestTSSActionItemTrigger {
    
    @isTest
    static void doInsert() {
        List<TSS_Result_Action_Plan__c> acplist = new List<TSS_Result_Action_Plan__c>();
        List<TSS_Action_Item__c> ailist = new List<TSS_Action_Item__c>();
        /*
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 3];
        Id apUser1Id = users[0].Id;
        Id apUser2Id = users[1].Id;
        Id apUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()]; 
        */
        List<User> admusers = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') 
                            AND Id = :UserInfo.getUserId() LIMIT 1];
        Set<Id> recIds = new Set<Id>();                   
        for(Integer i=0;i<1;i++) {
            String acpname = 'AITRGI' + String.valueOf(i);
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname,
                        Building_Address__c='ABC',
                        Building_Name__c='ABC',
                        City__c='Washington',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY14',
                        Location_Code_Plus__c=acpname,
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='D.C.',
                        Supervisor__c=admusers[0].Id));
        }
        insert acplist;
        ailist.add(new TSS_Action_Item__c(Name='TSAITEM',
                   Status__c='Cancelled',
                   Estimated_Completion_Date__c=Date.today()+5,
                   Extent_of_Issue__c='Building',
                   Service_Category__c='Elevators',
                   TSS_Result_Action_Plan__c=acplist[0].Id,
                   Issue_Description__c='SAMPLETRIG'));
        try {
            insert ailist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
    }   
    
    @isTest
    static void doUpdate() {
        List<TSS_Result_Action_Plan__c> acplist = new List<TSS_Result_Action_Plan__c>();
        List<TSS_Action_Item__c> ailist = new List<TSS_Action_Item__c>();
        /*
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 3];
        Id apUser1Id = users[0].Id;
        Id apUser2Id = users[1].Id;
        Id apUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()]; 
        */
        List<User> admusers = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') 
                            AND Id = :UserInfo.getUserId() LIMIT 1];
        Set<Id> recIds = new Set<Id>();                   
        for(Integer i=0;i<1;i++) {
            String acpname = 'AITRGU' + String.valueOf(i);
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname,
                        Building_Address__c='ABC',
                        Building_Name__c='ABC',
                        City__c='Washington',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY14',
                        Location_Code_Plus__c=acpname,
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='D.C.',
                        Supervisor__c=admusers[0].Id));
        }
        insert acplist;
        ailist.add(new TSS_Action_Item__c(Name='TSAITEM',
                   Status__c='In Progress',
                   Estimated_Completion_Date__c=Date.today()+5,
                   Extent_of_Issue__c='Building',
                   Service_Category__c='Elevators',
                   TSS_Result_Action_Plan__c=acplist[0].Id,
                   Issue_Description__c='SAMPLETRIG'));
        insert ailist;
        ailist[0].Status__c='Cancelled';
        try {
            update ailist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
    }
}