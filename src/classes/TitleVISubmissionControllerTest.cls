@isTest(seeAlldata = false)
private class TitleVISubmissionControllerTest {
    
    @testSetup
    static void createtestdata(){
        PublicUserGroupHandler.disableGroupMemberRecalculation = true;
        User thisUser = [SELECT Id,userroleid FROM User WHERE Id = :UserInfo.getUserId()];
        thisuser.userroleid='00E30000001ZtBrEAK';
        update thisuser;
        
        system.runAs(thisUser){       
            //--------------------------------
            OCIO_Title_VI_Submission__c titleVISubmissionRec2 = new OCIO_Title_VI_Submission__c();
            titleVISubmissionRec2.OCR_Preparation_Date__c = System.today();
            
            //Assign record to user/contact
            //Campaign
            Campaign camp = new Campaign(Name='test campaign');
            insert camp;
            titleVISubmissionRec2.OCR_Rollout__c =camp.id;
            //Account
            ID acctRecordTypeId = [select Id from RecordType where name = 'Title VI Account' limit 1].id;
            Account acct = new Account(Name='test account', Type='Donee', OCR_Reporting_State__c='VA', OCR_Title_VI_Status__c='Active',
                                                                    BillingStreet='123 Main St', BillingCity='Springs', BillingState='VA', BillingPostalCode='22153', BillingCountry='USA',
                                                                    recordTypeId=acctRecordTypeId);
            insert acct;
            titleVISubmissionRec2.OCR_Donee_Account__c = acct.id;
            //Contact - User
            
            ID contactRecordTypeId = [select Id from RecordType where name = 'Title VI Contact' limit 1].id;
            Contact contact = new Contact(lastName='Newtest',firstName='NewTest123',title='Test',
                                                            email='emailtest@test.com',OCR_Contact_Via__c='email',accountId=acct.Id, recordTypeId=contactRecordTypeId);
            insert contact;
          
            /*Profile p = [select Id, Name from Profile where name like '%Portal User%' limit 1];
            User portalUser = new User(alias = 'portalu', email='test@test.com',
                                            emailencodingkey='UTF-8', firstName='Testing', lastName='Testing', languagelocalekey='en_US',
                                            localesidkey='en_US', contactid = contact.id, profileid = p.Id, timezonesidkey='America/Los_Angeles', username='test@test.com');
            
            insert portalUser;*/
            User portalUser = new User();
            Profile p = [select Id, Name from Profile where name like '%GSA OCR Title VI OHVCP User%' limit 1];
            portalUser = new User(alias = 'portalu', email='test@test.com',
                                            emailencodingkey='UTF-8', firstName='Testing', lastName='Testing', languagelocalekey='en_US',
                                            localesidkey='en_US', contactid = contact.id,portalRole= 'worker', profileid = p.Id, timezonesidkey='America/Los_Angeles', username='test@test.com');
            
            insert portalUser;
            
           // Profile p = [select Id, Name from Profile where name like '%GSA OCR Title VI OHVCP User%' limit 1];
           // User portalUser = [select id from User where profileid =: p.id and isActive = true limit 1];
            
            titleVISubmissionRec2.OCR_Donee_Contact__c = contact.id;
            titleVISubmissionRec2.OCR_Submission_Status__c = 'Draft';
            insert titleVISubmissionRec2;
        }
    }
    static testmethod void testTitleVIController() {
        OCIO_Title_VI_Submission__c rec = [select id,OCR_Rollout__c,OCR_Submission_Status__c,OCR_Donee_Contact__c,OCR_Donee_Account__c,OCR_Preparation_Date__c
                                           from OCIO_Title_VI_Submission__c limit 1];
        User portalUser = [select id from User where email = 'test@test.com' limit 1];
        test.starttest();  
        System.runAs(portalUser) {
            ApexPages.currentPage().getParameters().put('id', rec.id);
            ApexPages.Standardcontroller stdc = new ApexPages.Standardcontroller(new OCIO_Title_VI_Submission__c());
            TitleVISubmissionController controller2 = new TitleVISubmissionController(stdc);
            List<OCIO_Title_VI_Submission__c> recList = controller2.getEditableRecords();
            System.assertNotEquals(0, recList.size());
            recList = controller2.getNonEditableRecords();
            System.assertEquals(true,controller2.getIsPortalUser());
            
            controller2.edit();
            
            controller2.submit();
            String fieldname = controller2.fieldLabel.get('OCR_Organizational_Background__c');
            //System.assert(ApexPages.getMessages().get(1).getDetail().contains(fieldname));
            
            controller2.titleVISubmission.OCR_Organizational_Background__c = 'startup';
            controller2.saveDraft();
            controller2.submit();
            fieldname = controller2.fieldLabel.get('OCR_Organizational_Type__c');
            //System.assert(ApexPages.getMessages().get(2).getDetail().contains(fieldname));
            
            controller2.titleVISubmission.OCR_Organizational_Type__c = 'Minority-focused';
            controller2.titleVISubmission.OCR_Organizational_Type_Other__c = 'test';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Organizational_Type__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Organizational_Type_Other__c = 'test';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Limited_English_Proficiency__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Languages_Most_Encountered__c = 'Chinese';
            controller2.titleVISubmission.OCR_Lanuage_Other__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Languages_Most_Encountered__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Lanuage_Other__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Translation_or_Interpretation_Assist__c = 'Volunteers';
            controller2.titleVISubmission.OCR_Trans_Interpretation_Assis_Other__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Translation_or_Interpretation_Assist__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Trans_Interpretation_Assis_Other__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_LEP_Notification_Method__c = 'Brochure';
            controller2.titleVISubmission.OCR_LEP_Notification_Method_Other__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_LEP_Notification_Method__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_LEP_Notification_Method_Other__c = 'Other';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_LEP_Additional_Cost__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_LEP_Actual_Cost__c = 45;
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Hearing_Visual_Impaired_Assistance__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Training_Educational_Programs__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Training_Educational_Programs_Desc__c = 'Desc';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Administrative_Grievance_Procedure__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Administrative_Grievance_Procedure_D__c = 'Desc';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Market_Advertise__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Complaints_Filed__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Complaint_Received__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_How_Did_You_Learn__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Property_Availability__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Problems_Experienced__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Property_Quality__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Information_Unavailable__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            controller2.titleVISubmission.OCR_Unavailable_Data__c = 'Yes';
            controller2.saveDraft();
            controller2.submit();
            
            
            controller2.editReview();
            controller2.saveReview();
            controller2.cancelAction();
            
            controller2.cancelEdit();
            
            recList = controller2.getNonEditableRecords();
            System.assertNotEquals(0, recList.size());
            
            //Test Exception block
            controller2.titleVISubmission=null;
            controller2.submit();     
        }
        test.stoptest();
        //Test record creation and saving
        OCIO_Title_VI_Submission__c titleVISubmissionRec = new OCIO_Title_VI_Submission__c();
        titleVISubmissionRec.OCR_Administrative_Grievance_Procedure__c = 'No';
        titleVISubmissionRec.OCR_Preparation_Date__c = System.today();
        insert titleVISubmissionRec;
        
        ApexPages.currentPage().getParameters().put('id', titleVISubmissionRec.id);
        TitleVISubmissionController controller = new TitleVISubmissionController(new ApexPages.Standardcontroller(titleVISubmissionRec));
        controller.saveDraft();
        
        System.assertEquals('Draft',controller.titleVISubmission.OCR_Submission_Status__c);
        controller.submit();
        //Still draft status - no validation
        System.assertEquals('Draft',controller.titleVISubmission.OCR_Submission_Status__c);
        
        System.assert(controller.getIsEditable());
        
        //Test Exception blocks
        ApexPages.currentPage().getParameters().put('id', null);
        ApexPages.Standardcontroller stdc = new ApexPages.Standardcontroller(new OCIO_Title_VI_Submission__c());
        TitleVISubmissionController controller2 = new TitleVISubmissionController(stdc);
        controller2.titleVISubmission=null;
        controller2.saveDraft();
        controller2.submit();
        
        //Test portal user
        System.assertEquals(false,controller.getIsPortalUser());
    }
    
}