/****************************************************************
 Name: ChecklistItemUpdaterByCreditBureau
============================================================
Author: Lenny
Purpose: Class for updating ChecklistItem by credit bureau
============================================================

****************************************************************/

public with sharing class ChecklistItemUpdaterByCreditBureau extends ChecklistItemUpdater {
	@TestVisible private static CreditBureauDAO creditBureauDA = new CreditBureauDataAccessor();

	private Map<Id,List<Credit_Bureau__c>> applicationIdToCreditBureauListMap;
	private Map<Id,Event_Request__c> applicationIdToEventRequestMap;


	private boolean relatedObjectsAreValid(Id applicationId){
		Event_Request__c relatedRequest = applicationIdToEventRequestMap.get(applicationId);

		for (Credit_Bureau__c cbr : applicationIdToCreditBureauListMap.get(applicationId)) {
			if(relatedRequest.Status__c == EventRequestDataAccessor.STATUS_FAILURE 
				|| cbr.CBR_Request_Result__c == 'Error' 
				|| cbr.CBR_Request_Result__c == null
			) {
				return false;
			}
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
			applicationNumbers.add(request.Application_Number__c);
		}
		return new Map<Id, Application__c>(getApplicationDA().getApplicationsByApplicationNumber(applicationNumbers));
	}
	

	private void initializeRelatedObjects(List<Id> applicationIds) {
		applicationIdToCreditBureauListMap = new Map<Id,List<Credit_Bureau__c>>();
		List<Credit_Bureau__c> relatedCreditBureaus = creditBureauDA.getActiveCreditBureausByApplicationIds(applicationIds);

		for(Credit_Bureau__c cbr : relatedCreditBureaus){
			if(applicationIdToCreditBureauListMap.containsKey(cbr.Application__c)){
				applicationIdToCreditBureauListMap.get(cbr.Application__c).add(cbr);
			} else {
				applicationIdToCreditBureauListMap.put(cbr.Application__c, new List<Credit_Bureau__c>{cbr});
			}
		}

		applicationIdToEventRequestMap = getApplicationIdToEventRequestMap();
	}


	public Map<Id, Checklist_Item__c> getApplicationIdToChecklistItemMap(){
	 	return buildApplicationIdChecklistItemMap(MasterChecklistDataAccessor.CBR_CODE);
	}
}