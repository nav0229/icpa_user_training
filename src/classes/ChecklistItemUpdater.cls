/****************************************************************
 Name: ChecklistItemUpdater
============================================================
Author: Lenny
Purpose: Abstract class for checklistItem Updater
============================================================

****************************************************************/

public abstract class ChecklistItemUpdater implements ChecklistItemUpdaterInterface {
	@TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();
	@TestVisible private static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	private Map<Id, Application__c> applicationIdToApplicationMap;
	protected List<SObject> sObjects;

	abstract Map<Id, Application__c> getApplicationMap();
	abstract void initializeRelatedObjects(List<Id> applicationIds);
	abstract boolean relatedObjectsAreValid(Id applicationId);
	abstract Map<Id, Checklist_Item__c> getApplicationIdToChecklistItemMap();


	public void handleChecklistUpdates(List<SObject> sObjects) {
		this.sObjects = sObjects;
		List<Checklist_Item__c> checklistItemsToUpdate = new List<Checklist_Item__c>();
		if(inputParametersAreValid()){
			applicationIdToApplicationMap = getApplicationMap();
			initializeRelatedObjects(new List<Id>(applicationIdToApplicationMap.keySet()));
			Map<Id, Checklist_Item__c> applicationIdToChecklistItemMap = getApplicationIdToChecklistItemMap();
			checklistItemsToUpdate = setChecklistItemStatus(applicationIdToChecklistItemMap);			
		}

		try {
			checklistItemDA.updateChecklistItems(checklistItemsToUpdate);
		} catch(DmlException e) {
			throw new ChecklistItemUpdaterException(
				'Error occurred while attempting to update new Checklist_Item__c: '+e.getMessage()
			);
		}
	}


	private boolean inputParametersAreValid(){
		return sObjects != null && !sObjects.isEmpty();
	}


	private List<Checklist_Item__c> setChecklistItemStatus(Map<Id, Checklist_Item__c> applicationIdToChecklistItemMap){
		List<Checklist_Item__c> checklistItemsToUpdate = new List<Checklist_Item__c>();

		for(Id applicationId : applicationIdToApplicationMap.keySet()) {
			if(applicationIdToChecklistItemMap.containsKey(applicationId)){
				Checklist_Item__c relatedChecklistItem = applicationIdToChecklistItemMap.get(applicationId);
				if(relatedObjectsAreValid(applicationId)){
					relatedChecklistItem.Checklist_Item_Status__c = ChecklistItemDataAccessor.RECEIVED_STATUS;
				}
				else {
					relatedChecklistItem.Checklist_Item_Status__c = ChecklistItemDataAccessor.FAILED_STATUS;
				}
				relatedChecklistItem.Last_Action_Date__c = System.Now();
				checklistItemsToUpdate.add(relatedChecklistItem);
			}
		}
		return checklistItemsToUpdate;
	}


	protected Map<Id, Event_Request__c> getApplicationIdToEventRequestMap() {
		Map<Id, Event_Request__c> applicationIdToEventRequestMap = new Map<Id, Event_Request__c>();
		for(Application__c application : applicationIdToApplicationMap.values()) {
			for(Event_Request__c request : (List<Event_Request__c>) sObjects) {
				if(application.Name == request.Application_Number__c) {
					applicationIdToEventRequestMap.put(application.Id, request);
				}
			}
		}
		return applicationIdToEventRequestMap;
	}


	protected Map<Id, Checklist_Item__c> buildApplicationIdChecklistItemMap(String checklistCode){
		Map<Id, Checklist_Item__c> applicationIdToLoanHistChecklistItemMap = new Map<Id, Checklist_Item__c>();
		List<Id> applicationIds = new List<Id>(applicationIdToApplicationMap.keySet());

		Master_Checklist__c checklist = new Master_Checklist__c();
		try {
			checklist = masterChecklistDA.getMasterChecklistByChecklistCode(checklistCode);
		} 
		catch (QueryException e) {
			System.debug('The Master Checklist Record with code:\'' + checklistCode + '\' does not exist in the system.');
			return new Map<Id, Checklist_Item__c>();
		}
		List<Checklist_Item__c> relatedChecklistItems = checklistItemDA.getChecklistItemsByApplicationIdsAndMasterChecklistId(applicationIds, checklist.Id);

		for(Checklist_Item__c item : relatedChecklistItems) {
			applicationIdToLoanHistChecklistItemMap.put(item.Application__c, item);
		}

		return applicationIdToLoanHistChecklistItemMap;
	}


	protected ApplicationDAO getApplicationDA(){
		return applicationDA;
	}

	public class ChecklistItemUpdaterException extends Exception {}
}