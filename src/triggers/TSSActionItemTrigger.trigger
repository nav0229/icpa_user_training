/*-------------------------------------------------------------------------------------------------*
  Apex trigger - TSS_Action_Item__c custom object
  TSS application trigger for validating the access for cancelling the action item
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/05/2014    1.0       Initial version.
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
trigger TSSActionItemTrigger on TSS_Action_Item__c (before insert, before update) {
    
    // before inserting a new record
    if(Trigger.isBefore && Trigger.isInsert) {
        TSSActionItemHelper.onBeforeInsert(Trigger.new);
    }
    
    // before updating the existing record
    if(Trigger.isBefore && Trigger.isUpdate) {
        TSSActionItemHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }        
}