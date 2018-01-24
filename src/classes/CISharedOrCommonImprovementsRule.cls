/****************************************************************
 Name:  CISharedOrCommonImprovementsRule
============================================================
Author: Lenny
Purpose: JIRA#2148                                                                                                            
============================================================

****************************************************************/
public with sharing class CISharedOrCommonImprovementsRule implements ChecklistItemRuleInterface{
	
	public Checklist_Item__c applyRuleAndCreateChecklistItem(ChecklistItemGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Case cas = generationCriteria.relatedCase;
		Application__c application = generationCriteria.relatedApplication;
		Loan_Condition_Checklist__c loanCondition = generationCriteria.relatedLC;
		Master_Checklist__c masterChecklist = mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.OC_SHD_CHECKLIST_ITEM_CODE);

		if(passesOCSHDLoanConditionRules(
			generationCriteria.relatedLC, 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.OC_SHD_LOAN_CONDITION_CODE)
		)){
			return new Checklist_Item__c(
	            Name = masterChecklist.Name + '-' + application.Name,
	            Application__c = application.Id,
	            Master_Checklist__c = masterChecklist.Id,
	            Loan__c = cas.Loan__c,
	            Loan_Condition__c = loanCondition.Id,
	            Property__c = loanCondition.Property__c,
	            Case__c = cas.Id,
	            Checklist_Item_Status__c = ChecklistItemDataAccessor.FINALIZED_STATUS,
	            Checklist_Item_Text__c = masterChecklist.Checklist_Description__c,
	            Type__c = ChecklistItemDataAccessor.CLOSING_DOC_TYPE,
	            Last_Action_Date__c = System.Now(),
	            Borrower_s_Signature_Required__c = false
        	);
		}

		return null;
	}

	private Boolean passesOCSHDLoanConditionRules(Loan_Condition_Checklist__c loanCondition, Master_Checklist__c relatedMC) {
		return (
			loanCondition.Master_Checklist__c == relatedMC.Id
			&& loanCondition.Active__c == true
			&& loanCondition.Loan_Condition_Type__c == 'Property'
		);
	}
}