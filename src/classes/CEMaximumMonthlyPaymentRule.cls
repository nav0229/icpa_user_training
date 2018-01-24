/****************************************************************
 Name:  CEMaximumMonthlyPaymentRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                            
============================================================

****************************************************************/
public with sharing class CEMaximumMonthlyPaymentRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c nameOfCourtChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.MAX_MONTHLY_PMT_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LP_EXT_CHECKLIST_ITEM_CODE).Id
			&& element.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.MONTHLY_AMOUNT_CODE).Id
		){
			return new Checklist_Item_Element__c(
				Name = nameOfCourtChecklist.Name,
				Checklist_Item__c = item.Id,
				Loan_Condition_Element__c = element.Id,
				Master_Checklist__c = nameOfCourtChecklist.Id
			);
    	}

		return null;
	}
}