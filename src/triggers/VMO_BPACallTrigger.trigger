/*
trigger VMO_BPACallTrigger on BPA_Call__c (after delete, after insert, after update) {
  if (VMO_AccountTriggerHelper.runOnce() && trigger.isAfter) {
    if (trigger.isInsert) {
      VMO_BPACallTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap, 'insert');
    }else if (trigger.isUpdate) { 
            VMO_BPACallTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap, 'update');
    }else if (trigger.isDelete) {
      VMO_BPACallTriggerHelper.afterUpdate(Trigger.old, Trigger.oldMap, Trigger.newMap, 'delete');  
    }
  }
}
*/
trigger VMO_BPACallTrigger on BPA_Call__c (after delete, after insert, after update) {
  if (VMO_AccountTriggerHelper.runOnce() && trigger.isAfter) {
    if (trigger.isInsert || trigger.isUpdate) {
      VMO_BPACallTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
    }else if (trigger.isDelete) {
      VMO_BPACallTriggerHelper.afterUpdate(Trigger.old, Trigger.oldMap, Trigger.newMap);  
    }
  }
}