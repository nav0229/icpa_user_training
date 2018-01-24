/****************************************************************
 Name:  ChecklistItemUpdaterBySBALoanHistory
============================================================
Author: Lenny
Purpose: JIRA#1293                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemUpdaterBySBALoanHistory extends ChecklistItemUpdater {
	@TestVisible private static SBALoanHistoryDAO sbaLoanHistoryDA = new SBALoanHistoryDataAccessor();

	private Map<Id,List<SBA_Loan_History__c>> applicationIdToSBALoanHistoryListMap;
	private Map<Id,Event_Request__c> applicationIdToEventRequestMap;


	private boolean relatedObjectsAreValid(Id applicationId){
		Event_Request__c relatedRequest = applicationIdToEventRequestMap.get(applicationId);

		for (SBA_Loan_History__c loanHistory : applicationIdToSBALoanHistoryListMap.get(applicationId)) {
			if(relatedRequest.Status__c == EventRequestDataAccessor.STATUS_FAILURE || loanHistory.Error_Number__c != null) {
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
		applicationIdToSBALoanHistoryListMap = new Map<Id,List<SBA_Loan_History__c>>();
		List<SBA_Loan_History__c> relatedLoanHistories = sbaLoanHistoryDA.getSBALoanHistoriesByApplicationIds(applicationIds);

		for(SBA_Loan_History__c loanHistory : relatedLoanHistories){
			if(applicationIdToSBALoanHistoryListMap.containsKey(loanHistory.Application__c)){
				applicationIdToSBALoanHistoryListMap.get(loanHistory.Application__c).add(loanHistory);
			} else {
				applicationIdToSBALoanHistoryListMap.put(loanHistory.Application__c, new List<SBA_Loan_History__c>{loanHistory});
			}
		}

		applicationIdToEventRequestMap = getApplicationIdToEventRequestMap();
	}


	public Map<Id, Checklist_Item__c> getApplicationIdToChecklistItemMap(){
	 	return buildApplicationIdChecklistItemMap(MasterChecklistDataAccessor.LOAN_HISTORY_CODE);
	}
}