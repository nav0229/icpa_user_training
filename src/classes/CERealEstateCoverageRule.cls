/****************************************************************
 Name:  CERealEstateCoverageRule
============================================================
Author: Lenny
Purpose: JIRA#2241                                                                                                        
============================================================

****************************************************************/
public with sharing class CERealEstateCoverageRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c reCoverageChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.RE_COVERAGE_CIE_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PROOF_OF_HAZARD_INS).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.REAL_ESTATE_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = reCoverageChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = reCoverageChecklist.Id
			);
    	}

		return null;
	}
}