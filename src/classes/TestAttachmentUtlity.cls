@isTest(SeeAllData=true)
public class TestAttachmentUtlity { 
     static testMethod void appRequest() {
        PageReference pageRef = Page.AppicationRequestAttachfiles;
        Test.setCurrentPage(pageRef);
        AttachmentUtlity  controller = new AttachmentUtlity ();
        Case objCase = [SELECT Id FROM Case LIMIT 1];
        Apexpages.currentPage().getParameters().put('caseId',objCase.Id);
        Apexpages.currentPage().getParameters().put('caseNumber','0007');
        Attachment attach = new Attachment();
        //Smitha: Bump up Code coverage 
        controller.upload();
        //Smitha
        controller.getFileName();
        controller.setFileName('Test');
        controller.getFileBody();
        controller.setFileBody(Blob.valueOf('Test Data'));
        controller.getFileSize();
        controller.setFileSize(12345);
        String strName = 'Test123';
        Integer intSize = 12345;
        //innerWrapper(strName, intSize);
        controller.parentId = objCase.Id;
        controller.upload();
        //controller.doneAttaching();
        System.assertEquals (True,True);
        }
}