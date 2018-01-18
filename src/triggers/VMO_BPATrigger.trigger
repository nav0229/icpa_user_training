trigger VMO_BPATrigger on BPA__c (after insert, after update, after delete) {
  system.debug('Entered into lloop');
  if (VMO_AccountTriggerHelper.runOnce() && trigger.isAfter) {
    if (trigger.isInsert) {
      VMO_BPATriggerHelper.afterInsert(Trigger.new, Trigger.oldMap, Trigger.newMap, 'insert');
    }else if (trigger.isupdate) {
      VMO_BPATriggerHelper.afterInsert(Trigger.new, Trigger.oldMap, Trigger.newMap, 'update');   
    }else if (trigger.isDelete) {
      VMO_BPATriggerHelper.afterDelete(Trigger.old, Trigger.oldMap, Trigger.newMap);   
    }  
    }else if (trigger.isAfter && trigger.isupdate) {
    VMO_BPATriggerHelper.afterInsert(Trigger.new, Trigger.oldMap, Trigger.newMap, 'update');   
  }    
}