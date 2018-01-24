/****************************************************************
 Name: ContentDocumentLinkDAO
============================================================
Author: Kevin
Purpose: Data Access Object for ContentDocumentlink
============================================================

****************************************************************/
public interface ContentDocumentLinkDAO {
	void insertContentDocumentLinks(List<ContentDocumentLink> links);
	void deleteContentDocumentLinks(List<ContentDocumentLink> links);

	List<ContentDocumentLink> getContentDocumentLinksByDocIds(Set<Id> contentDocumentIds);
	List<ContentDocumentLink> getContentDocumentLinksByLinkedEntityIds(Set<Id> linkedEntityIds);
}