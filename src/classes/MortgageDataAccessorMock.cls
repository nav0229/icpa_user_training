/****************************************************************
 Name: MortgageDataAccessorMock
============================================================
Author: Matt/
Purpose: 1340
Mock Data Accessor for Mortgage__c
============================================================

****************************************************************/

public with sharing class MortgageDataAccessorMock implements MortgageDAO{
	public Integer getMortgageByApplicationIdsCallCount {get; private set;}
	public Integer updateMortgagesCallCount {get; private set;}
	

	public List<Mortgage__c> getMortgageByApplicationIdsReturn;

	public MortgageDataAccessorMock() {
		updateMortgagesCallCount = 0;
		getMortgageByApplicationIdsCallCount = 0;

		getMortgageByApplicationIdsReturn = new List<Mortgage__c>();
	}

	public void updateMortgages(List<Mortgage__c> mortgages) {
		updateMortgagesCallCount++;
	}

	public List<Mortgage__c> getMortgageByApplicationIds(List<Id> applicationIds) {
		getMortgageByApplicationIdsCallCount++;
		return getMortgageByApplicationIdsReturn;
	}
}