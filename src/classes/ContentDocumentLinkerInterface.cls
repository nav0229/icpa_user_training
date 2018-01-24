/****************************************************************
 Name: ContentDocumentLinkerInterface
============================================================
Author: 
Purpose: Interface for ContentDocumentLinker
============================================================

****************************************************************/

public interface ContentDocumentLinkerInterface {

	void handleDocumentLinks(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap);
}