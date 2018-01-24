@isTest
public class OtherAssistanceDataAccessorTest {
	@isTest 
	static void getOtherAssistancebyApplicationId_givenAnApplicationId_shouldRetrieveRelatedOtherAssistance() {
	   OtherAssistanceDataAccessor otherAssistanceDA = new OtherAssistanceDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Other_Assistance__c testOtherAssistance = new Other_Assistance__c( Application__c = testApplication.Id);
		insert testOtherAssistance;

		Test.startTest();
			List<Other_Assistance__c> retrievedOtherAssistance = otherAssistanceDA.getOtherAssistancebyApplicationId(testApplication.Id);
		Test.stopTest();

		System.assert(
			retrievedOtherAssistance != null,
			'With the given Application Id, Other Assistance object should have been retrieved.'
		);

		System.assertEquals(retrievedOtherAssistance[0].Application__c, testApplication.Id, 'The incorrect Other Assistance was retrieved for the given Application Id.');
	}

	@isTest 
	static void getOtherAssistancebyApplicationIds_givenAnApplicationIds_shouldRetrieveRelatedOtherAssistance() {
	   OtherAssistanceDataAccessor otherAssistanceDA = new OtherAssistanceDataAccessor();
	   List<Id> applicationIds = new List<Id>();

		List<Application__c> testApplications = new List<Application__c>();
		testApplications.add(TestDataUtil.insertApplication());
		testApplications.add(TestDataUtil.insertApplication());

		applicationIds.add(testApplications[0].Id);
		applicationIds.add(testApplications[1].Id);

		Other_Assistance__c testOtherAssistance = new Other_Assistance__c( Application__c = testApplications[0].Id);
		insert testOtherAssistance;

		Other_Assistance__c testOtherAssistance2 = new Other_Assistance__c( Application__c = testApplications[1].Id);
		insert testOtherAssistance2;

		Test.startTest();
			List<Other_Assistance__c> retrievedOtherAssistance = otherAssistanceDA.getOtherAssistancebyApplicationIds(applicationIds);
		Test.stopTest();

		System.assert(
			retrievedOtherAssistance != null,
			'With the given Application Id, Other Assistance object should have been retrieved.'
		);

		System.assertEquals(retrievedOtherAssistance[0].Application__c, applicationIds[0], 'The incorrect Other Assistance was retrieved for the given Application Id.');
		System.assertEquals(retrievedOtherAssistance[1].Application__c, applicationIds[1], 'The incorrect Other Assistance was retrieved for the given Application Id.');
	}
}