trigger VMO_ContractTrigger on Contract__c (after delete, after insert, after update) { 

    if (Trigger.isAfter && VMO_AccountTriggerHelper.runOnce()) {
        if (Trigger.isInsert) {
            VMO_ContractTriggerHelper.onUpdate (Trigger.new, Trigger.oldMap, Trigger.newMap, 'insert');
        }else if (Trigger.isUpdate) {   
            VMO_ContractTriggerHelper.onUpdate (Trigger.new, Trigger.oldMap, Trigger.newMap, 'update');
        }else if (Trigger.isDelete) {
            VMO_ContractTriggerHelper.onUpdate (Trigger.old, Trigger.oldMap, Trigger.newMap, 'delete');
        }
    }  
}