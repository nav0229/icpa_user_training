/****************************************************************
 Name: ContentVersionTrigger
============================================================
Author: Kevin/Matt
Purpose: Trigger for ContentVersion
============================================================

****************************************************************/
trigger ContentVersionTrigger on ContentVersion (before update, after insert) {
	ContentVersionTriggerHelper contentVersionHelper = new ContentVersionTriggerHelper();

	if(trigger.isBefore){
		if(trigger.isUpdate){
			System.debug('isBefore isUpdate');
			contentVersionHelper.beforeUpdate(trigger.new, trigger.oldMap);
		}
	}
	if(trigger.isAfter) {
		if(trigger.isInsert) {
			System.debug('isAfter isInsert');
			contentVersionHelper.afterInsert(trigger.new);
		}
	}
}