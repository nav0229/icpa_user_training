/****************************************************************
 Name:  ApplicantTrigger()
============================================================
Purpose: JIRA#1870/1774
                                                                                                               
============================================================
*/
trigger ApplicantTrigger on Applicant__c (after insert,after update,before insert,before update) {
    if(Trigger.isBefore){
    	if(Trigger.isInsert){
    		ApplicantTriggerHelper.beforeInsertApplicants(Trigger.new);
    	}
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ApplicantTriggerHelper.afterInsertApplicants(Trigger.new);
        }
        if(Trigger.isUpdate){
        	ApplicantTriggerHelper.afterUpdateApplicants(Trigger.oldMap, Trigger.new);
        }
    }
    
}