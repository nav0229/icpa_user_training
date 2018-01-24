/****************************************************************
 Name: ChecklistItemGenerateDocumentFlagInvoker
============================================================
Author: Lenny
Purpose: DCMM-? / Drawloop technical task
============================================================

****************************************************************/
public with sharing class ChecklistItemGenerateDocumentFlagInvoker {

	@InvocableMethod(label='Flag Generate Document on Closing Document Checklist Items' description='Runs the method to flag the Generate Document field on applicable Checklist Items')
	public static void flagChecklistItemGenerateDocument (List<Id> loanIds) {
		ChecklistItemGenerateDocumentFlagger flagger = new ChecklistItemGenerateDocumentFlagger();
		flagger.flagClosingChecklistItems(loanIds);
	}
}