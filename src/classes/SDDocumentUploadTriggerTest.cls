@isTest
public with sharing class SDDocumentUploadTriggerTest {

	public static testMethod void testpromptErrorIfNotFromVisualForcePage_SDUploadDocumentGiven_DeleteErrorMessagePrompted(){
        SD_Document_Upload__c testDocumentUpload = [select CreatedDate,Owner.Id,Owner.Name,Name,Description__c from SD_Document_Upload__c where Description__c ='DescriptionforTesting' and order__C =1];
        SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = false;
        try {
            delete testDocumentUpload;
        }Catch (Exception  e){
            System.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), e.getMessage());
        }
	}

	@testSetup static void createTestData(){

        Id adminProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA System Administrator'].Id;
		User adminUser = [SELECT Id FROM User WHERE ProfileId = :adminProfileId AND IsActive = true AND Id != :UserInfo.getUserId() LIMIT 1];
		List<SD_Document_Upload__c> SDDocumentUploadList = new List<SD_Document_Upload__c>();

		SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST = true;

		SD_Document_Upload__c testDocumentUpload1 = new SD_Document_Upload__c();
		testDocumentUpload1.OwnerId = adminUser.id;
        testDocumentUpload1.Description__c ='DescriptionforTesting';
		testDocumentUpload1.order__c= 1;
		testDocumentUpload1.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_SD;
        SDDocumentUploadList.add(testDocumentUpload1);

        SD_Document_Upload__c testDocumentUpload2 = new SD_Document_Upload__c();
		testDocumentUpload2.OwnerId = adminUser.id;
        testDocumentUpload2.Description__c ='DescriptionforTesting2';
		testDocumentUpload2.order__c= 2;
        testDocumentUpload2.RecordTypeId = SDProjectConstants.RECORDTYPEID_SDDOCUMENTUPLOAD_AP;
        SDDocumentUploadList.add(testDocumentUpload2);

		insert SDDocumentUploadList ;

		Test.setCreatedDate(testDocumentUpload1.Id, Date.today());
		Test.setCreatedDate(testDocumentUpload2.Id, Date.today());

        Attachment testAttachment = new Attachment();
        testAttachment.Body = Blob.valueOf('TestAttachments');
	    testAttachment.Name = String.valueOf('test.txt');
	    testAttachment.ParentId = testDocumentUpload1.id;
	    insert testAttachment;

        System.assert(true);
	}

}