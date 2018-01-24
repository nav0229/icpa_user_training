/****************************************************************
 Name:  StandardRealEstateRequirementEvaluator
============================================================
Author: Lenny
Purpose: JIRA#1909
Responsible for resolving whether to include the Standard
Real Estate Requirement Condition to the Loan Conditions
============================================================

****************************************************************/
public with sharing class StandardRealEstateRequirementEvaluator {
	@TestVisible
    private static LossVerificationDAO lossVerificationDA = new LossVerificationDataAccessor();

	@TestVisible
    private static LoanConditionChecklistDAO loanConditionDA = new LoanConditionChecklistDataAccessor();

	@TestVisible
    private static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();

	@TestVisible
    private static LoanDAO loanDA = new LoanDataAccessor();

	public void evaluateStandardRealEstateRequirement(List<Id> applicationIds){
		List<Loan_Condition_Checklist__c> newLoanConditions = new List<Loan_Condition_Checklist__c>();
		Set<Id> loanIds = getRelatedLoanIds(applicationIds);
		Map<Id, List<Loss_Verification_Inspections__c>> loanIdToLossVerificationMap = createLoanIdToLossVerificationMap(loanIds);
		Master_Checklist__c standardRealEstate = masterChecklistDA.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.STANDARD_REAL_ESTATE_CODE);
		
		for(Id loanId : loanIds) {
			if(loanIdToLossVerificationMap.containsKey(loanId)){
				for(Loss_Verification_Inspections__c lossVerification : loanIdToLossVerificationMap.get(loanId)){
					if(lossVerification.Real_Estate_Verified_Loss__c > 0) {
						newLoanConditions.add(
							new Loan_Condition_Checklist__c(
								Loan__c = loanId,
								Master_Checklist__c = standardRealEstate.Id
							)
						);
						break;
					}
				}
			}
		}

		try {
			if(!newLoanConditions.isEmpty()){
				loanConditionDA.insertLoanConditionChecklists(newLoanConditions);
			}
		}
		catch (DmlException e){
			throw new StandardRealEstateRequirementEvaluatorException(
        		'Error creating new Loan Condition Checklists for Loans satisfying the Standard Real Estate Requirement:' + e.getMessage()
        	);
		}
	}

	private Map<Id, List<Loss_Verification_Inspections__c>> createLoanIdToLossVerificationMap(Set<Id> loanIds) {
		List<Loss_Verification_Inspections__c> relatedLossVerifications = lossVerificationDA.getLossVerificationsByLoanIds(loanIds);
        Map<Id, List<Loss_Verification_Inspections__c>> loanIdToLossVerificationMap = new Map<Id, List<Loss_Verification_Inspections__c>>();

        for(Id loanId : loanIds) {
            List<Loss_Verification_Inspections__c> currentLossVerifications = new List<Loss_Verification_Inspections__c>();
            for(Loss_Verification_Inspections__c lossVerification : relatedLossVerifications) {
                if(loanId == lossVerification.Loan__c) {
                    currentLossVerifications.add(lossVerification);
                }
            }
            loanIdToLossVerificationMap.put(loanId, currentLossVerifications);
        }
        return loanIdToLossVerificationMap;
    }

    private Set<Id> getRelatedLoanIds(List<Id> applicationIds) {
    	List<Loan__c> relatedLoans = loanDA.getLoansByApplicationIds(applicationIds);
    	Set<Id> loanIds = new Set<Id>();

    	for(Loan__c loan : relatedLoans) {
    		if(!loanIds.contains(loan.Id)){
    			loanIds.add(loan.Id);
    		}
    	}
    	return loanIds;
    }

    public class StandardRealEstateRequirementEvaluatorException extends Exception {}
}