/****************************************************************
 Name: SBALoanHistoryDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor for SBA_Loan_History__c
============================================================

****************************************************************/

@isTest
public with sharing class SBALoanHistoryDataAccessorMock implements SBALoanHistoryDAO {
	public Integer getSBALoanHistoriesByApplicationIdsCallCount {get; private set;}

	public List<SBA_Loan_History__c> getSBALoanHistoriesByApplicationIdsReturn;

	public SBALoanHistoryDataAccessorMock() {
		getSBALoanHistoriesByApplicationIdsCallCount = 0;

		getSBALoanHistoriesByApplicationIdsReturn = new List<SBA_Loan_History__c>();
	}

	public List<SBA_Loan_History__c> getSBALoanHistoriesByApplicationIds(List<Id> applicationIds){
		getSBALoanHistoriesByApplicationIdsCallCount++;
		return getSBALoanHistoriesByApplicationIdsReturn;		
	}
}