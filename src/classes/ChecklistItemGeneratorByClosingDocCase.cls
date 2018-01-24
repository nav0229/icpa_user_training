/****************************************************************
 Name:  ChecklistItemGeneratorByClosingDocCase
============================================================
Author: Lenny
Purpose: JIRA#1293, 2138, 2148                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemGeneratorByClosingDocCase extends ChecklistItemGenerator {

	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();
	@TestVisible private static LoanConditionChecklistDAO loanConditionChecklistDA = new LoanConditionChecklistDataAccessor();
	@TestVisible private static LoanConditionElementDAO loanConditionElementDA = new LoanConditionElementDataAccessor();
	@TestVisible private static ChecklistItemElementDAO checklistItemElementDA = new ChecklistItemElementDataAccessor();

	@TestVisible private static ChecklistItemDrawloopNextPopInterface drawloopNextPopulator = new ChecklistItemDrawloopNextPopulator();
	private static ChecklistItemGeneratorRuleFactory checklistItemGeneratorRuleFactory = new ChecklistItemGeneratorRuleFactory();
	private static ChecklistItemElementRuleFactory checklistItemElementRuleFactory = new ChecklistItemElementRuleFactory();

	@TestVisible private Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap;

	public ChecklistItemGeneratorByClosingDocCase(){}

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
			throw new ChecklistItemGeneratorByClosingDocCaseException('handleChecklistGeneration requires a List of Cases as input. ', e);
		}

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id closingDocRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_CLOSING_DOCUMENT).getRecordTypeId();

		List<Case> loanClosingCases = new List<Case>();

		for(Case cas : cases){
			if(cas.RecordTypeId == closingDocRecordTypeId){
				loanClosingCases.add(cas);
			}
		}

		if(!loanClosingCases.isEmpty()) {
			generateChecklistItems(loanClosingCases);
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
		List<Loan_Condition_Checklist__c> relatedLoanConditions = 
			loanConditionChecklistDA.getActiveLoanConditionChecklistsByApplicationIds(applicationIds);
		Map<Id, List<Loan_Condition_Checklist__c>> applicationIdToLoanConditionChecklistListMap = 
			buildApplicationIdToLoanConditionChecklistListMap(applicationIds, relatedLoanConditions);
		Map<Id, List<Loan_Condition_Element__c>> loanConditionToLoanConditionElementListMap = 
			buildLoanConditionToLoanConditionElementListMap(relatedLoanConditions);

		List<Checklist_Item__c> checklistItemsToInsert = new List<Checklist_Item__c>();
		List<Checklist_Item_Element__c> checklistItemElementsToInsert = new List<Checklist_Item_Element__c>();
		checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();
		for(Case cas : cases) {
			checklistItemsToInsert.addAll(createApplicableChecklistItemsForCases(
				cas,
				relatedApplicationIdToApplicationMap.get(cas.Application__c),
				applicationIdToLoanConditionChecklistListMap.get(cas.Application__c)
			));
		}

		try {
			checklistItemDA.insertChecklistItems(checklistItemsToInsert);
		} catch(DmlException e) {
			System.debug(e);
			throw new ChecklistItemGeneratorByClosingDocCaseException('Error occurred while attempting to insert new Checklist_Item__c.', e);
		}

		//populate Drawloop Next field and update checklist Items
		drawloopNextPopulator.populateDrawloopNext(checklistItemsToInsert);

		List<ChecklistItemElementRuleInterface> checklistItemLevelRulesList = 
        	checklistItemElementRuleFactory.getApplicableCILevelChecklistItemElementRules();
		
		for(Checklist_Item__c newChecklistItem : checklistItemsToInsert){
			ChecklistItemElementGenerationCriteria generationCriteria = 
				new ChecklistItemElementGenerationCriteria(newChecklistItem);
			for(ChecklistItemElementRuleInterface rule : checklistItemLevelRulesList){
				Checklist_Item_Element__c newElement = rule.applyRuleAndCreateChecklistItemElement(generationCriteria);
				if(newElement != null){
					checklistItemElementsToInsert.add(newElement);
				}
			}

			if(loanConditionToLoanConditionElementListMap.get(newChecklistItem.Loan_Condition__c) != null){
				checklistItemElementsToInsert.addAll(createChecklistItemElementsForChecklistItem(
					newChecklistItem,
					loanConditionToLoanConditionElementListMap.get(newChecklistItem.Loan_Condition__c)
				));
			}
		}

		try {
			checklistItemElementDA.insertChecklistItemElements(checklistItemElementsToInsert);
		} catch(DmlException e) {
			System.debug(e);
			throw new ChecklistItemGeneratorByClosingDocCaseException('Error occurred while attempting to insert new Checklist_Item_Element__c.', e);
		}
	}

	@TestVisible
	private List<Checklist_Item__c> createApplicableChecklistItemsForCases(
		Case cas, 
		Application__c application,
		List<Loan_Condition_Checklist__c> relatedLoanConditions
	){
		List<Checklist_Item__c> newChecklistItems = new List<Checklist_Item__c>();

		if(application == null){
			return newChecklistItems;
		}

		MasterChecklistData mcData = MasterChecklistData.getInstance();

		for(String checklistCode : MasterChecklistDataAccessor.DEFAULT_CLOSING_DOC_CODES){
			newChecklistItems.add(
				generateNewApplicationLevelChecklistItem(
					mcData.getMasterChecklistByChecklistCode(checklistCode),
					cas, 
					application, 
					ChecklistItemDataAccessor.FINALIZED_STATUS, 
					ChecklistItemDataAccessor.CLOSING_DOC_TYPE
				)
			);
		}

		List<ChecklistItemRuleInterface> lcRelatedRulesList = 
        	checklistItemGeneratorRuleFactory.getApplicableLCRelatedChecklistItemGeneratorRules();
		for(Loan_Condition_Checklist__c loanCondition : relatedLoanConditions){
	        ChecklistItemGenerationCriteria generationCriteria = new ChecklistItemGenerationCriteria(cas, application, loanCondition);
			for(ChecklistItemRuleInterface rule : lcRelatedRulesList){
				Checklist_Item__c newItem = rule.applyRuleAndCreateChecklistItem(generationCriteria);
				if(newItem != null){
					newChecklistItems.add(newItem);
				}
			}
		}

		return newChecklistItems;
	}

    private List<Checklist_Item_Element__c> createChecklistItemElementsForChecklistItem(
    	Checklist_Item__c newChecklistItem,
    	List<Loan_Condition_Element__c> relatedLoanConditionElements
    ){
    	List<Checklist_Item_Element__c> newChecklistItemElements = new List<Checklist_Item_Element__c>();

		List<ChecklistItemElementRuleInterface> lcElementRelatedRulesList = 
        	checklistItemElementRuleFactory.getApplicableLCERelatedChecklistItemElementRules();
			
		for(Loan_Condition_Element__c element : relatedLoanConditionElements){
			ChecklistItemElementGenerationCriteria generationCriteria = 
				new ChecklistItemElementGenerationCriteria(element, newChecklistItem);
			for(ChecklistItemElementRuleInterface rule : lcElementRelatedRulesList){
				Checklist_Item_Element__c newElement = rule.applyRuleAndCreateChecklistItemElement(generationCriteria);
				if(newElement != null){
					newChecklistItemElements.add(newElement);
				}
			}
    	}
    	return newChecklistItemElements;
    }

	private Map<Id,List<Loan_Condition_Checklist__c>> buildApplicationIdToLoanConditionChecklistListMap(
		List<Id> applicationIds, 
		List<Loan_Condition_Checklist__c> relatedLoanConditions
	){
		Map<Id,List<Loan_Condition_Checklist__c>> applicationIdToLoanConditionChecklistListMap = new Map<Id,List<Loan_Condition_Checklist__c>>();

		for(Id applicationId : applicationIds) {
			applicationIdToLoanConditionChecklistListMap.put(applicationId, new List<Loan_Condition_Checklist__c>());
		}

		for(Loan_Condition_Checklist__c loanCondition : relatedLoanConditions) {
			applicationIdToLoanConditionChecklistListMap.get(loanCondition.Application__c).add(loanCondition);
		}
		return applicationIdToLoanConditionChecklistListMap;
	}

	private Map<Id, List<Loan_Condition_Element__c>> buildLoanConditionToLoanConditionElementListMap(List<Loan_Condition_Checklist__c> relatedLoanConditions){
		Map<Id, List<Loan_Condition_Element__c>> loanConditionToLoanConditionElementListMap = new Map<Id, List<Loan_Condition_Element__c>>();
		List<Id> loanConditionIds = new List<Id>();

		for(Loan_Condition_Checklist__c loanCondition : relatedLoanConditions){
			loanConditionIds.add(loanCondition.Id);
		}

		List<Loan_Condition_Element__c> relatedElements = loanConditionElementDA.getLoanConditionElementsByLoanConditionChecklistIds(loanConditionIds);
		for(Loan_Condition_Element__c element : relatedElements){
			if(loanConditionToLoanConditionElementListMap.containsKey(element.Loan_Condition__c)) {
				loanConditionToLoanConditionElementListMap.get(element.Loan_Condition__c).add(element);
			}
			else {
				loanConditionToLoanConditionElementListMap.put(element.Loan_Condition__c, new List<Loan_Condition_Element__c>{element});
			}
		}

		return loanConditionToLoanConditionElementListMap;
	}

	public class ChecklistItemGeneratorByClosingDocCaseException extends Exception {}
}