@isTest
private class ChecklistItemUpdaterByIRSTranscriptTest {
	
	@isTest static void handleChecklistUpdates_givenAnEventRequestAndSuccesfulCreditBureau_shouldUpdateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		CaseDataAccessorMock caseMockDA = new CaseDataAccessorMock();
		IRSTranscriptsDataAccessorMock irsTranscriptMockDA = new IRSTranscriptsDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByIRSTranscript.irsTranscriptDA = irsTranscriptMockDA;
		ChecklistItemUpdaterByIRSTranscript updater = new ChecklistItemUpdaterByIRSTranscript();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApplication.Id, testApplication);

		MockSObjectBuilder irsTranscriptMockBuilder = new MockSObjectBuilder(IRS_Transcripts__c.getSObjectType());
		irsTranscriptMockBuilder.setField('Name', 'Test IRS Transcript');
		irsTranscriptMockBuilder.setField('Application__c', testApplication.Id);

		IRS_Transcripts__c testTranscript = (IRS_Transcripts__c) irsTranscriptMockBuilder.build();
		irsTranscriptMockDA.getIRSTranscriptsByApplicationIdsReturn.add(testTranscript);

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
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.IRS_TRANSCRIPT_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test IRS MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'IRS Transcript MC Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test IRS Transcript Checklist');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.FAILED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);		

		Test.startTest();
			updater.handleChecklistUpdates(new List<IRS_Transcripts__c>{testTranscript});
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
		IRSTranscriptsDataAccessorMock irsTranscriptMockDA = new IRSTranscriptsDataAccessorMock();

		ChecklistItemUpdater.applicationDA = applicationMockDA;
		ChecklistItemUpdater.checklistItemDA = checklistItemMockDA;
		ChecklistItemUpdater.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemUpdaterByIRSTranscript.irsTranscriptDA = irsTranscriptMockDA;
		ChecklistItemUpdaterByIRSTranscript updater = new ChecklistItemUpdaterByIRSTranscript();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApplication.Id, testApplication);

		MockSObjectBuilder irsTranscriptMockBuilder = new MockSObjectBuilder(IRS_Transcripts__c.getSObjectType());
		irsTranscriptMockBuilder.setField('Name', 'Test IRS Transcript');
		irsTranscriptMockBuilder.setField('Application__c', testApplication.Id);

		IRS_Transcripts__c testTranscript = (IRS_Transcripts__c) irsTranscriptMockBuilder.build();
		irsTranscriptMockDA.getIRSTranscriptsByApplicationIdsReturn.add(testTranscript);

		irsTranscriptMockBuilder.setField('Name', 'Test IRS Transcript Fail');
		irsTranscriptMockBuilder.setField('Error_Message__c', 'Error');
		irsTranscriptMockBuilder.setField('Application__c', testApplication.Id);

		IRS_Transcripts__c testTranscriptError = (IRS_Transcripts__c) irsTranscriptMockBuilder.build();
		irsTranscriptMockDA.getIRSTranscriptsByApplicationIdsReturn.add(testTranscriptError);

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
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.IRS_TRANSCRIPT_CODE);
		masterChecklistMockBuilder.setField('Name', 'Test IRS MC ');
		masterChecklistMockBuilder.setField('Checklist_Description__c', 'IRS Transcript MC Description');
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
		
		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMC;

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test IRS Transcript Checklist');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Checklist_Type__c', 'Interface');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', ChecklistItemDataAccessor.FAILED_STATUS);

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();
		checklistItemMockDA.getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn.add(testChecklistItem);		

		Test.startTest();
			updater.handleChecklistUpdates(new List<IRS_Transcripts__c>{testTranscript});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.updateChecklistItemsCallCount,
			'Checklist Items should have been updated with the given case and valid related objects.'
		);
	}

	@isTest static void handleChecklistUpdates_givenAListOfApplications_shouldCauseAnError() {
		ChecklistItemUpdaterByIRSTranscript updater = new ChecklistItemUpdaterByIRSTranscript();

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