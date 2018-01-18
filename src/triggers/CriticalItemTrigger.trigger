/*-------------------------------------------------------------------------------
  CriticalItemTrigger
  Critical Item trigger on Critical_Issues__c object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               03/25/2014   1.0       Creation
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */

trigger CriticalItemTrigger on Critical_Issues__c (before insert, before update, after insert, after update) {
    // Before Insert validation
    if(Trigger.isInsert && Trigger.isBefore) {
        CriticalItemHelper.onBeforeInsert(Trigger.new);
    }
    
    // Before Update validation
    if(Trigger.isUpdate && Trigger.isBefore) {
        CriticalItemHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    
    // After Insert method for apex record sharing
    if(Trigger.isInsert && Trigger.isAfter) {
        CriticalItemHelper.onAfterInsert(Trigger.new);
    }
    
    // After Update method for apex record sharing
    if(Trigger.isUpdate && Trigger.isAfter) {
        CriticalItemHelper.onAfterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
    }
}