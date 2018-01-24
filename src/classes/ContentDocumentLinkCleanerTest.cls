@isTest
private class ContentDocumentLinkCleanerTest {
	
	@isTest static void processDocumentLinks_givenAContentDocumentLinkToAContentDocumentWithoutAnExistingDocumentLineItem_shouldNotAddError() {
		ContentDocumentLinkDataAccessorMock linkMockDA = new ContentDocumentLinkDataAccessorMock();
		ContentDocumentLinkCleaner.contentDocumentLinkDA = linkMockDA;
		ContentDocumentLinkCleaner linkCleaner = new ContentDocumentLinkCleaner();

		MockSObjectBuilder contentDocumentMockBuilder = new MockSObjectBuilder(ContentDocument.getSObjectType());
		contentDocumentMockBuilder.setField('Title', 'Test Content Document');
		contentDocumentMockBuilder.setField('Id', contentDocumentMockBuilder.getMockId());

		ContentDocument testDoc = (ContentDocument) contentDocumentMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test Checklist Item');
		checklistItemMockBuilder.setField('Id', checklistItemMockBuilder.getMockId());

		Checklist_Item__c testLineItem = (Checklist_Item__c) checklistItemMockBuilder.build();

		ContentDocumentLink docLink = new ContentDocumentLink(
			ContentDocumentId = testDoc.Id,
			LinkedEntityId = testLineItem.Id
		);

		Test.startTest();
			linkCleaner.processDocumentLinks(new List<ContentDocumentLink>{docLink});
		Test.stopTest();

		System.assert(
			ApexPages.getMessages().isEmpty(), 
			'Since no previous link was created between a Checklist Item and ContentDocument, no error should be added.'
		);
	}
	
	@isTest static void processDocumentLinks_givenAContentDocumentLinkToAContentDocumentWithAnExistingDocumentLineItem_shouldAddError() {
		ContentDocumentLinkDataAccessorMock linkMockDA = new ContentDocumentLinkDataAccessorMock();
		ContentDocumentLinkCleaner.contentDocumentLinkDA = linkMockDA;
		ContentDocumentLinkCleaner linkCleaner = new ContentDocumentLinkCleaner();

		MockSObjectBuilder contentDocumentMockBuilder = new MockSObjectBuilder(ContentDocument.getSObjectType());
		contentDocumentMockBuilder.setField('Title', 'Test Content Document');
		contentDocumentMockBuilder.setField('Id', contentDocumentMockBuilder.getMockId());

		ContentDocument testDoc = (ContentDocument) contentDocumentMockBuilder.build();

		contentDocumentMockBuilder.setField('Title', 'Test Content Document For Error');
		contentDocumentMockBuilder.setField('Id', contentDocumentMockBuilder.getMockId());

		ContentDocument testDocForError = (ContentDocument) contentDocumentMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Name', 'Test Checklist Item');
		checklistItemMockBuilder.setField('Id', checklistItemMockBuilder.getMockId());

		Checklist_Item__c testLineItem = (Checklist_Item__c) checklistItemMockBuilder.build();

		ContentDocumentLink existingDocLink = new ContentDocumentLink(
			ContentDocumentId = testDoc.Id,
			LinkedEntityId = testLineItem.Id
		);

		linkMockDA.getContentDocumentLinksByLinkedEntityIdsReturn.add(existingDocLink);

		ContentDocumentLink newDocLink = new ContentDocumentLink(
			ContentDocumentId = testDocForError.Id,
			LinkedEntityId = testLineItem.Id
		);



		Test.startTest();
			linkCleaner.processDocumentLinks(new List<ContentDocumentLink>{newDocLink});
		Test.stopTest();

		System.debug('Error Messages: ' + ApexPages.getMessages());
		System.assert(
			!ApexPages.getMessages().isEmpty(), 
			'When a link is created between a Checklist Item and a new ContentDocument when one already exists, an error should be added.'
		);
	}
}