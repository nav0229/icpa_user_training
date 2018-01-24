/****************************************************************
 Name: EventRequestDataAccessorMock
============================================================
Author: Lenny
Purpose: Mock Data Accessor Class for Event_Request__c
============================================================

****************************************************************/

@isTest
public with sharing class EventRequestDataAccessorMock implements EventRequestDAO {
	public Integer insertEventRequestCallCount {get; private set;}
	public Integer insertEventRequestsCallCount {get; private set;}
	public Integer getEventRequestByStageAndApplicationNumberCallCount {get; private set;}
	public Integer getEventRequestsByStageAndApplicationNumbersCallCount {get; private set;}

	public Event_Request__c getEventRequestByStageAndApplicationNumberReturn;
	public List<Event_Request__c> getEventRequestsByStageAndApplicationNumbersReturn;

	public EventRequestDataAccessorMock() {
		insertEventRequestCallCount = 0;
		insertEventRequestsCallCount = 0;
		getEventRequestByStageAndApplicationNumberCallCount = 0;
		getEventRequestsByStageAndApplicationNumbersCallCount = 0;

		getEventRequestByStageAndApplicationNumberReturn = new Event_Request__c();
		getEventRequestsByStageAndApplicationNumbersReturn = new List<Event_Request__c>();
	}

	public void insertEventRequest(Event_Request__c eventRequest){
		insertEventRequestCallCount++;
	}

	public void insertEventRequests(List<Event_Request__c> eventRequests){
		insertEventRequestsCallCount++;
	}

	public Event_Request__c getEventRequestByStageAndApplicationNumber(String applicationNumber, String stage){
		getEventRequestByStageAndApplicationNumberCallCount++;
		return getEventRequestByStageAndApplicationNumberReturn;
	}

	public List<Event_Request__c> getEventRequestsByStageAndApplicationNumbers(List<String> applicationNumbers, String stage) {
		getEventRequestsByStageAndApplicationNumbersCallCount++;
		return getEventRequestsByStageAndApplicationNumbersReturn;
	}
}