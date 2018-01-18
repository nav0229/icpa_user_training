@isTest
private class testGSAITApplication {
   
    static testMethod void testHstsWorkaround() {
        new GSAITApplication().hstsHeader();
    }
    
    static testMethod void testGSAITApplication() {
               
        Applicants_Information__c contact1 = new Applicants_Information__c();
        GSA_IT_Applications__c newapplication = new GSA_IT_Applications__c();
        contact1.Name='Applicant1';
        contact1.Email__c='Applicant@gsa.gov';
        contact1.Phone__c='(703)603-8172';
        contact1.Current_Employer__c='AnyCompany, Inc.';
        contact1.City_State_or_Zip_Code__c='22201';
        
        PageReference pageRef = Page.GSAIT_Application;
        Test.setCurrentPage(pageRef);
 
        GSAITApplication obj = new GSAITApplication ();

        Applicants_Information__c appinfo = obj.ApplicantInfo;   
       GSA_IT_Applications__c application = obj.applicant;
       
        obj.ApplicantInfo=contact1;
        obj.applicant=application;
        
        obj.submit();
 
        Applicants_Information__c contact2 = new Applicants_Information__c();
        contact2.Name='pifApplicant2';
        contact2.Email__c='Applicant@gsa.gov';
        contact2.Phone__c='(703)603-8172';
        contact2.Current_Employer__c='AnyCompany, Inc.';
        contact2.City_State_or_Zip_Code__c='22201';
        
        obj = new GSAITApplication ();

        appinfo = obj.ApplicantInfo;   
        application = obj.applicant;
       
        obj.ApplicantInfo= contact2;
        obj.applicant=application;
       
        try{
            obj.submit();
        }
        catch(exception e){
   
            System.Assert(e.getMessage().contains('Email address already used to submit an application. Please choose a different email.'));
        }
        
       
   }
}