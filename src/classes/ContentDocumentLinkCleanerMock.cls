/****************************************************************
 Name: ContentDocumentLinkCleanerMock
============================================================
Author: Kevin
Purpose: Mock Data Accessor Class for ContentDocumentLinkCleaner
============================================================

****************************************************************/

@isTest
public with sharing class ContentDocumentLinkCleanerMock implements ContentDocumentLinkCleanerInterface {
	public Integer processDocumentLinksCallCount = 0;

	public void processDocumentLinks(List<ContentDocumentLink> contentDocumentLinks) {
		processDocumentLinksCallCount++;
	}
}