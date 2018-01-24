/****************************************************************
 Name: LoanConditionGeneratorRuleFactory
============================================================
Author: Lenny
Purpose: DCMM-2138
	Factory class that determines which rules should be applied to criteria
	This class also house the Generator Rule classes
============================================================

****************************************************************/
public with sharing class LoanConditionGeneratorRuleFactory {

	public LoanConditionGeneratorRuleFactory() {}

	public List<LoanConditionRuleInterface> getApplicableApplicationLevelAutomatedLoanConditionGeneratorRules(){
		List<LoanConditionRuleInterface> rulesList = new List<LoanConditionRuleInterface>();

		rulesList.add(new LCStandardRealEstateRule());

		return rulesList;
	}

	public List<LoanConditionRuleInterface> getApplicablePropertyLevelAutomatedLoanConditionGeneratorRules(){
		List<LoanConditionRuleInterface> rulesList = new List<LoanConditionRuleInterface>();		

		rulesList.add(new LCCondominiumRepairsRule());
		rulesList.add(new LCHazardInsuranceDamagedPropertyRule());
		rulesList.add(new LCHazardInsuranceOtherPropertyRule());

		return rulesList;
	}
}