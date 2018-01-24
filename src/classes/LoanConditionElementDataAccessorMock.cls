/****************************************************************
 Name: LoanConditionElementDataAccessorMock
============================================================
Author: Kevin
Purpose: DCMM-2148
	Mock Data Accessor for Loan_Condition_Element__c
============================================================

****************************************************************/
@isTest
public with sharing class LoanConditionElementDataAccessorMock implements LoanConditionElementDAO {
	public Integer insertLoanConditionElementsCallCount { get; private set; }
	public Integer getLoanConditionElementsByLoanConditionChecklistIdsCallCount { get; private set; }
	public Integer getRequiredLoanConditionElementsByLoanConditionChecklistIdsCallCount {get; private set;}

	public List<Loan_Condition_Element__c> getLoanConditionElementsByLoanConditionChecklistIdsReturn;
	public List<Loan_Condition_Element__c> getRequiredLoanConditionElementsByLoanConditionChecklistIdsReturn;

	public LoanConditionElementDataAccessorMock() {
		insertLoanConditionElementsCallCount = 0;
		getLoanConditionElementsByLoanConditionChecklistIdsCallCount = 0;
		getRequiredLoanConditionElementsByLoanConditionChecklistIdsCallCount = 0;

		getLoanConditionElementsByLoanConditionChecklistIdsReturn = new List<Loan_Condition_Element__c>();
		getRequiredLoanConditionElementsByLoanConditionChecklistIdsReturn = new List<Loan_Condition_Element__c>();
	}

	public void insertLoanConditionElements(List<Loan_Condition_Element__c> loanConditionElements){
		insertLoanConditionElementsCallCount++;
	}

	public List<Loan_Condition_Element__c> getLoanConditionElementsByLoanConditionChecklistIds(List<Id> loanConditionIds){
		getLoanConditionElementsByLoanConditionChecklistIdsCallCount++;
		return getLoanConditionElementsByLoanConditionChecklistIdsReturn;
	}

	public List<Loan_Condition_Element__c> getRequiredLoanConditionElementsByLoanConditionChecklistIds(List<Id> loanConditionIds){
		getRequiredLoanConditionElementsByLoanConditionChecklistIdsCallCount++;
		return getRequiredLoanConditionElementsByLoanConditionChecklistIdsReturn;
	}
}