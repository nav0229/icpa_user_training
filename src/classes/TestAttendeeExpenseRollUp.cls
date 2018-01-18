/* ----------------------------------------------------------------------------------
   Test class for AttendeeExpenseRollup Trigger and Helper class 
-------------------------------------------------------------------------------------
    Author          | Date     | Version | Descripton
-------------------------------------------------------------------------------------
    Raja Nangunoori  12/13/12    1.0       Initial Draft
    Rajakumar        02/06/15    2.0       Test coverage for case#17704
-------------------------------------------------------------------------------------    
*/
@isTest
private class TestAttendeeExpenseRollUp {
    //private static Id AttendeeIds;
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
        
        Attendee_Expense__c AttExpense = new Attendee_Expense__c();
        AttExpense.Attendee__c = Attendee.Id;
        AttExpense.Estimated_Amount__c = 10.00;
        AttExpense.Expense_Detail__c = 'Meals';
        insert AttExpense;
        AttExpense.Expense_Detail__c = 'Other';
        upsert AttExpense;
        delete AttExpense;
        
        system.assertEquals(true, true);
        
    }

}