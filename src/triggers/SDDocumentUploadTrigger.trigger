trigger SDDocumentUploadTrigger on SD_Document_Upload__c (before insert, before update, before delete, after insert, after update, after delete) {

	if(trigger.isBefore && trigger.isInsert && !SDDocumentUploadTriggerHelper.ALREADY_RAN) {
		SDDocumentUploadTriggerHelper.promptErrorIfNotFromVisualForcePage(trigger.new, SDProjectConstants.ERROR_MSG_TRIGGER_CAN_NOT_INSERT_UNLESS_IN_VFORCEPAGE);
	}

	if(trigger.isBefore && trigger.isDelete && !SDDocumentUploadTriggerHelper.ALREADY_RAN) {
		SDDocumentUploadTriggerHelper.promptErrorIfNotFromVisualForcePage(trigger.old, SDProjectConstants.ERROR_MSG_TRIGGER_CAN_NOT_DELETE_UNLESS_IN_VFORCEPAGE);
	}

	if(trigger.isAfter && trigger.isUpdate && !SDDocumentUploadTriggerHelper.ALREADY_RAN){
		SDDocumentUploadTriggerHelper.reorderRelevantDocumentRecords(trigger.new);
	}

	if(trigger.isAfter && trigger.isInsert && !SDDocumentUploadTriggerHelper.ALREADY_RAN){
		SDDocumentUploadTriggerHelper.shareDocumentsWithAppropriateLegalTeam(trigger.new);
		SDDocumentUploadTriggerHelper.reorderRelevantDocumentRecords(trigger.new);
	}

}