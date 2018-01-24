/****************************************************************
 Name: ChecklistItemGenerateSysGDocFlagInvoker
============================================================
Author: Vid
Purpose: DCMM-? / Invocable class to start generation of System Generated Documents via DrawLoop
============================================================

****************************************************************/
public with sharing class ChecklistItemGenerateSysGDocFlagInvoker {
	@InvocableMethod(label='Create System Generated Document Checklists' description='Performs logic to generate various System Generated Checklists and Documents')
	public static void createSystemGeneratedChecklistItem(List<Id> appIds) {
		CaseDataAccessor caseDA = new CaseDataAccessor();
		ChecklistItemGeneratorBySysGenCase sysGenChecklistItemGenerator = new ChecklistItemGeneratorBySysGenCase();
		sysGenChecklistItemGenerator.handleChecklistGeneration(caseDA.getCasesByApplicationIds(appIds));
	}
}