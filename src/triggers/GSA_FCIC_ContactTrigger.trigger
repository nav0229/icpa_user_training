trigger GSA_FCIC_ContactTrigger on Contact (before insert, before update, after insert, after update) {

	TriggerControls__c contactTriggers = TriggerControls__c.getValues('Contact');
    boolean contactTriggersAreOn = contactTriggers.On__c;

    if(contactTriggersAreOn){
        if(trigger.isBefore && trigger.isInsert){
            GSA_FCIC_TriggerHelper_Contact.beforeInsert(trigger.new);
        }
        if(trigger.isBefore && trigger.isUpdate){
            GSA_FCIC_TriggerHelper_Contact.beforeUpdate(trigger.new, trigger.old);
        }
        if(trigger.isAfter && trigger.isInsert){
        	GSA_FCIC_TriggerHelper_Contact.afterInsert();
        }
        if(trigger.isAfter && trigger.isUpdate){
        	GSA_FCIC_TriggerHelper_Contact.afterUpdate();
        }
    }

}