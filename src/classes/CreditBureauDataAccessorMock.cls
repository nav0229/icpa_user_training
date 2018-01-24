/****************************************************************
 Name: CreditBureauDataAccessorMock
============================================================
Author: Lenny
Purpose: Mock Data Accessor Class for Credit_Bureau__c
============================================================

****************************************************************/

@isTest
public with sharing class CreditBureauDataAccessorMock implements CreditBureauDAO {
	public Integer getActiveCreditBureausByIdCallCount {get; private set;}
	public Integer getActiveCreditBureausByApplicationLatestFirstCallCount {get; private set;}
	public Integer getActiveCreditBureausByApplicantIdCallCount {get; private set;}
	public Integer getActiveCreditBureausByApplicationIdsCallCount {get; private set;}
	public Integer insertCreditBureausCallCount {get; private set;}
	public Integer updateCreditBureausCallCount {get; private set;}
	public Integer insertCreditBureauCallCount {get; private set;}

	public List<Credit_Bureau__c> getActiveCreditBureausByIdReturn;
	public List<Credit_Bureau__c> getActiveCreditBureausByApplicationLatestFirstReturn;
	public List<Credit_Bureau__c> getActiveCreditBureausByApplicantIdReturn;
	public List<Credit_Bureau__c> getActiveCreditBureausByApplicationIdsReturn;

	public CreditBureauDataAccessorMock(){
		getActiveCreditBureausByIdCallCount = 0;		
		getActiveCreditBureausByApplicationLatestFirstCallCount = 0;
		getActiveCreditBureausByApplicantIdCallCount = 0;
		getActiveCreditBureausByApplicationIdsCallCount = 0;
		insertCreditBureausCallCount = 0;
		updateCreditBureausCallCount = 0;
		insertCreditBureauCallCount = 0;

		getActiveCreditBureausByIdReturn = new List<Credit_Bureau__c>();
		getActiveCreditBureausByApplicationLatestFirstReturn = new List<Credit_Bureau__c>();
		getActiveCreditBureausByApplicantIdReturn = new List<Credit_Bureau__c>();
		getActiveCreditBureausByApplicationIdsReturn = new List<Credit_Bureau__c>();
	}

	public List<Credit_Bureau__c> getActiveCreditBureausById(List<Id> creditBureauIds){
		getActiveCreditBureausByIdCallCount++;
		return getActiveCreditBureausByIdReturn;
	}

	public List<Credit_Bureau__c> getActiveCreditBureausByApplicationLatestFirst(Application__c app) {
		getActiveCreditBureausByApplicationLatestFirstCallCount++;
		return getActiveCreditBureausByApplicationLatestFirstReturn;
	}
    
    public List<Credit_Bureau__c> getActiveCreditBureausByApplicantId(List<Id> applicantIds) {
    	getActiveCreditBureausByApplicantIdCallCount++;
        return getActiveCreditBureausByApplicantIdReturn;
    }

    public List<Credit_Bureau__c> getActiveCreditBureausByApplicationIds(List<Id> applicationIds) {
    	getActiveCreditBureausByApplicationIdsCallCount++;
    	return getActiveCreditBureausByApplicationIdsReturn;
    }

	public void insertCreditBureaus(List<Credit_Bureau__c> creditBureaus){
		insertCreditBureausCallCount++;
	}

	public void updateCreditBureaus(List<Credit_Bureau__c> creditBureaus) {
		updateCreditBureausCallCount++;
	}

	public void insertCreditBureau(Credit_Bureau__c creditBureau) {
		insertCreditBureauCallCount++;
	}
}