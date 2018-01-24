/****************************************************************
 Name: ChecklistItemGeneratorMock
============================================================
Author: Lenny
Purpose: Mock Data Accessor Class for ChecklistItem
============================================================

****************************************************************/
@isTest
public with sharing class ChecklistItemGeneratorMock implements ChecklistItemGeneratorInterface{
	public Integer handleChecklistGenerationCallCount {get; private set;}

	public ChecklistItemGeneratorMock() {
		handleChecklistGenerationCallCount = 0;
	}

	public void handleChecklistGeneration(List<SObject> sObjects){
		handleChecklistGenerationCallCount++;
	}
}