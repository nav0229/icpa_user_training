@isTest
public with sharing class EventRequestGeneratorByChecklistItemMock implements EventRequestGenByChecklistItemInterface{
	public Integer generateEventRequestsForChecklistItemsCallCount {get; private set;}

	public EventRequestGeneratorByChecklistItemMock() {
		generateEventRequestsForChecklistItemsCallCount = 0;
	}

	public void generateEventRequestsForChecklistItems(List<Checklist_Item__c> checklistItems){
		generateEventRequestsForChecklistItemsCallCount++;
	}
}