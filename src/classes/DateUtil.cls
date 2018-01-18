/*-------------------------------------------------------------------------------------------------*
  Data Util Class
  - Utility class to calculate the date difference between any two given dates. It utilizes the Out of the Box (OOTB) 
  Holidays and Business Hours to include only the working days/hours and excluse Holidays and Weekends.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Sathish Durairaj      09/17/2014    1.0       Created
  
 *-------------------------------------------------------------------------------------------------*/

public with sharing class DateUtil {

  	public static Long daysOpen; 
  	
  	
  	public static Long DateDiff(Date startDate, Date completionDate, BusinessHours stdBusinessHours) {
  	  	
  	  		
		 if ((startDate != NULL) && (stdBusinessHours != NULL)) {
		 	if (completionDate != null) {
		    	daysOpen = BusinessHours.diff (stdBusinessHours.id, startDate, completionDate) /1000/60/60/8;
		    	system.debug('Inside class not null>>>>' +daysOpen);
		 	} else {
		 		daysOpen = BusinessHours.diff (stdBusinessHours.id, startDate, date.today()) /1000/60/60/8;
		 		system.debug('Inside class null>>>>' +daysOpen);
		 	}
		 }
		  
		 return daysOpen;
  	}
  

}