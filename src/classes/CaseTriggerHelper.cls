/****************************************************************
 Name: CaseTriggerHelper
============================================================
Author: Kevin
Purpose: Trigger Helper for Case Trigger
============================================================

****************************************************************/
public with sharing class CaseTriggerHelper {

	@TestVisible private static ChecklistItemGeneratorInterface interfaceChecklistItemGenerator = new ChecklistItemGeneratorByInterfaceCase();
	@TestVisible private static ChecklistItemGeneratorInterface docReqChecklistItemGenerator = new ChecklistItemGeneratorByDocRequestCase();
	@TestVisible private static ChecklistItemGeneratorInterface closDocChecklistItemGenerator = new ChecklistItemGeneratorByClosingDocCase();

    public CaseTriggerHelper(){}
    
    public void afterInsert(List<Case> cases){
    	interfaceChecklistItemGenerator.handleChecklistGeneration(cases);
    	docReqChecklistItemGenerator.handleChecklistGeneration(cases);
    	closDocChecklistItemGenerator.handleChecklistGeneration(cases);
    }
}