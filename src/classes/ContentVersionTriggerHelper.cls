/****************************************************************
 Name: ContentVersionTriggerHelper
============================================================
Author: Kevin/Matt
Purpose: Trigger Helper for ContentVersion Trigger
============================================================

****************************************************************/
public with sharing class ContentVersionTriggerHelper {

	@TestVisible private static ContentVersionSizeLimiterInterface contentVersionSizeLimiter = new ContentVersionSizeLimiter();
	@TestVisible private static ContentDocumentLinkerInterface contentDocumentLinker = new ContentDocumentLinker();
	@TestVisible private static ContentVersionReUploadedDocumentHandler contentVersiondocHandler = new ContentVersionReUploadedDocumentHandler();

	public ContentVersionTriggerHelper(){}

	public void beforeUpdate(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap){
		contentVersionSizeLimiter.validateContentSizes(newVersions);
		contentDocumentLinker.handleDocumentLinks(newVersions, oldVersionsMap);
	}

	public void AfterInsert(List<ContentVersion> newVersions) {
		contentVersionSizeLimiter.validateContentSizes(newVersions);
		contentVersiondocHandler.updateSignedDocumentChecklistItemStatus(newVersions);
	}
}