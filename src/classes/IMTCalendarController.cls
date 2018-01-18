/*-------------------------------------------------------------------------------
  IMTCalendarController.cls
  Class for displaying the IMT Calendar in visualforce page
  -------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------
  Rajakumar              08/13/2013  1.0       Initial version
  -------------------------------------------------------------------------------
*/  
public with sharing class IMTCalendarController {
    public String calendarId {get; set; }
    
    public IMTCalendarController () {
        calendarId = PublicCalendarList__c.getValues('IMTCalendar').CalendarID__c;    
    }
}