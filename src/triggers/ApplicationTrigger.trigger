/****************************************************************
 Name: ApplicationTrigger
============================================================
Author: Kevin
Purpose: Trigger for Application__c
============================================================

****************************************************************/
trigger ApplicationTrigger on Application__c (before insert, after update) {
	ApplicationTriggerHelper applicationTriggerHelper = new ApplicationTriggerHelper();

	if(trigger.isBefore){
		if(trigger.isInsert){
			applicationTriggerHelper.beforeInsert(trigger.new);
		}
	} else if(trigger.isAfter){
		if(trigger.isUpdate){
			applicationTriggerHelper.afterUpdate(trigger.new, trigger.oldMap);
		}
	}
}