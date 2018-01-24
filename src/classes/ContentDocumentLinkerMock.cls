@isTest
public with sharing class ContentDocumentLinkerMock implements ContentDocumentLinkerInterface{
	public Integer handleDocumentLinksCallCount {get; private set;}

	public ContentDocumentLinkerMock() {
		handleDocumentLinksCallCount = 0;
	}

	public void handleDocumentLinks(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap){
		handleDocumentLinksCallCount++;
	}
}