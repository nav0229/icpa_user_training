public with sharing class ChecklistItemDrawloopNextPopulatorMock implements ChecklistItemDrawloopNextPopInterface{
	public Integer populateDrawloopNextCallCount {get; private set;}

	public ChecklistItemDrawloopNextPopulatorMock() {
		populateDrawloopNextCallCount = 0;
	}

	public void populateDrawloopNext(List<Checklist_Item__c> checklistItems) {
		populateDrawloopNextCallCount++;
	}
}