@isTest
private class ApplicationDataPopulatorTest
{
	@isTest
	static void populateDataOnNewApplications_givenHomeApplication_shouldSetLookupToHomeAppProcVariables(){
		MockSObjectBuilder mockAppProcVarBuilder = new MockSObjectBuilder(App_Processing_Variables__c.getSObjectType());
		Id mockTestId = mockAppProcVarBuilder.getMockId();
		mockAppProcVarBuilder.setField('Id', mockTestId);
		mockAppProcVarBuilder.setField('Application_Type__c', ApplicationDataAccessor.APPLICATION_TYPE_HOME);

		MockAppProcessingVariablesDA mockAppProcVarDA = new MockAppProcessingVariablesDA();
		mockAppProcVarDA.getNewestActiveAppProcessingVariableByTypeHomeReturn = (App_Processing_Variables__c) mockAppProcVarBuilder.build();

		ApplicationDataPopulator.appProcessingVariablesDA = mockAppProcVarDA;
		ApplicationDataPopulator testAppDataPopulator = new ApplicationDataPopulator();


		MockSObjectBuilder mockAppBuilder = new MockSObjectBuilder(Application__c.getSObjectType());

		Schema.DescribeSObjectResult describeResult = Application__c.SObjectType.getDescribe();
		List<Schema.RecordTypeInfo> recordTypeInfos = describeResult.getRecordTypeInfos();
		for(Schema.RecordTypeInfo info : recordTypeInfos){
			if(info.getName() == ApplicationDataAccessor.APP_RT_NAME_HOME){
				mockAppBuilder.setField('RecordTypeId', info.getRecordTypeId());
			}
		}
		
		Application__c testApplication = (Application__c) mockAppBuilder.build();
		List<Application__c> testApps = new List<Application__c>{testApplication};

		Test.startTest();
			testAppDataPopulator.populateDataOnNewApplications(testApps);
		Test.stopTest();

		System.assertEquals(mockTestId, testApplication.App_Processing_Variables__c, 'App_Processing_Variables__c was not correctly set');
	}

	@isTest
	static void populateDataOnNewApplications_givenBusinessApplication_shouldSetLookupToBusinessAppProcVariables(){
		MockSObjectBuilder mockAppProcVarBuilder = new MockSObjectBuilder(App_Processing_Variables__c.getSObjectType());
		Id mockTestId = mockAppProcVarBuilder.getMockId();
		mockAppProcVarBuilder.setField('Id', mockTestId);
		mockAppProcVarBuilder.setField('Application_Type__c', ApplicationDataAccessor.APPLICATION_TYPE_BUSINESS);

		MockAppProcessingVariablesDA mockAppProcVarDA = new MockAppProcessingVariablesDA();
		mockAppProcVarDA.getNewestActiveAppProcessingVariableByTypeBusinessReturn = (App_Processing_Variables__c) mockAppProcVarBuilder.build();

		ApplicationDataPopulator testAppDataPopulator = new ApplicationDataPopulator();
		ApplicationDataPopulator.appProcessingVariablesDA = mockAppProcVarDA;


		MockSObjectBuilder mockAppBuilder = new MockSObjectBuilder(Application__c.getSObjectType());

		Schema.DescribeSObjectResult describeResult = Application__c.SObjectType.getDescribe();
		List<Schema.RecordTypeInfo> recordTypeInfos = describeResult.getRecordTypeInfos();
		for(Schema.RecordTypeInfo info : recordTypeInfos){
			if(info.getName() == ApplicationDataAccessor.APP_RT_NAME_BUSINESS){
				mockAppBuilder.setField('RecordTypeId', info.getRecordTypeId());
			}
		}
		
		Application__c testApplication = (Application__c) mockAppBuilder.build();
		List<Application__c> testApps = new List<Application__c>{testApplication};

		Test.startTest();
			testAppDataPopulator.populateDataOnNewApplications(testApps);
		Test.stopTest();

		System.assertEquals(mockTestId, testApplication.App_Processing_Variables__c, 'App_Processing_Variables__c was not correctly set');
	}

	public class MockAppProcessingVariablesDA implements AppProcessingVariablesDAO {
		Integer getNewestActiveAppProcessingVariableByTypeCallCount { get; private set; }

		public App_Processing_Variables__c getNewestActiveAppProcessingVariableByTypeHomeReturn;
		public App_Processing_Variables__c getNewestActiveAppProcessingVariableByTypeBusinessReturn;

		public mockAppProcessingVariablesDA(){
			getNewestActiveAppProcessingVariableByTypeCallCount = 0;
		}

		public App_Processing_Variables__c getNewestActiveAppProcessingVariableByType(String appType){
			getNewestActiveAppProcessingVariableByTypeCallCount++;

			if(appType == ApplicationDataAccessor.APPLICATION_TYPE_HOME){
				return getNewestActiveAppProcessingVariableByTypeHomeReturn;
			} else if(appType == ApplicationDataAccessor.APPLICATION_TYPE_BUSINESS){
				return getNewestActiveAppProcessingVariableByTypeBusinessReturn;
			} else {
				throw new QueryException('Unable to find App Processing Variable Record so bad things happened');
				return null;
			}
		}
	}
}