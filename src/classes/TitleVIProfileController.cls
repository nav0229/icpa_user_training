// ======================================================================================
// This class is a custom controller for Title VI My Profile page
// It allows the user to view their profile information from Account and Contact objects
// The user can edit their Contact information (but not their Account information)
// ======================================================================================
public with sharing class TitleVIProfileController {

    // page level fields for tracking edit/validation 
    public Boolean isEdit {get;set;}
    public Boolean isRequiredError {get;set;}
    public Boolean isEmailError {get;set;}
    
    // account and contact objects
    public Contact userContact {get;set;}
    public Account contactAccount {get;set;}
    
    // local fields for required attributes from account 
    public String acctName {get;set;}
    public String billingStreet {get;set;}
    public String billingCity {get;set;}
    public String billingPostalCode {get;set;}
    public String billingState {get;set;}
    public String billingCountry {get;set;}
    public String billingCounty {get;set;}
    
    // local fields for required attributes from contact
    public String firstName {get;set;}
    public String lastName {get;set;}
    public String title {get;set;}
    public String nickname {get;set;}    
    public String phone {get;set;}
    public String fax {get;set;}
    public String email {get;set;}
    public String contactVia {get;set;}
    
    // options for contactVia
    public List<SelectOption> contactViaList {
        get {
            List<SelectOption> options = new List<SelectOption>();
            Schema.Describefieldresult field = Contact.OCR_Contact_Via__c.getDescribe();
            for (Schema.Picklistentry f : field.getPicklistValues()) {
              options.add(new SelectOption(f.getValue(), f.getLabel()));    
            }
            return options;
        }
        set;}
            
    public TitleVIProfileController() {
        // get the currently logged in user id
        String currentAuthUserId = UserInfo.getUserId();

        // get the required user information
        User currentUser = getUserInfo(currentAuthUserId);
        
        // if we have a valid user logged in
        if (currentUser != null) {
            // get the contact details
            userContact = getContactInfo(currentUser.ContactId);
            
            // get the account details - based on accountId from contact object
            contactAccount = getAccountInfo(userContact != null ? userContact.AccountId : null);

            // set the local fields to values from contact and account
            resetAllFields();           
        }
       
        // reset the flags       
        isEdit = false;
        isRequiredError = false;
        isEmailError = false;        
    }

    public PageReference editContact() {
        // in edit mode
        isEdit = true;
        
        return null;
    }
    
    public PageReference saveContact() {
        try {          
            // update only the contact attributes - account fields are not updateable    
            userContact.FirstName = firstName;
            userContact.LastName = lastName;
            userContact.Title = title;
            userContact.OCR_AKA_Nickname__c = nickname;
            userContact.Phone = phone;
            userContact.Fax = fax;
            userContact.Email = email;
            userContact.OCR_Contact_Via__c = contactVia;
                           
            update userContact;

            // reset the flags
            isEdit = false;
            isRequiredError = false;
            isEmailError = false;           
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);           
        }
    
        return null;   
    }
    
    public PageReference cancelAction() {
        // reset the fields
        resetAllFields();
        
        // reset the flags
        isEdit = false;
        isRequiredError = false;
        isEmailError = false;           
        
        return null;    
    }
    
    public PageReference requiredError() {
        // required fields missing, set the appropriate flag   
        isRequiredError = true;
        isEmailError = false;
      
        return null;
    }
    
    public PageReference emailError() {
        // invalid email address, set the appropriate flag
        isRequiredError = false;
        isEmailError = true;
      
        return null;
    }
    
    private static User getUserInfo(Id userId) {
        User loggedInUser = null;

        if (userId != null) {
            loggedInUser = [Select Id, ContactId, Contact.AccountId from User where Id = :userId];
        }
        
        return loggedInUser;
    }
    
    private static Contact getContactInfo(Id contactId) {
        Contact conInfo = null;
        
        if (contactId != null) {
            conInfo = [select FirstName, LastName, AccountId, Title, OCR_AKA_Nickname__c, OCR_Contact_Via__c, Phone, Fax, Email
                       from Contact where Id = :contactId];
        }

        return conInfo;
    }
    
    private static Account getAccountInfo(Id accountId) {
        Account accInfo = null;
        
        if (accountId != null) {
            accInfo = [select Name, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry, OCR_County__c                          
                       from Account where Id = :accountId];
        }
        
        return accInfo; 
    }
    
    private void resetAllFields() {
        if (userContact != null) {
            firstName = userContact.FirstName;
            lastName = userContact.LastName;
            title = userContact.Title;
            nickname = userContact.OCR_AKA_Nickname__c;
            phone = userContact.Phone;
            fax = userContact.Fax;
            email = userContact.Email;
            contactVia = userContact.OCR_Contact_Via__c;
        }
        if (contactAccount != null) {
            acctName = contactAccount.Name;
            billingStreet = contactAccount.BillingStreet;
            billingCity = contactAccount.BillingCity;
            billingPostalCode = contactAccount.BillingPostalCode;       
            billingState = contactAccount.BillingState;
            billingCountry = contactAccount.BillingCountry;
            billingCounty = contactAccount.OCR_County__c;
        }
    }    
}