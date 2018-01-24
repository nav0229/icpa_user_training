@isTest
private class PrimaryApplicantHandlerTest {
	
	@isTest static void setPrimaryApplicantsIfNone_givenAnApplicant_shouldSetApplicantToPrimaryApplicant() {
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		PrimaryApplicantHandler.applicantDA = applicantMockDA;
		PrimaryApplicantHandler.applicationDA = applicationMockDA;
		PrimaryApplicantHandler primaryHandler = new PrimaryApplicantHandler();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Primary_Applicant__c', 'false');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		Test.startTest();
			primaryHandler.setPrimaryApplicantsIfNone(new List<Applicant__c>{testApplicant});
		Test.stopTest();

		System.assertEquals(
			true,
			testApplicant.Primary_Applicant__c,
			'With no Primary Applicant already existing, the test Applicant should have been marked as primary.'
		);
	}
	
	@isTest static void updatePrimaryApplicants_givenAnApplicant_shouldUpdateRelatedApplicationAndApplicants() {
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		PrimaryApplicantHandler.applicantDA = applicantMockDA;
		PrimaryApplicantHandler.applicationDA = applicationMockDA;
		PrimaryApplicantHandler primaryHandler = new PrimaryApplicantHandler();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Primary_Applicant_Name__c', 'Old Applicant');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Primary_Applicant__c', 'true');
		applicantMockBuilder.setField('Name', 'New Primary Applicant');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Primary_Applicant__c', 'true');
		applicantMockBuilder.setField('Name', 'Old Primary Applicant');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c oldPrimaryApplicant = (Applicant__c) applicantMockBuilder.build();
		applicantMockDA.getPrimaryApplicantsByApplicationIdReturn.add(oldPrimaryApplicant);

		Test.startTest();
			primaryHandler.updatePrimaryApplicants(new List<Applicant__c>{testApplicant});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Call to update Applications should have been updated.'
		);

		System.assert(
			applicantMockDA.updateApplicantsCallCount > 0,
			'Call to update Applicants shuold have been made.'
		);

		System.assertEquals(
			testApplicant.Name,
			testApplication.Primary_Applicant_Name__c,
			'Primary Applicant Name on Application should be that of the new Applicant.'
		);

		System.assertEquals(
			false,
			oldPrimaryApplicant.Primary_Applicant__c,
			'The old Primary Applicant should no longer be marked as primary.'
		);
	}
	
	@isTest static void updatePrimaryApplicantsAfterUpdate_givenAMapAndApplicant_shouldUpdateRelatedApplicationAndApplicants() {
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		PrimaryApplicantHandler.applicantDA = applicantMockDA;
		PrimaryApplicantHandler.applicationDA = applicationMockDA;
		PrimaryApplicantHandler primaryHandler = new PrimaryApplicantHandler();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Primary_Applicant_Name__c', 'Old Applicant');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Primary_Applicant__c', 'false');
		applicantMockBuilder.setField('Name', 'New Primary Applicant');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c oldTestApplicant = (Applicant__c) applicantMockBuilder.build();

		Applicant__c newTestApplicant = oldTestApplicant.clone(true, true, false, true);
		newTestApplicant.Primary_Applicant__c = true;

		Map<Id, Applicant__c> oldMap = new Map<Id,Applicant__c>();
		oldMap.put(oldTestApplicant.Id, oldTestApplicant);

		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Primary_Applicant__c', 'true');
		applicantMockBuilder.setField('Name', 'Old Primary Applicant');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c oldPrimaryApplicant = (Applicant__c) applicantMockBuilder.build();
		applicantMockDA.getPrimaryApplicantsByApplicationIdReturn.add(oldPrimaryApplicant);

		Test.startTest();
			primaryHandler.updatePrimaryApplicantsAfterUpdate(oldMap, new List<Applicant__c>{newTestApplicant});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Call to update Applications should have been updated.'
		);

		System.assert(
			applicantMockDA.updateApplicantsCallCount > 0,
			'Call to update Applicants shuold have been made.'
		);

		System.assertEquals(
			newTestApplicant.Name,
			testApplication.Primary_Applicant_Name__c,
			'Primary Applicant Name on Application should be that of the new Applicant.'
		);

		System.assertEquals(
			false,
			oldPrimaryApplicant.Primary_Applicant__c,
			'The old Primary Applicant should no longer be marked as primary.'
		);
	}
}