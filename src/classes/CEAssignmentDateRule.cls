/****************************************************************
 Name:  CEAssignmentDateRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                            
============================================================

****************************************************************/
public with sharing class CEAssignmentDateRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c assnDateChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ASSIGNMENT_DATE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.RA_ACM_CHECKLIST_ITEM_CODE).Id){
			return new Checklist_Item_Element__c(
				Name = assnDateChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = assnDateChecklist.Id
			);
    	}

		return null;
	}
}