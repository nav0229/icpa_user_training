/****************************************************************
 Name:  EventRequestTriggerHelper
============================================================
Author: Lenny/Matt
Purpose: Trigger Helper for Event Request Trigger                                                                                                               
============================================================

****************************************************************/

public with sharing class EventRequestTriggerHelper {
	@TestVisible
	private static EventRequestStageUpdateHandlerInterface stageUpdateHandler = new EventRequestStageUpdateHandler();

    @TestVisible
    private static EventRequestInterfaceReRunHandler interfaceReRunHandler = new EventRequestInterfaceReRunHandler();

    /****************************************************************
        Purpose:  Main method that passes the list of Event Requests provided
        by the trigger to be processed in the EventRequestStageUpdateHandler class.
        Parameters: List of Event Requests
        Returns: N/A
     ****************************************************************/

	public void afterInsert(List<Event_Request__c> newEventRequests){
		stageUpdateHandler.processEventRequest(newEventRequests);
        interfaceReRunHandler.handleEventHistoryRecords(newEventRequests);
	}
}