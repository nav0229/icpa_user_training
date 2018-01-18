@isTest(seeAlldata=false)
private class TitleVIReviewChildControllerTest {
    @testSetUp
    static void createtestdata(){
        OCIO_Title_VI_Submission__c submission = new OCIO_Title_VI_Submission__c();
        insert submission;
        system.assertNotEquals(null, submission.id);
        
    }
    static testMethod void testController()
    {
        OCIO_Title_VI_Submission__c rec = [select id from OCIO_Title_VI_Submission__c limit 1];
        ApexPages.currentPage().getParameters().put('id', rec.Id);
        test.startTest();
        TitleVIReviewChildController controller = new TitleVIReviewChildController();
        controller.redirect();      
        System.assert([SELECT Id FROM OCIO_Title_VI_Review__c WHERE OCR_Title_VI_Submission__c =: rec.Id].size() != 0);
        test.stopTest();
    }

}