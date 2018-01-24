/****************************************************************
 Name: EventRequestTrigger
============================================================
Author: Kevin
Purpose: Trigger for EventRequest__c
============================================================

****************************************************************/
trigger EventRequestTrigger on Event_Request__c (after insert) {
	EventRequestTriggerHelper helper = new EventRequestTriggerHelper();

	if(Trigger.isAfter){
		if(Trigger.isInsert){
			helper.afterInsert(Trigger.new);
		}
	}
}