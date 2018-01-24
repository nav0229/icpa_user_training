@isTest
private class ProcessingAppReviewTriggerHelperTest {
	@isTest
	static void beforeInsert_givenListOfPAR_shouldRunEligiblePhysicalLossCalculator() {
		ProcessingApplicationReviewTriggerHelper parTriggerHelper = new ProcessingApplicationReviewTriggerHelper();

		List<Processing_Application_Review__c> processingApplicationReviewList = new List<Processing_Application_Review__c>();

		Test.startTest();
			parTriggerHelper.beforeInsert(processingApplicationReviewList);
		Test.stopTest();
	}
}