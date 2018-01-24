/****************************************************************
 Name:  CENameOfInsuredRule
============================================================
Author: Lenny
Purpose: JIRA#2221                                                                                                            
============================================================

****************************************************************/
public with sharing class CENameOfInsuredRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c nameOfInsuredChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.NAME_OF_INSURED);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ASSN_LIFE_INSC).Id
			&& element.Id == null
		){
			return new Checklist_Item_Element__c(
				Name = nameOfInsuredChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = nameOfInsuredChecklist.Id
			);
    	}

		return null;
	}
}