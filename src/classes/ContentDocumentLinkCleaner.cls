/****************************************************************
 Name:  ContentDocumentLinkCleaner
============================================================
Author: Lenny
Purpose: JIRA#1258
Ensures that there is not more than one document attached to a 
Document Line Item
============================================================

****************************************************************/
public with sharing class ContentDocumentLinkCleaner implements ContentDocumentLinkCleanerInterface {
    private static final String CHECKLIST_ITEM = 'Checklist_Item__c';
    
    @TestVisible
	private static ContentDocumentLinkDAO contentDocumentLinkDA = new ContentDocumentLinkDataAccessor();
    
    public void processDocumentLinks(List<ContentDocumentLink> contentDocumentLinks){
        Set<Id> linkedEntityIds = new Set<Id>();
    	Map<Id,ContentDocumentLink> linkedEntityIdToContentDocumentLinkMap = new Map<Id,ContentDocumentLink>();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        String checklistItemIdPrefix = schemaMap.get(CHECKLIST_ITEM).getDescribe().getKeyPrefix();

    	for(ContentDocumentLink newLink : contentDocumentLinks) {
    		if(doesIdPrefixMatch(newLink.LinkedEntityId, checklistItemIdPrefix)){
                linkedEntityIds.add(newLink.LinkedEntityId);
	    		linkedEntityIdToContentDocumentLinkMap.put(newLink.LinkedEntityId, newLink);
    		}
    	}

        List<ContentDocumentLink> existingLinks = new List<ContentDocumentLink>();
        if(!linkedEntityIds.isEmpty()){
            try {
                existingLinks = contentDocumentLinkDA.getContentDocumentLinksByLinkedEntityIds(linkedEntityIds);
            } catch (QueryException e) {
                throw new QueryException('An error occurred retrieving ContentDocuments by LinkedEntityIds: '+e.getMessage());
            }
        }
        for(ContentDocumentLink link : existingLinks) {
            if(linkedEntityIds.contains(link.LinkedEntityId)){
                ContentDocumentLink relatedNewLink = linkedEntityIdToContentDocumentLinkMap.get(link.LinkedEntityId);
                relatedNewLink.addError('Document Line Item is already linked to another ContentDocument: ' + link.ContentDocumentId); 
            }
        }
    		
    }
    
    private boolean doesIdPrefixMatch(Id linkedEntityId, String idPrefix){		
		String idString = (String)linkedEntityId;

		return idString.subString(0,3) == idPrefix;
    }
}