@isTest
private class ContentDocumentLinkTriggerHelperTest {
	
	@isTest static void beforeInsert_givenAListOfContentDocumentLinks_shouldInvokeProcessDocumentLinks() {
		ContentDocumentLinkCleanerMock mockCleaner = new ContentDocumentLinkCleanerMock();
		ContentDocumentLinkTriggerHelper.contentDocumentLinkCleaner = mockCleaner;
		ContentDocumentLinkTriggerHelper helper = new ContentDocumentLinkTriggerHelper();

		Test.startTest();
			helper.beforeInsert(new List<ContentDocumentLink>());
		Test.stopTest();

		System.assertEquals(
			1,
			mockCleaner.processDocumentLinksCallCount,
			'processDocumentLinks method should have been called in beforeInsert method.'
		);
	}	
}