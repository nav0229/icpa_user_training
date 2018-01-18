/*-------------------------------------------------------------------------------------------------*
  Apex trigger - Leasing__c custom object
  IMT Leasing trigger to create/update the event on the IMT calendar.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/30/2013    1.0       Initial version.
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
trigger IMTLeasingTrigger on Leasing__c (before update, after insert, after update) {
    
    // before updating the existing record
    if(Trigger.isBefore && Trigger.isUpdate) {
        IMTLeasingHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    // after insert a new record
    if(Trigger.isAfter && Trigger.isInsert) {
        IMTLeasingHelper.onAfterInsert(Trigger.new);
    }
    // after update the existing record
    if(Trigger.isAfter && Trigger.isUpdate) {
        IMTLeasingHelper.onAfterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
    }    
     
}