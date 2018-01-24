@isTest
private class CreditBureauDataAccessorTest {
	
	@isTest static void insertCreditBureaus_givenACreditBureau_shouldInsertCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Credit_Bureau__c testCBR = new Credit_Bureau__c(
			Name = 'Test CBR',
			Credit_Score__c = 'Zero',
			Active__c = true
		);

		Test.startTest();
			creditBureauDA.insertCreditBureaus(new List<Credit_Bureau__c>{testCBR});
		Test.stopTest();

		Credit_Bureau__c insertedCBR = [
			SELECT Name
			FROM Credit_Bureau__c
			WHERE Name = 'Test CBR'
			LIMIT 1
		];

		System.assert(insertedCBR != null, 'The supplied Credit Bureau record Name should result in the Test Credit Bureau being returned.');
		System.assertEquals(testCBR.Name, insertedCBR.Name, 'The Credit Bureau record returned should have been the test credit bureau that was inserted.');
	}
	
	@isTest static void insertCreditBureau_givenACreditBureau_shouldInsertCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Credit_Bureau__c testCBR = new Credit_Bureau__c(
			Name = 'Test CBR',
			Credit_Score__c = 'Zero',
			Active__c = true
		);

		Test.startTest();
			creditBureauDA.insertCreditBureau(testCBR);
		Test.stopTest();

		Credit_Bureau__c insertedCBR = [
			SELECT Name
			FROM Credit_Bureau__c
			WHERE Name = 'Test CBR'
			LIMIT 1
		];

		System.assert(insertedCBR != null, 'The supplied Credit Bureau record Name should result in the Test Credit Bureau being returned.');
		System.assertEquals(testCBR.Name, insertedCBR.Name, 'The Credit Bureau record returned should have been the test credit bureau that was inserted.');
	}

	@isTest static void updateCreditBureaus_givenACreditBureau_shouldUpdateCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Credit_Bureau__c testCBR = new Credit_Bureau__c(
			Name = 'Test CBR',
			Credit_Score__c = 'Zero',
			Active__c = true
		);

		insert testCBR;

		testCBR.Credit_Score__c = '700';

		Test.startTest();
			creditBureauDA.updateCreditBureaus(new List<Credit_Bureau__c>{testCBR});
		Test.stopTest();

		Credit_Bureau__c updatedCBR = [
			SELECT Name, Credit_Score__c
			FROM Credit_Bureau__c
			WHERE Name = 'Test CBR'
			LIMIT 1
		];

		System.assert(updatedCBR != null, 'The supplied Credit Bureau record Name should result in the Test Credit Bureau being returned.');
		System.assertEquals('700', updatedCBR.Credit_Score__c, 'The Credit Bureau record Credit_Score__c field should have been updated.');
	}


	@isTest static void getActiveCreditBureausById_givenACreditBureauId_shouldRetrieveRelatedActiveCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Application__c testApp = new Application__c(
			Name = '11111111',
			Family_Size__c = 2,
			Sub_Status__c = 'Submit CBR'
		);

		insert testApp;

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 1',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = false
		);

	    Credit_Bureau__c testCreditBureau = new Credit_Bureau__c(
			Name = 'Test CBR 2',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = true
		);
		insert testCreditBureau;

		Test.startTest();
			List<Credit_Bureau__c> relatedCreditBureaus = creditBureauDA.getActiveCreditBureausById(new List<Id>{testCreditBureau.Id});
		Test.stopTest();

		System.assert(
			relatedCreditBureaus.size() == 1, 
			'With the supplied test Application Id, one active Credit Bureau records should have been returned.'
		);

		System.assertEquals(
			testCreditBureau.Id, 
			relatedCreditBureaus[0].Id, 
			'The credit bureau record returned should have been the active one inserted (Test CBR 2).'
		);
	}


	@isTest static void getActiveCreditBureausByApplicationLatestFirst_givenAnApplication_shouldRetrieveRelatedActiveCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Application__c testApp = new Application__c(
			Name = '11111111',
			Family_Size__c = 2,
			Sub_Status__c = 'Submit CBR'
		);

		insert testApp;

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 1',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = false
		);

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 2',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = true
		);

		insert new Credit_Bureau__c(
			Name = 'Test CBR 3',
			Credit_Score__c = 'Zero',
			Active__c = false
		);

		Test.startTest();
			List<Credit_Bureau__c> testAppCreditBureaus = creditBureauDA.getActiveCreditBureausByApplicationLatestFirst(testApp);
		Test.stopTest();

		System.debug(testAppCreditBureaus);

		System.assert(testAppCreditBureaus.size() > 0, 'With the supplied test Applications, Credit Bureau records should have been returned.');
		System.assertEquals('Test CBR 2', testAppCreditBureaus[0].Name, 'The credit bureau record returned should have been the active one inserted (Test CBR 2).');
	}

	@isTest static void getActiveCreditBureausByApplicantId_givenAnApplicantId_shouldRetrieveRelatedActiveCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Account testAcct = new Account(Name = 'TestAcct');
		insert testAcct;
		Contact testContact = new Contact(LastName = 'TestName', AccountId = testAcct.Id);
		insert testContact;

		Application__c testApp = new Application__c(
			Name = '11111111',
			Family_Size__c = 2,
			Sub_Status__c = 'Submit CBR'
		);

		insert testApp;

		Applicant__c testApplicant = new Applicant__c(
			Name = 'Test Applicant',
			Application__c = testApp.Id,
			Account__c = testAcct.Id,
			Contact__c = testContact.Id,
			Primary_Applicant__c = true
		);

		insert testApplicant;

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 1',
			Applicant_Name__c = testApplicant.Id,
			Credit_Score__c = 'Zero',
			Active__c = false
		);

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 2',
			Application__c = testApp.Id,
			Applicant_Name__c = testApplicant.Id,
			Credit_Score__c = 'Zero',
			Active__c = true
		);

		insert new Credit_Bureau__c(
			Name = 'Test CBR 3',
			Credit_Score__c = 'Zero',
			Active__c = false
		);

		Test.startTest();
			List<Credit_Bureau__c> testApplicantCreditBureaus = creditBureauDA.getActiveCreditBureausByApplicantId(new List<Id>{testApplicant.Id});
		Test.stopTest();

		System.debug(testApplicantCreditBureaus);

		System.assert(testApplicantCreditBureaus.size() > 0, 'With the supplied test Applicant, Credit Bureau records should have been returned.');
		System.assertEquals('Test CBR 2', testApplicantCreditBureaus[0].Name, 'The credit bureau record returned should have been the active one inserted (Test CBR 2).');
	}

	@isTest static void getActiveCreditBureausByApplicationId_givenAnApplicationId_shouldRetrieveRelatedActiveCreditBureau() {
		CreditBureauDataAccessor creditBureauDA = new CreditBureauDataAccessor();

		Application__c testApp = new Application__c(
			Name = '11111111',
			Family_Size__c = 2,
			Sub_Status__c = 'Submit CBR'
		);

		insert testApp;

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 1',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = false
		);

	    insert new Credit_Bureau__c(
			Name = 'Test CBR 2',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = true
		);

		insert new Credit_Bureau__c(
			Name = 'Test CBR 3',
			Credit_Score__c = 'Zero',
			Active__c = false
		);

		Test.startTest();
			List<Credit_Bureau__c> testApplicationCreditBureaus = creditBureauDA.getActiveCreditBureausByApplicationIds(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			testApplicationCreditBureaus.size() == 1, 
			'With the supplied test Application Id, one active Credit Bureau records should have been returned.'
		);

		System.assertEquals(
			'Test CBR 2', 
			testApplicationCreditBureaus[0].Name, 
			'The credit bureau record returned should have been the active one inserted (Test CBR 2).'
		);
	}
}