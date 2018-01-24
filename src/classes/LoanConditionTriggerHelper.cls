/****************************************************************
 Name: LoanConditionTriggerHelper
============================================================
Author: Kevin
Purpose: DCMM-2148
	Trigger Helper for LoanConditionTrigger
============================================================

****************************************************************/
public with sharing class LoanConditionTriggerHelper {
	@TestVisible private static LoanConditionElementGeneratorInterface loanConditionElementGenerator = new LoanConditionElementGenerator();

	public LoanConditionTriggerHelper(){}

	public void afterInsert(List<Loan_Condition_Checklist__c> newLoanConditions){
		loanConditionElementGenerator.generateLoanConditionElements(newLoanConditions);
	}
}