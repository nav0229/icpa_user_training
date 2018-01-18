/*-------------------------------------------------------------------------------
  TestIMTLeasingTrigger.cls
  Class for testing IMT Leasing trigger on Leasing object
  -------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------
  Rajakumar              08/12/2013  1.0       Initial version
  Rajakumar              09/09/2015  1.1       O&M Case# -20041
  Rajakumar              04/19/2016  1.2       O&M Case# -24343 
  -------------------------------------------------------------------------------
*/  
@isTest
private class TestIMTLeasingTrigger {
    // setup method for creating the respective records for the testing
    @testSetup public static void dataPrep() {    
        List<Leasing__c> leaselist = new List<Leasing__c>();
        List<Id> recordIds = new List<Id>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 7];
        
        PublicCalendarList__c pcal = new PublicCalendarList__c(Name='IMTCalendar',CalendarID__c='023300000053CAu');
        insert pcal;
        //PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar'); 
        for(Integer i=0;i<200;i++) {
            String prosnumber = 'LEASE-123' + String.valueOf(i);
            leaselist.add(new Leasing__c(Name='TriggerTestSample1',
                                        Prospectus_Number__c=prosnumber,Proposed_Lease_Award_Date__c=Date.Today(),
                                        Anticipated_Solicitation_Notification_Re__c=Date.Today()+2,
                                        Proposed_Rental_Rate__c=100,
                                        Proposed_Lease_Term_in_years__c=2,
                                        Region__c=1,
                                        Cilp_FY__c='2104',
                                        Proposed_RSF__c=2030,
                                        Project_Action__c='New',
                                        //Political_Status__c='New',
                                        //Agency__c='New',
                                        Project_Summary__c='project summary',
                                        Notes_Background__c='summary background',
                                        Location__c='F Street',
                                        City__c='Washington',
                                        State__c='DC',
                                        Current_Project_Phase__c='Requirements Development',
                                        Regional_POC__c=users[0].Id,
                                        Project_Number__c='1234',
                                        Proposed_Number_of_Employees__c=200,
                                        Proposed_Total_Annual_Cost__c=12345,
                                        Proposed_USF_Per_Person_all_in__c=12,
                                        Proposed_USF__c=123,
                                        Proposed_Office_Utilization_Rate__c=12));
        }
        for(Integer i=0;i<1;i++) {
            String prosnumber = 'LEASE123' + String.valueOf(i);
            leaselist.add(new Leasing__c(Name='TriggerTestSample2',
                                        Prospectus_Number__c=prosnumber,
                                        Proposed_Lease_Award_Date__c=Date.Today(),
                                        //Anticipated_Solicitation_Notification_Re__c=,
                                        Proposed_Rental_Rate__c=100,
                                        Proposed_Lease_Term_in_years__c=2,
                                        Region__c=1,
                                        Cilp_FY__c='2104',
                                        Proposed_RSF__c=2030,
                                        Project_Action__c='New',
                                        //Political_Status__c='New',
                                        //Agency__c='New',
                                        Project_Summary__c='project summary',
                                        Notes_Background__c='summary background',
                                        Location__c='F Street',
                                        City__c='Washington',
                                        State__c='DC',
                                        Current_Project_Phase__c='Requirements Development',
                                        Regional_POC__c=users[0].Id,
                                        Project_Number__c='1234',
                                        Proposed_Number_of_Employees__c=200,
                                        Proposed_Total_Annual_Cost__c=12345,
                                        Proposed_USF_Per_Person_all_in__c=12,
                                        Proposed_USF__c=123,
                                        Proposed_Office_Utilization_Rate__c=12));
        }
        for(Integer i=0;i<1;i++) {
            String prosnumber = 'LESE-123' + String.valueOf(i);
            leaselist.add(new Leasing__c(Name='TriggerTestSample3',
                                        Prospectus_Number__c=prosnumber,
                                        //Proposed_Lease_Award_Date__c=Date.Today(),
                                        Anticipated_Solicitation_Notification_Re__c=Date.today(),
                                        Proposed_Rental_Rate__c=100,
                                        Proposed_Lease_Term_in_years__c=2,
                                        Region__c=1,
                                        Cilp_FY__c='2104',
                                        Proposed_RSF__c=2030,
                                        Project_Action__c='New',
                                        //Political_Status__c='New',
                                        //Agency__c='New',
                                        Project_Summary__c='project summary',
                                        Notes_Background__c='summary background',
                                        Location__c='F Street',
                                        City__c='Washington',
                                        State__c='DC',
                                        Current_Project_Phase__c='Requirements Development',
                                        Regional_POC__c=users[0].Id,
                                        Project_Number__c='1234',
                                        Proposed_Number_of_Employees__c=200,
                                        Proposed_Total_Annual_Cost__c=12345,
                                        Proposed_USF_Per_Person_all_in__c=12,
                                        Proposed_USF__c=123,
                                        Proposed_Office_Utilization_Rate__c=12));
        }
        
        for(Integer i=0;i<1;i++) {
            String prosnumber = 'LEASES123' + String.valueOf(i);
            leaselist.add(new Leasing__c(Name='TriggerTestSample4',
                                        Prospectus_Number__c=prosnumber,
                                        //Proposed_Lease_Award_Date__c=Date.Today(),
                                        //Anticipated_Solicitation_Notification_Re__c=Date.today(),
                                        Proposed_Rental_Rate__c=100,
                                        Proposed_Lease_Term_in_years__c=2,
                                        Region__c=1,
                                        Cilp_FY__c='2104',
                                        Proposed_RSF__c=2030,
                                        Project_Action__c='New',
                                        //Political_Status__c='New',
                                        //Agency__c='New',
                                        Project_Summary__c='project summary',
                                        Notes_Background__c='summary background',
                                        Location__c='F Street',
                                        City__c='Washington',
                                        State__c='DC',
                                        Current_Project_Phase__c='Requirements Development',
                                        Regional_POC__c=users[0].Id,
                                        Project_Number__c='1234',
                                        Proposed_Number_of_Employees__c=200,
                                        Proposed_Total_Annual_Cost__c=12345,
                                        Proposed_USF_Per_Person_all_in__c=12,
                                        Proposed_USF__c=123,
                                        Proposed_Office_Utilization_Rate__c=12));
        }
        insert leaselist;
        System.assertEquals(true,true);
    }
    @isTest public static void testBulkInsertLeasing() {
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> extract = [Select Id, Name FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: extract) {
            recordids.add(c.Id);
        }
        // for only 50 records, 100 events and 2 for each record
        List<Event> eventslst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(400,eventslst.size());
    }
    // for testing the bulk update prospectus number to verify the limits
    @isTest public static void testBulkUpdatePropectusNumber() {
        List<Leasing__c> leaseList = new List<Leasing__c>();
        Integer i=0;
        for(Leasing__c l : [SELECT Id, Prospectus_Number__c FROM Leasing__c WHERE Name='TriggerTestSample1']) {
            l.Prospectus_Number__c = 'LEASE-223'+String.valueOf(i++);
            leaseList.add(l);            
        }
        Test.startTest();
        update leaseList;
        Test.stopTest();
        System.assertEquals(200, [SELECT Id FROM Leasing__c WHERE Prospectus_Number__c LIKE 'LEASE-223%'].size());
    }
    // for testing the bulk update ownerid to verify the limits
    @isTest public static void testBulkUpdateOwnerId() {
        List<Leasing__c> leaseList = new List<Leasing__c>();
        Integer i=0;
        User otherAdmUser = [SELECT Id FROM User WHERE Profile.Name='GSA System Administrator' AND IsActive=true 
                             AND Id != :UserInfo.getUserId() LIMIT 1];
        for(Leasing__c l : [SELECT Id, Prospectus_Number__c FROM Leasing__c WHERE Name='TriggerTestSample1']) {
            l.OwnerId = otherAdmUser.Id;
            leaseList.add(l);            
        }
        Test.startTest();
        update leaseList;
        Test.stopTest();
        System.assertEquals(200, [SELECT Id FROM Leasing__c WHERE OwnerId =:otherAdmUser.Id].size());
    }
    // for testing the validation rule for prospectus number and owner id fields.
    @isTest public static void testPropectusAndOwnerValidation() {
        Set<Id> userIdsExclude = new Set<Id>();
        Set<Id> userIdsInclude = new Set<Id>();
        // for excluding the existing users in the CO Editors and CO Superusers group
        for(GroupMember gm : [SELECT UserOrGroupId FROM GroupMember WHERE Group.Name IN('IMT Leasing-CO-Editors','IMT Leasing-CO-Superusers')]) {
            userIdsExclude.add(gm.UserOrGroupId);
        }
        Group grp = new Group();
        grp = [SELECT Id FROM Group WHERE DeveloperName='IMT_Leasing_R1_Editors' LIMIT 1];        
        PermissionSet pset = new PermissionSet();
        pset = [SELECT Id FROM PermissionSet WHERE Name='IMT_Leasing_CO_Users_CRE'];
        // for excluding the existing users in the CO Users CRE permission set
        for(PermissionSetAssignment pa : [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId = :pset.Id AND Assignee.IsActive = true]) {
            userIdsExclude.add(pa.AssigneeId);
        }     
        // for listing one user who is not in the 2 public groups and 1 permission set.
        List<User> users = [SELECT Id FROM User WHERE Id NOT IN :userIdsExclude AND IsActive = true 
                            AND Profile.Name ='GSA Standard Salesforce User' LIMIT 1];
        // adding necessary groups and permission sets to our sample running test user
        GroupMember gm = new GroupMember(UserOrGroupId=users[0].Id, GroupId=grp.Id);
        insert gm;
        PermissionSetAssignment passign = new PermissionSetAssignment(AssigneeId=users[0].Id, PermissionSetId=pset.Id);
        insert passign;
        // test the functionality as running standard user
        System.runAs(users[0]) {
            List<Leasing__c> leaseList = new List<Leasing__c>();
            User admUser = [SELECT Id FROM User WHERE Profile.Name ='GSA System Administrator' AND IsActive=true LIMIT 1];
            for(Integer i=0;i<1;i++) {
                String prosnumber = 'LESE-123T' + String.valueOf(i);
                leaselist.add(new Leasing__c(Name='TriggerTestUser1',
                                        Prospectus_Number__c=prosnumber,
                                        //Proposed_Lease_Award_Date__c=Date.Today(),
                                        Anticipated_Solicitation_Notification_Re__c=Date.today(),
                                        Proposed_Rental_Rate__c=100,
                                        Proposed_Lease_Term_in_years__c=2,
                                        Region__c=1,
                                        Cilp_FY__c='2104',
                                        Proposed_RSF__c=2030,
                                        Project_Action__c='New',
                                        //Political_Status__c='New',
                                        //Agency__c='New',
                                        Project_Summary__c='project summary',
                                        Notes_Background__c='summary background',
                                        Location__c='F Street',
                                        City__c='Washington',
                                        State__c='DC',
                                        Current_Project_Phase__c='Requirements Development',
                                        Regional_POC__c=users[0].Id,
                                        Project_Number__c='1234',
                                        Proposed_Number_of_Employees__c=200,
                                        Proposed_Total_Annual_Cost__c=12345,
                                        Proposed_USF_Per_Person_all_in__c=12,
                                        Proposed_USF__c=123,
                                        Proposed_Office_Utilization_Rate__c=12));
            }
            insert leaselist;
            for(Leasing__c l : leaselist) {
                l.Prospectus_Number__c = 'LESE-123T1';
                //leaseList.add(l);
                l.OwnerId = admUser.Id;
            }
            try {
                update leaseList;
            }
            catch(DMLException e) {
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
            }
        }
    }    
    @isTest public static void testInsertLeaseAwardNotNull() {    
        // for record assertion LeaseAward(not null) & LeaseSolicit(null)- insert
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> leaserecordIds = new List<Id>();
        List<Leasing__c> leaseextract = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                             FROM Leasing__c WHERE Name = 'TriggerTestSample2'];
        for(Leasing__c c: leaseextract) {
            leaserecordIds.add(c.id);
        }
        List<Event> leaseeventslst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :leaserecordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(1,leaseeventslst.size());
    }
    @isTest public static void testUpdateLeaseSolicitNotNull() {    
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> leaserecordIds = new List<Id>();
        List<Leasing__c> leaseextract = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                             FROM Leasing__c WHERE Name = 'TriggerTestSample2'];
        // for record assertion LeaseSolicit changed from null to date - Update
        for(Leasing__c c: leaseextract) {
            leaserecordIds.add(c.Id);
            c.Anticipated_Solicitation_Notification_Re__c = Date.today()+1;
        }
        update leaseextract;
        List<Event> leaseeventslst2 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :leaserecordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(2,leaseeventslst2.size());
    }    
    @isTest public static void testInsertLeaseAwardsNotNull() {
        // for record assertion LeaseSolicit(not null) and LeaseAward(null) - insert
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> solicitrecordIds = new List<Id>();
        List<Leasing__c> solicitextract = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                             FROM Leasing__c WHERE Name = 'TriggerTestSample3'];
        for(Leasing__c c: solicitextract) {
            solicitrecordids.add(c.Id);
        }
        List<Event> soliciteventslst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :solicitrecordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(1,soliciteventslst.size());
    }     
    @isTest public static void testUpdateLeaseAwardNotNull() {
        // for record assertion LeaseAward changed from null to date - Update
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> solicitrecordIds = new List<Id>();
        List<Leasing__c> solicitextract = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                             FROM Leasing__c WHERE Name = 'TriggerTestSample3'];
        for(Leasing__c c: solicitextract) {
            solicitrecordids.add(c.Id);
            c.Proposed_Lease_Award_Date__c=Date.Today()+1;
        }
        update solicitextract;
        List<Event> soliciteventslst2 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :solicitrecordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(2,soliciteventslst2.size());
    }
    @isTest public static void testInsertBothDatesNull() {    
        // for record assertion LeaseAward(null) and LeaseSolicit(null) - insert
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> bothrecordIds = new List<Id>();
        List<Leasing__c> bothextract = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample4'];
        for(Leasing__c c: bothextract) {
            bothrecordids.add(c.Id);
        }
        List<Event> botheventslst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :bothrecordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(0, botheventslst.size());
    }
    @isTest public static void testUpdateBothDatesNull() {    
        // for record assertion LeaseAward (changed from null to date) and LeaseSolicit((changed from null to date) - Update
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> bothrecordIds = new List<Id>();
        List<Leasing__c> bothextract = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample4'];
        for(Leasing__c c: bothextract) {
            bothrecordids.add(c.Id);
            c.Proposed_Lease_Award_Date__c=Date.Today()+1;
            c.Anticipated_Solicitation_Notification_Re__c = Date.today()+1;
        }
        update bothextract;
        List<Event> botheventslst2 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :bothrecordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(2, botheventslst2.size());
    }
    @isTest public static void testBulkUpdateSolicitNull() {    
        // only lease award date is changed from date1 to date2 and solicit date is changed from date1 to null
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = Date.Today()+1;
            c.Anticipated_Solicitation_Notification_Re__c = null;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst2 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(200,eventslst2.size());
    }
    @isTest public static void testBulkUpdateAwardDateNull() {    
        // only solicitation date is changed from date1 to date2 and lease date is changed from date1 to null
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = null;
            c.Anticipated_Solicitation_Notification_Re__c = Date.Today()+3;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst3 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(200,eventslst3.size());
    }
    @isTest public static void testBulkUpdateBothDatesNull() {    
        // both date fields set to null
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = null;
            c.Anticipated_Solicitation_Notification_Re__c = null;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst4 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(0,eventslst4.size());
    }
    @isTest public static void testBulkUpdateAwardDatesNull() {    
        // only lease award date is set to null
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = null;
            c.Anticipated_Solicitation_Notification_Re__c = null;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst5 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(0,eventslst5.size());
    }
    @isTest public static void testBulkUpdateSolicitDateNull() {     
        // both date fields are set to null
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = null;
            c.Anticipated_Solicitation_Notification_Re__c = Date.today()+3;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst6 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(200,eventslst6.size());
    }    
    @isTest public static void testBulkUpdateDateFieldsNull() {   
        // both date fields are changed to not-null
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = Date.today()+6;
            c.Anticipated_Solicitation_Notification_Re__c = Date.today()+7;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst7 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(400,eventslst7.size());
    }
    @isTest public static void testBulkUpdateBothNull() {   
        // both date fields are changed to not-null again
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = Date.today()+9;
            c.Anticipated_Solicitation_Notification_Re__c = Date.today()+1;
        }        
        update leaselist;
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst8 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(400,eventslst8.size());
    }
    @isTest public static void testBulkUpdateBothNullFinal() {   
        // both date fields are changed to null again
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        List<Id> recordIds = new List<Id>();
        List<Leasing__c> leaselist = [Select Id, Name, Proposed_Lease_Award_Date__c, Anticipated_Solicitation_Notification_Re__c
                                         FROM Leasing__c WHERE Name = 'TriggerTestSample1'];
        for(Leasing__c c: leaselist) {
            recordIds.add(c.Id);
            c.Proposed_Lease_Award_Date__c = null;
            c.Anticipated_Solicitation_Notification_Re__c = null;
        }        
        Test.startTest();
        update leaselist;
        Test.stopTest();
        //List<Leasing__c> extract2 = [Select Id, Name FROM Leasing__c];
        List<Event> eventslst9 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(0,eventslst9.size());
    }
}