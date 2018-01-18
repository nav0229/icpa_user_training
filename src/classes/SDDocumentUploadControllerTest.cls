@isTest
public with sharing class SDDocumentUploadControllerTest {

	@isTest
	public static void testControllerConstructor_SuspensionDebarRecordPassed_NoErrors(){
		Suspension_and_Debarment_Case__c sdCase = [SELECT Id FROM Suspension_and_Debarment_Case__c LIMIT 1];

		ApexPages.StandardController stdController = new ApexPages.StandardController(sdCase);

		SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

		System.assertNotEquals(uploadController, null, 'Document Upload page controller failed while passing in a Suspension Debarment case.');
	}


	@isTest
	public static void testControllerConstructor_AgencyProtestRecordPassed_NoErrors(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c LIMIT 1];

		ApexPages.StandardController stdController = new ApexPages.StandardController(apCase);

		SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

		System.assertNotEquals(uploadController, null, 'Document Upload page controller failed while passing in an Agency Protest case.');
	}

	@isTest
	public static void testSaveNewDocumentLineItems_NewDocsMemberVariableIsPopulatedWithSuspAndDebarDocs_AttachmentsAndDocumentUploadsCreated(){
		Suspension_and_Debarment_Case__c sdCase = [SELECT Id FROM Suspension_and_Debarment_Case__c LIMIT 1];

		ApexPages.StandardController stdController = new ApexPages.StandardController(sdCase);

		SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

		uploadController.newDocs.add(simulateAddingNewSuspensionDebarmentSDDocumentLineItemViaVisualForcePage(sdCase.Id));

		uploadController.saveNewDocumentLineItems();

		List<SD_Document_Upload__c> sdDocList = [SELECT Id FROM SD_Document_Upload__c WHERE CreatedDate = TODAY];
		List<Attachment> attachList = [SELECT Id FROM Attachment WHERE CreatedDate = TODAY];

		// 3 should be created because 2 are created in the setup method
		System.assertEquals(3, sdDocList.size(), 'Document Upload record was not inserted. Check the controller\'s save action.');
		System.assertEquals(3, attachList.size(), 'Attachments were not inserted. Check the controller\'s save action.');
	}

	@isTest
	public static void testSaveNewDocumentLineItems_NewDocsMemberVariableIsPopulatedWithAgencyProtestDocs_AttachmentsAndDocumentUploadsCreated(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c LIMIT 1];

		ApexPages.StandardController stdController = new ApexPages.StandardController(apCase);

		SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

		uploadController.newDocs.add(simulateAddingNewAgencyProtestSDDocumentLineItemViaVisualForcePage(apCase.Id));

		uploadController.saveNewDocumentLineItems();

		List<SD_Document_Upload__c> sdDocList = [SELECT Id FROM SD_Document_Upload__c WHERE CreatedDate = TODAY];
		List<Attachment> attachList = [SELECT Id FROM Attachment WHERE CreatedDate = TODAY];

		// 3 should be created because 2 are created in the setup method
		System.assertEquals(3, sdDocList.size(), 'Document Upload record was not inserted. Check the controller\'s save action.');
		System.assertEquals(3, attachList.size(), 'Attachments were not inserted. Check the controller\'s save action.');
	}

	@isTest
	public static void testDeleteDocumentLineItem_SuspDebarRecordNotClosed_DeleteOccursSuccessfully(){

		Profile gsaAdmin = [
				SELECT Id
				FROM Profile
				WHERE Name = :SDProjectConstants.GSA_ADMIN_PROFILE_NAME
		];

		User otherAdmin = [
				SELECT Id
				FROM User
				WHERE
						IsActive = true
					AND ProfileId = :gsaAdmin.Id
					AND Id != :UserInfo.getUserId()
				LIMIT 1
		];

		System.runAs(otherAdmin){
			Suspension_and_Debarment_Case__c sdCase = [SELECT Id FROM Suspension_and_Debarment_Case__c LIMIT 1];

			SD_Document_Upload__c sdDoc = [SELECT Id FROM SD_Document_Upload__c WHERE Suspension_and_Debarment_Record__c = :sdCase.Id];

			ApexPages.StandardController stdController = new ApexPages.StandardController(sdCase);

			SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

			//uploadController.saveNewDocumentLineItems();

			ApexPages.currentPage().getParameters().put('docIdForDeletion', sdDoc.Id);
			uploadController.deleteDocumentLineItem();
		}

		List<SD_Document_Upload__c> sdDocList = [SELECT Id FROM SD_Document_Upload__c WHERE CreatedDate = TODAY];
		List<Attachment> attachList = [SELECT Id FROM Attachment WHERE CreatedDate = TODAY];

		// 2 are created in test data. 1 is deleted in this test method
		System.assertEquals(1, sdDocList.size(), 'Document Upload record was not deleted.');
		System.assertEquals(1, attachList.size(), 'Attachments were not deleted.');
	}

	@isTest
	public static void testPageActions_DeleteADocumentWhenCaseIsClosed_DeleteNotSuccessful(){
		Suspension_and_Debarment_Case__c sdCase = [SELECT Id FROM Suspension_and_Debarment_Case__c LIMIT 1];

		sdCase.Case_Closed__c = 'Yes';
		update sdCase;

		SD_Document_Upload__c sdDoc = [SELECT Id FROM SD_Document_Upload__c WHERE Suspension_and_Debarment_Record__c = :sdCase.Id];

		ApexPages.StandardController stdController = new ApexPages.StandardController(sdCase);

		SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

		ApexPages.currentPage().getParameters().put('docIdForDeletion', sdDoc.Id);
		uploadController.deleteDocumentLineItem();

		List<SD_Document_Upload__c> sdDocList = [SELECT Id FROM SD_Document_Upload__c WHERE CreatedDate = TODAY];
		List<Attachment> attachList = [SELECT Id FROM Attachment WHERE CreatedDate = TODAY];

		System.assertEquals(2, sdDocList.size(), 'If actual result is 3 then a Document Upload record was somehow inserted. This should not have happened');
		System.assertEquals(2, attachList.size(), 'If actual result is 3 then a Document Upload record was somehow inserted. This should not have happened');
	}

	@isTest
	public static void testPageActions_SaveAndCancelPressed_NoApexErrorMessagesThrown(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c LIMIT 1];

		ApexPages.StandardController stdController = new ApexPages.StandardController(apCase);

		SDDocumentUploadController uploadController = new SDDocumentUploadController(stdController);

		uploadController.newDocs.add(simulateAddingNewAgencyProtestSDDocumentLineItemViaVisualForcePage(apCase.Id));

		uploadController.saveChanges();
		uploadController.cancelChanges();

		System.assert(true);
	}

	private static SDDocumentWrapper simulateAddingNewSuspensionDebarmentSDDocumentLineItemViaVisualForcePage(Id caseId){
		SD_Document_Upload__c sdDoc = new SD_Document_Upload__c();
		sdDoc.Suspension_and_Debarment_Record__c = caseId;
		sdDoc.RecordTypeId = sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;

		Attachment a = new Attachment();
		a.Name = 'Test';
		a.Body = Blob.valueOf('BBBBBBBBBB');

		SDDocumentWrapper item = new SDDocumentWrapper(sdDoc, a);
		return item;
	}

	private static SDDocumentWrapper simulateAddingNewAgencyProtestSDDocumentLineItemViaVisualForcePage(Id caseId){
		SD_Document_Upload__c sdDoc = new SD_Document_Upload__c();
		sdDoc.Agency_Protest_Case__c = caseId;
		sdDoc.RecordTypeId = sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_AP;

		Attachment a = new Attachment();
		a.Name = 'Test';
		a.Body = Blob.valueOf('BBBBBBBBBB');

		SDDocumentWrapper item = new SDDocumentWrapper(sdDoc, a);
		return item;
	}

	@testSetup static void createTestData(){

		Profile gsaAdmin = [
				SELECT Id
				FROM Profile
				WHERE Name = :SDProjectConstants.GSA_ADMIN_PROFILE_NAME
		];
		User otherAdmin = [
				SELECT Id
				FROM User
				WHERE
						IsActive = true
					AND ProfileId = :gsaAdmin.Id
					AND Id != :UserInfo.getUserId()
				LIMIT 1
		];

		System.runAs(otherAdmin){
			PermissionSet pset = new PermissionSet();
			try {
				pset = [
						SELECT Id
						FROM PermissionSet
						WHERE Name = :SDProjectConstants.PSET_SUPER_USER
				];
			} catch(Exception e){
				System.assert(false, 'Error while trying to query the Super User permission set for the SD project. Did the name change? Was it deployed?');
			}

			try {
				insert new PermissionSetAssignment(AssigneeId = UserInfo.getUserId(), PermissionSetId = pset.Id);
			} catch(DmlException e){
				// permission set has already been assigned to the current user
			}
		}

		SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = true;

		Suspension_and_Debarment_Case__c sdCase;
		Agency_Protest_Case__c apCase;
		SD_Document_Upload__c sdDoc;
		SD_Document_Upload__c apDoc;
		Attachment sdAttachment;
		Attachment apAttachment;

		try {
			sdCase = new Suspension_and_Debarment_Case__c();
			insert sdCase;
		} catch (Exception e){
			System.assert(false, 'Problem while creating a Suspension and Debarment case. Were new validation rules added?');
			return;
		}

		try {
			apCase = new Agency_Protest_Case__c();
			insert apCase;
		} catch (Exception e){
			System.assert(false, 'Problem while creating an Agency Protest case. Were new validation rules added?');
			return;
		}

		try {
			sdDoc = new SD_Document_Upload__c();
			sdDoc.Suspension_and_Debarment_Record__c = sdCase.Id;
			sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;
			insert sdDoc;
		} catch (Exception e){
			System.assert(false, 'Problem while creating a Document Upload record and associating it with a Suspension Debarment record.');
			return;
		}

		try {
			apDoc = new SD_Document_Upload__c();
			apDoc.Agency_Protest_Case__c = apCase.Id;
			apDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_AP;
			insert apDoc;
		} catch (Exception e){
			System.assert(false, 'Problem while creating a Document Upload record and associating it with an Agency Protest record.');
			return;
		}

		try {
			sdAttachment = new Attachment();
			sdAttachment.Name = 'sample.txt';
			sdAttachment.Body = Blob.valueOf('AAAAAAAAAAAAAA');
			sdAttachment.ParentId = sdDoc.Id;
			insert sdAttachment;
		} catch (Exception e){
			System.assert(false, 'Problem while create an Attachment and associating it with a Document Upload related to a Suspension and Debarment record.');
			return;
		}

		try {
			apAttachment = new Attachment();
			apAttachment.Name = 'sample.txt';
			apAttachment.Body = Blob.valueOf('AAAAAAAAAAAAAA');
			apAttachment.ParentId = apDoc.Id;
			insert apAttachment;
		} catch (Exception e){
			System.assert(false, 'Problem while create an Attachment and associating it with a Document Upload related to an Agency Protest record.');
			return;
		}

		System.assert(true, 'Successfully created all test data.');
	}

}