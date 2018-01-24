/****************************************************************
 Name:  DisbursementTriggerHelper
============================================================
Author: Matt
Purpose: Trigger helper for Disbursement Objects                                                                                       
============================================================

****************************************************************/

public with sharing class DisbursementTriggerHelper {

	DisbursementLineItemHandler disbursementLIHandler = new DisbursementLineItemHandler();
	DisbursementLineItemDAO disbursementLineItemDA = new DisbursementLineItemDataAccessor();

	public DisbursementTriggerHelper() {}

	public void afterInsert(List<Disbursement__c> disbursements) {
		List<Disbursement_Line_Item__c> disbursementLineItems = new List<Disbursement_Line_Item__c>();

		disbursementLineItems.addAll(disbursementLIHandler.createDisbursementLineItems(disbursements));

		try {
			disbursementLineItemDA.insertDisbursementLineItems(disbursementLineItems);
		}catch(DmlException e) {
			System.debug(e.getMessage());
			throw new DisbursementTriggerHelperException('An error accured while inserting Disbursement Line Items');
		}
	}

	public class DisbursementTriggerHelperException extends Exception {}
}