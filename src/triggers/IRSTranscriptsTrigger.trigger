/****************************************************************
 Name: IRSTranscriptsTrigger
============================================================
Author: /Matt
Purpose: Trigger for IRS Transcripts
============================================================

****************************************************************/

trigger IRSTranscriptsTrigger on IRS_Transcripts__c (after insert, after update) {
	IRSTranscriptsTriggerHelper irsTriggerHelper = new IRSTranscriptsTriggerHelper();
    
    if(trigger.isAfter){
    	if(trigger.isInsert){
    		irsTriggerHelper.afterInsert(trigger.new);
    	}
    	if(trigger.isUpdate){
    		irsTriggerHelper.afterUpdate(trigger.new, trigger.oldMap);
    	}
    }
}