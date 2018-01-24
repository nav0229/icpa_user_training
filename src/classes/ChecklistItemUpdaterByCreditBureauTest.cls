@isTest
private class ChecklistItemUpdaterByCreditBureauTest {
	
	@isTest static void handleChecklistUpdates_givenAnEventRequestAndSuccesfulCreditBureau_shouldUpdateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		CaseDataAccessorMock caseMockDA = new CaseDataAccessorMock();
		CreditBureauDataAccessorMock creditBureauMockDA = new CreditBureauDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByCreditBureau.creditBureauDA = creditBureauMockDA;
		ChecklistItemUpdaterByCreditBureau updater = new ChecklistItemUpdaterByCreditBureau();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApplication);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Success');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);

		Credit_Bureau__c testCreditBureau = (Credit_Bureau__c) creditBureauMockBuilder.build();
		creditBureauMockDA.getActiveCreditBureausByApplicationIdsReturn.add(testCreditBureau);

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder masterChecklistMockBuilder = new MockSObjectBuilder(Master_Checklist__c.getSObjectType());
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.CBR_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test CBR MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'Credit Bureau MC Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test CBR Checklist Item');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.FAILED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();
		

		Test.startTest();
			updater.handleChecklistUpdates(new List<Event_Request__c>{testRequest});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.updateChecklistItemsCallCount,
			'Checklist Items should have been updated with the given case and valid related objects.'
		);
	}
	
	@isTest static void handleChecklistUpdates_givenAnEventRequestAndFailedCreditBureau_shouldUpdateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		CaseDataAccessorMock caseMockDA = new CaseDataAccessorMock();
		CreditBureauDataAccessorMock creditBureauMockDA = new CreditBureauDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByCreditBureau.creditBureauDA = creditBureauMockDA;
		ChecklistItemUpdaterByCreditBureau updater = new ChecklistItemUpdaterByCreditBureau();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApplication);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Success');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);

		Credit_Bureau__c testCreditBureau = (Credit_Bureau__c) creditBureauMockBuilder.build();
		creditBureauMockDA.getActiveCreditBureausByApplicationIdsReturn.add(testCreditBureau);

		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau Fail');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Error');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);

		Credit_Bureau__c testCreditBureauError = (Credit_Bureau__c) creditBureauMockBuilder.build();
		creditBureauMockDA.getActiveCreditBureausByApplicationIdsReturn.add(testCreditBureauError);

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder masterChecklistMockBuilder = new MockSObjectBuilder(Master_Checklist__c.getSObjectType());
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.CBR_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test CBR MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'Credit Bureau MC Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test CBR Checklist Item');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.FAILED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();
		

		Test.startTest();
			updater.handleChecklistUpdates(new List<Event_Request__c>{testRequest});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.updateChecklistItemsCallCount,
			'Checklist Items should have been updated with the given case and valid related objects.'
		);
	}

	@isTest static void handleChecklistUpdates_givenAListOfApplications_shouldCauseAnError() {
		ChecklistItemUpdaterByCreditBureau updater = new ChecklistItemUpdaterByCreditBureau();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Test.startTest();
			Boolean invalidSObjectExceptionOccurred = false;
			try{
				updater.handleChecklistUpdates(new List<Application__c>{testApplication});
			}
			catch (ChecklistItemUpdater.ChecklistItemUpdaterException e){
				invalidSObjectExceptionOccurred = true;
			}
		Test.stopTest();

		System.assert(
			invalidSObjectExceptionOccurred,
			'When the handleChecklistUpdates is passed a list of objects other than Event Request, an exception should occur.'
		);	
	}
}