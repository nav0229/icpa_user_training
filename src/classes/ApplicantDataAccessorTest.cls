@isTest
private class ApplicantDataAccessorTest {
	
	@isTest static void getApplicantsByApplicationId_givenAnApplicationId_shouldRetrieveRelatedApplicants() {
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		Test.startTest();
			List<Applicant__c> retrievedApplicants = applicantDA.getApplicantsByApplicationId(testApplicant.Application__c);
		Test.stopTest();

		System.assert(
			!retrievedApplicants.isEmpty(),
			'With the given Application Id, Applicants should have been retrieved.'
		);

		System.assertEquals(
			testApplicant.Id,
			retrievedApplicants[0].Id,
			'The incorrect Applicant was retrieved for the given Application Id.'
		);
	}
	
	@isTest static void getApplicantsByApplicationIds_givenAListOfApplicationIds_shouldRetrieveRelatedApplicants() {
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		Test.startTest();
			List<Applicant__c> retrievedApplicants = applicantDA.getApplicantsByApplicationIds(new List<Id>{testApplicant.Application__c});
		Test.stopTest();

		System.assert(
			!retrievedApplicants.isEmpty(),
			'With the given Application Id, Applicants should have been retrieved.'
		);

		System.assertEquals(
			testApplicant.Id,
			retrievedApplicants[0].Id,
			'The incorrect Applicant was retrieved for the given Application Id.'
		);
	}
	
	@isTest static void getPrimaryApplicantsByApplicationId_givenAnApplicationId_shouldRetrieveThePrimaryApplicant() {
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		Applicant__c notPrimaryApplicant = TestDataUtil.createApplicant();
		notPrimaryApplicant.Name = 'Test Secondary Applicant';
		notPrimaryApplicant.Primary_Applicant__c = false;
		notPrimaryApplicant.Account__c = testApplicant.Account__c;
		notPrimaryApplicant.Contact__c = testApplicant.Contact__c;
		notPrimaryApplicant.Application__c = testApplicant.Application__c;
		insert notPrimaryApplicant;

		Test.startTest();
			List<Applicant__c> retrievedApplicants = applicantDA.getPrimaryApplicantsByApplicationId(new List<Id>{testApplicant.Application__c});
		Test.stopTest();

		System.assert(
			!retrievedApplicants.isEmpty(),
			'With the given Application Id, Applicants should have been retrieved.'
		);

		System.assert(
			retrievedApplicants.size() < 2,
			'With the given Application Id, only the Primary Applicant should have been retrieved.'
		);

		System.assertEquals(
			testApplicant.Id,
			retrievedApplicants[0].Id,
			'The incorrect Applicant was retrieved for the given Application Id.'
		);
	}

	@isTest static void getPrimaryApplicantAndRelatedContactByApplicationId_givenAnApplicationId_shouldRetrieveThePrimaryApplicantAndItsContact() {
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		Applicant__c notPrimaryApplicant = TestDataUtil.createApplicant();
		notPrimaryApplicant.Name = 'Test Secondary Applicant';
		notPrimaryApplicant.Primary_Applicant__c = false;
		notPrimaryApplicant.Account__c = testApplicant.Account__c;
		notPrimaryApplicant.Contact__c = testApplicant.Contact__c;
		notPrimaryApplicant.Application__c = testApplicant.Application__c;
		insert notPrimaryApplicant;

		Test.startTest();
			Applicant__c retrievedApplicant = applicantDA.getPrimaryApplicantAndRelatedContactByApplicationId(testApplicant.Application__c);
		Test.stopTest();

		System.assert(
			retrievedApplicant != null ,
			'With the given Application Id, Applicant should have been retrieved.'
		);

		System.assertEquals(
			testApplicant.Id,
			retrievedApplicant.Id,
			'The incorrect Applicant was retrieved for the given Application Id.'
		);

		Contact testContact = [
			SELECT Id, LastName
			FROM Contact
			WHERE Id = :testApplicant.Contact__c
			LIMIT 1
		];

		System.assertEquals(
			testContact.LastName,
			retrievedApplicant.Contact__r.LastName,
			'The incorrect Contact was retrieved for the given Application Id and Applicant.'
		);
	}

	@isTest static void updateApplicants_givenAnApplicant_shouldUpdateApplicant() {
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		testApplicant.County__c = 'Test County';
		Test.startTest();
			applicantDA.updateApplicants(new List<Applicant__c>{testApplicant});
		Test.stopTest();

		Applicant__c updatedApplicant = [
			SELECT Id, County__c
			FROM Applicant__c
			WHERE Application__c = :testApplicant.Application__c 
			LIMIT 1
		];

		System.assert(
			updatedApplicant.County__c != null,
			'Field \"County__c\" that was altered should have been updated.'
		);

		System.assertEquals(
			testApplicant.County__c,
			updatedApplicant.County__c,
			'Field was not updated to the correct value.'
		);
	}

	@isTest static void getApplicantsByApplicantIds_givenAnApplicantId_shouldReturnApplicant(){
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		Test.startTest();
			List<Applicant__c> retrievedApplicants = applicantDA.getApplicantsByApplicantIds(new List<Id>{testApplicant.Id});
		Test.stopTest();

		System.assert(
			!retrievedApplicants.isEmpty(),
			'With the given Application Id, Applicants should have been retrieved.'
		);

		System.assertEquals(
			testApplicant.Id,
			retrievedApplicants[0].Id,
			'The incorrect Applicant was retrieved for the given Application Id.'
		);
	}

	@isTest static void getApplicantsAndRelatedContactsByApplicationId_givenAnApplicationId_shouldReturnApplicantAndContact(){
		ApplicantDataAccessor applicantDA = new ApplicantDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();
		Test.startTest();
			List<Applicant__c> retrievedApplicants = applicantDA.getApplicantsAndRelatedContactsByApplicationId(testApplicant.Application__c);
		Test.stopTest();

		System.assert(
			!retrievedApplicants.isEmpty(),
			'With the given Application Id, Applicants should have been retrieved.'
		);

		System.assertEquals(
			testApplicant.Id,
			retrievedApplicants[0].Id,
			'The incorrect Applicant was retrieved for the given Application Id.'
		);

		Contact testContact = [
			SELECT Id, LastName
			FROM Contact
			WHERE Id = :testApplicant.Contact__c
			LIMIT 1
		];

		System.assertEquals(
			testContact.LastName,
			retrievedApplicants[0].Contact__r.LastName,
			'The incorrect Contact was retrieved for the given Application Id and Applicant.'
		);
	}

}