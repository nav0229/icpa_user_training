/****************************************************************
 Name: DisbursementDataAccessorMock
============================================================
Author: Matt
Purpose: Mock Data Accessor Class for Case
============================================================

****************************************************************/

@isTest
public with sharing class DisbursementDataAccessorMock implements DisbursementDAO {
	public Integer getDisbursementsByLoanIdsCallCount {get; private set;}
	public Integer getDisbursementsAndLineItemsByDisbursementIdsCallCount {get; private set;}
	public Integer updateDisbursementsCallCount {get; private set;}
	public Integer insertDisbursementsCallCount {get; private set;}
	public Integer getDisbursementsAndLineItemsByLoanIdsCallCount {get; private set;}

	public List<Disbursement__c> getDisbursementsByLoanIdsReturn;
	public List<Disbursement__c> getDisbursementsAndLineItemsByDisbursementIdsReturn;
	public List<Disbursement__c> getDisbursementsAndLineItemsByLoanIdsReturn;

	public DisbursementDataAccessorMock() {
		getDisbursementsByLoanIdsCallCount = 0;
		updateDisbursementsCallCount = 0;
		insertDisbursementsCallCount = 0;
		getDisbursementsAndLineItemsByDisbursementIdsCallCount = 0;
		getDisbursementsAndLineItemsByLoanIdsCallCount = 0;

		getDisbursementsByLoanIdsReturn = new List<Disbursement__c>();
		getDisbursementsAndLineItemsByDisbursementIdsReturn = new List<Disbursement__c>();
		getDisbursementsAndLineItemsByLoanIdsReturn = new List<Disbursement__c>();
	}

	public List<Disbursement__c> getDisbursementsByLoanIds(List<Id> loanId){
		getDisbursementsByLoanIdsCallCount++;
		return getDisbursementsByLoanIdsReturn;
	}

	public List<Disbursement__c> getDisbursementsAndLineItemsByDisbursementIds(List<Id> disbursementIds){
		getDisbursementsAndLineItemsByDisbursementIdsCallCount++;
		return getDisbursementsAndLineItemsByDisbursementIdsReturn;
	}

	public List<Disbursement__c> getDisbursementsAndLineItemsByLoanIds(List<Id> loanId) {
		getDisbursementsAndLineItemsByLoanIdsCallCount++;
		return getDisbursementsAndLineItemsByLoanIdsReturn;
	}

	public void updateDisbursements(List<Disbursement__c> disbursementIssues) {
		updateDisbursementsCallCount++;
	}

	public void insertDisbursements(List<Disbursement__c> disbursementIssues) {
		insertDisbursementsCallCount++;
	}
}