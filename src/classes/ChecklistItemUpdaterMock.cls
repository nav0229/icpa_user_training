/****************************************************************
 Name: ChecklistItemUpdaterMock
============================================================
Author: Lenny
Purpose: Mock Data Accessor Class for Checklist Item Updater
============================================================

****************************************************************/

@isTest
public with sharing class ChecklistItemUpdaterMock implements ChecklistItemUpdaterInterface{
	public Integer handleChecklistUpdatesCallCount {get; private set;}

	public ChecklistItemUpdaterMock() {
		handleChecklistUpdatesCallCount = 0;
	}

	public void handleChecklistUpdates(List<SObject> sObjects){
		handleChecklistUpdatesCallCount++;
	}
}