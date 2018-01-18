trigger VMO_TaskOrderTrigger on Task_Order__c (after insert, after update, after delete) {

  if (VMO_AccountTriggerHelper.runOnce() && trigger.isAfter) {
    if (trigger.isInsert) {
      VMO_TaskOrderTriggerHelper.onUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap, 'insert');
    }else if (trigger.isUpdate) { 
            VMO_TaskOrderTriggerHelper.onUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap, 'update');
    }else if (trigger.isDelete) {
      VMO_TaskOrderTriggerHelper.onUpdate(Trigger.old, Trigger.oldMap, Trigger.newMap, 'delete');  
    }
  }
}