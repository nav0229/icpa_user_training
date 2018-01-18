/*-------------------------------------------------------------------------------
  TestIMTCommunicationsTrigger.cls
  Class for testing IMT Communications trigger on Communications object
  -------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------
  Rajakumar              08/12/2013  1.0       Initial version
  -------------------------------------------------------------------------------
*/  
@isTest
private class TestIMTCommunicationsTrigger {
    //public static String calId; 
    
    // test the record sharing
    @isTest(seeAllData=true)
    static void testRecordInsertUpdate() {
        List<Communications__c> comslist = new List<Communications__c>();
        List<Id> recordIds = new List<Id>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 7];
        //TestIMTCommunicationsTrigger t = new TestIMTCommunicationsTrigger();
        //TestIMTCommunicationsTriggerData.testWithAllDataAccess();
        
        //PublicCalendarList__c pcal = new PublicCalendarList__c(Name='IMTCalendar',CalendarID__c='023Q000000DSc2k');
        //insert pcal;
        PublicCalendarList__c pcal = PublicCalendarList__c.getValues('IMTCalendar');
        for(Integer i=0;i<50;i++) {
            comslist.add(new Communications__c(Name='TriggerTestSample1',Type_of_Activity__c='Congressional - pink',Start_Date__c=Date.Today(),End_Date__c=Date.Today()+2,
                                               POC__c=users[0].Id,City__c='Washington',State__c='DC',OAS_Notification_Status__c='Not Applicable',
                                               Region_SSO__c='OCR',Show_in_Shared_Calendar__c=true));
            comslist.add(new Communications__c(Name='TriggerTestSample1',Type_of_Activity__c='Congressional - pink',Start_Date__c=Date.Today(),End_Date__c=Date.Today()+2,
                                               POC__c=users[0].Id,City__c='Washington',State__c='DC',OAS_Notification_Status__c='Not Applicable',
                                               Region_SSO__c='OCR',Show_in_Shared_Calendar__c=false));
        }
        insert comslist;
        List<Communications__c> extract = [Select Id, Name, Start_Date__c, End_Date__c, Show_in_Shared_Calendar__c, Region_SSO__c FROM Communications__c WHERE Name = 'TriggerTestSample1'];
        for(Communications__c c: extract) {
            recordids.add(c.Id);
        }
        //System.assertEquals(extract.size(),comslist.size());
        
        List<Event> eventslst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(50,eventslst.size());
        
        for(Communications__c c: comslist) {
            if(c.Show_in_Shared_Calendar__c == false)
                c.Show_in_Shared_Calendar__c = true;
            else
                c.Show_in_Shared_Calendar__c = false;
        }        
        update comslist;
        //List<Communications__c> extract2 = [Select Id, Name FROM Communications__c];
        List<Event> eventslst2 = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event 
                                 WHERE WhatId IN :recordIds AND OwnerId = :pcal.CalendarID__c];
        System.assertEquals(50,eventslst2.size());
    }
}