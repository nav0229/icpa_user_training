/****************************************************************
 Name:  ChecklistItemElementRuleFactory
============================================================
Author: Lenny
Purpose: JIRA#2148,2170,2221                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemElementRuleFactory {
	public ChecklistItemElementRuleFactory() {}

	public List<ChecklistItemElementRuleInterface> getApplicableLCERelatedChecklistItemElementRules(){
		List<ChecklistItemElementRuleInterface> rulesList = new List<ChecklistItemElementRuleInterface>();

		rulesList.add(new CESharedRepairResponsibilityRule());
		rulesList.add(new CECaseNumberRule());
		rulesList.add(new CEDefendantTitleRule());
		rulesList.add(new CEDefendantNameRule());
		rulesList.add(new CENameOfCourtRule());	
		rulesList.add(new CEMaximumMonthlyPaymentRule());	
		rulesList.add(new CENumberOfYearsRule());	
		rulesList.add(new CEPropertyNumberRule());
		rulesList.add(new CERealEstateCoverageRule());
		rulesList.add(new CEContentsCoverageRule());
		rulesList.add(new CELossPayeeRule());
		rulesList.add(new CEWindstormRule());
		rulesList.add(new CENameOfTrustRule());
		rulesList.add(new CEDateOfTrustRule());

		return rulesList;
	}

	public List<ChecklistItemElementRuleInterface> getApplicableCILevelChecklistItemElementRules(){
		List<ChecklistItemElementRuleInterface> rulesList = new List<ChecklistItemElementRuleInterface>();

		rulesList.add(new CEDefendantTitleRule());
		rulesList.add(new CEDefendantNameRule());
		rulesList.add(new CEAssignmentDateRule());
		rulesList.add(new CESBAAttorneyToSignRule());		
		rulesList.add(new CESewerBackupRule());
		rulesList.add(new CEPolicyNumberRule());
		rulesList.add(new CECarrierNameRule());
		rulesList.add(new CEAmountOfInsuranceRule());
		rulesList.add(new CENameOfInsuredRule());

		return rulesList;
	}
}