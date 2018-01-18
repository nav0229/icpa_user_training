// Anything user related goes through the User Trigger which queries for CollaborationGroup
@isTest
private class SurveyIndividualAnswerHelperTest {

	static TestMethod void testRelateToQuestions() {
		List<SurveyIndividualAnswer__c> testAnswers = setupTestData();

		Test.startTest();

			insert testAnswers;

		Test.stopTest();

		List<SurveyIndividualAnswer__c> afterInsertAnswers = [
			SELECT SurveyIndividualQuestion__c
			FROM SurveyIndividualAnswer__c];

		for(SurveyIndividualAnswer__c a : afterInsertAnswers) {
			System.assert(a.SurveyIndividualQuestion__c != null);
		}
	}

	private static List<SurveyIndividualAnswer__c> setupTestData() {
		Id contactRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'GSA'].Id;
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

		// By-pass User Trigger
		////PublicUserGroupHandler.disableGroupMemberRecalculation = true;
		insert testUsers;

		List<Contact> testContacts = new List<Contact>();
		for(User u : testUsers) {
			testContacts.add(TestUtil.buildContactByUser(u, contactRtId, testAccount.Id));
		}
		insert testContacts;

		Survey2__c testSurvey = TestUtil.buildSurveyMaster('Test Survey');
		insert testSurvey;

		List<SurveyFeedback__c> testFeedbacks = new List<SurveyFeedback__c>();
		for(Contact c : testContacts) {
			testFeedbacks.add(TestUtil.buildSurveyFeedback(c.Id, testSurvey.Id));
		}
		insert testFeedbacks;

		List<SurveyIndividualQuestion__c> testQuestions = new List<SurveyIndividualQuestion__c>();
		for(Integer i = 0; i < 3; i++) {
			testQuestions.add(TestUtil.buildSurveyQuestion('Q'+i, testSurvey.Id));
		}
		insert testQuestions;

		List<SurveyIndividualAnswer__c> testAnswers = new List<SurveyIndividualAnswer__c>();
		for(SurveyFeedback__c sf : testFeedbacks) {
			for(SurveyIndividualQuestion__c q : testQuestions) {
				testAnswers.add(TestUtil.buildSurveyAnswer(sf.Id, q.Name));
			}
		}

		return testAnswers;
	}
}