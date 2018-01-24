/****************************************************************
 Name:  ChecklistItemUpdaterByEventRequest
============================================================
Author: Lenny
Purpose: JIRA#1596/1602                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemUpdaterByEventRequest extends ChecklistItemUpdater{

	private Map<Id,Event_Request__c> applicationIdToEventRequestMap;
	private String inputEventRequestsStage;


	private boolean relatedObjectsAreValid(Id applicationId){
		Event_Request__c relatedRequest = applicationIdToEventRequestMap.get(applicationId);

		if(relatedRequest.Status__c == EventRequestDataAccessor.STATUS_FAILURE) {
			return false;
		}
		
		return true;
	}


	private Map<Id, Application__c> getApplicationMap(){
		List<Event_Request__c> eventRequests;
		try{
			eventRequests = (List<Event_Request__c>)sObjects;
		} 
		catch (TypeException e) {
			System.debug(e);
			throw new ChecklistItemUpdaterException('handleChecklistUpdates requires a List of Event Requests as input.', e);
		}

		List<String> applicationNumbers = new List<String>();
		for(Event_Request__c request : eventRequests) {
			if(inputEventRequestsStage == null){
				inputEventRequestsStage = request.Stage__c;
			}
			applicationNumbers.add(request.Application_Number__c);
		}
		return new Map<Id, Application__c>(getApplicationDA().getApplicationsByApplicationNumber(applicationNumbers));
	}
	

	private void initializeRelatedObjects(List<Id> applicationIds) {
		applicationIdToEventRequestMap = getApplicationIdToEventRequestMap();
	}


	public Map<Id, Checklist_Item__c> getApplicationIdToChecklistItemMap(){
		Map<Id, Checklist_Item__c> applicationIdToChecklistItemMap = new Map<Id, Checklist_Item__c>();
		if(inputEventRequestsStage == EventRequestDataAccessor.STAGE_RECEIVED_FLOOD_MAPPING){
	 		applicationIdToChecklistItemMap = buildApplicationIdChecklistItemMap(MasterChecklistDataAccessor.FLOOD_MAPPING_CODE);
		}
	 	else if(inputEventRequestsStage == EventRequestDataAccessor.STAGE_RECIEVED_LV_INSPECTION){
	 		applicationIdToChecklistItemMap = buildApplicationIdChecklistItemMap(MasterChecklistDataAccessor.LOSS_VERIFICATION_CODE);
	 	}
	 	return applicationIdToChecklistItemMap;
	}
}