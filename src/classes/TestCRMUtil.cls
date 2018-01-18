@isTest(SeeAllData=true)
public  class TestCRMUtil {
    Static String profileId = [Select Name from Profile where Name = 'GSA Standard Platform User'].Id;
    
    //Test if the method getAccountByCompanyName() returns a valid account
    static testMethod void getAccountByCompanyName() {
        Account account = new Account();
        account.Name = 'TestAccountName';
        RecordType record = [Select id from RecordType where SObjectType = 'Account' LIMIT 1];
        account.RecordTypeId = record.id;
        List<Account> accounts = new List<Account>();
        accounts.add(account);
        insert accounts;
        //For a valid account
        system.assertEquals(account.Name, CRMUtil.getAccountByCompanyName(accounts).Name);
        account.Name = String.valueof(DateTime.now());
        //For Account that does not exist
        system.assertEquals(null, CRMUtil.getAccountByCompanyName(accounts));
    }
    
    //Test if the method getAccountByCompanyName()  for an account and record type returns a valid account
    static testMethod void getAccountByNameAndRecordtype() {
        Account account = new Account();
        account.Name = 'TestAccountName';
        RecordType record = [Select id from RecordType where SObjectType = 'Account' LIMIT 1];
        account.RecordTypeId = record.id;
        insert account;
        
        //For a valid account
        system.assertEquals(account.Name, CRMUtil.getAccountByNameAndRecordtype(account.Name,record.id).Name);
        
        //For Account that does not exist
        account.Name = String.valueof(DateTime.now());
        system.assertEquals(null, CRMUtil.getAccountByNameAndRecordtype(account.Name,record.id));
    }
    
    //Test Create Account
    static testMethod void createAccount() {
        List<Account> accounts = new List<Account>();
        accounts.add(populateAccount());
        Account account = accounts.get(0);
        Account accountCreated = CRMUtil.createAccount(accounts);
        Account accountQueried = [Select Name, id from Account where Account.Name =: account.Name];
        //Assert the creation of a valid account
        system.assertEquals(accountCreated.Name, accountQueried.Name);
        //Assert the Account was not created
        account.Name = '';
        system.assertEquals(null,CRMUtil.createAccount(accounts));
    }
    
    //Test both get Contact by Email and get contact by email and account
    static testMethod void getContactByEmail() {
        Account account = [Select id from Account where Account.Name = 'General Services Administration' LIMIT 1];
        Contact contact = populateContact(account);
        List<Contact> contacts = new List<Contact>();
        contacts.add(contact);
        List<Account> accounts = new List<Account>();
        accounts.add(account);
        insert contacts;
        //Assert a contact is retrieved by providing the email
        system.assertEquals(contact.Email, CRMUtil.getContactByEmail(contacts).Email);
        //Assert a contact is retrieved by providing the email and account
        system.assertEquals(contact.Email, CRMUtil.getContactByEmail(accounts,contacts).Email);
        
        //Assert Null for a non existing contact
        contact.Email = String.valueOf(DateTime.now()) + '@email.com';
        system.assertEquals(null,CRMUtil.getContactByEmail(contacts));
        system.assertEquals(null,CRMUtil.getContactByEmail(accounts,contacts));
    }
    
    //Method to create an contact object 
    private static Contact populateContact(Account account){
        Contact returnContact = new Contact();
        returnContact.RecordType = [Select id, name from RecordType where RecordType.sobjecttype = 'Account' LIMIT 1];
        
        returnContact.AccountId = account.id;
        returnContact.LastName = 'TestLastName';
        returnContact.FirstName = 'TestFirstName';
        returnContact.Email = 'testemail@email.com';
        return returnContact;
    }
    
    //Method to create an account object
    private static Account populateAccount(){
        Account account = new Account();
        account.Name = 'TestAccountName';
        RecordType record = [Select id from RecordType where SObjectType = 'Account' LIMIT 1];
        account.RecordTypeId = record.id;
        return account;
    }
    
    //Create Contact
    static testMethod void createContact(){
        Account account = [Select id from Account where Account.Name = 'General Services Administration' LIMIT 1];
        Contact contact = populateContact(account);
        List<Account> accounts = new List<Account>();
        accounts.add(account);
        List<Contact> contacts = new List<Contact>();
        contacts.add(contact);
        Contact contactCreated = CRMUtil.createContact(accounts,contacts);
        Contact contactQueried = [Select id, Name, Email from Contact where LastName =: contact.LastName LIMIT 1];
        //Assert a new contact is created
        System.assertEquals(contactCreated.Email,contactQueried.Email);
        //Assert a contact is not created
        contact.LastName = '';
        System.assertEquals(null,CRMUtil.createContact(accounts,contacts));
                
    }
    
    //Test for creating an account by company if it does not exist
    static testMethod void findOrCreateAccountByCompanyName(){
        List<Account> newAccounts = new List<Account>();
        newAccounts.add(populateAccount());
        //Assert the creation of a new Account when the company does not exist
        System.assertEquals('TestAccountName', CRMUtil.findOrCreateAccountByCompanyName(newAccounts).Name);
        //Assert the retrieval of an account when the company exists
        newAccounts.get(0).Name = 'General Services Administration';
        System.assertEquals('General Services Administration',CRMUtil.findOrCreateAccountByCompanyName(newAccounts).Name);
    }
    
    //Test for creating an account/contact if it does not exist
    static TestMethod void findOrCreateAccountAndContact(){
        List<Account> accounts = new List<Account>();
        accounts.add(populateAccount());
        List<Contact> contacts = new List<Contact>();
        
        contacts.add(populateContact(accounts.get(0)));
        Contact contact = contacts.get(0);
        //Assert the creation of a new Account/Contact when the company does not exist
        System.assertEquals(contact.Email,CRMUtil.findOrCreateAccountAndContact(accounts,contacts,true).Email);
        //Assert the retrieval of an account/contact when the company exists
        
        System.assertEquals(contact.Email,CRMUtil.findOrCreateAccountAndContact(accounts,contacts,true).Email);
    }
    
    //Test for getting contact for federated Id
    static TestMethod void getContactByFederatedId(){
        Account account = populateAccount();
        Contact contact = populateContact(account);
        contact.Contact_Federated_ID__c = '482a7fc9-82b0-472e-8334-9d40d8cg375f';
        //Assert that no contact is retrieved for an invalid Fed Id 
        System.assertEquals(null,CRMUtil.getContactByFederatedId(account.id,contact.contact_Federated_Id__c));
        insert contact;
        
        //Assert a contact is retrieved for a valid Fed Id
        System.assertEquals(contact.LastName,CRMUtil.getContactByFederatedId(account.id,contact.contact_Federated_Id__c).LastName);
    }
    
    //Test to create contacts for users
    static TestMethod void CreateOrUpdateGsaContactFromUserNoFedId(){
        Contact queriedContact = new Contact();
        List<User> users = populateUser();
        users.get(0).FederationIdentifier = '';
        
        List<String> serializedUsers = new List<String>();
        for(User user : users){
            
            String serializedUser = JSON.serialize(user);
            serializedUsers.add(serializedUser);
        }
        Test.startTest();
        CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers,serializedUsers);
        Test.stopTest();
        List<Contact> queriedContacts = [Select id, Name from Contact where Email =: 'donald@email.com'];
        
        //Assert that a contact was not created for a user that did not have a Fed Id
        System.assertEquals(true,queriedContacts.isEmpty());
    }
    static TestMethod void CreateOrUpdateGsaContactFromUserForNewUser(){
        Contact queriedContact = new Contact();
        List<User> users = populateUser();
        List<String> serializedUsers = new List<String>();
        for(User user : users){
            
            String serializedUser = JSON.serialize(user);
            serializedUsers.add(serializedUser);
       
        }
        Test.startTest();
        CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers,serializedUsers);
        Test.stopTest();
        User quser = users.get(0);
        System.debug('User Info: ' + quser.FederationIdentifier);
        queriedContact = [Select id, Email from Contact where Contact_Federated_ID__c =: quser.FederationIdentifier LIMIT 1];
        //Assert a new COntact was created for a new User
        System.assertEquals(quser.Email,queriedContact.Email);
    }
    
    static TestMethod void CreateOrUpdateGsaContactFromUserForExistingContact(){
        Contact queriedContact = new Contact();
        List<Contact> newContact = new List<Contact>();
        Contact cont1 = new Contact();
        cont1.RecordTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        cont1.LastName = 'Smith';
        cont1.FirstName = 'Donald';
        cont1.Email = 'donald@email.com';
        cont1.Contact_Federated_ID__c = '482a7bc9-82d0-472e-8334-9d40d8cgabcd';
        cont1.AccountId = CRMUtil.getAppPropertiesValuesByType('GSAAccountId').get(0);
        
        newContact.add(cont1);
        insert newContact;
        List<User> users = populateUser();
      //  User quser = new User();
        List<String> serializedUsers = new List<String>();
        users = populateUser();
      //  users.get(0).Email = 'modifiedemail@email.com';
        users.get(0).IsActive = true;
        for(User user : users){
            
            String serializedUser = JSON.serialize(user);
            serializedUsers.add(serializedUser);
       
        }
        test.startTest();
        CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers,serializedUsers);
        test.stopTest();
        queriedContact = [Select id, Email from Contact where Contact_Federated_ID__c =: cont1.Contact_Federated_ID__c LIMIT 1];
        //Assert the existing contact was modified for a existing users
        System.assertEquals('donald@email.com',queriedContact.Email);
    }  
   
    static TestMethod void CreateOrUpdateGsaContactFromInactiveUser(){
        Contact queriedContact = new Contact();
        List<Contact> newContact = new List<Contact>();
        Contact cont1 = new Contact();
        cont1.RecordTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        cont1.LastName = 'Smith';
        cont1.FirstName = 'Donald';
        cont1.Email = 'donald@email.com';
        cont1.Contact_Federated_ID__c = '482a7bc9-82d0-472e-8334-9d40d8cgabcd';
        cont1.AccountId = CRMUtil.getAppPropertiesValuesByType('GSAAccountId').get(0);
        
        newContact.add(cont1);
        insert newContact;
        List<User> users = populateUser();
      //  User quser = new User();
        List<String> serializedUsers = new List<String>();
        users = populateUser();
      //  users.get(0).Email = 'modifiedemail@email.com';
        users.get(0).IsActive = false;
        users.get(0).FederationIdentifier = '';
        for(User user : users){
            
            String serializedUser = JSON.serialize(user);
            serializedUsers.add(serializedUser);
       
        }
        test.startTest();
        CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers,serializedUsers);
        test.stopTest();
        queriedContact = [Select id, isActive__c, Email from Contact where Email =: cont1.Email LIMIT 1];
        //Assert the existing contact was modified for a existing users
        System.assertEquals(false,queriedContact.isActive__c);
    } 
    
   //Populate the User object
   public static list<User> populateUser(){
       List<User> userReturned = new List<User>();
       User user = new User();
       user.Username='donald@email.com';
       user.Alias='DS';
       user.CommunityNickname='DS';
       user.TimeZoneSidKey='GMT';
       user.LocaleSidKey='en_US';
       user.EmailEncodingKey = 'ISO-8859-1';
       // user.ProfileId = '00e30000001jdgV' ;
       user.ProfileId = profileId;
       user.LastName='Smith';
       user.FirstName='Donald';
       user.Email='donald@email.com';
       user.LanguageLocaleKey = 'en_US';
       user.FederationIdentifier = '482a7bc9-82d0-472e-8334-9d40d8cgabcd';
       user.isActive=true;
       userReturned.add(user);      
       return userReturned;
    }
    
    static testMethod void testGetAppPropertiesValuesByType(){
        
        List<String> value = CRMUtil.getAppPropertiesValuesByType('GSAAccountId');
        System.assertEquals(false,value.isEmpty());
        value = CRMUtil.getAppPropertiesValuesByType('TestFalse');
        System.assertEquals(null,value);
    }
    
    /*
        This testmethod will create two Contacts.  The first Contact should be unique.
        The second Contact should fail on insertion because it uses the same email as the
        first Contact.
    */
    static testMethod void testUniqueEmails()
    {
        Contact cont = new Contact();
        //cont.RecordTypeId = ContactUtility.NON_GSA_RECORDTYPE;
        cont.RecordTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        cont.Public_Engagement_Is_Public_Engagement__c = true;
        cont.Public_Engagement_Region__c = '1';
        cont.LastName = 'Emailtester';
        cont.FirstName = 'Tester';
        cont.Email = 'Testeremail@testerz.com';
        insert cont;
        
        List<Contact> conts = new List<Contact>();
        //cont.RecordTypeId = ContactUtility.NON_GSA_RECORDTYPE;
        Contact cont1 = new Contact();
        cont1.RecordTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        cont1.Public_Engagement_Is_Public_Engagement__c = true;
        cont1.Public_Engagement_Region__c = '1';
        cont1.LastName = 'Emailtester1';
        cont1.FirstName = 'Tester1';
        cont1.Email = 'Testeremail@testerz.com';
        conts.add(cont1);
        
        
        Contact cont2 = new Contact();
        //cont2.RecordTypeId = ContactUtility.NON_GSA_RECORDTYPE;
        cont2.RecordTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        cont2.Public_Engagement_Is_Public_Engagement__c = true;
        cont2.Public_Engagement_Region__c = '1';
        cont2.LastName = 'Emailtester2';
        cont2.FirstName = 'Tester2';
        cont2.Email = '2testeremail@email.com';
        conts.add(cont2);
        
        Contact cont3 = new Contact();
        cont3.RecordTypeId = CRMUtil.NON_GSA_RECORDTYPE;        
        cont3.Public_Engagement_Is_Public_Engagement__c = true;
        cont3.Public_Engagement_Region__c = '1';
        cont3.LastName = 'Emailtester3';
        cont3.FirstName = 'Tester3';
        cont3.Email = '2testeremail@email.com';
        conts.add(cont3);
        //This insertion is EXPECTED to fail because there will be duplicate emails
        boolean didFail = false;
        try
        {
            System.debug('Contact Size: ' + conts.size());
            insert conts;
        }catch(Exception e)
        {
            didFail = true;
        }
        
        System.assert(didFail, 'The emails were allowed to be duplicated.');
    }
}