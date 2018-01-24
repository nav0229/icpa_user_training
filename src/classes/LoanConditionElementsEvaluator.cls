/****************************************************************
 Name: LoanConditionElementsEvaluator
============================================================
Author: Kevin
Purpose: DCMM-2148
	Determines if all the Required Loan Condition Elements have
	been completed for an application
============================================================

****************************************************************/
public with sharing class LoanConditionElementsEvaluator implements LoanConditionElementsEvaluatorInterface {
	@TestVisible private static LoanConditionChecklistDAO loanConditionDA = new LoanConditionChecklistDataAccessor();
	@TestVisible private static LoanConditionElementDAO loanConditionElementDA = new LoanConditionElementDataAccessor();
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	public LoanConditionElementsEvaluator(){}

	public void flagApplicationIfRequiredLoanConditionElementsCompleted(List<Loan_Condition_Element__c> loanConditionElements){
		Map<Id,List<Loan_Condition_Element__c>> applicationIdToRequiredLoanConditonElementsMap = constructApplicationIdsToRequiredLoanConditionElementsMap(loanConditionElements);

		List<Id> applicationIdsToFlag = new List<Id>();

		for(Id applicationId : applicationIdToRequiredLoanConditonElementsMap.keySet()){
			Boolean isCompleted = true;
			
			for(Loan_Condition_Element__c loanConditionElement : applicationIdToRequiredLoanConditonElementsMap.get(applicationId)){
				if(String.isBlank(loanConditionElement.Custom_Element_Value__c) && String.isBlank(loanConditionElement.Element_Value__c)){
					isCompleted = false;
					break;
				}
			}

			if(isCompleted){
				applicationIdsToFlag.add(applicationId);
			}
		}

		if(!applicationIdsToFlag.isEmpty()){
			flagApplications(applicationIdsToFlag);
		}
	}

	private Map<Id,List<Loan_Condition_Element__c>> constructApplicationIdsToRequiredLoanConditionElementsMap(List<Loan_Condition_Element__c> loanConditionElements){
		Set<Id> loanConditionIds = new Set<Id>();
		for(Loan_Condition_Element__c element : loanConditionElements){
			if(!loanConditionIds.contains(element.Loan_Condition__c)){
				loanConditionIds.add(element.Loan_Condition__c);
			}
		}
		List<Loan_Condition_Checklist__c> relatedLoanConditions = loanConditionDA.getActiveLoanConditionChecklistsByIds(new List<Id>(loanConditionIds));

		Set<Id> applicationIds = new Set<Id>();
		for(Loan_Condition_Checklist__c loanCondition : relatedLoanConditions){
			if(!applicationIds.contains(loanCondition.Application__c)){
				applicationIds.add(loanCondition.Application__c);
			}
		}
		
		List<Loan_Condition_Element__c> relatedLoanConditionElements = loanConditionElementDA.getRequiredLoanConditionElementsByLoanConditionChecklistIds(new List<Id>(loanConditionIds));

		Map<Id, List<Loan_Condition_Checklist__c>> applicationIdToLoanConditionChecklistListMap = 
			buildApplicationIdToLoanConditionChecklistListMap(new List<Id>(applicationIds), relatedLoanConditions);

		Map<Id, List<Loan_Condition_Element__c>> loanConditionToLoanConditionElementListMap = 
			buildLoanConditionToLoanConditionElementListMap(relatedLoanConditions, relatedLoanConditionElements);

		Map<Id,List<Loan_Condition_Element__c>> applicationIdToRequiredLoanConditonElementsMap = new Map<Id,List<Loan_Condition_Element__c>>();

		for(Id appId : applicationIds){
			for(Loan_Condition_Checklist__c loanCondition : applicationIdToLoanConditionChecklistListMap.get(appId)){
				if(loanConditionToLoanConditionElementListMap.containsKey(loanCondition.Id)){
					for(Loan_Condition_Element__c element : loanConditionToLoanConditionElementListMap.get(loanCondition.Id)){
						if(applicationIdToRequiredLoanConditonElementsMap.containsKey(appId)) {
							applicationIdToRequiredLoanConditonElementsMap.get(appId).add(element);
						}
						else {
							applicationIdToRequiredLoanConditonElementsMap.put(appId, new List<Loan_Condition_Element__c>{element});
						}
					}
				}
			}
		}

		return applicationIdToRequiredLoanConditonElementsMap;
	}

	private Map<Id,List<Loan_Condition_Checklist__c>> buildApplicationIdToLoanConditionChecklistListMap(
		List<Id> applicationIds, 
		List<Loan_Condition_Checklist__c> relatedLoanConditions
	){
		Map<Id,List<Loan_Condition_Checklist__c>> applicationIdToLoanConditionChecklistListMap = new Map<Id,List<Loan_Condition_Checklist__c>>();

		for(Loan_Condition_Checklist__c loanCondition : relatedLoanConditions) {
			if(applicationIdToLoanConditionChecklistListMap.containsKey(loanCondition.Application__c)) {
				applicationIdToLoanConditionChecklistListMap.get(loanCondition.Application__c).add(loanCondition);
			}
			else {
				applicationIdToLoanConditionChecklistListMap.put(loanCondition.Application__c, new List<Loan_Condition_Checklist__c>{loanCondition});
			}
		}
		
		return applicationIdToLoanConditionChecklistListMap;
	}

	private Map<Id, List<Loan_Condition_Element__c>> buildLoanConditionToLoanConditionElementListMap(
		List<Loan_Condition_Checklist__c> relatedLoanConditions, 
		List<Loan_Condition_Element__c> relatedElements
	){
		Map<Id, List<Loan_Condition_Element__c>> loanConditionToLoanConditionElementListMap = new Map<Id, List<Loan_Condition_Element__c>>();

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

	private void flagApplications(List<Id> applicationIds){
		List<Application__c> applicationsToFlag = applicationDA.getApplicationsById(applicationIds);
		for(Application__c application : applicationsToFlag){
			application.Elements_Completed__c = true;
		}

		try{
			applicationDA.updateApplications(applicationsToFlag);
		}
		catch(DmlException e){
			System.debug(e);
			throw new LoanConditionElementsEvaluatorException('Failed to update Applications after flagging them as elemetns completed.', e);
		}
	}

	public class LoanConditionElementsEvaluatorException extends Exception {}
}