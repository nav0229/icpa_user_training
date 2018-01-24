/****************************************************************
 Name:  CECaseNumberRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                           
============================================================

****************************************************************/
public with sharing class CECaseNumberRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c caseNumberChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.CASE_NUMBER_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.RA_LAW_CHECKLIST_ITEM_CODE).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.CASE_NUMBER_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = caseNumberChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = caseNumberChecklist.Id
			);
    	}

		return null;
	}
}