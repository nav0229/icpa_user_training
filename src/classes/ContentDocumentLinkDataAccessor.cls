/****************************************************************
 Name: ContentDocumentLinkDataAccessor
============================================================
Author: Kevin
Purpose: Data Accessor for ContentDocumentLink Object
============================================================

****************************************************************/
public with sharing class ContentDocumentLinkDataAccessor implements ContentDocumentLinkDAO {

	private final String CONTENT_DOCUMENT_LINK = 'ContentDocumentLink';

	private Set<String> contentDocumentLinkFields;

	public ContentDocumentLinkDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.contentDocumentLinkFields = schemaMap.get(CONTENT_DOCUMENT_LINK).getDescribe().fields.getMap().keySet();
	}

	public void insertContentDocumentLinks(List<ContentDocumentLink> links) {
		insert links;
	}

	public void deleteContentDocumentLinks(List<ContentDocumentLink> links) {
		delete links;
	}

	public List<ContentDocumentLink> getContentDocumentLinksByDocIds(Set<Id> contentDocumentIds) {
		QueryBuilder contentDocumentLinkQueryBuilder = new QueryBuilder(CONTENT_DOCUMENT_LINK);
        contentDocumentLinkQueryBuilder.addSelectField(this.contentDocumentLinkFields);
        contentDocumentLinkQueryBuilder.addWhereCondition('ContentDocumentId', new List<Id>(contentDocumentIds), QueryBuilder.ComparisonOperator.IN_LIST);
        return Database.query(contentDocumentLinkQueryBuilder.generateQuery());
	}

	public List<ContentDocumentLink> getContentDocumentLinksByLinkedEntityIds(Set<Id> linkedEntityIds) {
		QueryBuilder contentDocumentLinkQueryBuilder = new QueryBuilder(CONTENT_DOCUMENT_LINK);
        contentDocumentLinkQueryBuilder.addSelectField(this.contentDocumentLinkFields);
        contentDocumentLinkQueryBuilder.addWhereCondition('LinkedEntityId', new List<Id>(linkedEntityIds), QueryBuilder.ComparisonOperator.IN_LIST);
        return Database.query(contentDocumentLinkQueryBuilder.generateQuery());
	}
}