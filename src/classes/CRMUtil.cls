/*****************************************************************************************************************************************************
This util class checks for existing Accounts by exact company name, and Contacts by email and returns the Account /Contact . 
If none are found, this util class can create a new Account and/or Contact.

Creation Date                Created By                    Version
========================================================================
05/23/2013                 Raja Nangunoori                 1.0
04/30/2014                 Smitha Unnivelan     
========================================================================

*****************************************************************************************************************************************************/
public with sharing class CRMUtil{
    //Checks if its a test method and passes values if its test method;
    //  public static boolean isTestMethod = false;
    
    //Constants to store RecordTypeId and AccountId
    public static Id GSA_RECORDTYPE = [SELECT Id FROM RecordType WHERE DeveloperName = 'GSA' AND SObjectType = 'Contact'
                                      ].Id;
     
    public static Id NON_GSA_RECORDTYPE = [SELECT Id FROM RecordType WHERE DeveloperName = 'NON_GSA' AND SObjectType = 'Contact'].Id;
    
    private static String GSAACCOUNTID = 'GSAAccountId';
    
    private static String GSACONTACTRECORDTYPEID = 'GSAContactRecordTypeId';
    
    private static String CONTACTSYNCPROFILE = 'ContactSyncProfile';
    
    private static String SUPPORTEMAIL = 'SupportEmail'; 
    
    private static String FROMEMAILID = 'app-support@gsa.gov';
    //Account check by Company Name
    
   public static Account getAccountByCompanyName(List<Account> accounts) {
    
         Account returnAccountComp = new Account();
         //Getting all the fields from Account object
         Account account = accounts.get(0);        
         List<Account> getAcctInfoComp = [
         
         SELECT 
             Name, AccountNumber, Site, AccountSource, AnnualRevenue, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
             BillingLatitude, BillingLongitude, IsCustomerPortal, Jigsaw, Description, NumberOfEmployees, Fax, Industry, Ownership, Phone, Rating, 
             ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingLatitude, ShippingLongitude,  Sic, SicDesc, 
             TickerSymbol, Type, Website, AgencyBureauCode_4__c, AgencyBureauCode_5__c, Account_Nickname__c, sm1e__Active__c, Agency__c, Agency_Code_2__c, 
             Agency_Code_3__c, OCR_Certification_Date__c, Public_Engagement_Classification__c, OCR_County__c, Expired__c, FTRD_Is_FTRD_Account__c, 
             OCR_GSA_Region__c, OCR_ID__c, sm1e__smManufacturer__c, FedRAMP_Organization_Type__c, Product_Service_Code__c, Region__c, OCR_Reporting_State__c, 
             Routing_Code__c, SSO__c, OCR_Title_VI_Status__c, sm1e__smVendor__c                      
        FROM Account WHERE Name = :account.Name ORDER BY CreatedDate ASC LIMIT 1
        ];
        
         if (getAcctInfoComp.isEmpty()) {
            //If an account is not found returning null
             returnAccountComp = null;
         } else {
            //If an Account is found passing all Account fields to Account instance
             returnAccountComp = getAcctInfoComp.get(0);
         }
         
         //Returning Account instance
         return returnAccountComp;
    }
    
    //Get Accountobject for a Name and RecordType
    public static Account getAccountByNameAndRecordtype(String accountName, String recordType) {
    
        Account returnAccount = new Account();
        
        //Get account object for specified account name and record type id
        List<Account> accounts = [
            Select Name, AccountNumber, Site, AccountSource, AnnualRevenue, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
             BillingLatitude, BillingLongitude,  IsCustomerPortal, Jigsaw, Description, NumberOfEmployees, Fax, Industry, Ownership, Phone, Rating, 
            ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingLatitude, ShippingLongitude, Sic, SicDesc, 
            TickerSymbol, Type, Website, AgencyBureauCode_4__c, AgencyBureauCode_5__c, Account_Nickname__c, sm1e__Active__c, Agency__c, Agency_Code_2__c, 
            Agency_Code_3__c, OCR_Certification_Date__c, Public_Engagement_Classification__c, OCR_County__c, Expired__c, FTRD_Is_FTRD_Account__c, 
            OCR_GSA_Region__c, OCR_ID__c, sm1e__smManufacturer__c, FedRAMP_Organization_Type__c, Product_Service_Code__c, Region__c, OCR_Reporting_State__c, 
            Routing_Code__c, SSO__c, OCR_Title_VI_Status__c, sm1e__smVendor__c
            from Account 
            where Account.Name =: accountName and Account.RecordTypeId =: recordType
        ];    
         
        if(accounts.isEmpty()){
            //if no accounts found return null
            returnAccount = null;
        }
        else{
            //if accounts found return the first accounts instance to be returned
            returnAccount = accounts.get(0);
        }
        
        return returnAccount;
    }
    
    //Create Account
    public static Account createAccount(List<Account> accounts) {   
        //Inserting Account 
        
        try{
            insert accounts;
        }catch(DMLException e){
            System.debug('Exception in Insert Account');
            return null;
        }
            
        //Returning Account      
         return accounts.get(0);
    }
    
    //Get Contact for an Email for an Account
    public static Contact getContactByEmail(List<Account> accounts, List<Contact> contacts) {
        //Checking Contact by Email for a specific account
        Contact returnContact = new Contact();
        //Getting all the fields from Contact object
        Account account = accounts.get(0);
        Contact contact = contacts.get(0);
        List<Contact> getContact = [
         SELECT CanAllowPortalSelfReg, AssistantName, AssistantPhone, Birthdate, Jigsaw, Department, Description, DoNotCall, Email, HasOptedOutOfEmail,
                Fax, HasOptedOutOfFax, HomePhone, LastCURequestDate, LastCUUpdateDate, LeadSource, MailingStreet, MobilePhone, Name, Salutation, FirstName, LastName,
                OtherStreet, OtherPhone, Phone, Title, Affiliation__c, RPCD_Agency_Head__c, OCR_AKA_Nickname__c, Public_Engagement_Assistant_Email__c,Public_Engagement_Assistant_Fax__c, 
                RPCD_Building__c, RPCD_Bureau__c, CHRIS_ID__c, OCR_Contact_as_of_Date__c, Contact_ID__c, OCR_Contact_Via__c, GOVTPOC_COTAR__c, Public_Engagement_Data_Source__c, 
                RPCD_Division__c, OCR_Email_Bounced__c, Contact_Federated_ID__c, FTRD_Is_FTRD_Contact__c, RPCD_Functional_Area__c,
                Contact_GSA_Short_Symbol__c, Person_Separation_Date__c,Person_Start_Date__c, Public_Engagement_Is_Public_Engagement__c, sm1e__Labor_Rate_Overtime__c, sm1e__Labor_Rate_Regular__c, MAJOR_ORG__c,
                MAJOR_ORG_DESCRIPTION__c, Contact_Middle_Name__c, Nickname__c, RPCD_Office__c, Contact_Organization_Name__c, RPCD_Parent_Account__c,
                Public_Engagement_Region__c, Contact_Region__c, OCR_Reporting_State__c, RPCD_Room__c, RPCD_Suffix__c, Supervisor__c, OCR_Title_VI_Primary_Contact__c,
                UPN__c, WORK_BUILDING_PRIMARY__c, sm1e__Work_Order_Resource__c
                FROM Contact WHERE Email =: contact.Email AND AccountId =: account.Id LIMIT 1
                      ];
                                    
       if (getContact.isEmpty()) {
        //If a Contact is not found assigning null to the return Contact instance
            returnContact = null;
       } else {
        //If a Contact is found assigning Contact fields to the return Contact instance        
            returnContact = getContact.get(0);
       }
       //Return contact instance
        
        return returnContact;
    }
    
    //Get Contact by Federated Id for an Account and Contact Federated Id
    public static Contact getContactByFederatedId(String accountId, String contactFederatedId) {
        //Checking Contact by Email for a specific account
        Contact returnContact = new Contact();
        //Getting all the fields from Contact object
               
        List<Contact> getContact = [
         SELECT CanAllowPortalSelfReg, AssistantName, AssistantPhone, Birthdate, Jigsaw, Department, Description, DoNotCall, Email, HasOptedOutOfEmail,
                Fax, HasOptedOutOfFax, HomePhone, LastCURequestDate, LastCUUpdateDate, LeadSource, MailingStreet, MobilePhone, Name, Salutation, FirstName, LastName,
                OtherStreet, OtherPhone, Phone, Title, Affiliation__c, RPCD_Agency_Head__c, OCR_AKA_Nickname__c, Public_Engagement_Assistant_Email__c,Public_Engagement_Assistant_Fax__c, 
                RPCD_Building__c, RPCD_Bureau__c, CHRIS_ID__c, OCR_Contact_as_of_Date__c, Contact_ID__c, OCR_Contact_Via__c, GOVTPOC_COTAR__c, Public_Engagement_Data_Source__c, 
                RPCD_Division__c, OCR_Email_Bounced__c, Contact_Federated_ID__c, FTRD_Is_FTRD_Contact__c, RPCD_Functional_Area__c,
                Contact_GSA_Short_Symbol__c,Person_Separation_Date__c,Person_Start_Date__c, Public_Engagement_Is_Public_Engagement__c, sm1e__Labor_Rate_Overtime__c, sm1e__Labor_Rate_Regular__c, MAJOR_ORG__c,
                MAJOR_ORG_DESCRIPTION__c, Contact_Middle_Name__c, Nickname__c, RPCD_Office__c, Contact_Organization_Name__c, RPCD_Parent_Account__c,
                Public_Engagement_Region__c, Contact_Region__c, OCR_Reporting_State__c, RPCD_Room__c, RPCD_Suffix__c, Supervisor__c, OCR_Title_VI_Primary_Contact__c,
                UPN__c, WORK_BUILDING_PRIMARY__c, sm1e__Work_Order_Resource__c
                FROM Contact WHERE Contact_Federated_ID__c =: contactFederatedId AND AccountId =: accountId LIMIT 1
                      ];
                                    
       if (getContact.isEmpty()) {
        //If a Contact is not found assigning null to the return Contact instance
            returnContact = null;
       } else {
        //If a Contact is found assigning Contact fields to the return Contact instance        
            returnContact = getContact.get(0);
       }
       //Return contact instance
        
        return returnContact;
    }
    
    //Get Contact by Federated Id for an Account and Contact Federated Id
    public static Contact getContactByFederatedId(String accountId, String contactFederatedId, String recordtype) {
        //Checking Contact by Email for a specific account
        Contact returnContact = new Contact();
        //Getting all the fields from Contact object
               
        List<Contact> getContact = [
         SELECT CanAllowPortalSelfReg, AssistantName, AssistantPhone, Birthdate, Jigsaw, Department, Description, DoNotCall, Email, HasOptedOutOfEmail,
                Fax, HasOptedOutOfFax, HomePhone, LastCURequestDate, LastCUUpdateDate, LeadSource, MailingStreet, MobilePhone, Name, Salutation, FirstName, LastName,
                OtherStreet, OtherPhone, Phone, Title, Affiliation__c, RPCD_Agency_Head__c, OCR_AKA_Nickname__c, Public_Engagement_Assistant_Email__c,Public_Engagement_Assistant_Fax__c, 
                RPCD_Building__c, RPCD_Bureau__c, CHRIS_ID__c, OCR_Contact_as_of_Date__c, Contact_ID__c, OCR_Contact_Via__c, GOVTPOC_COTAR__c, Public_Engagement_Data_Source__c, 
                RPCD_Division__c, OCR_Email_Bounced__c, Contact_Federated_ID__c, FTRD_Is_FTRD_Contact__c, RPCD_Functional_Area__c,
                Contact_GSA_Short_Symbol__c,Person_Separation_Date__c,Person_Start_Date__c, Public_Engagement_Is_Public_Engagement__c, sm1e__Labor_Rate_Overtime__c, sm1e__Labor_Rate_Regular__c, MAJOR_ORG__c,
                MAJOR_ORG_DESCRIPTION__c, Contact_Middle_Name__c, Nickname__c, RPCD_Office__c, Contact_Organization_Name__c, RPCD_Parent_Account__c,
                Public_Engagement_Region__c, Contact_Region__c, OCR_Reporting_State__c, RPCD_Room__c, RPCD_Suffix__c, Supervisor__c, OCR_Title_VI_Primary_Contact__c,
                UPN__c, WORK_BUILDING_PRIMARY__c, sm1e__Work_Order_Resource__c
                FROM Contact WHERE Contact_Federated_ID__c =: contactFederatedId AND AccountId =: accountId  AND RecordTypeId =: recordtype LIMIT 1
                      ];
                                    
       if (getContact.isEmpty()) {
        //If a Contact is not found assigning null to the return Contact instance
            returnContact = null;
       } else {
        //If a Contact is found assigning Contact fields to the return Contact instance        
            returnContact = getContact.get(0);
       }
       //Return contact instance
        
        return returnContact;
    }
    
    //Get Contact by Email
    public static Contact getContactByEmail(List<Contact> contacts) {
        //Checking Contact by Email
        Contact returnContact = new Contact();
        //Getting all the fields from Contact object
        Contact contact = contacts.get(0);       
        List<Contact> getContact = [
         SELECT CanAllowPortalSelfReg, AssistantName, AssistantPhone, Birthdate, Jigsaw, Department, Description, DoNotCall, Email, HasOptedOutOfEmail,
                Fax, HasOptedOutOfFax, HomePhone, LastCURequestDate, LastCUUpdateDate, LeadSource, MailingStreet, MobilePhone, Name, Salutation, FirstName, LastName,
                OtherStreet, OtherPhone, Phone, Title, Affiliation__c, RPCD_Agency_Head__c, OCR_AKA_Nickname__c, Public_Engagement_Assistant_Email__c,Public_Engagement_Assistant_Fax__c, 
                RPCD_Building__c, RPCD_Bureau__c, CHRIS_ID__c, OCR_Contact_as_of_Date__c, Contact_ID__c, OCR_Contact_Via__c, GOVTPOC_COTAR__c, Public_Engagement_Data_Source__c, 
                RPCD_Division__c, OCR_Email_Bounced__c, Contact_Federated_ID__c, FTRD_Is_FTRD_Contact__c, RPCD_Functional_Area__c,
                Contact_GSA_Short_Symbol__c, Person_Separation_Date__c,Person_Start_Date__c, Public_Engagement_Is_Public_Engagement__c, sm1e__Labor_Rate_Overtime__c, sm1e__Labor_Rate_Regular__c, MAJOR_ORG__c,
                MAJOR_ORG_DESCRIPTION__c, Contact_Middle_Name__c, Nickname__c, RPCD_Office__c, Contact_Organization_Name__c, RPCD_Parent_Account__c,
                Public_Engagement_Region__c, Contact_Region__c, OCR_Reporting_State__c, RPCD_Room__c, RPCD_Suffix__c, Supervisor__c, OCR_Title_VI_Primary_Contact__c,
                UPN__c, WORK_BUILDING_PRIMARY__c, sm1e__Work_Order_Resource__c 
                FROM Contact WHERE Email =: contact.Email ORDER BY CreatedDate ASC LIMIT 1
                      ];
                      
       if (getContact.isEmpty()) {
        //If a Contact is not found assigning null to the return Contact instance
            returnContact = null;
       } else {
        //If a Contact is found assigning Contact fields to the return Contact instance
            returnContact = getContact.get(0);
       }
       
       //Return contact instance
       
        return returnContact;
    }
    
     //Create Contact
     public static Contact createContact(List<Account> accounts, List<Contact> contacts) {
         //Assign the Account Id to Contact
         
         contacts.get(0).AccountId = accounts.get(0).Id;
         //Insert Contact
         try{
             insert contacts;
         }catch(DMLException e){
             System.debug('Exception in Insert Contact');
             return null;
         }
         //Return Contact       
         return contacts.get(0);
    }
    
    //Look up for an Account by company name and if Account exists for that compnay return the company or create 
    //a new Account for that company
    public static Account findOrCreateAccountByCompanyName(List<Account> accounts){
        //Find or Create Account by using Company Name
        Account account = accounts.get(0);
        Account findAccountComp = new Account();
        //Calling Accounts by Company Name menthod
        findAccountComp = getAccountByCompanyName(accounts);
        //Checking if Account exists        
        if (findAccountComp == null) {
            //IF Account is not found, creating a new Account
            findAccountComp = createAccount(accounts);
        }
        //Returns Account
        return findAccountComp;
    }
    
    //Look up for an Account based on Company name and Contact based on Email and Account if not existing then create 
    //a new Account and new Contact
     public static Contact findOrCreateAccountAndContact(List<Account> accounts, List<Contact> contacts, Boolean accountByName) {
        //Find or Create Account, Find or Create Contact
        Account findAccountComp = new Account();
        Account account = accounts.get(0);
        Contact contact = contacts.get(0); 
        //Checking if the accountByName is True or False
        if (accountByName){
            //If account is set to True will call find or create Account by company name method
        //    findAccountComp = findOrCreateAccountByCompanyName(account);
            findAccountComp = findOrCreateAccountByCompanyName(accounts);
        }  
        Contact contactEmail = new Contact();
        //Calling get contact by email menthod
        List<Account> findAccountComps = new List<Account>();
        findAccountComps.add(findAccountComp); 
        contactEmail = getContactByEmail(findAccountComps, contacts);
               
        //If contact is not found will create a Contact
        if (contactEmail == null) {
            //Calling create contact method
            List<Account> accountForContact = new List<Account>();
            accountForContact.add(findAccountComp);
            List<Contact> contactToAdd = new List<Contact>();
            contactToAdd.add(contact);
            contactEmail = createContact(accountForContact,contactToAdd );         
        }
        
        //Returning Contact
        return contactEmail;
    }
    
    //Upsert a contact from user based on the Federated Id
    
    @future
    public static void CreateOrUpdateGsaContactFromUser(List<String> serializedNewUsers,List<String> serializedOldUsers){
        //Contact which will be upserted
        List<Contact> upsertContacts = new List<Contact>();
        List<Contact> inactiveContacts = new List<Contact>();
        Boolean isContactCreated = true;
        String content = 'The following Contact records were not created/updated for their respective User records: \r\n';
            
        //Get Account for Name 'General Services Administration' and record type 'Account' 
        
        String accountId = getAppPropertiesValuesByType(GSAACCOUNTID).get(0);
        String recordTypeId = getAppPropertiesValuesByType(GSACONTACTRECORDTYPEID).get(0);
        //Interate through the serialized users and create a list of users who are active and those who are inactive
        List<User> updatedUsers = new List<User>();
        Map<Id,User> oldUsers = new Map<Id,User>();
        Set<String> supervisorEmails = new Set<String>();
        
        List<User> inactiveUsers = new List<User>();
        
        for(String serializedNewUser: serializedNewUsers){
            User eachUser = new User();
            eachUser = (User) JSON.deserialize(serializedNewUser, User.class);
            updatedUsers.add(eachUser);
            supervisorEmails.add(eachUser.Supervisor_Email__c); 
        }
        if(!serializedOldUsers.isEmpty()){
            for(String serializedOldUser : serializedOldUsers){
                User oldUser = (User) JSON.deserialize(serializedOldUser, User.class);
                oldUsers.put(oldUser.Id, oldUser);
                System.debug('OldUser: '+oldUser.Id);
            }
        }
        List<User> supervisorUsers = [Select Id, FederationIdentifier, Email from User 
                                      Where Email in : supervisorEmails];
        //Create a map that will hold the User Id and the Federated Id of the Supervisor
        Map<Id,String> userToSupervisorFedId = new Map<Id,String>();
        //Populate the Map
        for(User eachUser : updatedUsers){
            for(User supervisor: supervisorUsers){
                if(eachUser.Supervisor_Email__c == supervisor.Email){
                    userToSupervisorFedId.put(eachUser.Id, supervisor.FederationIdentifier);
                }
            }
        }
        for(User modifiedUser: updatedUsers){  
            //Contact that will be lookedup, using the Federated Id from user
            Contact contactFound = new Contact();
            
            //Check if the the profile of the User belongs to a list of profiles given in the custom setting 
            if(getContactSyncProfileIds().contains(modifiedUser.ProfileId)){
                //If Fed Id is blank and the previous Fed Id is also blank for an inactive User then do not make any change
                //to the User
                String fedId;
                if(modifiedUser.IsActive){
                    fedId = modifiedUser.FederationIdentifier;
                }else{
                    fedId = oldUsers.get(modifiedUser.Id).FederationIdentifier;
                }
                System.debug('Fed Id Queried: '+fedId);
                //Populate the Upsert list
                if(!(fedId == '' || fedId == NULL)){
                    contactFound = getContactByFederatedId(accountId,fedId,recordTypeId);
                    //for Active Users who have a Fed Id
                    if(modifiedUser.IsActive){
                        //Get the contact record for the user's Fed Id and account's id
                        
                        List<Contact> contactAdded = new List<Contact>();
                        List<Contact> supervisors= new List<Contact>();
                        if(userToSupervisorFedId.containsKey(modifiedUser.Id)){
                            supervisors.add(getContactByFederatedId(accountId,userToSupervisorFedId.get(modifiedUser.Id),recordTypeId));
                        }
                        //If User is in the listed profile and there is no existing contact for that user create a new contact object
                        List<User> modifiedUsers = new List<User>();
                        List<Contact> contacts = new List<Contact>();
                        if(contactFound == null){
                
                            //Populate the Contact to be inserted from User, this will be a new record
                            System.debug('New Active Contact should be created: '+ modifiedUser.FederationIdentifier);
                            contacts.add(new Contact());
                            modifiedUsers.add(modifiedUser);
                            contactAdded = populateContactFromUserAndAccount(modifiedUsers,accountId,contacts,supervisors,recordTypeId);
                        }//there is a contact for the Fed Id
                        else{
                    
                            //If User is in the listed profile and there is a contact for that user update the existing contact with any 
                            //new information from the user.
                            System.debug('Active Contact should be updated: '+ modifiedUser.FederationIdentifier);
                            contacts.add(contactFound);
                            modifiedUsers.add(modifiedUser);
                            contactAdded = populateContactFromUserAndAccount(modifiedUsers,accountId,contacts,supervisors,recordTypeId);
                        } 
                        upsertContacts.add(contactAdded.get(0)); 
                    }//Update the Inactive User, clear Fed Id and append Fed to the email
                    else{
                        //Federated Id field will have a blank value, hence an upsert is not possible on this list
                        //of Inactive Users. A new list is created and then updated.
                            System.debug('InActive Contact should be updated using old fedid: '+ fedId);
                            List<Contact> contactAdded = new List<Contact>();
                            List<Contact> supervisors= new List<Contact>();
                            if(userToSupervisorFedId.containsKey(modifiedUser.Id)){
                                supervisors.add(getContactByFederatedId(accountId,userToSupervisorFedId.get(modifiedUser.Id),recordTypeId));
                            }
                            //If User is in the listed profile and there is no existing contact for that user create a new contact object
                            List<User> modifiedUsers = new List<User>();
                            List<Contact> contacts = new List<Contact>();
                            contacts.add(contactFound);
                            modifiedUsers.add(modifiedUser);
                            contactAdded = populateContactFromUserAndAccount(modifiedUsers,accountId,contacts,supervisors,recordTypeId);
                            contactAdded.get(0).Email = modifiedUser.Email + FedId;
                            contactAdded.get(0).Contact_Federated_ID__c = '';
                            inactiveContacts.add(contactAdded.get(0));    
                        
                        
                    }
                }//if User is active and current Fed Id is blank or User is Inactive and old Fed Id is blank then Contact is not Upserted
                else{
                    System.debug('Contact not created: isActive: ' + modifiedUser.isActive + ' fed Id: ' + fedId);
           
                }
            } 
        }
        //Upsert All Contacts
        //For any Contact that was not created the user has to be still created
        //Creation of a User record and Contact record are independent of each other
        if(upsertContacts.size() > 0){
            List<Database.UpsertResult> upsertResults = new List<Database.UpsertResult>();
            
            Schema.SObjectField externalId = Contact.Fields.Contact_Federated_ID__c;
            
            //upsertResult will contain data regarding each insert/update of contact
            //Any contact that failed the upsert can be retrieved from upsertResult
            upsertResults = Database.upsert(upsertContacts, externalId, false);
            
            //List the Contacts that were not created/updated
            
   			Integer contactIndex = 0;
            for(Database.UpsertResult upsertResult : upsertResults){
                
                if(!upsertResult.isSuccess()){
                        
                    System.debug('Contact fields that were not created or updated: ' + upsertContacts.get(contactIndex).LastName + ' '  
                                      + upsertContacts.get(contactIndex).FirstName + ' '
                                    + upsertContacts.get(contactIndex).Email + ' Error: '+upsertResult.getErrors().get(0));
                    
                }
                contactIndex++;
            }
   
        } 
        //IF THERE ARE INACTIVE USERS THEN UPDATE THE CONTACT
        if(!inactiveContacts.isEmpty()){
            List<Database.SaveResult> updateResults = Database.update(inactiveContacts,false);
        
            Integer contactIndex = 0;
        	//LOOP THRU THE RESULT SET TO SEE IF THERE IS ANY UNSUCCESSFULL UPDATE AND SEND EMAIL NOTIFICATION
            for (Database.SaveResult updateResult : updateResults) {
                if (!updateResult.isSuccess()) {
                               
                        System.debug('Contact fields that were not created or updated: ' + inactiveContacts.get(contactIndex).LastName + ' '  
                                      + inactiveContacts.get(contactIndex).FirstName + ' '
                                    + inactiveContacts.get(contactIndex).Email + ' Error: '+ updateResult.getErrors().get(0));
                }
                contactIndex++;
            }
      
        }
    
    }

    //Populate the contact object with data from the user and account objects
    private static List<Contact> populateContactFromUserAndAccount(List<User> users, String accountId, 
                                                                   List<Contact> populatedContacts, List<Contact> supervisors,String recordTypeId)
    {
        
        //Set values for fields that are mapped between the user,account and contact objects
        User user = users.get(0);
        Contact populatedContact = populatedContacts.get(0);
        populatedContact.AccountId = accountId;
        populatedContact.Affiliation__c = user.Affiliation__c;
        populatedContact.CHRIS_ID__c = user.CHRIS_ID__c;
        populatedContact.Contact_GSA_Short_Symbol__c = user.Division;
        populatedContact.Contact_ID__c = user.Contact_ID__c;
        populatedContact.Contact_Middle_Name__c = user.Middle_Name__c;
        populatedContact.Contact_Organization_Name__c = user.User_Organization_Name__c;
        populatedContact.Contact_Region__c = user.User_Region__c;
        populatedContact.Email = user.Email;
        populatedContact.Contact_Federated_ID__c = user.FederationIdentifier;
        populatedContact.Fax = user.Fax;
        populatedContact.FirstName = user.FirstName;
        populatedContact.GOVTPOC_COTAR__c = user.GOVTPOC_COTAR__c;        
        populatedContact.LastName = user.LastName;
        populatedContact.MailingCity = user.City;
        populatedContact.MailingCountry = user.Country;
        populatedContact.MailingPostalCode = user.PostalCode;
        populatedContact.MailingState = user.State;
        populatedContact.MailingStreet = user.Street;
        populatedContact.MAJOR_ORG__c = user.MAJOR_ORG__c;
        populatedContact.MAJOR_ORG_DESCRIPTION__c = user.MAJOR_ORG_DESCRIPTION__c;
        populatedContact.MobilePhone = user.MobilePhone;
        populatedContact.Nickname__c = user.Nickname__c;
        populatedContact.Phone = user.Phone;
        populatedContact.Title = user.Title;
        populatedContact.UPN__c = user.UPN__c;
        populatedContact.WORK_BUILDING_PRIMARY__c = user.WORK_BUILDING_PRIMARY__c;       
        populatedContact.Supervisory_Status__c = user.Supervisory_Status__c; // This line added by jlyon@acumensolutions.com for OHRM's New Supervisor surveys.
 
        if(supervisors.size() > 0){
            populatedContact.Supervisor__c = supervisors.get(0).Id;    
        }
        else{
            populatedContact.Supervisor__c = null;
            System.debug('Supervisor not in Contact');
        }
        populatedContact.Person_Separation_Date__c = user.Person_Separation_Date__c;
        populatedContact.Person_Start_Date__c=user.Person_Start_Date__c;
        
        populatedContact.RecordTypeId = recordTypeId;
        populatedContact.isActive__c = user.isActive;

        
        return populatedContacts;
    }
    
    
     //Get the profile Ids for a given name  
     public static Set<Id> getContactSyncProfileIds(){
        List<String> validUserProfiles = getAppPropertiesValuesByType(CONTACTSYNCPROFILE);
         
        List<Profile> profileList = [Select p.Id From Profile p where p.NAME IN: validUserProfiles];
        Set<Id> profileIds = new Set<Id>();
        for(Profile profile : profileList){
            profileIds.add(profile.Id);
        }
        return profileIds;        
    }
    
    public static List<String> getAppPropertiesValuesByType(String typeName){
        List<String> userProfiles = new List<String>();
        List<App_Properties__c> propertyValues = [Select Value__c from App_Properties__c where Type__c = :typeName];
        
        if(propertyValues.isEmpty()){
            userProfiles = null;
        }else{
            for(App_Properties__c propertyValue : propertyValues){
                userProfiles.add(propertyValue.Value__c);
            }
        }
        return userProfiles;
    }
    
    //No two contacts can have the same email id, this is validated before a new contact is created
    public static void validateUniqueEmails(List<Contact> triggerNew, Map<Id, Contact> triggerOldMap)
    {
        //Id nonGsaTypeId = ContactUtility.NON_GSA_RECORDTYPE;
        Id nonGsaTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        //Make sure that I don't error when I call the oldMap.get later
        if (triggerOldMap == null)
            triggerOldMap = new Map<Id, Contact>();
        
        //Get a Set of all of the different Emails being put into the database
        Set<String> emails = new Set<String>();
        System.debug('Trigger Size: ' + triggerNew.size());
        for (Contact cont: triggerNew)
        {
            Contact oldCont = triggerOldMap.get(cont.Id);
            if (cont.Email != null){
                if ((oldCont == null || cont.Email != oldCont.Email) && cont.RecordTypeId == nonGsaTypeId && cont.Public_Engagement_Is_Public_Engagement__c)
                {
                    
                    if (!emails.contains(cont.Email)) {
                        System.debug('Emails in for loop: ' + emails.size());
                        emails.add(cont.Email);
                    }
                    else {
                        cont.addError('Duplicate emails being added together.  Only the first will be added.');
                        
                    }
                    system.debug('emails---------------->' + emails);
                }
            }
        }
        
        //Get a Set of Emails that already exist in the system
        Set<String> similarEmails = new Set<String>();
        for (Contact cont: [SELECT Email FROM Contact WHERE Email IN: emails AND RecordTypeId =: nonGsaTypeId AND Public_Engagement_Is_Public_Engagement__c = true])
        {
            similarEmails.add(cont.Email);
            system.debug('similarEmails-------------------->' + similarEmails);
        }
        
        for (Contact cont: triggerNew)
        {
            Contact oldCont = triggerOldMap.get(cont.Id);
            if (cont.Email != null){
                if ((oldCont == null || cont.Email != oldCont.Email) && cont.RecordTypeId == nonGsaTypeId && cont.Public_Engagement_Is_Public_Engagement__c)
                {
                    if (similarEmails.contains(cont.Email))
                    {
                        cont.addError('A Public Engagement Contact with the same email address exists. Please check.');
                    }
                }
            }
        }
    }
}