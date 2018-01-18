/*
  TestPublicUserGroupHandler.cls
  Class for testing publicUserGroupHandler object
  -------------------------------------------------------------------------------
  Author                 Date        Version  Description
  -------------------------------------------------------------------------------
  Murugaboopathi         07/02/2012  1.0      Creation
  Raja Kumar P           02/01/2016  2.0      Updated for case# 22001 test coverage
*/
//@isTest(SeeAllData=true)
@isTest
public class TestPublicUserGroupHandler {

    static testMethod void insertGroupMembers() {
        Test.startTest();
        Id acctRecTypeID = [Select r.Name, r.IsActive, r.Id From RecordType r where sObjectType = 'Account' and Name = 'Account'].id;
        Account a = new Account();
        a.Name = 'GSA';
        a.FTRD_Is_FTRD_Account__c = true;
        a.recordtypeid = acctRecTypeID;
        
        insert a;
        App_Properties__c appPropertyContactSetting = new App_Properties__c();
        appPropertyContactSetting.Name = 'Contact Record Type for GSA123';
		appPropertyContactSetting.Type__c = 'GSAContactRecordTypeId';
        appPropertyContactSetting.Value__c = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
		insert appPropertyContactSetting;  
        
        App_Properties__c appPropertyGSAAccountId = new App_Properties__c();
        appPropertyGSAAccountId.Name = 'GSA Account Id';
		appPropertyGSAAccountId.Type__c = 'GSAAccountId';
        appPropertyGSAAccountId.Value__c = a.id;
		insert appPropertyGSAAccountId;  
        

        App_Properties__c appPropertyProfileSetting = new App_Properties__c();
        appPropertyProfileSetting.Name = 'GSA Standard Platform User123';
		appPropertyProfileSetting.Type__c = 'ContactSyncProfile';
        appPropertyProfileSetting.Value__c = 'GSA Standard Platform User';
		insert appPropertyProfileSetting;        

        
        System.runAs ( new User(Id = UserInfo.getUserId()) ) {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        UserLicense userLicence = [Select u.SystemModstamp, u.Name, u.MonthlyLoginsUsed, u.MonthlyLoginsEntitlement, u.LicenseDefinitionKey, u.Id From UserLicense u where u.Name = 'Salesforce'];
                
        string randomName = string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','');     
        string userName = 't123';   
         
        User u2 = new User(Alias = 't123xy', Email=randomName+userName+'@gsa.gov', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id,MAJOR_ORG__c='A' ,Affiliation__c='Government',
        TimeZoneSidKey='America/Los_Angeles', UserName=randomName+userName+'@gsa.gov',CommunityNickname='t123xy');            
        
        Group group1 = [SELECT Id,Name FROM Group WHERE Group.DeveloperName ='A_PUBLIC_GROUP_GSASYSTEM'][0];
        insert u2;
        
        randomName = string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','');     
        userName = 't12D3';   
        User u3 = new User(Alias = 't12G5xy', Email=randomName+userName+'@gsa.gov', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id,MAJOR_ORG__c='I' ,Affiliation__c='Contractor',
        TimeZoneSidKey='America/Los_Angeles', UserName=randomName+userName+'@gsa.gov',CommunityNickname='t1235xy');            
        
        Group group3 = [SELECT Id,Name FROM Group WHERE Group.DeveloperName ='I_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM'][0];
        insert u3;
        
        Test.stopTest();
        
        List<GroupMember> preGroupMember = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :group1.Id and UserOrGroupId = :u2.Id];
        System.assertEquals(1,preGroupMember.size());
        
        List<GroupMember> preGroupMemberContractor = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :group3.Id and UserOrGroupId = :u3.Id];
        System.assertEquals(1,preGroupMemberContractor.size());
        }
        
    }
    
    static testMethod void updateGroupMembers() {

        Id acctRecTypeID = [Select r.Name, r.IsActive, r.Id From RecordType r where sObjectType = 'Account' and Name = 'Account'].id;
        Account a = new Account();
        a.Name = 'GSA';
        a.FTRD_Is_FTRD_Account__c = true;
        a.recordtypeid = acctRecTypeID;
        
        insert a;
        App_Properties__c appPropertyContactSetting = new App_Properties__c();
        appPropertyContactSetting.Name = 'Contact Record Type for GSA123';
		appPropertyContactSetting.Type__c = 'GSAContactRecordTypeId';
        appPropertyContactSetting.Value__c = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
		insert appPropertyContactSetting;  
        
        App_Properties__c appPropertyGSAAccountId = new App_Properties__c();
        appPropertyGSAAccountId.Name = 'GSA Account Id';
		appPropertyGSAAccountId.Type__c = 'GSAAccountId';
        appPropertyGSAAccountId.Value__c = a.id;
		insert appPropertyGSAAccountId;  
        

        App_Properties__c appPropertyProfileSetting = new App_Properties__c();
        appPropertyProfileSetting.Name = 'GSA Standard Platform User123';
		appPropertyProfileSetting.Type__c = 'ContactSyncProfile';
        appPropertyProfileSetting.Value__c = 'GSA Standard Platform User';
		insert appPropertyProfileSetting;        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        Profile p2 = [SELECT Id FROM Profile WHERE Name='GSA Standard Salesforce User']; 
        string randomName = string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','');     
        string userName = 't324', userName1 = 'u345', userName2 = 'x456';   
        List<User> usersToInsert = new List<User>();
        List<User> usersToUpdate = new List<User>();
        Map<Id,User> newUserMap = new Map<Id,User>(); 
        User u1 = new User(Alias = 't324xy', Email=randomName+userName+'@gsa.gov', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id,MAJOR_ORG__c='A' ,Affiliation__c='Government',Supervisory_Status__c=2,
        TimeZoneSidKey='America/Los_Angeles', UserName=randomName+userName+'@gsa.gov',CommunityNickname='t324xy');            
        usersToInsert.add(u1);
        User u3 = new User(Alias = 't324xy', Email=randomName+userName1+'@gsa.gov', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id,MAJOR_ORG__c='A' ,Affiliation__c='Contractor',Supervisory_Status__c=2,
        TimeZoneSidKey='America/Los_Angeles', UserName=randomName+userName1+'@gsa.gov',CommunityNickname='u345xy'); 
        usersToInsert.add(u3);
        User u2 = [SELECT Id, Email, UserName, Affiliation__c, MAJOR_ORG__c, Supervisory_Status__c 
                     FROM User 
                    WHERE IsActive = true AND ProfileId = :p2.Id AND Affiliation__c = 'Government' 
                    AND Supervisory_Status__c = 2 LIMIT 1];
        Group group1 = [SELECT Id,Name FROM Group WHERE Group.DeveloperName ='A_PUBLIC_GROUP_GSASYSTEM'][0];
         System.runAs ( new User(Id = UserInfo.getUserId()) ) {                
        Test.startTest();
        insert usersToInsert;
        
        u1.MAJOR_ORG__c='B';
        u1.Supervisory_Status__c = 3;
        usersToUpdate.add(u1);
        
        u2.MAJOR_ORG__c='B';
        u2.Supervisory_Status__c = 3;
        usersToUpdate.add(u2);
        
        u3.MAJOR_ORG__c='I';
        u3.Supervisory_Status__c = 3;
        usersToUpdate.add(u3);
        update usersToUpdate;
        Test.stopTest();
         }
        /*
        List<GroupMember> preGroupMember = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :group1.Id and UserOrGroupId = :u2.Id];
        System.assertEquals(1,preGroupMember.size());
        */
        Group group2 = [SELECT Id,Name FROM Group WHERE Group.DeveloperName ='B_PUBLIC_GROUP_GSASYSTEM'][0];
        List<GroupMember> preGroupMember1 = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :group2.Id and UserOrGroupId = :u2.Id];
        System.assertEquals(1,preGroupMember1.size());
        
        Group group3 = [SELECT Id,Name FROM Group WHERE Group.DeveloperName ='A_PUBLIC_GROUP_GSASYSTEM'][0];
        List<GroupMember> preGroupMember3 = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :group3.Id and UserOrGroupId = :u2.Id];
        System.assertEquals(0,preGroupMember3.size());        
    }
 
}