/****************************************************************
 Name:  CESewerBackupRule
============================================================
Author: Lenny
Purpose: JIRA#2241                                                                                                            
============================================================

****************************************************************/
public with sharing class CESewerBackupRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c sewerBackupChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.SEWER_BACKUP_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PROOF_OF_HAZARD_INS).Id){
			return new Checklist_Item_Element__c(
				Name = sewerBackupChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = sewerBackupChecklist.Id
			);
    	}

		return null;
	}
}