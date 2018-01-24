/****************************************************************
 Name: LoanConditionElementsEvaluatorInterface
============================================================
Author: Kevin
Purpose: DCMM-2148
	Interface for LoanConditionElementsEvaluator
============================================================

****************************************************************/
public interface LoanConditionElementsEvaluatorInterface {
	void flagApplicationIfRequiredLoanConditionElementsCompleted(List<Loan_Condition_Element__c> loanConditionElements);
}