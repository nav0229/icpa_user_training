@isTest
private class AttachmentTriggerTest {
	
	@isTest static void testAttachmentInsertions() {
		Attachment attach1= new Attachment();
		Attachment attach2= new Attachment();

		Suspension_and_Debarment_Case__c sdCase = new Suspension_and_Debarment_Case__c();
		insert sdCase;

		SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = true;

		SD_Document_Upload__c sdDoc = new SD_Document_Upload__c();
		sdDoc.Suspension_and_Debarment_Record__c = sdCase.Id;
		sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;
		insert sdDoc;

		attach1.Name = 'sample.txt';
		attach1.Body = Blob.valueOf('AAAAAAAAAAAAAA');
		attach1.ParentId= sdDoc.Id;

		attach2.Name = 'sample.txt';
		attach2.Body = Blob.valueOf('AAAAAAAAAAAAAA');
		attach2.ParentId = sdDoc.Id;

		Test.startTest();
			insert attach1;
			SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = false;
			try{
				insert attach2;
			} catch (Exception e) {
				//this is just so that we don't have the test interrupted by an exception
				System.assert(true);
			}
		Test.stopTest();

		List<Attachment> allAttachments= [SELECT Id FROM Attachment];

		System.assertEquals(1, allAttachments.size(), 'One of the attachments should have failed to insert due to being associated with a SD Document Upload');
	}
	
	@isTest static void testAttachmentDeletions(){
		Attachment attach1= new Attachment();
		Attachment attach2= new Attachment();

		Suspension_and_Debarment_Case__c sdCase = new Suspension_and_Debarment_Case__c();
		insert sdCase;

		SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = true;

		SD_Document_Upload__c sdDoc = new SD_Document_Upload__c();
		sdDoc.Suspension_and_Debarment_Record__c = sdCase.Id;
		sdDoc.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;
		insert sdDoc;

		attach1.Name = 'sample.txt';
		attach1.Body = Blob.valueOf('AAAAAAAAAAAAAA');
		attach1.ParentId= sdDoc.Id;

		attach2.Name = 'sample.txt';
		attach2.Body = Blob.valueOf('AAAAAAAAAAAAAA');
		attach2.ParentId = sdDoc.Id;

		insert attach1;
		insert attach2;

		Test.startTest();
			delete attach1;
			SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = false;
			try{
				delete attach2;
			} catch (Exception e) {
				//this is just so that we don't have the test interrupted by an exception
				System.assert(true);
			}
		Test.stopTest();

		List<Attachment> allAttachments= [SELECT Id FROM Attachment];

		System.assertEquals(1, allAttachments.size(), 'One of the attachments should have failed to delete due to being associated with a SD Document Upload');
	}

}