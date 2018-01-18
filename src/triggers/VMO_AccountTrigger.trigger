trigger VMO_AccountTrigger on Account (before insert, before update) {
    
    if (VMO_AccountTriggerHelper.runOnce() && Trigger.isBefore) {
        if(Trigger.isUpdate){
            VMO_AccountTriggerHelper.beforeUpdate (Trigger.new, Trigger.oldMap, Trigger.newMap);
        }else if(Trigger.isInsert){
            VMO_AccountTriggerHelper.beforeInsert (Trigger.new, Trigger.oldMap, Trigger.newMap);
        }
    }
}