/****************************************************************
 Name:  CESharedRepairResponsibilityRule
============================================================
Author: Lenny
Purpose: JIRA#2148                                                                                                            
============================================================

****************************************************************/
public with sharing class CESharedRepairResponsibilityRule implements ChecklistItemElementRuleInterface{
	public CESharedRepairResponsibilityRule() {}

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c srrChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.SRR_CHECKLIST_ELEMENT_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.OC_SHD_CHECKLIST_ITEM_CODE).Id
			&& element.Element_Type__c == LoanConditionElementDataAccessor.SHARED_REPAIR_RESPONSIBILITY_TYPE
		){
			return new Checklist_Item_Element__c(
				Name = srrChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = srrChecklist.Id
			);
    	}

		return null;
	}
}