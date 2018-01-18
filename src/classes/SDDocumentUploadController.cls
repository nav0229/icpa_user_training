public with sharing class SDDocumentUploadController {

	public static boolean IS_FROM_VF_PAGE_OR_TEST = false;
	public static boolean SHOWN_ADD_LINE_ITEM_WARNING {get; set;}

	public List<SDDocumentWrapper> allDocs {get;set;}
	public List<SDDocumentWrapper> newDocs {get;set;}
	public boolean renderDeleteFunctionality {get;set;}
	public boolean renderUploadFunctionality {get;set;}
	public boolean renderViewFunctionality {get;set;}

	// page object variables
	private SObject pageSObject;
	private String pageObjAPIName;
	private String pageObjId;
	private Id pageObjApproverId;

	private SD_Document_Upload__c newDocument;
	private List<SD_Document_Upload__c> existingDocsList;
	private Map<Id, Attachment> existingAttachmentsMap;

	// access booleans
	private boolean isRecordClosed = false;
	private boolean isRecordOwner = false;
	private boolean isRecordApprover = false;
	private boolean isAgencyProtestApprovalUser = false;
	private boolean isSuspensionDebarmentApprovalUser = false;
	private boolean isSDOUser = false; // has both AP and SD psets
	private boolean isStaffUserIntegrityOfficer = false;
	private boolean isSuperUser = false;

	public SDDocumentUploadController(ApexPages.StandardController stdController) {
		IS_FROM_VF_PAGE_OR_TEST = true;

		allDocs = new List<SDDocumentWrapper>();
		newDocs = new List<SDDocumentWrapper>();
		newDocument = new SD_Document_Upload__c();

		setPageObjectVariables(stdController); // pageSObject, pageObjAPIName, pageObjId

		setAccessBooleans();

		determineVisibileFunctionalityBasedOnAccessBooleans();

		existingDocsList = SDDocumentUploadControllerHelper.getExistingDocumentsList(pageObjId);

		existingAttachmentsMap = SDDocumentUploadControllerHelper.getExistingAttachmentsMap(existingDocsList);

		addNewDocumentLineItem();

		populateAllDocs();

		SHOWN_ADD_LINE_ITEM_WARNING = false;
	}

	public PageReference saveNewDocumentLineItems(){
		IS_FROM_VF_PAGE_OR_TEST = true;

		List<SD_Document_Upload__c> sdDocsToInsert = new List<SD_Document_Upload__c>();
		List<Attachment> attachmentsToInsert = new List<Attachment>();

		newDocs = removeBadDocumentLineItemsBeforeInsert(newDocs);

		for(SDDocumentWrapper item : newDocs){
			item.SdDocumentUpload = populateRecordTypeAndParentIdOnNewDocument(item.SdDocumentUpload);
			sdDocsToInsert.add(item.SdDocumentUpload);
		}

		SDDocumentUploadControllerHelper.insertDocuments(sdDocsToInsert);

		for(SDDocumentWrapper item : newDocs){
			attachmentsToInsert.add(
					makeNewAttachment(
							item.Attachment.Name,
							item.SdDocumentUpload.Id,
							item.Attachment.Body
					)
			);
		}

		SDDocumentUploadControllerHelper.insertAttachments(attachmentsToInsert);

		return returnRefreshedPageAfterChangesAreMade();
	}

	public void addNewDocumentLineItem(){

		SHOWN_ADD_LINE_ITEM_WARNING = true;

		for(SDDocumentWrapper item : newDocs){
			item.Attachment.Body = null;
		}

		Attachment a = new Attachment();
		SD_Document_Upload__c sdDoc = new SD_Document_Upload__c();
		SDDocumentWrapper newDoc = new SDDocumentWrapper(sdDoc, a);
		newDocs.add(newDoc);

	}

	public PageReference deleteDocumentLineItem() {
		IS_FROM_VF_PAGE_OR_TEST = true;
		String docIdForDeletion = ApexPages.currentPage().getParameters().get('docIdForDeletion');
		if(userCanDeleteSpecificDocument(docIdForDeletion)) {
			try {
				List<SD_Document_Upload__c> sdDocsToDelete = new List<SD_Document_Upload__c>();
				sdDocsToDelete.add(new SD_Document_Upload__c(Id = docIdForDeletion));
				SDDocumentUploadControllerHelper.deleteDocument(sdDocsToDelete);
				return returnRefreshedPageAfterChangesAreMade();
			} catch (ListException e){
				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, SDProjectConstants.ERROR_MSG_VFORCE_DOCUMENT_NOT_SELECTED));
				return null;
			}
		} else {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, SDProjectConstants.ERROR_MSG_VFORCE_NOT_ALLOWED_TO_DELETE_THIS_DOCUMENT));
			return null;
		}
	}

	public PageReference saveChanges(){

		if(isRecordClosed){
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, SDProjectConstants.ERROR_MSG_VFORCE_UNABLE_TO_EDIT_DOCUMENTS_WHEN_RECORD_IS_CLOSED));
			return null;
		}

		IS_FROM_VF_PAGE_OR_TEST = true; // not needed for an update yet but just in case we do in the future
		List<SD_Document_Upload__c> sdDocsToUpdate = new List<SD_Document_Upload__c>();
		List<Attachment> attachmentsToUpdate = new List<Attachment>();
		for(SDDocumentWrapper item : allDocs){
			sdDocsToUpdate.add(item.SdDocumentUpload);
			attachmentsToUpdate.add(item.Attachment);
		}

		SDDocumentUploadControllerHelper.updateDocuments(sdDocsToUpdate);
		SDDocumentUploadControllerHelper.updateAttachments(attachmentsToUpdate);

		return returnRefreshedPageAfterChangesAreMade();
	}

	public PageReference cancelChanges(){
		return returnRefreshedPageAfterChangesAreMade();
	}

	private List<SDDocumentWrapper> removeBadDocumentLineItemsBeforeInsert(List<SDDocumentWrapper> items){
		List<SDDocumentWrapper> goodItems = new List<SDDocumentWrapper>();

		for(SDDocumentWrapper item : items){

			if(item.Attachment.Body != null){

				goodItems.add(item);

			}

		}

		return goodItems;
	}

	private SD_Document_Upload__c populateRecordTypeAndParentIdOnNewDocument(SD_Document_Upload__c sdDoc){

		if(pageObjAPIName == SDProjectConstants.OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD) {

			sdDoc.Suspension_and_Debarment_Record__c = pageObjId;
			sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;

		} else if(pageObjAPIName == SDProjectConstants.OBJECTAPINAME_AGENCY_PROTEST_CASE) {

			sdDoc.Agency_Protest_Case__c = pageObjId;
			sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_AP;

		}

		return sdDoc;
	}

	private Attachment makeNewAttachment(String name, String documentId, Blob bodyBlob) {
		Attachment newAttachment = new Attachment();
		newAttachment.Name = prependRandomStringToName(name);
		newAttachment.Name = removeAllCharactersThatAreNotAlphanumeric(newAttachment.Name);
		newAttachment.ParentId = documentId;
		newAttachment.Body = bodyBlob;
		return newAttachment;
	}

	private PageReference returnRefreshedPageAfterChangesAreMade() {
		PageReference ref;

		if(pageObjAPIName == SDProjectConstants.OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD) {

			ref = new PageReference(SDProjectConstants.SUSPENSION_AND_DEBARMENT_CASE_VF_PAGE + pageObjId);

		} else if(pageObjAPIName == SDProjectConstants.OBJECTAPINAME_AGENCY_PROTEST_CASE) {

			ref = new PageReference(SDProjectConstants.AGENCY_PROTEST_VF_PAGE + pageObjId);

		}
		ref.setRedirect(true);
		return ref;
	}

	private void setPageObjectVariables(ApexPages.StandardController stdController) {
		String suspAndDebarPrefix = Suspension_and_Debarment_Case__c.getSObjectType().getDescribe().getKeyPrefix();
		String agencyProtestPrefix = Agency_Protest_Case__c.getSObjectType().getDescribe().getKeyPrefix();
		SObject rec = stdController.getRecord();
		String pageObjPrefix = ((String) (rec.Id)).mid(0, 3);

		if(suspAndDebarPrefix == pageObjPrefix) {
			pageObjAPIName = SDProjectConstants.OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD;
		} else if(agencyProtestPrefix == pageObjPrefix) {
			pageObjAPIName = SDProjectConstants.OBJECTAPINAME_AGENCY_PROTEST_CASE;
		}

		pageObjId = rec.Id;

		pageSObject = SDDocumentUploadControllerHelper.getPageSObject(pageObjAPIName, pageObjId);
	}

	private void populateAllDocs() {
		if(existingDocsList==null) {
			return;
		}
		for(Integer i = 0; i < existingDocsList.size(); i++){ // want to maintain the ORDER BY query... i.e. I don't trust for each loops
			SD_Document_Upload__c sdDoc = existingDocsList.get(i);
			for(Attachment a : existingAttachmentsMap.values()){
				if(a.ParentId == sdDoc.Id){
					allDocs.add(new SDDocumentWrapper(sdDoc, a));
				}
			}
		}
	}

	private String prependRandomStringToName(String s) {
		Integer i1 = (Math.random() * 26).intValue();
		Integer i2 = (Math.random() * 26).intValue();
		Integer i3 = (Math.random() * 26).intValue();
		String c1 = SDProjectConstants.ALPHABET.substring(i1, i1 + 1);
		String c2 = SDProjectConstants.ALPHABET.substring(i2, i2 + 1);
		String c3 = SDProjectConstants.ALPHABET.substring(i3, i3 + 1);
		return c1 + c2 + c3 + s;
	}

	private String removeAllCharactersThatAreNotAlphanumeric(String s) {
		Pattern pat = Pattern.compile('[a-zA-Z0-9.]');
		Matcher match = pat.matcher(s);
		String newString = '';
		while(match.find() == true) {
			newString += match.group();
		}
		return newString;
	}

	private void setAccessBooleans() {
		Map<Id, PermissionSet> psetIdToPsetObjectMap = SDDocumentUploadControllerHelper.getPermissionSetIDToPermissionSetObjectMap();
		List<String> assignedPermissionSetNamesList = SDDocumentUploadControllerHelper.getPermissionSetAssignmentList(psetIdToPsetObjectMap);

		isRecordClosed = isRecordClosed();

		isRecordOwner = isRecordOwner();

		isRecordApprover = isCurrentRecordApprover();

		for(String assignedPsetName : assignedPermissionSetNamesList) {
			if(assignedPsetName == SDProjectConstants.PSET_LEGAL_USER_AGENCY_PROTEST) {
				isAgencyProtestApprovalUser = true;
			} else if(assignedPsetName == SDProjectConstants.PSET_LEGAL_USER_SUSPENSION_DEBARMENT) {
				isSuspensionDebarmentApprovalUser = true;
			} else if(assignedPsetName == SDProjectConstants.PSET_INTEGRITY_OFFICER) {
				isStaffUserIntegrityOfficer = true;
			} else if(assignedPsetName == SDProjectConstants.PSET_SUPER_USER) {
				isSuperUser = true;
			}
		}

		if(isAgencyProtestApprovalUser && isSuspensionDebarmentApprovalUser) {
			isSDOUser = true;
		}
	}

	private void determineVisibileFunctionalityBasedOnAccessBooleans() {
		determineIfUserCanView();
		determineIfUserCanSeeUpload();
		determineIfUserCanSeeDelete();
	}

	private void determineIfUserCanView() {
		renderViewFunctionality = true;
	}

	private void determineIfUserCanSeeUpload() {
		if(isRecordClosed) {
			renderUploadFunctionality = false;
		} else if(isStaffUserIntegrityOfficer || isSuperUser || isRecordApprover){
			renderUploadFunctionality = true;
		} else {
			renderUploadFunctionality = false;
		}
	}

	private void determineIfUserCanSeeDelete() {
		if(isRecordClosed) {
			renderDeleteFunctionality = false;
		} else {
			renderDeleteFunctionality = true;
		}
	}

	private boolean userCanDeleteSpecificDocument(String docId) {
		if(isRecordClosed) {
			return false;
		} else if(isUploader(docId) && isRecordApprover && (isAgencyProtestApprovalUser || isSuspensionDebarmentApprovalUser || isSDOUser)) {
			return true;
		} else if(isUploader(docId) && isStaffUserIntegrityOfficer){
			return true;
		} else if(isRecordOwner && isStaffUserIntegrityOfficer) {
			return true;
		} else if(isSuperUser){
			return true;
		} else {
			return false;
		}
	}

	private boolean isRecordClosed() {
		return (pageSObject.get('Case_Closed__c') == 'Yes') ? true : false;
	}

	private boolean isRecordOwner() {
		return (UserInfo.getUserId() == pageSObject.get('OwnerId')) ? true : false;
	}

	private boolean isCurrentRecordApprover() {
		List<ProcessInstanceWorkItem> processInstanceWorkItems = SDDocumentUploadControllerHelper.getProcessInstanceWorkItems(pageObjId);
		for(ProcessInstanceWorkitem item : processInstanceWorkItems) {
			pageObjApproverId = item.ActorId;
			if(UserInfo.getUserId() == item.ActorId) {
				return true;
			}
		}
		return false;
	}

	private boolean isUploader(String docId) {
		SD_Document_Upload__c doc = new SD_Document_Upload__c();
		for(SD_Document_Upload__c sdDoc : existingDocsList){
			if(sdDoc.Id == docId){
				doc = sdDoc;
			}
		}
		return (doc.OwnerId == UserInfo.getUserId()) ? true : false;
	}
}