@isTest
private class ApplicantTriggerHelperTest {
	
	@isTest static void afterUpdateApplicants_givenAMapAndListOfApplicants_shouldCallUpdatePrimaryApplicantsAfterUpdate() {
		PrimaryApplicantHandlerMock handlerMock = new PrimaryApplicantHandlerMock();
		ApplicantTriggerHelper.primaryHandler = handlerMock;

		Test.startTest();
			ApplicantTriggerHelper.afterUpdateApplicants(new Map<Id,Applicant__c>(), new List<Applicant__c>());
		Test.stopTest();

		System.assert(
			handlerMock.updatePrimaryApplicantsAfterUpdateCallCount > 0,
			'UpdatePrimaryApplicantsAfterUpdate should have been called.'
		);
	}
	
	@isTest static void afterInsertApplicants_givenAListOfApplicants_shouldCallUpdatePrimaryApplicants() {
		PrimaryApplicantHandlerMock handlerMock = new PrimaryApplicantHandlerMock();
		ApplicantTriggerHelper.primaryHandler = handlerMock;

		Test.startTest();
			ApplicantTriggerHelper.afterInsertApplicants(new List<Applicant__c>());
		Test.stopTest();

		System.assert(
			handlerMock.updatePrimaryApplicantsCallCount > 0,
			'UpdatePrimaryApplicants should have been called.'
		);
	}

	@isTest static void beforeInsertApplicants_givenAListOfApplicants_shouldCallSetPrimaryApplicantsIfNone() {
		PrimaryApplicantHandlerMock handlerMock = new PrimaryApplicantHandlerMock();
		ApplicantTriggerHelper.primaryHandler = handlerMock;

		Test.startTest();
			ApplicantTriggerHelper.beforeInsertApplicants(new List<Applicant__c>());
		Test.stopTest();

		System.assert(
			handlerMock.setPrimaryApplicantsIfNoneCallCount > 0,
			'SetPrimaryApplicantsIfNone should have been called.'
		);
	}
	
}