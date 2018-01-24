/****************************************************************
 Name: LoanConditionChecklistDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor for Loan_Condition_Checklist__c
============================================================

****************************************************************/

@isTest
public with sharing class LoanConditionChecklistDataAccessorMock implements LoanConditionChecklistDAO {
	public Integer insertLoanConditionChecklistsCallCount {get; private set;}
	public Integer getActiveLoanConditionChecklistsByApplicationIdsCallCount {get; private set;}
	public Integer getActiveLoanConditionChecklistsByIdsCallCount {get; private set;}

	public List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByApplicationIdsReturn;
	public List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByIdsReturn;

	public LoanConditionChecklistDataAccessorMock(){
		insertLoanConditionChecklistsCallCount = 0;
		getActiveLoanConditionChecklistsByApplicationIdsCallCount = 0;
		getActiveLoanConditionChecklistsByIdsCallCount = 0;

		getActiveLoanConditionChecklistsByApplicationIdsReturn = new List<Loan_Condition_Checklist__c>();
		getActiveLoanConditionChecklistsByIdsReturn = new List<Loan_Condition_Checklist__c>();
	}

	public void insertLoanConditionChecklists(List<Loan_Condition_Checklist__c> loanConditionChecklists){
		insertLoanConditionChecklistsCallCount++;
	}

	public List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByApplicationIds(List<Id> applicationIds){
		getActiveLoanConditionChecklistsByApplicationIdsCallCount++;
		return getActiveLoanConditionChecklistsByApplicationIdsReturn;
	}

	public List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByIds(List<Id> loanConditionIds){
		getActiveLoanConditionChecklistsByIdsCallCount++;
		return getActiveLoanConditionChecklistsByIdsReturn;
	}
}