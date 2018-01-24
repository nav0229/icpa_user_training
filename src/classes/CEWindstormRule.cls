/****************************************************************
 Name:  CEWindstormRule
============================================================
Author: Lenny
Purpose: JIRA#2241                                                                                                        
============================================================

****************************************************************/
public with sharing class CEWindstormRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c windstormChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.WINDSTORM_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PROOF_OF_HAZARD_INS).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.WINDSTORM_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = windstormChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = windstormChecklist.Id
			);
    	}

		return null;
	}
}