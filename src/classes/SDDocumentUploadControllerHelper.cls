// class soley exists to execute code in a 'without sharing' context
public without sharing class SDDocumentUploadControllerHelper {

	public static void insertDocuments(List<SD_Document_Upload__c> docsToInsert){
		insert docsToInsert;
	}

	public static void insertAttachments(List<Attachment> attachmentsToInsert){
		insert attachmentsToInsert;
	}

	public static void updateDocuments(List<SD_Document_Upload__c> docsToUpdate){
		update docsToUpdate;
	}

	public static void updateAttachments(List<Attachment> attachmentsToUpdate){
		update attachmentsToUpdate;
	}

	public static void deleteDocument(List<SD_Document_Upload__c> sdDocsToDelete){
		delete sdDocsToDelete;
	}

	public static List<SD_Document_Upload__c> getExistingDocumentsList(Id caseId) {
		return new List<SD_Document_Upload__c>([
				SELECT Id,
						CreatedById,
						CreatedDate,
						LastModifiedById,
						OwnerId,
						Owner.Name,
						RecordTypeId,
						Name,
						Agency_Protest_Case__c,
						Description__c,
						Order__c,
						Suspension_and_Debarment_Record__c
				FROM SD_Document_Upload__c
				WHERE
							Suspension_and_Debarment_Record__c = :caseId
					OR 		Agency_Protest_Case__c = :caseId
				ORDER BY 	Order__c ASC NULLS LAST
		]);
	}

	public static Map<Id, Attachment> getExistingAttachmentsMap(List<SD_Document_Upload__c> existingDocsList) {
		Set<Id> parents = new Set<Id>();
		for(SD_Document_Upload__c sdDoc : existingDocsList){
			parents.add(sdDoc.Id);
		}
		return new Map<Id, Attachment>([
				SELECT Id,
						ParentId,
						Name
				FROM Attachment
				WHERE
						ParentId IN :parents
		]);
	}

	public static SObject getPageSObject(String objectAPIName, Id caseId) {
		SObject pageObj;
		if(objectAPIName == SDProjectConstants.OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD) {
			pageObj = [
					SELECT Id, Case_Closed__c, OwnerId
					FROM Suspension_and_Debarment_Case__c
					WHERE Id = :caseId
			];
		} else if(objectAPIName == SDProjectConstants.OBJECTAPINAME_AGENCY_PROTEST_CASE) {
			pageObj = [
					SELECT Id, Case_Closed__c, OwnerId
					FROM Agency_Protest_Case__c
					WHERE Id = :caseId
			];
		}
		return pageObj;
	}

	public static List<ProcessInstanceWorkItem> getProcessInstanceWorkItems(String caseId) {
		return [
				SELECT Id, ActorId, ProcessInstance.TargetObjectId, ProcessInstanceId
				FROM ProcessInstanceWorkItem
					WHERE
						(ProcessInstance.Status = 'Pending'
					OR 	ProcessInstance.Status = 'Started')
					AND	ProcessInstance.TargetObjectId = :caseId
		];
	}

	public static Map<Id, PermissionSet> getPermissionSetIDToPermissionSetObjectMap() {
		return new Map<Id, PermissionSet>([
				SELECT Id, Name
				FROM PermissionSet
				WHERE
					Name = :SDProjectConstants.PSET_LEGAL_USER_AGENCY_PROTEST
				OR 	Name = :SDProjectConstants.PSET_LEGAL_USER_SUSPENSION_DEBARMENT
				OR 	Name = :SDProjectConstants.PSET_INTEGRITY_OFFICER
				OR 	Name = :SDProjectConstants.PSET_SUPER_USER
		]);
	}

	public static List<String> getPermissionSetAssignmentList(Map<Id, PermissionSet> permSetMap) {
		List<PermissionSetAssignment> psetAssignmentList = [
				SELECT Id,
						AssigneeId,
						PermissionSetId
				FROM PermissionSetAssignment
				WHERE
				PermissionSetId IN :permSetMap.keySet()
				AND AssigneeId = :UserInfo.getUserId()
		];
		List<String> assignmentsToReturn = new List<String>();
		for(PermissionSetAssignment assignment : psetAssignmentList) {
			Id curPermissionSetId = assignment.PermissionSetId;
			PermissionSet curPermissionSet = permSetMap.get(curPermissionSetId);
			String curPermissionSetName = curPermissionSet.Name;
			assignmentsToReturn.add(curPermissionSetName);
		}
		return assignmentsToReturn;
	}

}