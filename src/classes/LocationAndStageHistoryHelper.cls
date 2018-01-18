public class LocationAndStageHistoryHelper{

	// prevents adding a second location and stage history when the stage is changed to closed
	public static Map<Id, boolean> controlledDocumentIdRecursionTracker = new Map<Id, boolean>();
	public static BusinessHours cdtBusinessHours = [SELECT Id 
												FROM BusinessHours 
												WHERE Name = 'CDT Business Hours'];			

	// BEFORE INSERT ONLY
	// inserts start dates and also sets the Current Location
	public static void insertStartDatesAndSetCurrentLocation(List<Controlled_Document__c> newCDocs){
		Date currentLocalDate = System.now().date();
		
		for(Controlled_Document__c newControlledDocument : newCDocs){
			newControlledDocument.Current_Stage_Start_Date_New__c = currentLocalDate;
			newControlledDocument.Days_On_Current_Stage_New__c = 0;
			newControlledDocument.Current_Location_Start_Date_New__c = currentLocalDate;
			newControlledDocument.Days_In_Current_Location_New__c = 0;

			// if the current location IS empty and the originating office is NOT empty
			// check subdivision - if sub division is populated then use THAT
			// if not use the originating office
			if(newControlledDocument.Current_Location__c == null && newControlledDocument.Originating_Office__c != null){
				if(newControlledDocument.Sub_Division__c == null){
					newControlledDocument.Current_Location__c = newControlledDocument.Originating_Office__c;
				} else {
					newControlledDocument.Current_Location__c = newControlledDocument.Sub_Division__c;
				}
			} else if (newControlledDocument.Current_Location__c != null && newControlledDocument.Originating_Office__c == null){
				// do nothing
				// current location was set soooooo good to go!
			} else if (newControlledDocument.Current_Location__c != null && newControlledDocument.Originating_Office__c != null){
				// do nothing 
				// current location was set soooooo good to go!
			} else{
				newControlledDocument.Current_Location__c = 'Location Unspecified';
			}
		}
	}

	// AFTER INSERT ONLY
	public static void insertLocationHistoryForNewCDocs(List<Controlled_Document__c> newCDocs){
		Datetime current = System.now();
		Date currDate = current.date();
		Time currTime = current.time();
		Datetime currentLocal = Datetime.newInstance(currDate, currTime);

		List<Location_and_Stage_History__c> historiesToAdd = new List<Location_and_Stage_History__c>();
		for(Controlled_Document__c controlledDocument : newCDocs){
			if(controlledDocument.Current_Location__c == null) continue;
			// if a CD is inserted as closed then this happens
			if(controlledDocument.Stage__c == 'Closed') continue;
			Location_and_Stage_History__c newHistoryLocation = new Location_and_Stage_History__c();
			newHistoryLocation.Name = controlledDocument.Current_Location__c;
            // Case# 30668 - BEGIN
            String locationName = (controlledDocument.current_Region__c != null) ? mergeString(controlledDocument.current_Region__c, 
                                                                                             controlledDocument.Current_Location__c) : null;
            newHistoryLocation.Name = (locationName != null) ? locationName : controlledDocument.Current_Location__c;
            // Case# 30668 - END
			newHistoryLocation.Stage__c = controlledDocument.Stage__c;
			newHistoryLocation.Active__c = TRUE;
			newHistoryLocation.Start_Date__c = currentLocal;
			newHistoryLocation.of_Days_New__c = 0.0;
			newHistoryLocation.Controlled_Document__c = controlledDocument.Id;
			historiesToAdd.add(newHistoryLocation);
		}
		insert historiesToAdd;
	}

	// BEFORE UPDATE ONLY
	public static void checkAndUpdateHistory(Map<Id, Controlled_Document__c> newCDocs, Map<Id, Controlled_Document__c> oldCDocs){
		Datetime current = System.now();
		Date currDate = current.date();
		Time currTime = current.time();
		Time midnightTime = Time.newInstance(0, 0, 0, 0);
		Datetime currentLocal = Datetime.newInstance(currDate, currTime);
		Datetime currentLocalMidnight = Datetime.newInstance(currDate, midnightTime);
		Date currentLocalDate = currDate;

		System.debug('111');

		List<Controlled_Document__c> cDocsNeedingHistoryChanges = new List<Controlled_Document__c>();
		for(Controlled_Document__c newControlledDocument : newCDocs.values()){
			// prevents closed controlled documents from running twice
			if(controlledDocumentIdRecursionTracker.get(newControlledDocument.Id) == true) {
				// allows another attempt after an initial 'closed' status in case a document is ever updated to 'closed' then to a new status in the same transcation
				// this should never happen -_-
				controlledDocumentIdRecursionTracker.put(newControlledDocument.Id, false);
				continue;
			}

			System.debug('222');

			if(newControlledDocument.Stage__c == 'Closed'){
				newControlledDocument.Current_Location_Start_Date_New__c = null;
				newControlledDocument.Current_Stage_Start_Date_New__c = null;
				newControlledDocument.Days_In_Current_Location_New__c = null;
				newControlledDocument.Days_On_Current_Stage_New__c = null;
				cDocsNeedingHistoryChanges.add(newControlledDocument);
				continue;	
			}

			// this will help preventing nulls on existing controlled documents
			if(newControlledDocument.Current_Location_Start_Date_New__c == null) newControlledDocument.Current_Location_Start_Date_New__c = currentLocalDate;
			if(newControlledDocument.Current_Stage_Start_Date_New__c == null) newControlledDocument.Current_Stage_Start_Date_New__c = currentLocalDate;

			// used to prevent adding the same object to our list
			boolean added = false;
			if(newControlledDocument.Current_Location__c != oldCDocs.get(newControlledDocument.Id).Current_Location__c ||
              newControlledDocument.Current_Region__c != oldCDocs.get(newControlledDocument.Id).Current_Region__c){

				System.debug('333');

				cDocsNeedingHistoryChanges.add(newControlledDocument);
				newControlledDocument.Current_Location_Start_Date_New__c = currentLocalDate;
				newControlledDocument.Days_In_Current_Location_New__c = 0;
				added = true;
			}
			// adds a new record even if the location doesn't change
			if(newControlledDocument.Stage__c != oldCDocs.get(newControlledDocument.Id).Stage__c){

				System.debug('444');

				newControlledDocument.Current_Stage_Start_Date_New__c = currentLocalDate;
				newControlledDocument.Days_On_Current_Stage_New__c = 0;
				if(!added){
					cDocsNeedingHistoryChanges.add(newControlledDocument);
					added = true;
					if(newControlledDocument.Stage__c == 'Closed'){
						controlledDocumentIdRecursionTracker.put(newControlledDocument.Id, true);
					}
				}
			}

			// if these dates change then either an admin is doing something or we are testing
			boolean stageStartDateChanged = false;
			if(newControlledDocument.Current_Stage_Start_Date_New__c != oldCDocs.get(newControlledDocument.Id).Current_Stage_Start_Date_New__c){
				stageStartDateChanged = true;
			}

			// if these dates change then either an admin is doing something or we are testing
			boolean locationStartDateChanged = false;
			if(newControlledDocument.Current_Location_Start_Date_New__c != oldCDocs.get(newControlledDocument.Id).Current_Stage_Start_Date_New__c){
				locationStartDateChanged = true;
			}

			// changes controlled documents whenever the batch is run and not any other time
			if(UpdateDaysOpenOnApprovalStepsBatch.isBatchOn || stageStartDateChanged || locationStartDateChanged){
				newControlledDocument.Days_On_Current_Stage_New__c = getBsnsHoursDifferenceLong(cdtBusinessHours, newControlledDocument.Current_Stage_Start_Date_New__c, currentLocalDate);
				newControlledDocument.Days_In_Current_Location_New__c = getBsnsHoursDifferenceLong(cdtBusinessHours, newControlledDocument.Current_Location_Start_Date_New__c, currentLocalDate);
			}
		}

		List<Id> controlledDocumentIds = new List<Id>();
		List<Location_and_Stage_History__c> historiesToAdd = new List<Location_and_Stage_History__c>();
		for(Controlled_Document__c controlledDocument : cDocsNeedingHistoryChanges){

			System.debug('666');

			controlledDocumentIds.add(controlledDocument.Id);

			// if closed we are not adding a new Location and Stage History but updating the most recent one to inactive and setting the end date
			if(controlledDocument.Stage__c == 'Closed') continue;

			Location_and_Stage_History__c newHistoryLocation = new Location_and_Stage_History__c();
            newHistoryLocation.Name = controlledDocument.Current_Location__c;			
            // Case# 30668 - BEGIN
            String locationName = (controlledDocument.current_Region__c != null) ? mergeString(controlledDocument.current_Region__c, 
                                                                                             controlledDocument.Current_Location__c) : null;
            newHistoryLocation.Name = (locationName != null) ? locationName : controlledDocument.Current_Location__c;
            // Case# 30668 - END
			newHistoryLocation.Stage__c = controlledDocument.Stage__c;
			newHistoryLocation.Active__c = TRUE;
			newHistoryLocation.Start_Date__c = currentLocal;
			newHistoryLocation.Controlled_Document__c = controlledDocument.Id;
			newHistoryLocation.Of_Days_New__c = 0.0;
			historiesToAdd.add(newHistoryLocation);
		}

		List<Location_and_Stage_History__c> oldHistoryList = [SELECT Id, Active__c, Start_Date__c, End_Date__c, of_Days_New__c
													FROM Location_and_Stage_History__c
													WHERE Active__c = true AND
														Controlled_Document__c IN :controlledDocumentIds];							

		for(Location_and_Stage_History__c oldHistory : oldHistoryList){

			System.debug('777');

			oldHistory.Active__c = FALSE;
			oldHistory.End_Date__c = currentLocal;
			if(oldHistory.Start_Date__c != null) {

				System.debug('888');
				Double d = getBsnsHoursDifferenceDouble(cdtBusinessHours, oldHistory.Start_Date__c, oldHistory.End_Date__c);
				oldHistory.of_Days_New__c = d;
			}
		}

		update oldHistoryList;
		System.debug('oldHistoryList' + oldHistoryList);
		insert historiesToAdd;
		System.debug('historiesToAdd' + historiesToAdd);
	}

	private static Long getBsnsHoursDifferenceLong(BusinessHours bsnsHours, Datetime startTime, Datetime endTime){
		Long l = BusinessHours.diff(bsnsHours.Id, startTime, endTime);
		return l/1000/3600/8;
	}

	private static Double getBsnsHoursDifferenceDouble(BusinessHours bsnsHours, Datetime startTime, Datetime endTime){
		Double d = BusinessHours.diff(bsnsHours.Id, startTime, endTime);
		return d/1000/3600/8;
	}
	// Case# 30668 - BEGIN 
    private static String mergeString(String currentRegion, String currentLocation) {
        String merged = null;
        if(currentregion != null) {
            merged = currentRegion + ': ' + currentLocation;
            if(merged.length() > 80) {
                merged = merged.substring(0, 80);
            }
        }
        return merged;
    } // Case# 30668 - END
}