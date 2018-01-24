/****************************************************************
 Name:  CEDefendantTitleRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                            
============================================================

****************************************************************/
public with sharing class CEDefendantTitleRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c defTitleCEChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.DEFENDANT_TITLE_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.RA_ACM_CHECKLIST_ITEM_CODE).Id
			&& element.Id == null
		){
			return new Checklist_Item_Element__c(
				Name = defTitleCEChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = defTitleCEChecklist.Id
			);
    	}

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ASSN_DAMAGE_INSC).Id
			&& element.Id == null
		){
			return new Checklist_Item_Element__c(
				Name = defTitleCEChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = defTitleCEChecklist.Id
			);
    	}

    	if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.RA_LAW_CHECKLIST_ITEM_CODE).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.DEFENDANT_TITLE_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = defTitleCEChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = defTitleCEChecklist.Id
			);
    	}

		return null;
	}
}