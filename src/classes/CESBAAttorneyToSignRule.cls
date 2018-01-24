/****************************************************************
 Name:  CESBAAttorneyToSignRule
============================================================
Author: Lenny
Purpose: JIRA#2170                                                                                                            
============================================================

****************************************************************/
public with sharing class CESBAAttorneyToSignRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c attorneyToSignChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ATTORNEY_TO_SIGN_CODE);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.RA_ACM_CHECKLIST_ITEM_CODE).Id){
			return new Checklist_Item_Element__c(
				Name = attorneyToSignChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = attorneyToSignChecklist.Id
			);
    	}

		return null;
	}
}