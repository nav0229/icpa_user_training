/****************************************************************
 Name: ContentDocumentLinker
============================================================
Author: Kevin
Purpose: Class to create new ContentDocumentLink to Application__c
	and remove outdated Application links
============================================================

****************************************************************/
public with sharing class ContentDocumentLinker implements ContentDocumentLinkerInterface {

	private static final String APPLICATION = 'Application__c';

	@TestVisible
	private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	@TestVisible
	private static ContentDocumentLinkDAO contentDocumentLinkDA = new ContentDocumentLinkDataAccessor();

	public ContentDocumentLinker(){}

	public void handleDocumentLinks(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap){
		if(newVersions == null || oldVersionsMap == null){
			return;
		}

		List<ContentVersion> versionsNeedingNewApplicationLink = new List<ContentVersion>();

		for(ContentVersion version : newVersions){
			if(String.isNotBlank(version.New_Parent_Application_No__c) 
				&& version.New_Parent_Application_No__c != oldVersionsMap.get(version.Id).New_Parent_Application_No__c)
			{
				versionsNeedingNewApplicationLink.add(version);
			}
		}

		if(!versionsNeedingNewApplicationLink.isEmpty()){
			linkDocumentsToApplications(versionsNeedingNewApplicationLink);
		}
	}

	private void linkDocumentsToApplications(List<ContentVersion> versionsToLink){
		List<String> newParentAppNumbers = new List<String>();
		Set<Id> docIds = new Set<Id>();

		for(ContentVersion version : versionsToLink){
			newParentAppNumbers.add(version.New_Parent_Application_No__c);
			docIds.add(version.ContentDocumentId);
		}

		List<Application__c> applicationsToLink = applicationDA.getApplicationsByApplicationNumber(newParentAppNumbers);
		List<ContentDocumentLink> oldLinksToDelete = getContentDocumentApplicationLinks(docIds);

		List<ContentDocumentLink> newLinks = new List<ContentDocumentLink>();

		for(ContentVersion version : versionsToLink){
			Boolean hasMatchingApplication = false;

			for(Application__c app : applicationsToLink){
				if(version.New_Parent_Application_No__c == app.Name){
					hasMatchingApplication = true;

					newLinks.add(new ContentDocumentLink(
						ContentDocumentId = version.ContentDocumentId,
						LinkedEntityId = app.Id,
						ShareType = 'V',
						Visibility = 'AllUsers'
					));
				}
			}

			if(!hasMatchingApplication){
				version.addError('Unable to find Application with Application Number: '+version.New_Parent_Application_No__c);
				continue;
			}

			version.New_Parent_Application_No__c = '';
		}

		try {
			contentDocumentLinkDA.deleteContentDocumentLinks(oldLinksToDelete);
			contentDocumentLinkDA.insertContentDocumentLinks(newLinks);
		} catch(DMLException e) {
			for(ContentVersion version : versionsToLink){
				version.addError('An error occurred while attempting to update Document Links: '+ e.getMessage());
			}
		}
	}

	private List<ContentDocumentLink> getContentDocumentApplicationLinks(Set<Id> docIds){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		String applicationIdPrefix = schemaMap.get(APPLICATION).getDescribe().getKeyPrefix();

		List<ContentDocumentLink> applicationLinks = new List<ContentDocumentLink>();
		List<ContentDocumentLink> links = new List<ContentDocumentLink>();

		if(docIds != null){
			links = contentDocumentLinkDA.getContentDocumentLinksByDocIds(docIds);
		}

		for(ContentDocumentLink link : links){
			String idString = (String)link.LinkedEntityId;

			if(idString.subString(0,3) == applicationIdPrefix){
				applicationLinks.add(link);
			}
		}

		return applicationLinks;
	}
}