@isTest
private class AppProcessingVariablesDataAccessorTest {
	
	@isTest static void getNewestActiveAppProcessingVariableByType_givenAnApplicationType_shouldReturnAppProcessingVariable() {
		AppProcessingVariablesDataAccessor appProcessingDA = new AppProcessingVariablesDataAccessor();

		App_Processing_Variables__c testVariable = new App_Processing_Variables__c(
			Application_Type__c = 'Home'
		);
		insert testVariable;

		Test.startTest();
			App_Processing_Variables__c retrievedVariable = appProcessingDA.getNewestActiveAppProcessingVariableByType(testVariable.Application_Type__c);
		Test.stopTest();

		System.assert(
			retrievedVariable != null,
			'With the given Application Type, an App Processing Variable should have been retrieved.'
		);

		System.assertEquals(
			testVariable.Id,
			retrievedVariable.Id,
			'With the given Application Type, the test App Processing Variable that was inserted should have been retrieved.'
		);
	}
	
}