@isTest
private class PrimaryWageEarnerIdentifierTest {
	@isTest static void identifyPrimaryWageEarners_givenAnApplicationIdAndNoRelatedApplicants_shouldNotUpdateApplicants() {
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		PrimaryWageEarnerIdentifier.applicantDA = applicantMockDA;
		PrimaryWageEarnerIdentifier primaryIdentifier = new PrimaryWageEarnerIdentifier();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();

		Test.startTest();
			primaryIdentifier.identifyPrimaryWageEarners(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assertEquals(
			0,
			applicantMockDA.updateApplicantsCallCount,
			'No update should have been performed when there are no Applicants related to the given Applicant Id.'
		);
	}


	@isTest static void identifyPrimaryWageEarners_givenAnApplicationIdAndRelatedApplicant_shouldSetApplicantToPrimaryWageEarner() {
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		PrimaryWageEarnerIdentifier.applicantDA = applicantMockDA;
		PrimaryWageEarnerIdentifier primaryIdentifier = new PrimaryWageEarnerIdentifier();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Gross_Annual_Income__c', '100');
		applicantMockBuilder.setField('Primary_Wage_Earner__c', 'false');
		applicantMockBuilder.setField('Application__c', testApp.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		applicantMockDA.getApplicantsByApplicationIdsReturn.add(testApplicant);

		Test.startTest();
			primaryIdentifier.identifyPrimaryWageEarners(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assertEquals(
			true,
			testApplicant.Primary_Wage_Earner__c,
			'The test Applicant provided should have been identified as the primary wage earner.'
		);
	}
	
	@isTest static void identifyPrimaryWageEarners_givenAnApplicationIdAndTwoRelatedApplicants_shouldSetApplicantToPrimaryWageEarner() {
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		PrimaryWageEarnerIdentifier.applicantDA = applicantMockDA;
		PrimaryWageEarnerIdentifier primaryIdentifier = new PrimaryWageEarnerIdentifier();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Gross_Annual_Income__c', '100');
		applicantMockBuilder.setField('Primary_Wage_Earner__c', 'false');
		applicantMockBuilder.setField('Application__c', testApp.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		applicantMockDA.getApplicantsByApplicationIdsReturn.add(testApplicant);

		applicantMockBuilder.setField('Gross_Annual_Income__c', '1000');
		applicantMockBuilder.setField('Primary_Wage_Earner__c', 'false');
		applicantMockBuilder.setField('Application__c', testApp.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicantWithHigherGAI = (Applicant__c) applicantMockBuilder.build();

		applicantMockDA.getApplicantsByApplicationIdsReturn.add(testApplicantWithHigherGAI);

		Test.startTest();
			primaryIdentifier.identifyPrimaryWageEarners(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assertEquals(
			true,
			testApplicantWithHigherGAI.Primary_Wage_Earner__c,
			'The test Applicant with the higher Gross Annual Income should have been identified as the primary wage earner.'
		);
	}
	
}