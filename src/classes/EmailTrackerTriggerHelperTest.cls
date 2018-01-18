/**
 * Test coverage for Acumen Solutions's development on the EmailTrackerTrigger.trigger and EmailTrackerHelper.cls
 * @author Justin Lyon
 * @created 09.24.2015
 * Author                Date            Description
   GaneshKumar Mandava    08/24/2017     Modified test class as per best practices
 */
@isTest
private class EmailTrackerTriggerHelperTest {
    
    @TestSetup static void setup() {
        
        Id accountRtId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('GSA Organization').getRecordTypeId(); 
        Id userProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA Standard Salesforce User'].Id;

        Account testAccount = TestUtil.buildAccount('testAccount', accountRtId);
        insert testAccount;
          //GSAAccountId
        App_Properties__c appPropertyAccountSetting = new App_Properties__c();
        appPropertyAccountSetting.Name = 'GSA Account Id';
        appPropertyAccountSetting.Type__c = 'GSAAccountId';
        appPropertyAccountSetting.Value__c = testAccount.id;
        insert appPropertyAccountSetting;
        
        App_Properties__c appPropertyContactSetting = new App_Properties__c();
        appPropertyContactSetting.Name = 'Contact Record Type for GSA';
        appPropertyContactSetting.Type__c = 'GSAContactRecordTypeId';
        appPropertyContactSetting.Value__c = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
        insert appPropertyContactSetting;        

        App_Properties__c appPropertyProfileSetting = new App_Properties__c();
        appPropertyProfileSetting.Name = 'GSA Standard Platform User';
        appPropertyProfileSetting.Type__c = 'ContactSyncProfile';
        appPropertyProfileSetting.Value__c = 'GSA Standard Platform User';
        insert appPropertyProfileSetting;        
        
        
        List<User> testUsers = new List<User>();
        for(Integer i = 1; i < 4; i++) {
            testUsers.add(TestUtil.buildUser(i, userProfileId, 'testContact' + i + '@fake.com'));
        }
        insert testUsers;
    }
    static testmethod void testEmailTrackerTrigger(){
        Id contactRtId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
        List<User> testUsers = [select id,FirstName,LastName,Email,FederationIdentifier from User where email like '%@fake.com'];
        Account testAccount = [select id from Account limit 1];
        
        List<Contact> testContacts = new List<Contact>();
        for(User u : testUsers) {
            Contact tempContact = TestUtil.buildContactByUser(u, contactRtId, testAccount.Id);
            tempContact.Supervisory_Status__c = 2;
            testContacts.add(tempContact);
        }
        insert testContacts;
        system.assertEquals(3,[select count() from EmailTracker__c]);
    
    }

}