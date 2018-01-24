/****************************************************************
 Name: DisbursementLineItemTrigger
============================================================
Author: Matt
Purpose: Trigger for Disbursement Line Items
============================================================

****************************************************************/

trigger DisbursementLineItemTrigger on Disbursement_Line_Item__c (after update) {
	DisbursementLineItemTriggerHelper triggerHelper = new DisbursementLineItemTriggerHelper();

	if(trigger.isAfter) {
		if(trigger.isUpdate) {
			triggerHelper.afterUpdate(trigger.new);
		}
	}
}