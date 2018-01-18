/**
 * Test coverage for Acumen Solutions's development on the ContactTriggers.trigger and ContactHelper.cls
 * @author Justin Lyon
 * @created 09.24.2015
 */
@isTest
private class ContactTriggerHelperTest {
	static final String QUEUED = 'Queued';
	static final String INITIAL_SEND = 'Initial Send';
	static final String NEW_SUPERVISOR_SURVEY = 'VOE - New Supervisor Survey';
    
	@TestSetup static void setup() {
		Id accountRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'GSA Organization'].Id;
		Id userProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA Standard Salesforce User'].Id;

		Account testAccount = TestUtil.buildAccount('testAccount', accountRtId);
		insert testAccount;
        
        //GSAAccountId
        App_Properties__c appPropertyAccountSetting = new App_Properties__c();
        appPropertyAccountSetting.Name = 'GSA Account Id';
		appPropertyAccountSetting.Type__c = 'GSAAccountId';
        appPropertyAccountSetting.Value__c = testAccount.id;
		insert appPropertyAccountSetting;
        
		List<User> testUsers = new List<User>();
		for(Integer i = 1; i < 4; i++) {
			testUsers.add(TestUtil.buildUser(i, userProfileId, 'testContact' + i + '@fake.com'));
		}

        
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
        
		// By-pass User Trigger
		//////PublicUserGroupHandler.disableGroupMemberRecalculation = true;
		//PublicUserGroupHandler.disableGroupMemberRecalculation = true;
		insert testUsers;

		//System.assert(PublicUserGroupHandler.disableGroupMemberRecalculation);
		System.assert(!testUsers.isEmpty());
	}

	static TestMethod void testCatchNewSupervisors_afterUpdate() {
		Id contactRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'GSA'].Id;

		Account testAccount = [SELECT Id FROM Account LIMIT 1];
		List<User> testUsers = [SELECT FirstName, LastName, Email, FederationIdentifier FROM User WHERE Email LIKE '%@fake.com'];

		List<Contact> testContacts = new List<Contact>();
		for(User u : testUsers) {
			Contact tempContact = TestUtil.buildContactByUser(u, contactRtId, testAccount.Id);
			tempContact.Supervisory_Status__c = 1;
			testContacts.add(tempContact);
		}
		insert testContacts;

		for(Contact c : testContacts) {
			c.Supervisory_Status__c = 2;
		}

		Test.startTest();

			update testContacts;

		Test.stopTest();

		List<EmailTracker__c> afterUpdateEmailTrackers = [SELECT Type__c, Status__c, Purpose__c, ToContact__c FROM EmailTracker__c];
		System.assertEquals(3, afterUpdateEmailTrackers.size());
		for(EmailTracker__c emt : afterUpdateEmailTrackers) {
			System.assertEquals(QUEUED, emt.Status__c);
			System.assertEquals(INITIAL_SEND, emt.Purpose__c);
			System.assertEquals(NEW_SUPERVISOR_SURVEY, emt.Type__c);
		}
	}

	static TestMethod void testCatchNewSupervisors_afterInsert() {
		Id contactRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'GSA'].Id;

		Account testAccount = [SELECT Id FROM Account LIMIT 1];
		List<User> testUsers = [SELECT FirstName, LastName, Email, FederationIdentifier FROM User WHERE Email LIKE '%@fake.com'];

		List<Contact> testContacts = new List<Contact>();
		for(User u : testUsers) {
			Contact tempContact = TestUtil.buildContactByUser(u, contactRtId, testAccount.Id);
			tempContact.Supervisory_Status__c = 2;
			testContacts.add(tempContact);
		}

		Test.startTest();

			insert testContacts;

		Test.stopTest();

		List<EmailTracker__c> afterInsertEmailTrackers = [SELECT Type__c, Status__c, Purpose__c, ToContact__c FROM EmailTracker__c];
		System.assertEquals(3, afterInsertEmailTrackers.size());
		for(EmailTracker__c emt : afterInsertEmailTrackers) {
			System.assertEquals(QUEUED, emt.Status__c);
			System.assertEquals(INITIAL_SEND, emt.Purpose__c);
			System.assertEquals(NEW_SUPERVISOR_SURVEY, emt.Type__c);
		}
	}
}