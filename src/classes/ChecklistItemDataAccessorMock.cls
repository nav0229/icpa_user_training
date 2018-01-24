/****************************************************************
 Name: ChecklistItemDataAccessorMock
============================================================
Author: Lenny
Purpose: Mock Data Accessor Class for ChecklistItem
============================================================

****************************************************************/

@isTest
public with sharing class ChecklistItemDataAccessorMock implements ChecklistItemDAO{
	public Integer insertChecklistItemsCallCount { get; private set; }
	public Integer updateChecklistItemsCallCount { get; private set; }
	public Integer getChecklistItemsByApplicationIdsAndMasterChecklistIdCallCount {get; private set;}
	public Integer getChecklistItemsByCaseIdsCallCount {get; private set;}
	public Integer getChecklistItemsByChecklistItemIdsCallCount {get; private set;}
	public Integer getLoanClosingChecklistItemsByLoanIdsCallCount {get; private set;}

	public List<Checklist_Item__c> getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn;
	public List<Checklist_Item__c> getChecklistItemsByCaseIdsReturn;
	public List<Checklist_Item__c> getChecklistItemsByChecklistItemIdsReturn;
	public List<Checklist_Item__c> getLoanClosingChecklistItemsByLoanIdsReturn;

	public ChecklistItemDataAccessorMock(){
		insertChecklistItemsCallCount = 0;
		updateChecklistItemsCallCount = 0;
		getChecklistItemsByApplicationIdsAndMasterChecklistIdCallCount = 0;
		getChecklistItemsByCaseIdsCallCount = 0;
		getChecklistItemsByChecklistItemIdsCallCount = 0;
		getLoanClosingChecklistItemsByLoanIdsCallCount = 0;

		getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn = new List<Checklist_Item__c>();
		getChecklistItemsByCaseIdsReturn = new List<Checklist_Item__c>();
		getChecklistItemsByChecklistItemIdsReturn = new List<Checklist_Item__c>();
		getLoanClosingChecklistItemsByLoanIdsReturn = new List<Checklist_Item__c>();
	}

	public void insertChecklistItems(List<Checklist_Item__c> checklistItems){
		insertChecklistItemsCallCount++;
	}

	public void updateChecklistItems(List<Checklist_Item__c> checklistItems){
		updateChecklistItemsCallCount++;
	}

	public List<Checklist_Item__c> getChecklistItemsByApplicationIdsAndMasterChecklistId(List<Id> applicationIds, Id checklistId) {
		getChecklistItemsByApplicationIdsAndMasterChecklistIdCallCount++;
		return getChecklistItemsByApplicationIdsAndMasterChecklistIdReturn;
	}

	public List<Checklist_Item__c> getChecklistItemsByCaseIds(List<Id> caseIds) {
		getChecklistItemsByCaseIdsCallCount++;
		return getChecklistItemsByCaseIdsReturn;
	}

	public List<Checklist_Item__c> getChecklistItemsByChecklistItemIds(Set<Id> checklistItemIds) {
		getChecklistItemsByChecklistItemIdsCallCount++;
		return getChecklistItemsByChecklistItemIdsReturn;
	}

	public List<Checklist_Item__c> getLoanClosingChecklistItemsByLoanIds(List<Id> loanIds){
		getLoanClosingChecklistItemsByLoanIdsCallCount++;
		return getLoanClosingChecklistItemsByLoanIdsReturn;
	}
}