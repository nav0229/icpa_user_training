/****************************************************************
 Name: LoanConditionElementDAO
============================================================
Author: Kevin
Purpose: DCMM-2148
	DAO for Loan_Condition_Element__c
============================================================

****************************************************************/
public interface LoanConditionElementDAO {
	void insertLoanConditionElements(List<Loan_Condition_Element__c> loanConditionElements);

	List<Loan_Condition_Element__c> getLoanConditionElementsByLoanConditionChecklistIds(List<Id> loanConditionIds);
	List<Loan_Condition_Element__c> getRequiredLoanConditionElementsByLoanConditionChecklistIds(List<Id> loanConditionIds);
}