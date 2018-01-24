/****************************************************************
 Name: ContentDocumentLinkDataAccessorMock
============================================================
Author: Kevin
Purpose: Mock Data Accessor for ContentDocumentLink
============================================================

****************************************************************/
@isTest 
public with sharing class ContentDocumentLinkDataAccessorMock implements ContentDocumentLinkDAO {

	public Integer getContentDocumentLinksByDocIdsCallCount { get; private set; }
	public Integer getContentDocumentLinksByLinkedEntityIdsCallCount { get; private set; }
	public Integer insertContentDocumentLinksCallCount { get; private set; }
	public Integer deleteContentDocumentLinksCallCount { get; private set; }

	public List<ContentDocumentLink> getContentDocumentLinksByDocIdsReturn;
	public List<ContentDocumentLink> getContentDocumentLinksByLinkedEntityIdsReturn;

	public ContentDocumentLinkDataAccessorMock(){
		getContentDocumentLinksByDocIdsCallCount = 0;
		getContentDocumentLinksByLinkedEntityIdsCallCount = 0;
		insertContentDocumentLinksCallCount = 0;
		deleteContentDocumentLinksCallCount = 0;

		getContentDocumentLinksByDocIdsReturn = new List<ContentDocumentLink>();
		getContentDocumentLinksByLinkedEntityIdsReturn = new List<ContentDocumentLink>();
	}

	public List<ContentDocumentLink> getContentDocumentLinksByDocIds(Set<Id> contentDocumentIds){
		getContentDocumentLinksByDocIdsCallCount++;
		return getContentDocumentLinksByDocIdsReturn;
	}

	public List<ContentDocumentLink> getContentDocumentLinksByLinkedEntityIds(Set<Id> linkedEntityIds){
		getContentDocumentLinksByLinkedEntityIdsCallCount++;
		return getContentDocumentLinksByLinkedEntityIdsReturn;
	}

	public void insertContentDocumentLinks(List<ContentDocumentLink> links){
		insertContentDocumentLinksCallCount++;
	}

	public void deleteContentDocumentLinks(List<ContentDocumentLink> links){
		deleteContentDocumentLinksCallCount++;
	}
}