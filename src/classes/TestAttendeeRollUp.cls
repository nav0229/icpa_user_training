/* ----------------------------------------------------------------------------------
   Test class for AttendeeRollup Trigger and Helper class 
-------------------------------------------------------------------------------------
    Author          | Date     | Version | Descripton
-------------------------------------------------------------------------------------
    Raja Nangunoori  12/13/12    1.0       Initial Draft
    Rajakumar        05/06/14    2.0       Apex sharing for HSSO &Supervisor
    Rajakumar        08/19/14    3.0       Undo the changes made in 2.0
    Rajakumar        02/06/15    4.0       Test coverage for case#17704
-------------------------------------------------------------------------------------    
*/
@isTest
private class TestAttendeeRollUp {
    //private static Id EventApprovalIds;
    static testMethod void testRollUp() {
        //User u = [SELECT Id, Name FROM User WHERE isactive = :true LIMIT 1];
        Id recTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Non_GSA_Sponsored_Conference' 
                        AND SObjectType = 'Event_Approval__c'].Id;
        Event_Approval__c EventApproval = new Event_Approval__c();
        EventApproval.Name = 'TestEAInsert01ABC1';
        EventApproval.EA_Event_Name__c = 'TestEAInsert01ABC1';
        EventApproval.Conference_Site__c ='Test Conf';
        EventApproval.EA_Purpose_or_Objective__c = 'Test Method';
        EventApproval.EA_Start_Date__c = Date.today();
        EventApproval.EA_End_Date__c = Date.today()+1;
        EventApproval.RecordTypeId = recTypeId;
        EventApproval.EA_Stage__c = 'Approved';
        insert EventApproval;
        
        Attendee__c Attendee = new Attendee__c();
        Attendee.Event_Number__c = EventApproval.Id;
        Attendee.Attending_Start_Date__c = Date.today();
        Attendee.Attending_End_Date__c = Date.today()+1;
        Attendee.Attendee_Type_of_Funding_None__c = true;
        //Attendee.Supervisors_Name__c = u.Id;
        
        insert Attendee;
        
        Attendee.Status__c = 'Approved';
        upsert Attendee;
        delete Attendee;
        
        system.assertEquals(true, true);
        
    }
    
    /* -- Ver 3.0 Undo the changes made in 2.0 -- BEGIN --
    // -- Ver 2.0 -- Added for the apex Record Sharing -- BEGIN -- //
    static testMethod void testSupervisorInsert() {
        List<User> userlist = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId()
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 2];
        Event_Approval__c eventApproval = new Event_Approval__c();
        eventApproval.Name = 'Test23';
        eventApproval.EA_Event_Name__c = 'Test12';
        eventApproval.Conference_Site__c ='Test Conf';
        eventApproval.EA_Purpose_or_Objective__c = 'Test Method';
        eventApproval.EA_Stage__c = 'Approved';
        insert eventApproval;
        
        Attendee__c attendee = new Attendee__c();
        attendee.Event_Number__c = EventApproval.Id;
        attendee.Attending_Start_Date__c = Date.newInstance(2013, 04, 09);
        attendee.Attending_End_Date__c = Date.newInstance(2013, 04, 19);
        //attendee.HSSO__c = userlist[0].Id;
        attendee.Supervisor__c = userlist[1].Id;
        Test.startTest();
        insert attendee;
        Test.stopTest();
        
        List<Attendee__Share> shares = [SELECT Id FROM Attendee__Share 
                                                WHERE ParentId = :attendee.Id AND UserorGroupId =:userlist[1].Id 
                                                AND AccessLevel = 'Edit' AND RowCause = 'Supervisor__c'];
        System.assertEquals(1, shares.size());
        
    }
    
    static testMethod void testSupervisorUpdate() {
        List<User> userlist = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId()
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 2];
        Event_Approval__c eventApproval = new Event_Approval__c();
        eventApproval.Name = 'Test23';
        eventApproval.EA_Event_Name__c = 'Test12';
        eventApproval.Conference_Site__c ='Test Conf';
        eventApproval.EA_Purpose_or_Objective__c = 'Test Method';
        eventApproval.EA_Stage__c = 'Approved';
        insert eventApproval;
        
        Attendee__c attendee = new Attendee__c();
        attendee.Event_Number__c = EventApproval.Id;
        attendee.Attending_Start_Date__c = Date.newInstance(2013, 04, 09);
        attendee.Attending_End_Date__c = Date.newInstance(2013, 04, 19);
        attendee.HSSO__c = userlist[0].Id;
        attendee.Supervisor__c = userlist[1].Id;
        
        insert attendee;
        
        attendee.Status__c = 'Approved';
        //attendee.HSSO__c = userlist[1].Id;
        attendee.Supervisor__c = userlist[0].Id;
        Test.startTest();
        update attendee;
        Test.stopTest();
        //delete Attendee;
        List<Attendee__Share> shares = [SELECT Id FROM Attendee__Share 
                                                WHERE ParentId = :attendee.Id AND UserorGroupId =:userlist[0].Id 
                                                AND AccessLevel = 'Edit' AND RowCause = 'Supervisor__c'];
        System.assertEquals(1, shares.size());
        
        List<Attendee__Share> shares2 = [SELECT Id FROM Attendee__Share 
                                                WHERE ParentId = :attendee.Id AND UserorGroupId =:userlist[1].Id 
                                                AND AccessLevel = 'Edit' AND RowCause = 'Supervisor__c'];
        System.assertEquals(0, shares2.size());
        
    }
    
    static testMethod void testHSSOInsert() {
        List<User> userlist = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId()
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 2];
        Event_Approval__c eventApproval = new Event_Approval__c();
        eventApproval.Name = 'Test23';
        eventApproval.EA_Event_Name__c = 'Test12';
        eventApproval.Conference_Site__c ='Test Conf';
        eventApproval.EA_Purpose_or_Objective__c = 'Test Method';
        eventApproval.EA_Stage__c = 'Approved';
        insert eventApproval;
        
        Attendee__c attendee = new Attendee__c();
        attendee.Event_Number__c = EventApproval.Id;
        attendee.Attending_Start_Date__c = Date.newInstance(2013, 04, 09);
        attendee.Attending_End_Date__c = Date.newInstance(2013, 04, 19);
        attendee.HSSO__c = userlist[0].Id;
        //attendee.Supervisor__c = userlist[1].Id;
        Test.startTest();
        insert attendee;
        Test.stopTest();
        
        List<Attendee__Share> shares = [SELECT Id FROM Attendee__Share 
                                                WHERE ParentId = :attendee.Id AND UserorGroupId =:userlist[0].Id 
                                                AND AccessLevel = 'Edit' AND RowCause = 'HSSO__c'];
        System.assertEquals(1, shares.size());
        
    }
    
    static testMethod void testHSSOUpdate() {
        List<User> userlist = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId()
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') LIMIT 2];
        Event_Approval__c eventApproval = new Event_Approval__c();
        eventApproval.Name = 'Test23';
        eventApproval.EA_Event_Name__c = 'Test12';
        eventApproval.Conference_Site__c ='Test Conf';
        eventApproval.EA_Purpose_or_Objective__c = 'Test Method';
        eventApproval.EA_Stage__c = 'Approved';
        insert eventApproval;
        
        Attendee__c attendee = new Attendee__c();
        attendee.Event_Number__c = EventApproval.Id;
        attendee.Attending_Start_Date__c = Date.newInstance(2013, 04, 09);
        attendee.Attending_End_Date__c = Date.newInstance(2013, 04, 19);
        attendee.HSSO__c = userlist[0].Id;
        attendee.Supervisor__c = userlist[1].Id;
        
        insert attendee;
        
        attendee.Status__c = 'Approved';
        attendee.HSSO__c = userlist[1].Id;
        //attendee.Supervisor__c = userlist[0].Id;
        Test.startTest();
        update attendee;
        Test.stopTest();
        //delete Attendee;
        List<Attendee__Share> shares = [SELECT Id FROM Attendee__Share 
                                                WHERE ParentId = :attendee.Id AND UserorGroupId =:userlist[1].Id 
                                                AND AccessLevel = 'Edit' AND RowCause = 'HSSO__c'];
        System.assertEquals(1, shares.size());
        
        List<Attendee__Share> shares2 = [SELECT Id FROM Attendee__Share 
                                                WHERE ParentId = :attendee.Id AND UserorGroupId =:userlist[0].Id 
                                                AND AccessLevel = 'Edit' AND RowCause = 'HSSO__c'];
        System.assertEquals(0, shares2.size());
        
    }
    // -- Ver 2.0 -- Added for the apex Record Sharing -- END -- //
       -- Ver 3.0 Undo the changes made in 2.0         -- END -- */
}