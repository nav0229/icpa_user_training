/****************************************************************
 Name:  DisbursementLineItemDataAccessorMock
============================================================
Author: Matt
Purpose: Data accessor mock for disbursement line items                                                                                                    
============================================================

****************************************************************/
@isTest
public with sharing class DisbursementLineItemDataAccessorMock implements DisbursementLineItemDAO {
	public Integer insertDisbursementLineItemsCallCount {get; private set;}

	public DisbursementLineItemDataAccessorMock() {
		insertDisbursementLineItemsCallCount = 0;
		
	}

	public void insertDisbursementLineItems(List<Disbursement_Line_Item__c> disbursementLineItems) {
		insertDisbursementLineItemsCallCount++;
	}
}