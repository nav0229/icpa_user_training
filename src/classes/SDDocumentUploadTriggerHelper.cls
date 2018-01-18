public without sharing class SDDocumentUploadTriggerHelper {

	public static boolean ALREADY_RAN = false;

	public static void shareDocumentsWithAppropriateLegalTeam(List<SD_Document_Upload__c> sdDocumentUploadList){

		List<SD_Document_Upload__share> sharesToInsert = new List<SD_Document_Upload__share>();

		String agencyProtestLegalUsersPubGroupId = [
				SELECT Id
				FROM Group
				WHERE
						DeveloperName = :SDProjectConstants.PUBGROUP_AGENCY_PROTEST_LEGAL_USERS
		].Id;

		String suspAndDebarLegalUserPubGroupId = [
				SELECT Id
				FROM Group
				WHERE
						DeveloperName = :SDProjectConstants.PUBGROUP_SUSPENSION_AND_DEBARMENT_LEGAL_USERS
		].Id;


		for(SD_Document_Upload__c sdDoc : sdDocumentUploadList){

			if(sdDoc.RecordTypeId == SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_AP){

				sharesToInsert.add(makeNewShare(
						agencyProtestLegalUsersPubGroupId,
						sdDoc.Id
				));

			} else if (sdDoc.RecordTypeId == SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD){

				sharesToInsert.add(makeNewShare(
						suspAndDebarLegalUserPubGroupId,
						sdDoc.Id
				));

			} else {

				sdDoc.addError('Unable to share the Document because it hasn\'t been given a record type.');

			}
		}

		insert sharesToInsert;
	}

	public static void promptErrorIfNotFromVisualForcePage(List<SD_Document_Upload__c> sdDocumentUploadList, string errorMsg){
		if(!SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST){
			for(SD_Document_Upload__c sdDoc : sdDocumentUploadList){
				sdDoc.addError(errorMsg);
			}
		}
	}

	public static void reorderRelevantDocumentRecords(List<SD_Document_Upload__c> newSDDocumentsList){

		Set<Id> relatedAgencyProtestCases = new Set<Id>();
		Set<Id> relatedSuspesionDebarmentCases = new Set<Id>();
		Map<Id, List<SD_Document_Upload__c>> caseToDocumentListMap = new Map<Id, List<SD_Document_Upload__c>>();

		for(SD_Document_Upload__c newDoc : newSDDocumentsList){

			if(newDoc.Agency_Protest_Case__c != null){
				relatedAgencyProtestCases.add(newDoc.Agency_Protest_Case__c);
			} else if (newDoc.Suspension_and_Debarment_Record__c != null){
				relatedSuspesionDebarmentCases.add(newDoc.Suspension_and_Debarment_Record__c);
			}

		}

		List<SD_Document_Upload__c> relevantDocumentUploads = [
				SELECT Id, Order__c, Agency_Protest_Case__c, Suspension_and_Debarment_Record__c
				FROM SD_Document_Upload__c
				WHERE 	Agency_Protest_Case__c IN :relatedAgencyProtestCases
					OR 	Suspension_and_Debarment_Record__c IN :relatedSuspesionDebarmentCases
				ORDER BY Order__c ASC NULLS LAST // hugely important - maintains order that we depend on when we assign a new order #
		];

		for(SD_Document_Upload__c doc : relevantDocumentUploads){

			if(doc.Agency_Protest_Case__c != null){
				addDocumentsToMap(doc, doc.Agency_Protest_Case__c, caseToDocumentListMap);
			} else {
				addDocumentsToMap(doc, doc.Suspension_and_Debarment_Record__c, caseToDocumentListMap);
			}

		}

		List<SD_Document_Upload__c> docsToUpdate = reorderDocuments(caseToDocumentListMap);

		ALREADY_RAN = true;

		update docsToUpdate;
	}

	private static void addDocumentsToMap(SD_Document_Upload__c doc, Id caseId, Map<Id, List<SD_Document_Upload__c>> caseToDocumentListMap){
		if(caseToDocumentListMap.get(caseId) == null){
			caseToDocumentListMap.put(caseId, new List<SD_Document_Upload__c>());
			caseToDocumentListMap.get(caseId).add(doc);
		} else {
			caseToDocumentListMap.get(caseId).add(doc);
		}
	}

	private static List<SD_Document_Upload__c> reorderDocuments(Map<Id, List<SD_Document_Upload__c>> caseToDocumentListMap){

		List<SD_Document_Upload__c> docsToUpdate = new List<SD_Document_Upload__c>();

		for(Id caseId : caseToDocumentListMap.keySet()){
			List<SD_Document_Upload__c> docList = caseToDocumentListMap.get(caseId);
			renumberTheOrder(docList);
			docsToUpdate.addAll(docList);
		}

		return docsToUpdate;
	}

	private static void renumberTheOrder(List<SD_Document_Upload__c> sortedList){
		for(Integer i = 0; i < sortedList.size(); i++){
			sortedList.get(i).Order__c = i+1;
		}
	}

	private static SD_Document_Upload__share makeNewShare(String groupToShareTo, String docId){
		SD_Document_Upload__share newShare = new SD_Document_Upload__share();
		newShare.UserOrGroupId = groupToShareTo;
		newShare.ParentId = docId;
		newShare.RowCause = 'Manual';
		newShare.AccessLevel = 'Read';
		return newShare;
	}
}