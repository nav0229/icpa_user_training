@isTest(seealldata=false)
public with sharing class RT_TechnologyRequestFormControllerTest{

    @testsetup
    static void createtestdata(){        
        Account account = new Account(Name = 'Test Account for MyProfile',Type = 'Donee',BillingStreet = '123 Main Street',BillingCity = 'Cityville',BillingState = 'NJ',
										BillingPostalCode = '12345',BillingCountry = 'USA',OCR_County__c = 'Farmville',OCR_Reporting_State__c = 'OH',OCR_Title_VI_Status__c = 'Active');
        insert account;
        system.assertnotEquals(null,account.id);
        List<contact> collContacts = new List<Contact>();
        collContacts.add(new Contact(LastName = 'Doe',FirstName = 'John',Title = 'President',OCR_AKA_Nickname__c = 'JD',Phone = '123-456-7890',Fax = '234-567-8901',
										Email = 'john.doe@nowhere.com',OCR_Contact_Via__c = 'Email',AccountId = account.Id));
		collContacts.add(new Contact(LastName = 'Doe2',FirstName = 'John2',Title = 'President',OCR_AKA_Nickname__c = 'JD2',Phone = '123-456-7891',Fax = '234-567-8902',
										Email = 'john2@nowhere.com',OCR_Contact_Via__c = 'Email',AccountId = account.Id));
        insert collContacts;
        system.assertEquals(2, [select count() from contact]);
    }
    
    static testmethod void testvf1(){
        Contact tmp = [select id,email from contact where Email='john.doe@nowhere.com' limit 1];
        Contact tmp2 = [select id,email from contact where Email='john2@nowhere.com' limit 1];
        test.starttest();
        PageReference pageRef = Page.TechnologyRequestForm;
        Test.setCurrentPage(pageRef);
        
        RT_TechnologyRequestFormController obj = new RT_TechnologyRequestFormController();
        obj.reqTracker.SpokenWithGSAIT__c = 'Yes';
        obj.reqTracker.GSA_IT_Contact__c = tmp.id;
        obj.reqTracker.BusinessJustification__c = 'Test';
        obj.reqTracker.RequestingFor__c = tmp2.id;
        obj.reqTracker.TechnologyToolIdentified__c = 'No';
        obj.Submit();
        test.stoptest();
        system.assertEquals(1, [select count() from Request_Tracker__c]);
    }
    
    static testmethod void testvf2(){
        test.starttest();
        PageReference pageRef = Page.TechnologyRequestForm;
        Test.setCurrentPage(pageRef);
        
        RT_TechnologyRequestFormController obj = new RT_TechnologyRequestFormController();
        obj.reqTracker.SpokenWithGSAIT__c = 'No';
        obj.reqTracker.BusinessJustification__c = 'Testing';
        obj.reqTracker.TechnologyToolIdentified__c = 'Yes';
        obj.reqTracker.pilot_initiative__c = 'Yes';
        obj.reqTracker.T_C__c = true;
        obj.reqTracker.Technology_Tool_Name__c = 'Test Technology' ;
        obj.reqTracker.Company_Name__c = 'Test Company' ;
        obj.reqTracker.Customer_Support_Email__c = 'Test@abc.com';
        obj.reqTracker.Category__c ='Other' ;
        obj.reqTracker.CategoryOther__c = 'test other';
        obj.reqTracker.type_of_technology__c = 'Other';
        obj.reqTracker.Tech_other__c = 'Test Other type';
        obj.Submit();
        test.stoptest();
        system.assertEquals(1, [select count() from Request_Tracker__c]);
    }
    static testmethod void testvf3(){
        test.starttest();
        PageReference pageRef = Page.TechnologyRequestForm;
        Test.setCurrentPage(pageRef);
        
        RT_TechnologyRequestFormController obj = new RT_TechnologyRequestFormController();
        obj.reqTracker.SpokenWithGSAIT__c = 'No';
        obj.reqTracker.BusinessJustification__c = 'Test2';
        obj.reqTracker.TechnologyToolIdentified__c = 'Yes';
        obj.reqTracker.pilot_initiative__c = 'No';
        obj.reqTracker.Technology_Tool_Name__c = 'Test Technology' ;
        obj.reqTracker.Company_Name__c = 'Test Company' ;
        obj.reqTracker.Customer_Support_Email__c = 'Test@abc.com';
        obj.reqTracker.VPAT__c = 'No';
        obj.reqTracker.Category__c ='Application Servers' ;
        obj.reqTracker.type_of_technology__c = 'Desktop;';
        obj.Submit();
        obj.validateform();
        test.stoptest();
        system.assertEquals(1, [select count() from Request_Tracker__c]);
    }

}