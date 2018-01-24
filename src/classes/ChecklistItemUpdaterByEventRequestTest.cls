@isTest
private class ChecklistItemUpdaterByEventRequestTest {
	
	@isTest static void handleChecklistUpdates_givenASuccessfulFloodMappingEventRequest_shouldUpdateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		CaseDataAccessorMock caseMockDA = new CaseDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByEventRequest updater = new ChecklistItemUpdaterByEventRequest();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApplication);

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
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.FLOOD_MAPPING_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test Flood Mapping MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'Flood Mapping Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test Flood Mapping Checklist Item');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.REQUESTED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Stage__c', EventRequestDataAccessor.STAGE_RECEIVED_FLOOD_MAPPING);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();
		

		Test.startTest();
			updater.handleChecklistUpdates(new List<Event_Request__c>{testRequest});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.updateChecklistItemsCallCount,
			'Checklist Items should have been updated with the given event request and valid related objects.'
		);
	}
	
	@isTest static void handleChecklistUpdates_givenAFailedFloodMappingEventRequest_shouldUpdateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		CaseDataAccessorMock caseMockDA = new CaseDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByEventRequest updater = new ChecklistItemUpdaterByEventRequest();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApplication);

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
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.FLOOD_MAPPING_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test Flood Mapping MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'Flood Mapping Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test Flood Mapping Checklist Item');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.REQUESTED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Stage__c', EventRequestDataAccessor.STAGE_RECEIVED_FLOOD_MAPPING);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_FAILURE);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();
		

		Test.startTest();
			updater.handleChecklistUpdates(new List<Event_Request__c>{testRequest});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.updateChecklistItemsCallCount,
			'Checklist Items should have been updated with the given event request and valid related objects.'
		);
	}

	@isTest static void handleChecklistUpdates_givenAnLVInspectionEventRequest_shouldUpdateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		CaseDataAccessorMock caseMockDA = new CaseDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByEventRequest updater = new ChecklistItemUpdaterByEventRequest();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApplication);

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
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.LOSS_VERIFICATION_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test LV Inspection MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'LV Inspection Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test LV Inspection Checklist Item');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.REQUESTED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Stage__c', EventRequestDataAccessor.STAGE_RECIEVED_LV_INSPECTION);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_FAILURE);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();
		

		Test.startTest();
			updater.handleChecklistUpdates(new List<Event_Request__c>{testRequest});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.updateChecklistItemsCallCount,
			'Checklist Items should have been updated with the given event request and valid related objects.'
		);
	}
	
	@isTest static void handleChecklistUpdates_givenAListOfApplications_shouldCauseAnError() {
		ChecklistItemUpdaterByEventRequest updater = new ChecklistItemUpdaterByEventRequest();

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