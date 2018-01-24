@isTest
public with sharing class ChecklistItemElementDataAccessorMock implements ChecklistItemElementDAO {
	public Integer insertChecklistItemElementsCallCount {get; private set;}

	public ChecklistItemElementDataAccessorMock() {
		insertChecklistItemElementsCallCount = 0;
	}

	public void insertChecklistItemElements(List<Checklist_Item_Element__c> newChecklistItemElements){
		insertChecklistItemElementsCallCount++;
	}
}