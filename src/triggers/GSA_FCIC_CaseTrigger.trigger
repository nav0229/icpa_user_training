trigger GSA_FCIC_CaseTrigger on Case (before insert, before update, after insert, after update) {

    TriggerControls__c caseTriggers = TriggerControls__c.getValues('Case');
    boolean caseTriggersAreOn = caseTriggers.On__c;

    if(caseTriggersAreOn){
        if(trigger.isBefore && trigger.isInsert){
            GSA_FCIC_TriggerHelper_Case.beforeInsert(trigger.new);
        }
        if(trigger.isBefore && trigger.isUpdate){
            GSA_FCIC_TriggerHelper_Case.beforeUpdate(trigger.newMap, trigger.oldMap);
        }
        if(trigger.isAfter && trigger.isInsert){
            GSA_FCIC_TriggerHelper_Case.afterInsert(trigger.newMap);
        }
        if(trigger.isAfter && trigger.isUpdate){
            GSA_FCIC_TriggerHelper_Case.afterUpdate(trigger.newMap, trigger.oldMap);
        }
    }

}