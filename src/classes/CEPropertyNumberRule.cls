/****************************************************************
 Name:  CEPropertyNumberRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                            
============================================================

****************************************************************/
public with sharing class CEPropertyNumberRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c propertyNumberCEChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PROPERTY_NUMBER_CIE_CODE);

		if(element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PROPERTY_NUMBER_CODE).Id){
			return new Checklist_Item_Element__c(
				Name = propertyNumberCEChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = propertyNumberCEChecklist.Id
			);
    	}

		return null;
	}
}