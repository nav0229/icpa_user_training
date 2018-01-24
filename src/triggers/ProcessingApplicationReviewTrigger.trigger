/****************************************************************
 Name:  ProcessingApplicationReviewTrigger
============================================================
Author: Matt
Purpose: JIRA#1711
============================================================

****************************************************************/

trigger ProcessingApplicationReviewTrigger on Processing_Application_Review__c (before insert) {

	ProcessingApplicationReviewTriggerHelper processingApplicationReviewTriggerHelper = new ProcessingApplicationReviewTriggerHelper();

	if(Trigger.isBefore){
    	if(Trigger.isInsert){
    		processingApplicationReviewTriggerHelper.beforeInsert(Trigger.new);
	    }
	}
}