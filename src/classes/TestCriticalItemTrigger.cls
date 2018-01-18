/*-------------------------------------------------------------------------------
  TestCriticalItemTrigger.cls
  Class for testing Critical Item trigger on Critical_Issues__c object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               03/25/2014   1.0       Creation
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */
//@isTest(seeAllData=true)
@isTest
private class TestCriticalItemTrigger {
 
    // test the record sharing - Insert
    @isTest
    static void testInsertSharing() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
                
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        System.runAs(thisUser) {
        // for critical items - created
        for (Integer i=0;i<200;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Ready For Signature/Approval',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        insert citemslist;
 
        // insert the records with POC  
        for (Critical_Issues__c ci : citemslist) {
            recids.add(ci.Id);
        }
      
        // assert that 50 POC shares were created for critical items
        List<Critical_Issues__Share> pocshares = [SELECT Id FROM Critical_Issues__Share WHERE 
                                                    ParentId IN :recids AND UserOrGroupId = :ciUser1Id AND AccessLevel = 'Read' 
                                                    AND RowCause = 'POC__c'];
        System.assertEquals(200,pocshares.size());
    
        }
        
    }
    
    // test the record sharing - Update
    @isTest
    static void testUpdateSharing() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        
        // for critical items - created
        for (Integer i=0;i<200;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Ready For Signature/Approval',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        insert citemslist;
        
        // update the existing records to assign them to different POCs 
        Test.startTest();
        for (Critical_Issues__c ci : citemslist) {
            ci.User__c = ciUser2Id;
            ciupdateids.add(ci.Id);
        }
        update citemslist;
        
        // assert that 5 POC shares were updated for critical items
        List<Critical_Issues__Share> pocupdshares = [SELECT Id FROM Critical_Issues__Share WHERE 
                                                        ParentId IN :ciupdateids AND UserOrGroupId = :ciUser2Id 
                                                        AND RowCause = 'POC__c'];
        System.assertEquals(200, pocupdshares.size());
        
        // assert that 5 old POC shares were deleted i.e. 0 old POC shares exist
        List<Critical_Issues__Share> pocdelshares = [SELECT Id FROM Critical_Issues__Share WHERE 
                                                        ParentId IN :ciupdateids AND UserOrGroupId = :ciUser1Id 
                                                        AND RowCause = 'POC__c'];
        System.assertEquals(0, pocdelshares.size());
        Test.stopTest();
        }
    }
    /*
    @isTest
    static void testUpdateStatusValidation() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        for (Integer i=0;i<13;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Ready For Signature/Approval',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        insert citemslist;
        
        // insert the records with POC  
        for (Integer i=0; i<13; i++) {
            recids.add(citemslist[i].Id);
            if (i == 0)
                citemslist[i].Critical_Item_Status__c='Follow-up';
            else if (i == 1)
                citemslist[i].Critical_Item_Status__c='RC Reviewed';
            else if (i == 2)
                citemslist[i].Critical_Item_Status__c='Business Line Reviewed';
            else if (i == 3)
                citemslist[i].Critical_Item_Status__c='RA Reviewed';
            else if (i == 4)
                citemslist[i].Critical_Item_Status__c='Commissioner Reviewed';
            else if (i == 5)
                citemslist[i].Critical_Item_Status__c='Commissioner Approved';
            else if (i == 6)
                citemslist[i].Critical_Item_Status__c='Staff Office Reviewed';
            else if (i == 7)
                citemslist[i].Critical_Item_Status__c='Front Office Reviewed';
            else if (i == 8)
                citemslist[i].Critical_Item_Status__c='Chief of Staff Reviewed';
            else if (i == 9)
                citemslist[i].Critical_Item_Status__c='Deputy Administrator Reviewed';
            else if (i == 10)
                citemslist[i].Critical_Item_Status__c='Administrator Reviewed';
            else if (i == 11)
                citemslist[i].Critical_Item_Status__c='Administrator Approved';
            else
                citemslist[i].Action_Required_by_Administrator__c='Ready For Signature/Approval'; 
        
        
        }
        
        // update the existing records to assign them to different POCs 
        try {
            update citemslist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
        }
    }
        
    @isTest
    static void testInsertStatusValidation() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        for (Integer i=0;i<13;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Ready For Signature/Approval',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        //insert citemslist;
        
        // insert the records with POC  
        for (Integer i=0; i<13; i++) {
            //recids.add(citemslist[i].Id);
            if (i == 0)
                citemslist[i].Critical_Item_Status__c='Follow-up';
            else if (i == 1)
                citemslist[i].Critical_Item_Status__c='RC Reviewed';
            else if (i == 2)
                citemslist[i].Critical_Item_Status__c='Business Line Reviewed';
            else if (i == 3)
                citemslist[i].Critical_Item_Status__c='RA Reviewed';
            else if (i == 4)
                citemslist[i].Critical_Item_Status__c='Commissioner Reviewed';
            else if (i == 5)
                citemslist[i].Critical_Item_Status__c='Commissioner Approved';
            else if (i == 6)
                citemslist[i].Critical_Item_Status__c='Staff Office Reviewed';
            else if (i == 7)
                citemslist[i].Critical_Item_Status__c='Front Office Reviewed';
            else if (i == 8)
                citemslist[i].Critical_Item_Status__c='Chief of Staff Reviewed';
            else if (i == 9)
                citemslist[i].Critical_Item_Status__c='Deputy Administrator Reviewed';
            else if (i == 10)
                citemslist[i].Critical_Item_Status__c='Administrator Reviewed';
            else if (i == 11)
                citemslist[i].Critical_Item_Status__c='Administrator Approved';
            else
                citemslist[i].Action_Required_by_Administrator__c='Ready For Signature/Approval';  
        
        
        }
        
        // update the existing records to assign them to different POCs 
        try {
            insert citemslist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
        }
    }
    */
    //adding users
    @isTest
    static void testUpdateStatusAddUsers() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        List<Group> grpList = [SELECT Id FROM Group WHERE DeveloperName 
            IN ('Critical_Items_Delegate_Users',
                'Critical_Items_RA_Users',
                'Critical_Items_RC_Users',
                'Critical_Items_ExecSec_Users',
                'Critical_Items_HSO_Users',
                'Critical_Items_Front_Office_Users',
                'Critical_Items_Commissioner_Users',
                'Critical_Items_Administrator_Users',
                'Critical_Items_ChiefofStaff_Users',
                'Critical_Items_DeputyAdmin_Users',               
                'Critical_Items_BusLineExec_Users')];
        for(Group grp : grpList) {
            GroupMember gm = new GroupMember(GroupId=grp.Id, UserOrGroupId=thisUser.Id);
            //GroupMemberAssign.addUserstoGroup(gm);
            insert gm;
        }    
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        for (Integer i=0;i<13;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Ready For Signature/Approval',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        insert citemslist;
        
        // insert the records with POC  
        for (Integer i=0; i<13; i++) {
            recids.add(citemslist[i].Id);
            if (i == 0)
                citemslist[i].Critical_Item_Status__c='Follow-up';
            else if (i == 1)
                citemslist[i].Critical_Item_Status__c='RC Reviewed';
            else if (i == 2)
                citemslist[i].Critical_Item_Status__c='Business Line Reviewed';
            else if (i == 3)
                citemslist[i].Critical_Item_Status__c='RA Reviewed';
            else if (i == 4)
                citemslist[i].Critical_Item_Status__c='Commissioner Reviewed';
            else if (i == 5)
                citemslist[i].Critical_Item_Status__c='Commissioner Approved';
            else if (i == 6)
                citemslist[i].Critical_Item_Status__c='Staff Office Reviewed';
            else if (i == 7)
                citemslist[i].Critical_Item_Status__c='Front Office Reviewed';
            else if (i == 8)
                citemslist[i].Critical_Item_Status__c='Chief of Staff Reviewed';
            else if (i == 9)
                citemslist[i].Critical_Item_Status__c='Deputy Administrator Reviewed';
            else if (i == 10)
                citemslist[i].Critical_Item_Status__c='Administrator Reviewed';
            else if (i == 11)
                citemslist[i].Critical_Item_Status__c='Administrator Approved';
            else
                citemslist[i].Action_Required_by_Administrator__c='Ready For Signature/Approval'; 
        
        
        }
        
        // update the existing records to assign them to different POCs 
        try {
            update citemslist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
        }
    }
    
    // adding users
    @isTest
    static void testInsertStatusAddUsers() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        List<Group> grpList = [SELECT Id FROM Group WHERE DeveloperName 
            IN ('Critical_Items_Delegate_Users',
                'Critical_Items_RA_Users',
                'Critical_Items_RC_Users',
                'Critical_Items_ExecSec_Users',
                'Critical_Items_HSO_Users',
                'Critical_Items_Front_Office_Users',
                'Critical_Items_Commissioner_Users',
                'Critical_Items_Administrator_Users',
                'Critical_Items_ChiefofStaff_Users',
                'Critical_Items_DeputyAdmin_Users',               
                'Critical_Items_BusLineExec_Users')];
        for(Group grp : grpList) {
            GroupMember gm = new GroupMember(GroupId=grp.Id, UserOrGroupId=thisUser.Id);
            //GroupMemberAssign.addUserstoGroup(gm);
            insert gm;
        }    
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        for (Integer i=0;i<13;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Ready For Signature/Approval',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        //insert citemslist;
        
        // insert the records with POC  
        for (Integer i=0; i<13; i++) {
            //recids.add(citemslist[i].Id);
            if (i == 0)
                citemslist[i].Critical_Item_Status__c='Follow-up';
            else if (i == 1)
                citemslist[i].Critical_Item_Status__c='RC Reviewed';
            else if (i == 2)
                citemslist[i].Critical_Item_Status__c='Business Line Reviewed';
            else if (i == 3)
                citemslist[i].Critical_Item_Status__c='RA Reviewed';
            else if (i == 4)
                citemslist[i].Critical_Item_Status__c='Commissioner Reviewed';
            else if (i == 5)
                citemslist[i].Critical_Item_Status__c='Commissioner Approved';
            else if (i == 6)
                citemslist[i].Critical_Item_Status__c='Staff Office Reviewed';
            else if (i == 7)
                citemslist[i].Critical_Item_Status__c='Front Office Reviewed';
            else if (i == 8)
                citemslist[i].Critical_Item_Status__c='Chief of Staff Reviewed';
            else if (i == 9)
                citemslist[i].Critical_Item_Status__c='Deputy Administrator Reviewed';
            else if (i == 10)
                citemslist[i].Critical_Item_Status__c='Administrator Reviewed';
            else if (i == 11)
                citemslist[i].Critical_Item_Status__c='Administrator Approved';
            else
                citemslist[i].Action_Required_by_Administrator__c='Ready For Signature/Approval';  
        }
        
        // update the existing records to assign them to different POCs 
        try {
            insert citemslist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
        }
    }


    @isTest
    static void testInsertValidationUnassigned() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId() 
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') LIMIT 1];
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        for (Integer i=0;i<13;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Info Only/No Action Needed',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        //insert citemslist;
        
        // insert the records with POC  
        for (Integer i=0; i<13; i++) {
            //recids.add(citemslist[i].Id);
            if (i == 0)
                citemslist[i].Critical_Item_Status__c='Follow-up';
            else if (i == 1)
                citemslist[i].Critical_Item_Status__c='RC Reviewed';
            else if (i == 2)
                citemslist[i].Critical_Item_Status__c='Business Line Reviewed';
            else if (i == 3)
                citemslist[i].Critical_Item_Status__c='RA Reviewed';
            else if (i == 4)
                citemslist[i].Critical_Item_Status__c='Commissioner Reviewed';
            else if (i == 5)
                citemslist[i].Critical_Item_Status__c='Commissioner Approved';
            else if (i == 6)
                citemslist[i].Critical_Item_Status__c='Staff Office Reviewed';
            else if (i == 7)
                citemslist[i].Critical_Item_Status__c='Front Office Reviewed';
            else if (i == 8)
                citemslist[i].Critical_Item_Status__c='Chief of Staff Reviewed';
            else if (i == 9)
                citemslist[i].Critical_Item_Status__c='Deputy Administrator Reviewed';
            else if (i == 10)
                citemslist[i].Critical_Item_Status__c='Administrator Reviewed';
            else if (i == 11)
                citemslist[i].Critical_Item_Status__c='Administrator Approved';
            else
                citemslist[i].Action_Required_by_Administrator__c='Ready For Signature/Approval';  
        
        
        }
        
        // update the existing records to assign them to different POCs 
        try {
            insert citemslist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
        }
    }
    
    @isTest
    static void testUpdateValidationUnassigned() {
 
        Set<ID> recids = new Set<ID>();
        Set<ID> ciupdateids = new Set<ID>();
        List<Critical_Issues__c> citemslist = new List<Critical_Issues__c>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[0].Id;
        ID ciUser2Id = users[1].Id;
        ID ciUser3Id = users[2].Id;
        User thisUser = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId() 
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') LIMIT 1];
        System.runAs(thisUser) {
        //citemslist = [Select Id, User__c from Critical_Issues__c LIMIT 5];
        for (Integer i=0;i<13;i++) {
            citemslist.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Info Only/No Action Needed',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        insert citemslist;
        
        // insert the records with POC  
        for (Integer i=0; i<13; i++) {
            recids.add(citemslist[i].Id);
            if (i == 0)
                citemslist[i].Critical_Item_Status__c='Follow-up';
            else if (i == 1)
                citemslist[i].Critical_Item_Status__c='RC Reviewed';
            else if (i == 2)
                citemslist[i].Critical_Item_Status__c='Business Line Reviewed';
            else if (i == 3)
                citemslist[i].Critical_Item_Status__c='RA Reviewed';
            else if (i == 4)
                citemslist[i].Critical_Item_Status__c='Commissioner Reviewed';
            else if (i == 5)
                citemslist[i].Critical_Item_Status__c='Commissioner Approved';
            else if (i == 6)
                citemslist[i].Critical_Item_Status__c='Staff Office Reviewed';
            else if (i == 7)
                citemslist[i].Critical_Item_Status__c='Front Office Reviewed';
            else if (i == 8)
                citemslist[i].Critical_Item_Status__c='Chief of Staff Reviewed';
            else if (i == 9)
                citemslist[i].Critical_Item_Status__c='Deputy Administrator Reviewed';
            else if (i == 10)
                citemslist[i].Critical_Item_Status__c='Administrator Reviewed';
            else if (i == 11)
                citemslist[i].Critical_Item_Status__c='Administrator Approved';
            else
                citemslist[i].Action_Required_by_Administrator__c='Info Only/May Require Action'; 
        }
        
        // update the existing records to assign them to different POCs 
        try {
            update citemslist;
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
        }
    }
    
}