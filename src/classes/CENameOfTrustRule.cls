/****************************************************************
 Name:  CENameOfTrustRule
============================================================
Author: Lenny
Purpose: JIRA#2221                                                                                                            
============================================================

****************************************************************/
public with sharing class CENameOfTrustRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c nameOfTrustChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TRUST_NM_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TAG_CI_CODE).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TRUST_NAME_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = nameOfTrustChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Custom_Element_Value__c = element.Custom_Element_Value__c,
				Master_Checklist__c = nameOfTrustChecklist.Id
			);
    	}

		return null;
	}
}