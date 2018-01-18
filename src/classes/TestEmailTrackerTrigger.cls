/*-------------------------------------------------------------------------------------------------*
  Test class for EmailTrackerHelper and Trigger - VOE OHRM surveys functionality
  Contact Manager - VOE OHRM Surveys
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/17/2015    1.1     created.

 *-------------------------------------------------------------------------------------------------* 
 *-------------------------------------------------------------------------------------------------*/
@isTest
public class TestEmailTrackerTrigger {
    // setup method for creating the respective records for the testing
    @testSetup public static void dataPrep() {
        RecordType rt = [SELECT Id,Name, DeveloperName 
                         FROM RecordType 
                         WHERE SobjectType='Account' AND DeveloperName='Account' LIMIT 1];
        RecordType contRT = [SELECT Id, Name, DeveloperName, SObjectType 
                             FROM RecordType 
                             WHERE SObjectType='Contact' AND DeveloperName ='GSA' LIMIT 1];
        User u = [SELECT Id, Email, FederationIdentifier FROM User WHERE Id = :UserInfo.getUserId() AND IsActive = true LIMIT 1];
        User otheruser = [SELECT Id, Email, FederationIdentifier FROM User 
                            WHERE Id != :UserInfo.getUserId() 
                            AND ProfileId IN (SELECT Id FROM Profile WHERE Name='GSA Standard Salesforce User') 
                            AND IsActive = true LIMIT 1];
        User othersfuser = [SELECT Id, Email, FederationIdentifier FROM User 
                            WHERE Id != :UserInfo.getUserId() 
                            AND ProfileId IN (SELECT Id FROM Profile WHERE Name='GSA Standard Platform User') 
                            AND IsActive = true LIMIT 1];                    
        Account acct = new Account();
        acct.Name='GSA';
        acct.RecordTypeId = rt.Id;
        // insert account
        insert acct;
        Contact cont2 = new Contact();
        cont2.LastName = 'KumarSupervisor';
        cont2.FirstName = 'Raj';
        cont2.Email='raj.testsupervisor@gsa.gov';
        cont2.RecordTypeId = contRT.Id;
        cont2.AccountId = acct.Id;
        // insert contact for supervisor
        insert cont2;
        Contact cont = new Contact();
        cont.LastName = 'KumarEmp';
        cont.FirstName = 'Raj';
        cont.Email='raj.testemployee@gsa.gov';
        cont.RecordTypeId = contRT.Id;
        cont.Person_Start_Date__c=Date.today();
        cont.Contact_Federated_ID__c=u.FederationIdentifier;
        cont.Supervisor__c=cont2.Id;
        cont.AccountId = acct.Id;               
        // insert contact for employee
        insert cont;
        Contact cont1 = new Contact();
        cont1.LastName = 'KumarEmp1';
        cont1.FirstName = 'Raj';
        cont1.Email='raj.testemployee1@gsa.gov';
        cont1.RecordTypeId = contRT.Id;
        cont1.Person_Start_Date__c=Date.today();
        cont1.Contact_Federated_ID__c=otheruser.FederationIdentifier;
        cont1.Supervisor__c=cont2.Id;
        cont1.AccountId = acct.Id;               
        // insert contact for employee1
        insert cont1;
        List<EmailTracker__c> etracker = new List<EmailTracker__c>();
        for(Integer i=0;i<1;i++) {
            etracker.add(new EmailTracker__c(Status__c='Sent',
                                        Type__c='VOE - Hiring Manager Survey',
                                        SurveyURL__c='http://www.clicktools.com',
                                        ToContact__c=cont.Id,
                                        SendDate__c=Date.today()));
        }
        insert etracker;
        // for bulk email trackers purpose
        List<EmailTracker__c> etrackers = new List<EmailTracker__c>();
        for(Integer i=0;i<200;i++) {
            etrackers.add(new EmailTracker__c(Status__c='Sent',
                                        Type__c='VOE - Hiring Manager Survey',
                                        SurveyURL__c='http://www.clicktools.com',
                                        ToContact__c=cont1.Id,
                                        SendDate__c=Date.today()));
        }
        insert etrackers;
        System.assertEquals(true,true);
    }
    
    // method to validate the trigger owners - Logged in user/running user
    @isTest public static void testOwnerSameAsToContactId() {
        Contact cont = [SELECT Id, Email FROM Contact WHERE Email ='raj.testemployee@gsa.gov' LIMIT 1];
        List<EmailTracker__c> etExtract = [SELECT Id, OwnerId 
                                            FROM EmailTracker__c 
                                            WHERE ToContact__c=:cont.Id AND OwnerId =:UserInfo.getUserId()];
        System.assertEquals(3, etExtract.size());
    }
    
    // method to validate the reminder EmailTracker records - count=2
    @isTest public static void testReminderRecordsCount() {
        Contact cont = [SELECT Id, Email FROM Contact WHERE Email ='raj.testemployee@gsa.gov' LIMIT 1];
        List<EmailTracker__c> etExtract = [SELECT Id, OwnerId, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE ToContact__c=:cont.Id AND Purpose__c='Reminder'];
        System.assertEquals(2, etExtract.size());
    }
    
    // method to validate the reminder deleted reminders - count=0
    @isTest public static void testEmailTrackerStatusChanged() {
        Contact cont = [SELECT Id, Email FROM Contact WHERE Email ='raj.testemployee@gsa.gov' LIMIT 1];
        List<EmailTracker__c> etrecords = [SELECT Id, Status__c, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE ToContact__c=:cont.Id AND Purpose__c='Initial Send'];
        for(EmailTracker__c et: etrecords) {
            et.Status__c='Responded';
        }
        update etrecords;
        List<EmailTracker__c> etreminders = [SELECT Id, Status__c, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE Purpose__c='Reminder' AND Parent__c =:etrecords[0].Id];   
        System.assertEquals(0, etreminders.size());
    }
    
    // method to validate the Bulk reminder EmailTracker records - count=400
    @isTest public static void testBulkReminderRecordsCount() {
        Contact cont = [SELECT Id, Email FROM Contact WHERE Email ='raj.testemployee1@gsa.gov' LIMIT 1];
        List<EmailTracker__c> etExtract = [SELECT Id, OwnerId, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE ToContact__c=:cont.Id AND Purpose__c='Reminder'];
        System.assertEquals(400, etExtract.size());
        List<EmailTracker__c> etExtract2 = [SELECT Id, OwnerId, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE ToContact__c=:cont.Id AND Purpose__c='Initial Send'];
        System.assertEquals(200, etExtract2.size());
    }
    
    // method to validate the Bulk deleted reminders - count=0
    @isTest public static void testBulkEmailTrackerStatusChanged() {
        Contact cont = [SELECT Id, Email FROM Contact WHERE Email ='raj.testemployee1@gsa.gov' LIMIT 1];
        List<EmailTracker__c> etrecords = [SELECT Id, Status__c, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE ToContact__c=:cont.Id AND Purpose__c='Initial Send'];
        for(EmailTracker__c et: etrecords) {
            et.Status__c='Responded';
        }
        update etrecords;
        List<EmailTracker__c> etreminders = [SELECT Id, Status__c, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE Purpose__c='Reminder' AND ToContact__c=:cont.Id];   
        System.assertEquals(0, etreminders.size());
        List<EmailTracker__c> etreminders1 = [SELECT Id, Status__c, Purpose__c 
                                            FROM EmailTracker__c 
                                            WHERE Purpose__c='Initial Send' AND Status__c='Responded'];   
        System.assertEquals(200, etreminders1.size());
    }

}