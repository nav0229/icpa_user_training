/****************************************************************
 Name: ChecklistItemCreateSystemGeneratedDoc
============================================================
Author: Vid
Purpose: DCMM-? / Invocable class to start generation of System Generated Documents via DrawLoop
============================================================

****************************************************************/
public with sharing class ChecklistItemCreateSystemGeneratedDoc {
	@InvocableMethod(label='Create System Generated Document Checklists' description='Performs logic to generate various System Generated Checklists and Documents')
	public static void createSystemGeneratedChecklistItem(List<CustomApplication> cApps) {
		List<Id> appIds;
		CaseDataAccessor caseDA = new CaseDataAccessor();
		ChecklistItemGeneratorBySysGenCase sysGenChecklistItemGenerator = new ChecklistItemGeneratorBySysGenCase();
		sysGenChecklistItemGenerator.handleChecklistGeneration(caseDA.getCasesByApplicationIds(appIds));
	}
	
	public class CustomApplication {
		@InvocableVariable
		public Id appId;
		@InvocableVariable
		public List<String> docTypeCode;
		
		public CustomApplication() {
			
		}
	}
}