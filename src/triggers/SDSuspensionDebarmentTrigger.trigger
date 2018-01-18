trigger SDSuspensionDebarmentTrigger on Suspension_and_Debarment_Case__c (after insert, after update, before insert, before update) {

	if(trigger.isBefore){
		SDSuspensionDebarmentTriggerHelper.updateIntegrityOfficerOnSuspensionAndDebarmentCaseRecords(trigger.new);
	}

	if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
		SDSuspensionDebarmentTriggerHelper.makeFieldsRequiredWhenLeadAgencyIsGSA(trigger.new);
		SDSuspensionDebarmentTriggerHelper.add45BusinessDaysToCompletionDate(trigger.isUpdate, trigger.oldMap, trigger.new);
	}

	if(trigger.isBefore && trigger.isUpdate){
		SDSuspensionDebarmentTriggerHelper.verifyUserAllowedToChangeOwner(trigger.oldMap, trigger.new);
		SDSuspensionDebarmentTriggerHelper.deleteAllCorrespondingSandDDataRecordsExceptLeadAgencyTransfers(trigger.new);
	}

	if(Trigger.isAfter && Trigger.isInsert){
		SDSuspensionDebarmentTriggerHelper.updateDestructionDateAndInsertIntoSandDDataObject(trigger.new);
	}

	if(Trigger.isAfter && Trigger.isUpdate) {
		//SDSuspensionDebarmentTriggerHelper.deleteAllCorrespondingSandDDataRecordsExceptLeadAgencyTransfers(trigger.new);
		SDSuspensionDebarmentTriggerHelper.updateDestructionDateAndInsertIntoSandDDataObject(trigger.new);
	}
}