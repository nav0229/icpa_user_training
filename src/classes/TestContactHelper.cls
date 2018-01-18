/*-------------------------------------------------------------------------------------------------*
  Test class for ContactHelper - VOE OHRM surveys functionality
  Contact Manager - VOE OHRM Surveys
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/17/2015    1.1     created.
  GaneshKumar Mandava    08/24/2017        Modified the test class as per best practices
 *-------------------------------------------------------------------------------------------------* 
 *-------------------------------------------------------------------------------------------------*/
@isTest(seealldata=false)
private class TestContactHelper {
    // setup method for creating the respective records for the testing
    @testSetup 
    static void testdata() {
    
        Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Account').getRecordTypeId();
        Id conRecTypId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
        Id profId = [SELECT Id FROM Profile WHERE Name = 'GSA System Administrator'].Id;
        PublicUserGroupHandler.disableGroupMemberRecalculation = true;
        List<User> collUsers = new List<User>();
        collUsers.add(testutil.buildUser(1,profId,'testuser1@test.com'));
        collUsers.add(testutil.buildUser(2,profId,'testuser2@test.com'));
        insert collUsers;
        
        User employee = [SELECT Id, firstname,lastname,Email, FederationIdentifier FROM User 
                            WHERE email ='testuser1@test.com' LIMIT 1];
        User supervisor = [SELECT Id,firstname,lastname, Email, FederationIdentifier FROM User 
                            WHERE email = 'testuser2@test.com' LIMIT 1];
                            
        Account acct = TestUtil.buildAccount('GSA', accRecTypId);
        insert acct;
        system.assertnotEquals(null, acct.id);

        // insert contact for supervisor
        Contact cont2 = new Contact();
        cont2.LastName = 'KumarSupervisor1';
        cont2.FirstName = 'Raj1';
        cont2.Email='testsupervisor1@gsa.gov';
        cont2.RecordTypeId = conRecTypId;
        cont2.Person_Start_Date__c = Date.today()-1;
        cont2.Contact_Federated_ID__c = supervisor.FederationIdentifier;
        cont2.AccountId = acct.id;
        insert cont2;
        
        // insert contact for employee
        Contact cont = new Contact();
        cont.LastName = 'Kumar2';
        cont.FirstName = 'Raj2';
        cont.Email='testemployee1@gsa.gov';
        cont.RecordTypeId = conRecTypId;
        cont.Person_Start_Date__c = Date.today();
        cont.Contact_Federated_ID__c = employee.FederationIdentifier;
        cont.Supervisor__c=cont2.Id;  
        cont.AccountId = acct.Id; 
        cont.Supervisory_Status__c = 2;
        insert cont; 
        
        List<Contact> contacts = new List<Contact>();
        // for bulk testing
        List<User> sfdcUsers = [SELECT Id, Email, FederationIdentifier FROM User 
                            WHERE Id != :UserInfo.getUserId() 
                            AND ProfileId IN (SELECT Id FROM Profile WHERE Name='GSA Standard Salesforce User') 
                            AND IsActive = true LIMIT 200];
        for(Integer i=0;i<200;i++) {
            contacts.add(new Contact(LastName='TestRKP'+i, FirstName='TestKP'+i, RecordTypeId=conRecTypId, 
                            Contact_Federated_ID__c = sfdcUsers[i].FederationIdentifier, Supervisor__c=cont2.Id,
                            Email='rajkpOHRMbulktest'+i+'@gsa.gov', AccountId= acct.Id)); 
        }
        insert contacts;
        
    }
    
  
    // method to validate the trigger email tracker entries for non-30 Day NH Survey - text status value
    static testmethod void testContactSurveyStatusNoChange() {
        List<Contact> contacts = new List<Contact>();
        contacts = [SELECT Id, NewHireEmailTextStatuses__c FROM Contact WHERE Email ='testemployee1@gsa.gov']; 
        test.startTest();
        for(Contact c: contacts) {
            c.NewHireEmailTextStatuses__c = 'NH_30 Day Sent';
            c.Supervisory_Status__c = 2;
        }
        update contacts;
        for(Contact c: contacts) {
            c.NewHireEmailTextStatuses__c = 'NH_30 Day Sent;NH_60 Day Sent';
        }
        update contacts;
        List<Contact> supercontacts = new List<Contact>();
        supercontacts = [SELECT Id FROM Contact WHERE Email='testsupervisor1@gsa.gov'];
        // asserting
        List<EmailTracker__c> etExtract = new List<EmailTracker__c>();
        etExtract = [SELECT Id FROM EmailTracker__c WHERE Purpose__c='Initial Send' 
                        /*AND SurveyURL__c!= null */ AND ToContact__c=:supercontacts[0].Id];
        test.stoptest();
        System.assertEquals(1, etExtract.size());
    }
    
   // method to validate the bulk records for 30 Day NH Survey
    static testmethod void testBulkContactSurveyStatusChange() {
        List<Contact> contacts = new List<Contact>();
        contacts = [SELECT Id, NewHireEmailTextStatuses__c FROM Contact WHERE Email LIKE 'rajkpOHRMbulktest%']; 
        test.startTest();
        for(Contact c: contacts) {
            c.NewHireEmailTextStatuses__c = 'NH_30 Day Sent';
        }
        update contacts;
        List<Contact> supercontacts = new List<Contact>();
        supercontacts = [SELECT Id FROM Contact WHERE Email='testsupervisor1@gsa.gov'];
        // asserting
        List<EmailTracker__c> etExtract = new List<EmailTracker__c>();
        etExtract = [SELECT Id FROM EmailTracker__c WHERE Purpose__c='Initial Send' 
                       /* AND SurveyURL__c!= null */  AND ToContact__c=:supercontacts[0].Id];
        test.stopTest();
        System.assertEquals(200, etExtract.size());
    } 
}