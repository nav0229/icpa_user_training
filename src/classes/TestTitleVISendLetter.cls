@isTest
private class TestTitleVISendLetter {

	/** 
	 * Runs all the different scenarios, with both successful and error scenarios
	 */
	static testMethod void testCompleteSendLetterProcess() {
		Test.startTest();

		List<Campaign> campaigns = createCampaigns(1);
		Campaign cmpg = campaigns[0];
		
		createAccountContact();

		/* 
		 * @TEST 1: Execute the "Send First Letter" click on a campaign
		 * without campaign members because the rollout has not been setup
		 */
		TitleVIMailController controller = createController(cmpg, 'First');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that there are errors and the campaign status remains "In Progress"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('In Progress', cmpg.Status);

		/* 
		 * @TEST 2: Execute the "Rollout Set Up" click on a campaign to add
		 * the campaign members to this campaign 
		 */
		setupRollout(cmpg);
		cmpg = [SELECT Status FROM Campaign WHERE Id =: cmpg.Id];
		// Verify that the campaign status was changed to rollout set up 
		System.assertEquals('Rollout Set Up', cmpg.Status);

		/* 
		 * @TEST SUITE 3: Execute different scenarios of the "Send First Letter" 
		 * click on a campaign after campaign members have been added 
		 */
		controller = createController(cmpg, 'First');
		executeSendFirstLetterScenarios(cmpg, controller);

		/* 
		 * @TEST SUITE 4: Execute different scenarios of the "Send Second Letter" 
		 * click on a campaign after campaign members have been added
		 */
		controller = createController(cmpg, 'Second');
		executeSendSecondLetterScenarios(cmpg, controller);

		/* 
		 * @TEST SUITE 4: Execute different scenarios of the "Send Third Letter" 
		 * click on a campaign after campaign members have been added
		 */
		controller = createController(cmpg, 'Third');
		executeSendThirdLetterScenarios(cmpg, controller);

		Test.stopTest();
	}

	/**
	 * TEST SUITE 1: Execute the "Send First Letter" test case scenarios 
	 */
	private static void executeSendFirstLetterScenarios(Campaign cmpg, 
			TitleVIMailController controller) {
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that there are no errors and the campaign status is changed 
		// to "First Letter Sent"
		cmpg = [SELECT status FROM Campaign WHERE Id =: cmpg.Id];
		System.debug('Errors: -----> '+controller.errorsFound);
		System.debug('errors = ' + controller.errorMessage);
		System.assertEquals(false, controller.errorsFound);
		System.assertEquals('First Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3a: Click on the "Send First Letter" link again while the
		 * campaign's status is set to "First Letter Sent"
		 */
		controller = createController(cmpg, 'First');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that the page reference contains errors and the campaign status
		// remains as "First Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('First Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3b: Click on the "Send Third Letter" link while the
		 * campaign's status is set to "First Letter Sent"
		 */
		controller = createController(cmpg, 'Third');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that the page reference contains errors and the campaign status
		// remains as "First Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('First Letter Sent', cmpg.Status);
	}

	/**
	 * TEST SUITE 2: Execute the "Send Second Letter" test case scenarios 
	 */
	private static void executeSendSecondLetterScenarios(Campaign cmpg,
			TitleVIMailController controller) {
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that there are no errors and the campaign status is changed 
		// to "Second Letter Sent"
		cmpg = [SELECT status FROM Campaign WHERE Id =: cmpg.Id];
		System.assertEquals(false, controller.errorsFound);
		System.assertEquals('Second Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3a: Click on the "Send First Letter" link while the
		 * campaign's status is set to "Second Letter Sent"
		 */
		controller = createController(cmpg, 'First');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();
		
		// Verify that the page reference contains errors and the campaign status
		// remains as "Second Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('Second Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3b: Click on the "Send Second Letter" link again while the
		 * campaign's status is set to "Second Letter Sent"
		 */
		controller = createController(cmpg, 'Second');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that the page reference contains errors and the campaign status
		// remains as "Second Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('Second Letter Sent', cmpg.Status);
	}

	/**
	 * TEST SUITE 3: Execute the "Send Third Letter" test case scenarios 
	 */
	private static void executeSendThirdLetterScenarios(Campaign cmpg,
			TitleVIMailController controller) {
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that there are no errors and the campaign status is changed 
		// to "Third Letter Sent"
		cmpg = [SELECT status FROM Campaign WHERE Id =: cmpg.Id];
		System.assertEquals(false, controller.errorsFound);
		System.assertEquals('Third Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3a: Click on the "Send First Letter" link while the
		 * campaign's status is set to "Third Letter Sent"
		 */
		controller = createController(cmpg, 'First');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that the page reference contains errors and the campaign status
		// remains as "Third Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('Third Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3b: Click on the "Send Second Letter" link while the
		 * campaign's status is set to "Third Letter Sent"
		 */
		controller = createController(cmpg, 'Second');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that the page reference contains errors and the campaign status
		// remains as "Third Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('Third Letter Sent', cmpg.Status);

		/* 
		 * @SUB-TEST 3b: Click on the "Send Third Letter" link again while the
		 * campaign's status is set to "Third Letter Sent"
		 */
		controller = createController(cmpg, 'Third');
		controller.generateAndSendLetter();
		controller.addTitleVISubmissionsAndUpdateCampaign();

		// Verify that the page reference contains errors and the campaign status
		// remains as "Third Letter Sent"
		System.assertEquals(true, controller.errorsFound);
		System.assertEquals('Third Letter Sent', cmpg.Status);
	}



	/********************************************************************************/
	/******************************* HELPER FUNCTIONS *******************************
	/********************************************************************************/


	/**
	 * Runs the common initial setup logic used between all the test cases. Returns a
	 * standard controller to get a handle to the "vf page" and perform system asserts
	 */
	private static TitleVIMailController createController(Campaign cmpg, String letter) {
		// Setup the "send first letter" link click action
		PageReference pageRef = Page.TitleVIMailController;
		pageRef.getParameters().put('letter', letter);

		// Instantiate the controller class to simulate the link click action
		Test.setCurrentPage(pageRef);
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(cmpg);
		TitleVIMailController controller = new TitleVIMailController(sc);
		return controller;
	}
	
	/**
	 * Creates a campaign record
	 */
	private static List<Campaign> createCampaigns(Integer numCampaigns) {
		List<Campaign> campaigns = new List<Campaign>();
		String rolloutCode = 'test_class_rollout_code_111';
		for ( Integer i = 0; i < numCampaigns; i++ ) {
			String campaignName = 'Test Campaign ' + i;

			Campaign test = new Campaign();
			test.OCR_Rollout_ID__c = campaignName;
			test.Name = campaignName;
			test.OCR_Rollout_Code__c = rolloutCode;
			test.OCR_Rollout_State__c = 'AK';
			test.StartDate = Date.today();
			test.EndDate = Date.today();
			test.Description = 'Test deescription';
			test.Status = 'In Progress';
			campaigns.add(test);
		}
		insert campaigns;
		return campaigns;
	}
	
	private static void createAccountContact()
	{
		//Account
		ID acctRecordTypeId = [select Id from RecordType where name = 'Title VI Account' limit 1].id;
		Account acct = new Account(Name='test account', Type='Donee', OCR_Reporting_State__c='AK', OCR_Title_VI_Status__c='Active',
		    BillingStreet='123 Main St', BillingCity='Springs', BillingState='AK', BillingPostalCode='22153', BillingCountry='USA',
		    recordTypeId = acctRecordTypeId);
		insert acct;
		//Contact - User
		
		ID contactRecordTypeId = [select Id from RecordType where name = 'Title VI Contact' limit 1].id;
		Contact contact = new Contact(lastName='Newtest',firstName='NewTest123',title='Test',
			email='emailtest@test.com',OCR_Contact_Via__c='E-Mail',accountId=acct.Id, recordTypeId=contactRecordTypeId);
		insert contact;
		
		Contact contact2 = new Contact(lastName='Newtest',firstName='NewTest123',title='Test',
			email='emailtest@test.com',OCR_Contact_Via__c='Mail',accountId=acct.Id, recordTypeId=contactRecordTypeId);
		insert contact2;
	}

	/**
	 * Executes the set up rollout command which populates the campaign with contacts
	 * and sets their status to selected and campaign status to rollout setup
	 */
	private static PageReference setupRollout(Campaign cmpgn) {
		PageReference pageRef = Page.OCRTitleVISetUpRollout;
		Test.setCurrentPage(pageRef);

		cmpgn = [SELECT Status, OCR_Rollout_State__c FROM Campaign WHERE Id =: cmpgn.Id];

		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(cmpgn);
		SetUpRolloutController controller = new SetUpRolloutController(sc);

		controller.setUpRollout();
		return pageRef;
	}

}