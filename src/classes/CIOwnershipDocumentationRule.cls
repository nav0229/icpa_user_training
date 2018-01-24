/****************************************************************
 Name:  CIOwnershipDocumentationRule
============================================================
Author: Lenny
Purpose: JIRA#2221                                                                                                            
============================================================

****************************************************************/
public with sharing class CIOwnershipDocumentationRule implements ChecklistItemRuleInterface{
	private static final Set<String> OWNERSHIP_DOCUMENTATION_REQUIRED_LC_CODES = new Set<String>{
		MasterChecklistDataAccessor.OWNR_DOC_DEED,
		MasterChecklistDataAccessor.OWNR_DOC_VSL,
		MasterChecklistDataAccessor.OWNR_DOC_MANU_HOME,
		MasterChecklistDataAccessor.OWNR_DOC_CUSTOM
	};

	public Checklist_Item__c applyRuleAndCreateChecklistItem(ChecklistItemGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Case cas = generationCriteria.relatedCase;
		Application__c application = generationCriteria.relatedApplication;
		Loan_Condition_Checklist__c loanCondition = generationCriteria.relatedLC;
		Master_Checklist__c masterChecklist = mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.OWNR_DOC_CI);

		Set<Id> loanConditionsRequiringOwnershipDoc = createLoanConditionSet(mcData);

		if(passesOwnershipDocumentLoanConditionRules(
			loanCondition,
			loanConditionsRequiringOwnershipDoc
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

	private Boolean passesOwnershipDocumentLoanConditionRules(Loan_Condition_Checklist__c loanCondition, Set<Id> loanConditionsRequiringOwnershipDoc) {
		return (
			loanConditionsRequiringOwnershipDoc.contains(loanCondition.Master_Checklist__c)
			&& loanCondition.Active__c == true
		);
	}

	private Set<Id> createLoanConditionSet(MasterChecklistData mcData){
		Set<Id> loanConditionsRequiringOwnershipDoc = new Set<Id>();
		for(String checklistCode : OWNERSHIP_DOCUMENTATION_REQUIRED_LC_CODES) {
			Master_Checklist__c masterChecklist = mcData.getMasterChecklistByChecklistCode(checklistCode);
			loanConditionsRequiringOwnershipDoc.add(masterChecklist.Id);	
		}
		return loanConditionsRequiringOwnershipDoc;
	}
}