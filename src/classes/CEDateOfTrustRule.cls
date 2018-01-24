/****************************************************************
 Name:  CEDateOfTrustRule
============================================================
Author: Lenny
Purpose: JIRA#2221                                                                                                            
============================================================

****************************************************************/
public with sharing class CEDateOfTrustRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c dateOfTrustChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TRUST_DT_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TAG_CI_CODE).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TRUST_NAME_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = dateOfTrustChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = dateOfTrustChecklist.Id
			);
    	}

		return null;
	}
}