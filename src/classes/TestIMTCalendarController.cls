/*-------------------------------------------------------------------------------
  TestIMTCalendarController.cls
  Class for testing IMT Calendar controller
  -------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------
  Rajakumar              08/13/2013  1.0       Initial version
  -------------------------------------------------------------------------------
*/
@isTest
private class TestIMTCalendarController {
    @isTest
    static void testCaledarExtract() {  
        PublicCalendarList__c publicCalenderList = new PublicCalendarList__c();
        publicCalenderList.Name = 'IMTCalendar';
        publicCalenderList.CalendarID__c = '023300000053CAu';
        insert publicCalenderList;
        IMTCalendarController imt = new IMTCalendarController();
        System.assertEquals(imt.calendarId,PublicCalendarList__c.getValues('IMTCalendar').calendarID__c); 
    }
}