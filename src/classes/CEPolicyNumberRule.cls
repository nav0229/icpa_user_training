/****************************************************************
 Name:  CEPolicyNumberRule
============================================================
Author: Lenny
Purpose: JIRA#2221                                                                                                            
============================================================

****************************************************************/
public with sharing class CEPolicyNumberRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c policyNumberChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.POLICY_NUMBER_CIE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ASSN_LIFE_INSC).Id
			&& element.Id == null
		){
			return new Checklist_Item_Element__c(
				Name = policyNumberChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = policyNumberChecklist.Id
			);
    	}

		return null;
	}
}