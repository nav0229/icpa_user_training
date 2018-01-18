@isTest
public with sharing class SDDocumentWrapperTest {

	public static testMethod void testSDDocumentWrapper_SDDocAndAttachemntGiven_SDDocumentWrapperCreated(){

        SD_Document_Upload__c testDocumentUpload = [select CreatedDate,Owner.Id,Owner.Name,Name,Description__c from SD_Document_Upload__c where Description__c ='DescriptionforTesting' and order__C =1];
        Attachment testAttachment = [select Name from Attachment where ParentId =: testDocumentUpload.id];
        SDDocumentWrapper testDocumentWrapper= new SDDocumentWrapper(testDocumentUpload,testAttachment);
        System.assertEquals(testDocumentWrapper.DocDescription,testDocumentUpload.Description__c);
        System.assertEquals(testDocumentWrapper.AttachmentFileName,testAttachment.Name);

	}
	@testSetup static void createTestData(){
        Id adminProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA System Administrator'].Id;
		User adminUser = [SELECT Id FROM User WHERE ProfileId = :adminProfileId AND IsActive = true AND Id != :UserInfo.getUserId() LIMIT 1];

		SD_Document_Upload__c testDocumentUpload = new SD_Document_Upload__c();
		testDocumentUpload.OwnerId = adminUser.id;
        testDocumentUpload.Description__c ='DescriptionforTesting';
		testDocumentUpload.Order__c= 1;
		testDocumentUpload.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;
		SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = true;
		insert testDocumentUpload;

		Test.setCreatedDate(testDocumentUpload.Id, Date.today());

        Attachment testAttachment = new Attachment();
        testAttachment.Body = Blob.valueOf('TestAttachments');
	    testAttachment.Name = String.valueOf('test.txt');
	    testAttachment.ParentId = testDocumentUpload.id;
	    insert testAttachment;

        System.assert(true);
	}

}