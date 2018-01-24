/****************************************************************
 Name: CaseTrigger
============================================================
Author: Kevin
Purpose: Trigger for Case
============================================================

****************************************************************/
trigger CaseTrigger on Case (after insert) {
    CaseTriggerHelper caseTriggerHelper = new caseTriggerHelper();
    
    if(trigger.isAfter){
    	if(trigger.isInsert){
    		caseTriggerHelper.afterInsert(trigger.new);
    	}
    }
}