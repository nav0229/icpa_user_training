/*
    DateUtility.cls
    Utility to calculate Date not including Weekends based on the Start date and Days
    ----------------------------------------------------------------------------------------------------------------------------------------
    Author               Date            Version          Description
    ----------------------------------------------------------------------------------------------------------------------------------------   
    Raja Nangunoori      11/12/2013       1.0             Date Utility to Calculate a date without Weekends based on a Date and Number of days passed
*/

public with sharing class DateUtility{    
     public static Date getNextBusinessDate(Date startDate, integer numberOfDays){
         Decimal NoOfDays = 0;
         Date tempStartDate = startDate;
         for( integer i = 0; NoOfDays < numberOfDays; i ++ ) {
               if(tempStartDate.daysBetween(tempStartDate.toStartofWeek()) == 0 ||
                             tempStartDate.daysBetween(tempStartDate.toStartofWeek()) == -6)
               {
                   tempStartDate = tempStartDate.adddays(1);
                   continue;
               }
               NoOfDays = NoOfDays+1;
               tempStartDate = tempStartDate.adddays(1);
          }                  
            return tempStartDate;
     }   
 }