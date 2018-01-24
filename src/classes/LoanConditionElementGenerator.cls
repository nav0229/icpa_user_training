/****************************************************************
 Name: LoanConditionElementGenerator
============================================================
Author: Kevin
Purpose: DCMM-2148
	Creates and inserts the necessary Loan Condition Elements for Loan Conditions
============================================================

****************************************************************/
public with sharing class LoanConditionElementGenerator implements LoanConditionElementGeneratorInterface {
	@TestVisible private static LoanConditionElementGeneratorRuleFactory loanConditionElementRuleFactory = new LoanConditionElementGeneratorRuleFactory();

	@TestVisible private static LoanConditionElementDAO loanConditionElementDA = new LoanConditionElementDataAccessor();
	@TestVisible private static PropertyDAO propertyDA = new PropertyDataAccessor();
	@TestVisible private static LossVerificationDAO lossVerificationDA = new LossVerificationDataAccessor();

	public LoanConditionElementGenerator(){}

	public void generateLoanConditionElements(List<Loan_Condition_Checklist__c> loanConditions){
		List<Loan_Condition_Element__c> elementsToInsert = new List<Loan_Condition_Element__c>();

		List<LoanConditionCriteria> loanConditionCriteriaList = buildLoanConditionCriteriaList(loanConditions);

		List<LoanConditionElementRuleInterface> rulesList = loanConditionElementRuleFactory.getLoanConditionElementGeneratorRules();

		for(LoanConditionCriteria loanConditionCriteria : loanConditionCriteriaList){
			for(LoanConditionElementRuleInterface rule : rulesList){
				if(rule.doesRuleApply(loanConditionCriteria)){
					elementsToInsert.add(rule.applyRuleAndCreateLoanConditionElement(loanConditionCriteria));
				}
			}
		}

		Savepoint sp = Database.setSavepoint();

		try {
			loanConditionElementDA.insertLoanConditionElements(elementsToInsert);
			//update related SObject lists
		} catch(DmlException e) {
			System.debug(e.getMessage());
			Database.rollback(sp);
			for(Loan_Condition_Checklist__c loanCondition : loanConditions){
				loanCondition.addError(e.getMessage());
			}
		}
	}

	private List<LoanConditionCriteria> buildLoanConditionCriteriaList(List<Loan_Condition_Checklist__c> loanConditions){
		List<Id> applicationIds = new List<Id>();
		for(Loan_Condition_Checklist__c loanCondition : loanConditions){
			applicationIds.add(loanCondition.Application__c);
		}

		Map<Id,Property__c> idToDamagedPropertyMap = propertyDA.getDamagedPropertiesByApplicationIds(applicationIds);
		List<Loss_Verification_Inspections__c> lossVerificationsWithUPCodes = lossVerificationDA.getLossVerificationsAndRelatedUPCodesByApplicationIds(applicationIds);
		Map<Id,List<UP_Codes__c>> damagedPropertyIdToUPCodesMap = buildDamagedPropertyToUPCodesMap(lossVerificationsWithUPCodes);

		List<LoanConditionCriteria> loanConditionCriteriaList = new List<LoanConditionCriteria>();

		for(Loan_Condition_Checklist__c loanCondition : loanConditions){
			loanConditionCriteriaList.add(new LoanConditionCriteria(
				loanCondition,
				idToDamagedPropertyMap.get(loanCondition.Property__c),
				damagedPropertyIdToUPCodesMap.get(loanCondition.Property__c)
			));
		}

		return loanConditionCriteriaList;
	}

	private Map<Id,List<UP_Codes__c>> buildDamagedPropertyToUPCodesMap(List<Loss_Verification_Inspections__c> lossVerificationsWithUPCodes){
		Map<Id,List<UP_Codes__c>> damagedPropertyIdToUPCodesMap = new Map<Id,List<UP_Codes__c>>();

		for(Loss_Verification_Inspections__c lv : lossVerificationsWithUPCodes){
			for(UP_Codes__c upCode : lv.UP_Codes__r){
				if(damagedPropertyIdToUPCodesMap.containsKey(lv.Property__c)){
					damagedPropertyIdToUPCodesMap.get(lv.Property__c).add(upCode);
				} else {
					damagedPropertyIdToUPCodesMap.put(lv.Property__c, new List<UP_Codes__c>{upCode});
				}
			}
		}

		return damagedPropertyIdToUPCodesMap;
	}
}