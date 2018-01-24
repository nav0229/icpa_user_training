@isTest
private class ContentVersionReUploadedDocHandlerTest {
	
	@isTest
	static void updateSignedDocumentChecklistItemStatus_givenContentVersionList_shouldMakeNecessaryStatusUpdates(){
		ContentVersionReUploadedDocumentHandler contentVersionReUploadedDocHandler = new ContentVersionReUploadedDocumentHandler();

		ContentDocumentLinkDataAccessorMock contentdocDAMock = new ContentDocumentLinkDataAccessorMock();
		CaseDataAccessorMock caseDAMock = new CaseDataAccessorMock();
		ChecklistItemDataAccessorMock checklistDAMock = new ChecklistItemDataAccessorMock();

		ContentVersionReUploadedDocumentHandler.contentDocDA = contentdocDAMock;
		ContentVersionReUploadedDocumentHandler.caseDA = caseDAMock;
		ContentVersionReUploadedDocumentHandler.checklistItemDA = checklistDAMock;

		
		List<ContentDocument> contentDocuments = new List<ContentDocument>();
		List<ContentVersion> contentVersions = new List<ContentVersion>();
		List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
		List<Checklist_Item__c> checklistItems = new List<Checklist_Item__c>();
		List<Case> cases = new List<Case>();

		MockSObjectBuilder contentVersionMockBuilder = new MockSObjectBuilder(ContentVersion.getSObjectType());
		contentVersionMockBuilder.setField('VersionNumber', '2');
		contentVersionMockBuilder.setField('ContentDocumentId', '100');
		contentVersionMockBuilder.setField('Id', contentVersionMockBuilder.getMockId());
		ContentVersion testContentVersion = (ContentVersion) contentVersionMockBuilder.build();

		MockSObjectBuilder contentVersionMockBuilder2 = new MockSObjectBuilder(ContentVersion.getSObjectType());
		contentVersionMockBuilder2.setField('VersionNumber', '2');
		contentVersionMockBuilder2.setField('ContentDocumentId', '101');
		contentVersionMockBuilder2.setField('Id', contentVersionMockBuilder2.getMockId());
		ContentVersion testContentVersion2 = (ContentVersion) contentVersionMockBuilder2.build();

		contentVersions.add(testContentVersion);
		contentVersions.add(testContentVersion2);

		MockSObjectBuilder contentDocumentLinkMockBuilder = new MockSObjectBuilder(ContentDocumentLink.getSObjectType());
		contentDocumentLinkMockBuilder.setField('LinkedEntityId', '200');
		contentDocumentLinkMockBuilder.setField('Id', contentDocumentLinkMockBuilder.getMockId());
		ContentDocumentLink testContentDocumentLink = (ContentDocumentLink) contentDocumentLinkMockBuilder.build();	

		contentdocDAMock.getContentDocumentLinksByDocIdsReturn.add(testContentDocumentLink);

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Pending Borrower\'s Verification');
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());
		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Borrower_s_Signature_Required__c', 'true');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', 'Pending Borrower\'s Verification');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Id', checklistItemMockBuilder.getMockId());
		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder2 = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder2.setField('Borrower_s_Signature_Required__c', 'false');
		checklistItemMockBuilder2.setField('Checklist_Item_Status__c', 'Pending Borrower\'s Verification');
		checklistItemMockBuilder2.setField('Case__c', testCase.Id);
		checklistItemMockBuilder2.setField('Id', checklistItemMockBuilder2.getMockId());
		Checklist_Item__c testChecklistItem2 = (Checklist_Item__c) checklistItemMockBuilder2.build();

		caseDAMock.getCasesByCaseIdsReturn.add(testCase);

		checklistDAMock.getChecklistItemsByChecklistItemIdsReturn.add(testChecklistItem);
		checklistDAMock.getChecklistItemsByChecklistItemIdsReturn.add(testChecklistItem2);

		checklistDAMock.getChecklistItemsByCaseIdsReturn.add(testChecklistItem);
		checklistDAMock.getChecklistItemsByCaseIdsReturn.add(testChecklistItem2);

		Test.startTest();
			contentVersionReUploadedDocHandler.updateSignedDocumentChecklistItemStatus(contentVersions);
		Test.stopTest();

		System.assertEquals(2, checklistDAMock.updateChecklistItemsCallCount, 'Checklist items were not updated twice');
		System.assertEquals(1, caseDAMock.updateCasesCallCount, 'Cases were not updated');
	}

	@isTest
	static void updateSignedDocumentChecklistItemStatus_givenContentVersionList_shouldNotUpdateEveryChecklistItemFromACase(){
		ContentVersionReUploadedDocumentHandler contentVersionReUploadedDocHandler = new ContentVersionReUploadedDocumentHandler();

		ContentDocumentLinkDataAccessorMock contentdocDAMock = new ContentDocumentLinkDataAccessorMock();
		CaseDataAccessorMock caseDAMock = new CaseDataAccessorMock();
		ChecklistItemDataAccessorMock checklistDAMock = new ChecklistItemDataAccessorMock();

		ContentVersionReUploadedDocumentHandler.contentDocDA = contentdocDAMock;
		ContentVersionReUploadedDocumentHandler.caseDA = caseDAMock;
		ContentVersionReUploadedDocumentHandler.checklistItemDA = checklistDAMock;

		
		List<ContentDocument> contentDocuments = new List<ContentDocument>();
		List<ContentVersion> contentVersions = new List<ContentVersion>();
		List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
		List<Checklist_Item__c> checklistItems = new List<Checklist_Item__c>();
		List<Case> cases = new List<Case>();

		MockSObjectBuilder contentVersionMockBuilder = new MockSObjectBuilder(ContentVersion.getSObjectType());
		contentVersionMockBuilder.setField('VersionNumber', '2');
		contentVersionMockBuilder.setField('ContentDocumentId', '100');
		contentVersionMockBuilder.setField('Id', contentVersionMockBuilder.getMockId());
		ContentVersion testContentVersion = (ContentVersion) contentVersionMockBuilder.build();

		MockSObjectBuilder contentVersionMockBuilder2 = new MockSObjectBuilder(ContentVersion.getSObjectType());
		contentVersionMockBuilder2.setField('VersionNumber', '2');
		contentVersionMockBuilder2.setField('ContentDocumentId', '101');
		contentVersionMockBuilder2.setField('Id', contentVersionMockBuilder2.getMockId());
		ContentVersion testContentVersion2 = (ContentVersion) contentVersionMockBuilder2.build();

		contentVersions.add(testContentVersion);
		contentVersions.add(testContentVersion2);

		MockSObjectBuilder contentDocumentLinkMockBuilder = new MockSObjectBuilder(ContentDocumentLink.getSObjectType());
		contentDocumentLinkMockBuilder.setField('LinkedEntityId', '200');
		contentDocumentLinkMockBuilder.setField('Id', contentDocumentLinkMockBuilder.getMockId());
		ContentDocumentLink testContentDocumentLink = (ContentDocumentLink) contentDocumentLinkMockBuilder.build();	

		contentdocDAMock.getContentDocumentLinksByDocIdsReturn.add(testContentDocumentLink);

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Pending Borrower\'s Verification');
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());
		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Borrower_s_Signature_Required__c', 'true');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', 'Pending Borrower\'s Verification');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Id', checklistItemMockBuilder.getMockId());
		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder2 = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder2.setField('Borrower_s_Signature_Required__c', 'true');
		checklistItemMockBuilder2.setField('Checklist_Item_Status__c', 'Pending Borrower\'s Verification');
		checklistItemMockBuilder2.setField('Case__c', testCase.Id);
		checklistItemMockBuilder2.setField('Id', checklistItemMockBuilder2.getMockId());
		Checklist_Item__c testChecklistItem2 = (Checklist_Item__c) checklistItemMockBuilder2.build();

		caseDAMock.getCasesByCaseIdsReturn.add(testCase);

		checklistDAMock.getChecklistItemsByChecklistItemIdsReturn.add(testChecklistItem);

		checklistDAMock.getChecklistItemsByCaseIdsReturn.add(testChecklistItem);
		checklistDAMock.getChecklistItemsByCaseIdsReturn.add(testChecklistItem2);

		Test.startTest();
			contentVersionReUploadedDocHandler.updateSignedDocumentChecklistItemStatus(contentVersions);
		Test.stopTest();

		System.assertEquals(2, checklistDAMock.updateChecklistItemsCallCount, 'Checklist items were not updated twice');
		System.assertEquals(1, caseDAMock.updateCasesCallCount, 'Cases were not updated');
	}
}