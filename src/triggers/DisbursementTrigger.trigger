/****************************************************************
 Name:  DisbursementTrigger
============================================================
Author: Matt
Purpose: Trigger for Disbursement Objects                                                                                       
============================================================

****************************************************************/

trigger DisbursementTrigger on Disbursement__c (after insert) {
	DisbursementTriggerHelper disbursementTH = new DisbursementTriggerHelper();

	if(trigger.isAfter) {
		if(trigger.isInsert) {
			disbursementTH.afterInsert(trigger.new);
		}
	}
}