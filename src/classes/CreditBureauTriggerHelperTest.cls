@isTest
private class CreditBureauTriggerHelperTest {
	@isTest
	static void copyCreditScoreToApplicant_givenListOfNewCBItems_shouldCopyCreditScoreToApplicant() {
		CreditBureauTriggerHelper cbrTriggerHelper = new CreditBureauTriggerHelper();
		ApplicantDataAccessorMock applicantDAMock = new ApplicantDataAccessorMock();		

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', '12345678');
		applicantMockBuilder.setField('Credit_Score__c', '0');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());
		Applicant__c testAppicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder cbrMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		cbrMockBuilder.setField('Applicant_Name__c', testAppicant.Id);
		cbrMockBuilder.setField('Credit_Score__c', '100');
		cbrMockBuilder.setField('Id', cbrMockBuilder.getMockId());
		Credit_Bureau__c testCBR = (Credit_Bureau__c) cbrMockBuilder.build();

		CreditBureauTriggerHelper.applicantDA = applicantDAMock;
		applicantDAMock.getApplicantsByApplicantIdsReturn.add(testAppicant);

		List<Credit_Bureau__c> newCBItems = new List<Credit_Bureau__c>();
		newCBItems.add(testCBR);

		Test.startTest();
			cbrTriggerHelper.afterInsert(newCBItems);
		Test.stopTest();

		System.assert(testAppicant.Credit_Score__c == Integer.valueOf(testCBR.Credit_Score__c));
		System.assert(applicantDAMock.getApplicantsByApplicantIdsCallCount > 0);
		System.assert(applicantDAMock.updateApplicantsCallCount > 0);
	}
}