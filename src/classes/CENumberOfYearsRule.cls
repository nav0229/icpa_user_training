/****************************************************************
 Name:  CENumberOfYearsRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                            
============================================================

****************************************************************/
public with sharing class CENumberOfYearsRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c numberOfYearsChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.NUM_YEARS_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LP_EXT_CHECKLIST_ITEM_CODE).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LEASE_LENGTH_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = numberOfYearsChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = numberOfYearsChecklist.Id
			);
    	}

		return null;
	}
}