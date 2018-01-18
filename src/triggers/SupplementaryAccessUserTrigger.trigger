trigger SupplementaryAccessUserTrigger on Supplementary_Access_User__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

	if (Trigger.isBefore) {

	}
	else if (Trigger.isAfter) {

		if(Trigger.isInsert || Trigger.isUndelete){
			
			ShareDocumentToApproversHelper.manageControlledDocumentSharing(Trigger.new);

		}
		else if(Trigger.isUpdate){

			ShareDocumentToApproversHelper.manageControlledDocumentSharing(Trigger.old, Trigger.new);

		}
		else if(Trigger.isDelete){ //isDelete

			ShareDocumentToApproversHelper.manageControlledDocumentSharing(Trigger.old);
	
		}

	}

}