/****************************************************************
 Name:  DisbursementLineItemDataAccessor
============================================================
Author: Matt
Purpose: Data Accessor for Disbursement Line Items                                                                                                
============================================================

****************************************************************/

public with sharing class DisbursementLineItemDataAccessor implements DisbursementLineItemDAO {
	public DisbursementLineItemDataAccessor() {

	}

	public void insertDisbursementLineItems(List<Disbursement_Line_Item__c> disbursementLineItems) {
		insert disbursementLineItems;
	}
}