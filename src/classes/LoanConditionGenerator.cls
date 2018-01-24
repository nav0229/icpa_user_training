/****************************************************************
 Name: LoanConditionGenerator
============================================================
Author: Lenny
Purpose: DCMM-2138
	Creates and inserts the necessary automated Loan Conditions for Applications
============================================================

****************************************************************/
public with sharing class LoanConditionGenerator implements LoanConditionGeneratorInterface{
	
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static PropertyDAO propertyDA = new PropertyDataAccessor();
	@TestVisible private static LossVerificationDAO lossVerificationDA = new LossVerificationDataAccessor();
	@TestVisible private static LoanConditionChecklistDAO loanConditionDA = new LoanConditionChecklistDataAccessor();

	private static LoanConditionGeneratorRuleFactory loanConditionGeneratorRuleFactory = new LoanConditionGeneratorRuleFactory();

	public LoanConditionGenerator() {}

	public void generateLoanCondition(List<Id> applicationIds){
        Id applicationId = applicationIds[0]; 

        Application__c application = applicationDA.getApplicationById(applicationId);

        List<Property__c> damagedProperties = propertyDA.getDamagedPropertiesByApplicationId(applicationId);
        List<Loss_Verification_Inspections__c> lossVerifications = 
        	lossVerificationDA.getLossVerificationsAndRelatedUPCodesByApplicationId(applicationId);

        List<UP_Codes__c> upCodes = new List<UP_Codes__c>();
        Map<Id, List<UP_Codes__c>> damagedPropertyToUPCodesMap = new Map<Id, List<UP_Codes__c>>();

		for(Loss_Verification_Inspections__c lv : lossVerifications){
			if(lv.Property__r.Application__r.RecordType.Name!='Home Loan Application'){
                System.debug('This class does not generate Loan conditiions for Non-Home Loans' );
                return;
            }
			upCodes.addAll(lv.UP_Codes__r);
			for(UP_Codes__c upCode : lv.UP_Codes__r){
				if(damagedPropertyToUPCodesMap.containsKey(lv.Property__c)){
					damagedPropertyToUPCodesMap.get(lv.Property__c).add(upCode);
				}
				else{
					damagedPropertyToUPCodesMap.put(lv.Property__c, new List<UP_Codes__c>{upCode});
				}
			}
		}

		List<Loan_Condition_Checklist__c> loanConditionsToInsert = new List<Loan_Condition_Checklist__c>();

        List<LoanConditionRuleInterface> applicationLevelRulesList = 
        	loanConditionGeneratorRuleFactory.getApplicableApplicationLevelAutomatedLoanConditionGeneratorRules();
        LoanConditionGenerationCriteria generationCriteria = new LoanConditionGenerationCriteria(application, upCodes);
		for(LoanConditionRuleInterface rule : applicationLevelRulesList){
			Loan_Condition_Checklist__c newLC = rule.applyRuleAndCreateLoanCondition(generationCriteria);
			if(newLC != null){
				loanConditionsToInsert.add(newLC);
			}
		}

		List<LoanConditionRuleInterface> propertyLevelRulesList = 
        	loanConditionGeneratorRuleFactory.getApplicablePropertyLevelAutomatedLoanConditionGeneratorRules();
        for(Property__c damagedProperty : damagedProperties){
        	LoanConditionGenerationCriteria propertyLevelGenerationCriteria = new LoanConditionGenerationCriteria(
        		application, damagedPropertyToUPCodesMap.get(damagedProperty.Id), damagedProperty
        	);
			for(LoanConditionRuleInterface rule : propertyLevelRulesList){
				Loan_Condition_Checklist__c newLC = rule.applyRuleAndCreateLoanCondition(propertyLevelGenerationCriteria);
				if(newLC != null){
					loanConditionsToInsert.add(newLC);
				}
			}		
		}

		try{
			loanConditionDA.insertLoanConditionChecklists(loanConditionsToInsert);
		} catch (DmlException e) {
			System.debug(e.getMessage());
			throw new LoanConditionGeneratorException(
				'An error occurred while attempting to insert automated loan conditions',
				e
			);
		}
	}

	public class LoanConditionGeneratorException extends Exception {}
}