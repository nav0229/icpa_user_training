/****************************************************************
 Name:  ChecklistItemGeneratorBySysGenCase
============================================================
Author: Vid Lakshmanan
Purpose: JIRA#? Create checklist items for System Generated Requests 
============================================================

****************************************************************/
public with sharing class ChecklistItemGeneratorBySysGenCase extends ChecklistItemGenerator {
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();
	@TestVisible private static ChecklistItemDrawloopNextPopInterface drawloopNextPopulator = new ChecklistItemDrawloopNextPopulator();
	
	public ChecklistItemGeneratorBySysGenCase() {}
	
	public void handleChecklistGeneration(List<SObject> caseSobjects){
		if(caseSobjects == null || caseSobjects.isEmpty()){
			return;
		}

		List<Case> cases;
		try{
			cases = (List<Case>)caseSobjects;
		} 
		catch (TypeException e) {
			System.debug(e);
			throw new ChecklistItemGeneratorBySysGenCaseException(
				'handleChecklistGeneration requires a List of Cases as input. ', e
			);
		}

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id systemGeneratedRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_SYSTEM_GENERATED).getRecordTypeId();

		List<Case> systemGeneratedCases = new List<Case>();

		for(Case cas : cases){
			if(cas.RecordTypeId == systemGeneratedRecordTypeId){
				systemGeneratedCases.add(cas);
			}
		}

		if(!systemGeneratedCases.isEmpty()) {
			generateChecklistItems(systemGeneratedCases);
		}
	}

	private void generateChecklistItems(List<Case> cases){
		List<Id> applicationIds = new List<Id>();
		for(Case cas : cases){
			applicationIds.add(cas.Application__c);
		}
		if(applicationIds.isEmpty()){
			return;
		}

		Map<Id,Application__c> relatedApplicationIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);
		List<Checklist_Item__c> checklistItemsToInsert = new List<Checklist_Item__c>();
		
		for(Case cas : cases) {
			checklistItemsToInsert.addAll(
				createApplicableChecklistItemsForCases(
					cas, 
					relatedApplicationIdToApplicationMap.get(cas.Application__c) 
				)
			);
		}

		try {
			checklistItemDA.insertChecklistItems(checklistItemsToInsert);
		} catch(DmlException e) {
			System.debug(e);
			throw new ChecklistItemGeneratorBySysGenCaseException('Error occurred while attempting to insert new Checklist_Item__c.', e);
		}
		
		//populate Drawloop Next field and update checklist Items
		drawloopNextPopulator.populateDrawloopNext(checklistItemsToInsert);
	}
	
	@TestVisible
	private List<Checklist_Item__c> createApplicableChecklistItemsForCases(
		Case cas, 
		Application__c application
	){
		List<Checklist_Item__c> newChecklistItems = new List<Checklist_Item__c>();

		if(application == null){
			return newChecklistItems;
		}

		MasterChecklistData mcData = MasterChecklistData.getInstance();

		for(String checklistCode : MasterChecklistDataAccessor.DEFAULT_SYSTEM_GENERATED_CODES){
			Checklist_Item__c newChecklistItem = generateNewApplicationLevelChecklistItem(
					mcData.getMasterChecklistByChecklistCode(checklistCode),
					cas, 
					application, 
					ChecklistItemDataAccessor.AVAILABLE_STATUS, 
					ChecklistItemDataAccessor.SYSTEM_GENERATED_TYPE
				);
			newChecklistItem.Generate_Document__c = true; // Generate document right away
			newChecklistItems.add(newChecklistItem);
		}
		
		return newChecklistItems;
	}
	
	public class ChecklistItemGeneratorBySysGenCaseException extends Exception {}
}