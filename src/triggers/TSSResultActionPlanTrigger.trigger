/*-------------------------------------------------------------------------------------------------*
  Apex trigger - TSS_Result_Action_Plan__c custom object
  TSS application trigger for change the owner to respective property manageer.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/05/2014    1.0       Initial version.
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
trigger TSSResultActionPlanTrigger on TSS_Result_Action_Plan__c (before insert, before update) {
    
    // before inserting a new record
    if(Trigger.isBefore && Trigger.isInsert) {
        TSSResultActionPlanHelper.onBeforeInsert(Trigger.new);
    }
    
    // before updating the existing record
    if(Trigger.isBefore && Trigger.isUpdate) {
        TSSResultActionPlanHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }        
}