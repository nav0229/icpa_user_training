/****************************************************************
 Name: ContentDocumentLinkTriggerHelper
============================================================
Author: 
Purpose: Trigger helper for ContentDocumentLink
============================================================

****************************************************************/

public with sharing class ContentDocumentLinkTriggerHelper {
    @TestVisible
	private static ContentDocumentLinkCleanerInterface contentDocumentLinkCleaner = new ContentDocumentLinkCleaner();
	
	public void beforeInsert(List<ContentDocumentLink> newContentDocumentLinks){
		contentDocumentLinkCleaner.processDocumentLinks(newContentDocumentLinks);
	}
}