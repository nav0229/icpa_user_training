/****************************************************************
 Name: CreditBureauLineItemDataAccessorMock
============================================================
Author: Kevin/Lenny
Purpose: Mock Data Accessor for Credit_Bureau_Line_Item__c
============================================================

****************************************************************/
@isTest
public with sharing class CreditBureauLineItemDataAccessorMock implements CreditBureauLineItemDAO{
	public Integer insertCreditBureauLineItemCallCount {get; private set;}
	public Integer updateCreditBureauLineItemCallCount {get; private set;}
	public Integer updateCreditBureauLineItemsCallCount {get; private set;}
	public Integer getActiveCreditBureauLineItemsByApplicationIdsCallCount {get; private set;}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIdsReturn;

	public CreditBureauLineItemDataAccessorMock(){		
		insertCreditBureauLineItemCallCount = 0;
		updateCreditBureauLineItemCallCount = 0;
		updateCreditBureauLineItemsCallCount = 0;
		getActiveCreditBureauLineItemsByApplicationIdsCallCount = 0;

		getActiveCreditBureauLineItemsByApplicationIdsReturn = new List<Credit_Bureau_Line_Item__c>();
	}

	public void insertCreditBureauLineItem(Credit_Bureau_Line_Item__c cbrLineItem){
		insertCreditBureauLineItemCallCount++;
	}

	public void updateCreditBureauLineItem(Credit_Bureau_Line_Item__c cbrLineItem){
		updateCreditBureauLineItemCallCount++;
	}

	public void updateCreditBureauLineItems(List<Credit_Bureau_Line_Item__c> cbrLineItems){
		updateCreditBureauLineItemsCallCount++;
	}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIds(List<Id> applicatonIds) {
		getActiveCreditBureauLineItemsByApplicationIdsCallCount++;
		return getActiveCreditBureauLineItemsByApplicationIdsReturn;
	}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicantId(List<Id> applicantIds){
		return null;
	}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIds(List<Id> appIds, Set<String> purposeOfAccountCodes, 
		Set<String> paymentStatusCodes, Set<String> accountConditionCodes, String paymentStatusForeclose) 
	{	
		getActiveCreditBureauLineItemsByApplicationIdsCallCount++;
		return getActiveCreditBureauLineItemsByApplicationIdsReturn;
	}
}