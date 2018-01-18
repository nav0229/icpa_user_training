trigger SDAgencyProtestTrigger on Agency_Protest_Case__c(before insert, after insert, before update, after update) {

	if(Trigger.isBefore) {
		SDAgencyProtestTriggerHelper.updateIntegrityOfficerToCurrentLoggedInUserIfBlank(trigger.new);
	}

	if(Trigger.isUpdate) {
		SDAgencyProtestTriggerHelper.deleteAllCorrespondingRecordsOfAPOData(trigger.new);
	}

	if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
		SDAgencyProtestTriggerHelper.insertRecordsIntoAPODataObjectWithDecisionGroundsAndActualDecisionDate(trigger.new);
	}

}