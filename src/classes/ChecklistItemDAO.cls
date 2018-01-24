/****************************************************************
 Name: ChecklistItemDAO
============================================================
Author: 
Purpose: Data Access Object for ChecklistItem
============================================================

****************************************************************/

public interface ChecklistItemDAO {
	void insertChecklistItems(List<Checklist_Item__c> checklistItems);
	void updateChecklistItems(List<Checklist_Item__c> checklistItems);

	List<Checklist_Item__c> getChecklistItemsByApplicationIdsAndMasterChecklistId(List<Id> applicationIds, Id checklistId);
	List<Checklist_Item__c> getChecklistItemsByCaseIds(List<Id> caseIds);
	List<Checklist_Item__c> getChecklistItemsByChecklistItemIds(Set<Id> checklistItemIds);
	List<Checklist_Item__c> getLoanClosingChecklistItemsByLoanIds(List<Id> loanIds);
}