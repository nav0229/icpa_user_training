/*--------------------------------------------------------------------------------------------------------------------
  OCMTrigger
  Apex trigger on Comms_Marketing_Service__c custom object (OCM request tracker)
  --------------------------------------------------------------------------------------------------------------------
   Author                |Date       |Version  |Description
  --------------------------------------------------------------------------------------------------------------------
   Rajakumar              07/15/2014  1.0       Created - Link the Project record with OCM record and vice versa.
  
  --------------------------------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------
*/
trigger OCMTrigger on Comms_Marketing_Service__c (before update, after insert, after update) {
    // After insert operation
    if(Trigger.isAfter && Trigger.isInsert) {
        OCMHelper.onAfterInsert(Trigger.new);
    }
    // After update operation
    if(Trigger.isAfter && Trigger.isUpdate) {
        if(!OCMRecursionCheck.hasAlreadyUpdated()) {
            OCMHelper.onAfterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
        }   
    }
    // before update
    if(Trigger.isBefore && Trigger.isUpdate) {
        OCMHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
        OCMHelper.onBeforeUpdatecommstatus(Trigger.new,Trigger.oldMap);
        } 
    
}