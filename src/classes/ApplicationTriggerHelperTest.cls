@isTest
private class ApplicationTriggerHelperTest
{
	@isTest
	static void beforeInsert_givenNonNullList_shouldCallPopulateDateOnNewApplications(){
		ApplicationDataPopulatorMock mockApplicationDataPopulator = new ApplicationDataPopulatorMock();
		ApplicationTriggerHelper.applicationDataPopulator = mockApplicationDataPopulator;
		ApplicationTriggerHelper testController = new ApplicationTriggerHelper();

		List<Application__c> testApplications = new List<Application__c>();

		Test.startTest();
			testController.beforeInsert(testApplications);
		Test.stopTest();

		System.assertEquals(1, mockApplicationDataPopulator.populateDataOnNewApplicationsCallCount);
	}

	public class ApplicationDataPopulatorMock implements ApplicationDataPopulatorInterface {
		public Integer populateDataOnNewApplicationsCallCount;

		public ApplicationDataPopulatorMock(){
			populateDataOnNewApplicationsCallCount = 0;
		}

		public void populateDataOnNewApplications(List<Application__c> applications){
			populateDataOnNewApplicationsCallCount++;
		}
	}
}