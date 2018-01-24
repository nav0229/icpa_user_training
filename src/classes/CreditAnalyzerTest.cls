@isTest
private class CreditAnalyzerTest
{

	@isTest static void runCreditAnalysis_givenAnApplication_shouldRetrieveAndUpdateRelatedProcessingApplicationReview(){
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		ProcessingAppReviewDataAccessorMock processingAppReviewMockDA = new ProcessingAppReviewDataAccessorMock();
		CreditAnalyzer.applicationDA = applicationMockDA;
		CreditAnalyzer.creditBureauLineItemDA = cbrLineItemMockDA;
		CreditAnalyzer.processingApplicationReviewDA = processingAppReviewMockDA;
		CreditAnalyzer analyzer = new CreditAnalyzer();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Has_Delinquencies__c', 'false');
		applicationMockBuilder.setField('Original_Submission_Date__c', '2017-09-01');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn.add(testApp);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApp.Id);
		parMockBuilder.setField('Name', 'Test Processing Application Review');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());

		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();
		processingAppReviewMockDA.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		Test.startTest();
			CreditAnalyzer.runCreditAnalysis(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			processingAppReviewMockDA.getProcessingApplicationReviewsByAppIdsCallCount > 0,
			'Call to retrieve related processing application review should have been made.'
		);
		System.assert(
			processingAppReviewMockDA.updateProcessingApplicationReviewsCallCount > 0,
			'Call to update processing application review according to test result should have been made.'
		);
	}

	@isTest static void runCreditAnalysisBulkTest_givenAnApplicationIdWithPassingCredentials_shouldAssignApplicationToPassCreditAnalysisTest(){
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		ProcessingAppReviewDataAccessorMock processingAppReviewMockDA = new ProcessingAppReviewDataAccessorMock();
		CreditAnalyzer.applicationDA = applicationMockDA;
		CreditAnalyzer.creditBureauLineItemDA = cbrLineItemMockDA;
		CreditAnalyzer.processingApplicationReviewDA = processingAppReviewMockDA;
		CreditAnalyzer analyzer = new CreditAnalyzer();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Has_Delinquencies__c', 'false');
		applicationMockBuilder.setField('Original_Submission_Date__c', '2017-09-01');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn.add(testApp);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApp.Id);
		parMockBuilder.setField('Name', 'Test Processing Application Review');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());

		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();
		processingAppReviewMockDA.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		Test.startTest();
			Map<Id,Boolean> appIDCreditAnalysisTestResultMap = CreditAnalyzer.runCreditAnalysisBulkTest(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			!appIDCreditAnalysisTestResultMap.isEmpty(), 
			'Bulk Credit Analysis test should have been run and a result map should be present.'
		);
		System.assertEquals(
			appIDCreditAnalysisTestResultMap.get(testApp.Id), 
			true, 
			'With the given parameters on the test Application and no related test CBR Line Item, test should have passed.'
		);
	}

	@isTest static void runCreditAnalysisBulkTest_givenAnApplicationIdWithFailingCredentials_shouldAssignApplicationToFailCreditAnalysisTest(){
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		CreditAnalyzer.applicationDA = applicationMockDA;
		CreditAnalyzer.creditBureauLineItemDA = cbrLineItemMockDA;
		CreditAnalyzer analyzer = new CreditAnalyzer();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Has_Delinquencies__c', 'true');
		applicationMockBuilder.setField('Original_Submission_Date__c', '2017-09-01');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn.add(testApp);

		Test.startTest();
			Map<Id,Boolean> appIDCreditAnalysisTestResultMap = CreditAnalyzer.runCreditAnalysisBulkTest(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			!appIDCreditAnalysisTestResultMap.isEmpty(),
			'Bulk Credit Analysis test should have been run and a result map should be present.'
		);
		System.assertEquals(
			appIDCreditAnalysisTestResultMap.get(testApp.Id), 
			false, 
			'With the given parameters (Has_Delinquencies__c = true) on the test Application and no related test CBR Line Item, test should have failed.'
		);
	}

	@isTest static void runCreditAnalysisBulkTest_givenAnApplicationIdWithFailingAccountConditionCode_shouldAssignApplicationToFailCreditAnalysisTest(){
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		CreditAnalyzer.applicationDA = applicationMockDA;
		CreditAnalyzer.creditBureauLineItemDA = cbrLineItemMockDA;
		CreditBureauDataAccessorMock cbrMockDA = new CreditBureauDataAccessorMock();
		CreditAnalyzer analyzer = new CreditAnalyzer();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Has_Delinquencies__c', 'false');
		applicationMockBuilder.setField('Original_Submission_Date__c', '2017-09-01');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn.add(testApp);


		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();


		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Account_Condition_Code__c', 'FED TAX LIEN');
		creditBureauLineItemMockBuilder.setField('Purpose_Of_Account_Code__c', '50');
		creditBureauLineItemMockBuilder.setField('Balance_Date__c', '2017-09-04');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);


		Test.startTest();
			Map<Id,Boolean> appIDCreditAnalysisTestResultMap = CreditAnalyzer.runCreditAnalysisBulkTest(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			!appIDCreditAnalysisTestResultMap.isEmpty(),
			'Bulk Credit Analysis test should have been run and a result map should be present.'
		);
		System.assertEquals( 
			false, 
			appIDCreditAnalysisTestResultMap.get(testApp.Id),
			'With the given parameters on the test Application and related test CBR Line Item, test should have failed.'
		);
	}

	@isTest static void runCreditAnalysisBulkTest_givenAnApplicationIdWithFieldsFailingActiveChapter713TestRule1_shouldAssignApplicationToFailCreditAnalysisTest(){
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		CreditAnalyzer.applicationDA = applicationMockDA;
		CreditAnalyzer.creditBureauLineItemDA = cbrLineItemMockDA;
		CreditBureauDataAccessorMock cbrMockDA = new CreditBureauDataAccessorMock();
		CreditAnalyzer analyzer = new CreditAnalyzer();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Has_Delinquencies__c', 'false');
		applicationMockBuilder.setField('Original_Submission_Date__c', '2017-09-01');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn.add(testApp);


		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();


		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Account_Condition_Code__c', 'BK 7-PETIT');
		creditBureauLineItemMockBuilder.setField('Credit_Bureau_Line_Item_Type__c', 'Public Record');
		creditBureauLineItemMockBuilder.setField('Public_Record_Satisified_Date__c', '2014-09-04');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);


		Test.startTest();
			Map<Id,Boolean> appIDCreditAnalysisTestResultMap = CreditAnalyzer.runCreditAnalysisBulkTest(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			!appIDCreditAnalysisTestResultMap.isEmpty(),
			'Bulk Credit Analysis test should have been run and a result map should be present.'
		);
		System.assertEquals(
			appIDCreditAnalysisTestResultMap.get(testApp.Id), 
			false, 
			'With the given parameters on the test Application and related test CBR Line Item, test should have failed.'
		);
	}

	@isTest static void runCreditAnalysisBulkTest_givenAnApplicationIdWithFieldsFailingActiveChapter713TestRule2and3_shouldAssignApplicationToFailCreditAnalysisTest(){
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		CreditAnalyzer.applicationDA = applicationMockDA;
		CreditAnalyzer.creditBureauLineItemDA = cbrLineItemMockDA;
		CreditBureauDataAccessorMock cbrMockDA = new CreditBureauDataAccessorMock();
		CreditAnalyzer analyzer = new CreditAnalyzer();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Has_Delinquencies__c', 'false');
		applicationMockBuilder.setField('Original_Submission_Date__c', '2017-09-01');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn.add(testApp);


		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();


		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Payment_Status_Code__c', 'FORECLOS');
		creditBureauLineItemMockBuilder.setField('Balance_Date__c', '2014-09-04');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);


		Test.startTest();
			Map<Id,Boolean> appIDCreditAnalysisTestResultMap = CreditAnalyzer.runCreditAnalysisBulkTest(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			!appIDCreditAnalysisTestResultMap.isEmpty(),
			'Bulk Credit Analysis test should have been run and a result map should be present.'
		);
		System.assertEquals(
			appIDCreditAnalysisTestResultMap.get(testApp.Id), 
			false, 
			'With the given parameters on the test Application and related test CBR Line Item, test should have failed.'
		);
	}
}