/****************************************************************
 Name: LoanDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor object for Loan__c
============================================================

****************************************************************/

@isTest
public with sharing class LoanDataAccessorMock implements LoanDAO {
	public Integer getLoansByApplicationIdCallCount { get; private set; }
	public Integer getLoansByApplicationIdsCallCount { get; private set; }
	public Integer updateLoansCallCount { get; private set; }
	

	public List<Loan__c> getLoansByApplicationIdReturn;
	public List<Loan__c> getLoansByApplicationIdsReturn;

	public LoanDataAccessorMock() {
		getLoansByApplicationIdCallCount = 0;
		getLoansByApplicationIdsCallCount = 0;
		updateLoansCallCount = 0;

		getLoansByApplicationIdReturn = new List<Loan__c>();
		getLoansByApplicationIdsReturn = new List<Loan__c>();
	}

	public List<Loan__c> getLoansByApplicationId(Id applicationId){
		getLoansByApplicationIdCallCount++;
		return getLoansByApplicationIdReturn;
	}

	public List<Loan__c> getLoansByApplicationIds(List<Id> applicationIds){
		getLoansByApplicationIdsCallCount++;
		return getLoansByApplicationIdsReturn;
	}

	public void updateLoans(List<Loan__c> loans) {
		updateLoansCallCount++;
	}
}