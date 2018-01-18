/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestTitleVIProfileController {

    static testMethod void testTitleVIProfileController() {
        //Create an account with Title VI Status in Ohio
        Account account = new Account();
        account.Name = 'Test Account for MyProfile';
        account.Type = 'Donee';
        account.BillingStreet = '123 Main Street';
        account.BillingCity = 'Cityville';
        account.BillingState = 'NJ';
        account.BillingPostalCode = '12345';
        account.BillingCountry = 'USA';
        account.OCR_County__c = 'Farmville';
        account.OCR_Reporting_State__c = 'OH';
        account.OCR_Title_VI_Status__c = 'Active';
        insert account;
        
        //Create an associated Contact for the Account
        Contact contact = new Contact();
        contact.LastName = 'Doe';
        contact.FirstName = 'John';
        contact.Title = 'President';
        contact.OCR_AKA_Nickname__c = 'JD';
        contact.Phone = '123-456-7890';
        contact.Fax = '234-567-8901';
        contact.Email = 'john.doe@nowhere.com';
        contact.OCR_Contact_Via__c = 'Email';        
        contact.AccountId = account.Id;
        insert contact;
        
        TitleVIProfileController controller = new TitleVIProfileController();
        // resetAllFields() method is private, so we have to set the values first time
        controller.userContact = contact;
        controller.contactAccount = account;
        controller.firstName = contact.FirstName;
        controller.lastName = contact.LastName;
        controller.title = contact.Title;
        controller.nickname = contact.OCR_AKA_Nickname__c;
        controller.phone = contact.Phone;
        controller.fax = contact.Fax;
        controller.email = contact.Email;
        controller.contactVia = contact.OCR_Contact_Via__c;
         
        controller.acctName = account.Name;
        controller.billingStreet = account.BillingStreet;
        controller.billingCity = account.BillingCity;
        controller.billingPostalCode = account.BillingPostalCode;       
        controller.billingState = account.BillingState;
        controller.billingCountry = account.BillingCountry;
        controller.billingCounty = account.OCR_County__c;
                
        // now we should have all the variables set as displayed on the page. let's verify        
        System.assert(controller.acctName == 'Test Account for MyProfile');
        
        // edit the profile
        controller.editContact();
        
        System.assert(controller.isEdit == true);
        System.assert(controller.isRequiredError == false);
        System.assert(controller.isEmailError == false);
                
        controller.firstName = 'Jane';
        
        // save the profile 
        controller.saveContact();
        
        System.assert(controller.userContact.FirstName == 'Jane');
        System.assert(contact.FirstName == 'Jane');
        
        // verify the flags are reset after save
        System.assert(controller.isEdit == false);
        System.assert(controller.isRequiredError == false);
        System.assert(controller.isEmailError == false);
        
        // edit and cancel the edit
        controller.editContact();
        
        System.assert(controller.isEdit == true);
        
        controller.cancelAction();
        
        System.assert(controller.isEdit == false);
        
        // edit and verify validation errors
        controller.editContact();
        
        System.assert(controller.isEdit == true);
        
        controller.lastName = null;
        controller.phone = null;
        controller.requiredError();
        controller.saveContact();   

        // save should fail and not update the record
        System.assert(controller.isRequiredError == true);                
        System.assert('Doe' == [select LastName from Contact where Id = :contact.Id][0].LastName);
        System.assert('123-456-7890' == [select Phone from Contact where Id = :contact.Id][0].Phone);

        // verify invalid email 
        controller.editContact();
        controller.email = 'notanemail';
        controller.emailError();
        controller.saveContact();
        
        // save should fail and not update the record
        System.assert(controller.isEmailError == true);
        System.assert('john.doe@nowhere.com' == [select Email from Contact where Id = :contact.Id][0].Email);
        
        // finally, verify if the Contact Via options are available
        List<SelectOption> options = controller.contactViaList;
        System.assert(options != null);
        System.assert(options.size() > 0);
    }
}