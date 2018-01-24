/****************************************************************
 Name: EventRequestDAO
============================================================
Author: Lenny
Purpose: Data Access Object for Event_Request__c
============================================================

****************************************************************/
public interface EventRequestDAO {
	void insertEventRequest(Event_Request__c eventRequest);
	void insertEventRequests(List<Event_Request__c> eventRequests);

	Event_Request__c getEventRequestByStageAndApplicationNumber(String applicationNumber, String stage);
	List<Event_Request__c> getEventRequestsByStageAndApplicationNumbers(List<String> applicationNumbers, String stage);
}