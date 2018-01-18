@isTest(seealldata = false)
public with sharing class RT_TypeaheadTest {

    @testsetup
    static void creattestdata(){
        
        Account account = new Account(Name = 'Test Account for MyProfile',Type = 'Donee',BillingStreet = '123 Main Street',BillingCity = 'Cityville',BillingState = 'NJ',
										BillingPostalCode = '12345',BillingCountry = 'USA',OCR_County__c = 'Farmville',OCR_Reporting_State__c = 'OH',OCR_Title_VI_Status__c = 'Active');
        insert account;
        system.assertnotEquals(null,account.id);
        Id recordtype = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
        List<contact> collContacts = new List<Contact>();
        collContacts.add(new Contact(RecordTypeId =recordtype, LastName = 'test',FirstName = 'John',Title = 'President',OCR_AKA_Nickname__c = 'JD',Phone = '123-456-7890',Fax = '234-567-8901',
										Email = 'john.doe@nowhere.com',OCR_Contact_Via__c = 'Email',AccountId = account.Id));
		collContacts.add(new Contact(RecordTypeId =recordtype, LastName = 'test',FirstName = 'John2',Title = 'President',OCR_AKA_Nickname__c = 'JD2',Phone = '123-456-7891',Fax = '234-567-8902',
										Email = 'john2@nowhere.com',OCR_Contact_Via__c = 'Email',AccountId = account.Id));
        insert collContacts;
        system.assertEquals(2, [select count() from contact]);
        system.debug('collContacts @@'+collContacts);
        
    }
    static testmethod void testQuery(){
        List<Contact> collCont = [select id,lastname,firstname from Contact where recordtypeid = '01230000001Ir70AAC'];
        system.debug('collCont@2 '+collCont);
        list<Id> fixedSearchResults= new list<Id>{collCont[0].id, collCont[1].id};
      	Test.setFixedSearchResults(fixedSearchResults);
        List<String> fieldnm = new List<String>{'Lastname','Firstname'};
		Test.startTest();
        list<sObject> results = RT_Typeahead.searchRecords( 'test', null, fieldnm, null, null, null, null );
        Test.stopTest();  
        system.assertEquals(2, results.size());
    }
}