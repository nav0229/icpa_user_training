/****************************************************************
 Name: ChecklistItemGenerateDocumentFlagger
============================================================
Author: Lenny
Purpose: DCMM-? / Drawloop technical task
============================================================

****************************************************************/
public with sharing class ChecklistItemGenerateDocumentFlagger {
	@TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();

	public ChecklistItemGenerateDocumentFlagger() {}

	public void flagClosingChecklistItems(List<Id> loanIds) {
		List<Checklist_Item__c> checklistItemsToFlag = checklistItemDA.getLoanClosingChecklistItemsByLoanIds(loanIds);

		for(Checklist_Item__c checklistItem : checklistItemsToFlag){
			checklistItem.Generate_Document__c = true;
		}

		try{
			checklistItemDA.updateChecklistItems(checklistItemsToFlag);
		} catch (DmlException e) {
			System.debug(e);
			throw new ChecklistItemGenerateDocumentFlaggerException('Error updating the Generate Drawloop field on Closing Document Checklist Items.', e);
		}
	}

	public class ChecklistItemGenerateDocumentFlaggerException extends Exception{}
}