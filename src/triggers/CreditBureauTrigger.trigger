/****************************************************************
 Name: CreditBureauTrigger
============================================================
Author: Matt
Purpose: 
	Trigger for Credit_Bureau__c
============================================================

****************************************************************/

trigger CreditBureauTrigger on Credit_Bureau__c (after insert) {

	CreditBureauTriggerHelper cbrTriggerHelper = new CreditBureauTriggerHelper();


	if(trigger.isAfter) {
		if(trigger.isInsert) {
			cbrTriggerHelper.afterInsert(trigger.new);
		}
	}
}