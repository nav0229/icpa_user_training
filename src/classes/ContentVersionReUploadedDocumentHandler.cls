/****************************************************************
 Name: ContentVersionReUploadedDocumentHandler
============================================================
Author: Matt
Purpose: 1830 
		When a document that needs a signature is reuploaded the status 
		 of the checklist item is changed to 'Pending Case Manager Review'.
		 If all checklist Items are 'Pending Case Manager Review' the 
		 Request(case) status is also set to 'Pending Case Manager Review'.
============================================================

****************************************************************/

public with sharing class ContentVersionReUploadedDocumentHandler {

	public ContentVersionReUploadedDocumentHandler() {}

		@TestVisible
		private static CaseDAO caseDA = new CaseDataAccessor();

		@TestVisible
		private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();

		@TestVisible
		public static ContentDocumentLinkDAO contentDocDA = new ContentDocumentLinkDataAccessor();

		public void updateSignedDocumentChecklistItemStatus(List<ContentVersion> newVersions) {
			List<ContentVersion> changedContentVersions = findChangedContentVersions(newVersions);
			List<Checklist_Item__c> changedChecklistItems = new List<Checklist_Item__c>();						
			
			if(changedContentVersions.isEmpty()) { 
				return; 
			}

			changedChecklistItems = getChecklistItemsFromContentVersion(changedContentVersions);
			changedChecklistItems = changeStatusOfSignatureRequiredChecklistItemsToPCMR(changedChecklistItems);

			try{
				checklistItemDA.updateChecklistItems(changedChecklistItems);
			}catch(DmlException e) {
       			throw new ContentVersionReUploadedDocumentHandlerException('Error updating Checklist Items: ' + e.getMessage());
       		}

       		checkAndChangeStatusOfCasesAndAllChecklistItems(changedChecklistItems);	
		}

		private void checkAndChangeStatusOfCasesAndAllChecklistItems(List<Checklist_Item__c> changedChecklistItems) {
			Map<Case, List<Checklist_Item__c>> caseChecklistItemMap = new Map<Case, List<Checklist_Item__c>>();
       		List<Case> casesToUpdate = new List<Case>();
			List<Case> cases = new List<Case>();
			List<Id> caseIds = new List<Id>();
			List<Checklist_Item__c> allChecklistItems = new List<Checklist_Item__c>();

			for(Checklist_Item__c checklistItem : changedChecklistItems) {
				caseIds.add(checklistItem.Case__c);
			}

			try{
				allChecklistItems = checklistItemDA.getChecklistItemsByCaseIds(caseIds);
				cases = caseDA.getCasesByCaseIds(caseIds);
			}catch(QueryException e) {
       			throw new ContentVersionReUploadedDocumentHandlerException('Error getting Checklist Items or Cases by Case Ids: ' + e.getMessage());
			}

			caseChecklistItemMap = populateCaseChecklistItemMap(cases, allChecklistItems);
			allChecklistItems.clear();

			for(Case c: caseChecklistItemMap.keyset()) {
				List<Checklist_Item__c> checklistItemList = caseChecklistItemMap.get(c);

				if(doesEveryChecklistItemNeedingSigHaveStatusPCMR(checklistItemList)) {
					checklistItemList = changeStatusOfChecklistItemsToPCMR(checklistItemList);
					allChecklistItems.addAll(checklistItemList);
					if(c.Status == ChecklistItemDataAccessor.PENDING_BORROWERS_VERIFICATION_STATUS) {
						c.Status = ChecklistItemDataAccessor.PENDING_CASE_MANAGER_REVIEW_STATUS;
						casesToUpdate.add(c);
					}
				}
			}
			System.debug(allChecklistItems);
			System.debug(casesToUpdate);
			try{
				checklistItemDA.updateChecklistItems(allChecklistItems);
				caseDA.updateCases(casesToUpdate);	
			}catch(DmlException e) {
       			throw new ContentVersionReUploadedDocumentHandlerException('Error updating checklistItems or Cases: ' + e.getMessage());
			}
		}


		private List<ContentVersion> findChangedContentVersions(List<ContentVersion> newVersions) {
			List<ContentVersion> changedContentVersions = new List<ContentVersion>();

			for(ContentVersion cv: newVersions) {
				if(Integer.valueOf(cv.VersionNumber) > 1) {
					changedContentVersions.add(cv);
				}
			}
			return changedContentVersions;
		}



		private List<Checklist_Item__c> getChecklistItemsFromContentVersion(List<ContentVersion> changedContentVersions) {
			List<Checklist_Item__c> changedChecklistItems = new List<Checklist_Item__c>();
			List<ContentDocumentLink> contentDocLink = new List<ContentDocumentLink>();
			Set<Id> linkedEntityIds = new Set<Id>();
			Set<Id> contentDocIds = new Set<Id>();

			for(ContentVersion cv: changedContentVersions) {
				contentDocIds.add(cv.ContentDocumentId);
			}

			try{
				contentDocLink = contentDocDA.getContentDocumentLinksByDocIds(contentDocIds);	
			}catch(QueryException e) {
           		throw new ContentVersionReUploadedDocumentHandlerException('Error getting Content Document Links: ' + e.getMessage());
			}
			
			for(ContentDocumentLink cdl: contentDocLink) {
				linkedEntityIds.add(cdl.LinkedEntityId);
			}

			try{
				changedChecklistItems = checklistItemDA.getChecklistItemsByChecklistItemIds(linkedEntityIds);
			}catch(QueryException e) {
           		throw new ContentVersionReUploadedDocumentHandlerException('Error getting Checklist Items: ' + e.getMessage());
			}

			return changedChecklistItems;
		}

		private List<Checklist_Item__c> changeStatusOfSignatureRequiredChecklistItemsToPCMR(List<Checklist_Item__c> checklistItemList) {
			for(Checklist_Item__c checklistItem: checklistItemList){
				if(checklistItem.Borrower_s_Signature_Required__c && (checklistItem.Checklist_Item_Status__c == ChecklistItemDataAccessor.PENDING_BORROWERS_VERIFICATION_STATUS)) {
					checklistItem.Checklist_Item_Status__c = ChecklistItemDataAccessor.PENDING_CASE_MANAGER_REVIEW_STATUS;
				}
			}
			return checklistItemList;
		}

		private Map<Case, List<Checklist_Item__c>> populateCaseChecklistItemMap(List<Case> cases, List<Checklist_Item__c> allChecklistItems) {
			Map<Case, List<Checklist_Item__c>> caseChecklistItemMap = new Map<Case, List<Checklist_Item__c>>();

			for(Case c : cases) {
				List<Checklist_Item__c> singleCaseChecklistItems = new List<Checklist_Item__c>();

				for(Checklist_Item__c checklistItem : allChecklistItems) {
					if(checklistItem.Case__c == c.Id) {
						singleCaseChecklistItems.add(checklistItem);
					}
				}

				caseChecklistItemMap.put(c, singleCaseChecklistItems);
			}
			 return caseChecklistItemMap;
		}

		private boolean doesEveryChecklistItemNeedingSigHaveStatusPCMR(List<Checklist_Item__c> checklistItemList){
			for(Checklist_Item__c checklistItem: checklistItemList){
				if(checklistItem.Borrower_s_Signature_Required__c){
					if(checklistItem.Checklist_Item_Status__c != ChecklistItemDataAccessor.PENDING_CASE_MANAGER_REVIEW_STATUS) {
						return false;
					}
				}	
			}
   			return true;
		}

		private List<Checklist_Item__c> changeStatusOfChecklistItemsToPCMR(List<Checklist_Item__c> checklistItemList) {
			for(Checklist_Item__c checklistItem: checklistItemList){
				if(checklistItem.Checklist_Item_Status__c == ChecklistItemDataAccessor.PENDING_BORROWERS_VERIFICATION_STATUS) {
					checklistItem.Checklist_Item_Status__c = ChecklistItemDataAccessor.PENDING_CASE_MANAGER_REVIEW_STATUS;
				}
			}
			return checklistItemList;
		}

		public class ContentVersionReUploadedDocumentHandlerException extends Exception {}
}