trigger GSA_FCIC_TaskTrigger on Task (before insert, before update, after insert, after update) {

		TriggerControls__c taskTriggers = TriggerControls__c.getValues('Task');
		boolean taskTriggersAreOn = taskTriggers.On__c;
		
		if(taskTriggersAreOn){

			if(trigger.isBefore && trigger.isInsert){
				GSA_FCIC_TriggerHelper_Task.storeTemplateInformation(trigger.new);
			}
		
			if(trigger.isAfter && trigger.isInsert){
				GSA_FCIC_TriggerHelper_Task.afterInsert(trigger.new);
			}
		}

}