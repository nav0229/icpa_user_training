/****************************************************************
 Name:  EventRequestStageUpdateHandlerMock
============================================================
Author: Lenny
Purpose: Mock version of EventRequestStageUpdateHandler class.                                                                                                               
============================================================

****************************************************************/

@isTest
public class EventRequestStageUpdateHandlerMock implements EventRequestStageUpdateHandlerInterface {
	
	public Integer processEventRequestCallCount = 0;

	public void processEventRequest(List<Event_Request__c> eventRequests) {
		processEventRequestCallCount++;
	}
}