/****************************************************************
 Name: DisbursementLineItemHandler
============================================================
Author: Matt
Purpose: Class handler for Disbursement Line Items
============================================================

****************************************************************/

public with sharing class DisbursementLineItemHandler {

	@TestVisible private static LoanDAO loanDA = new LoanDataAccessor();

	private final Map<String, String> upCodeCatToLineItemCat = new Map<String, String>{
		LoanUPCodeHandler.CONTENTS => 'Contents', 
		LoanUPCodeHandler.MOTOR_VEHICLE => 'Motor Vehicle',
		LoanUPCodeHandler.REAL_ESTATE_REPAIR_REPLACE => 'Real Estate (Repair/Replace)',
		LoanUPCodeHandler.REFINANCING => 'Refinancing',
		LoanUPCodeHandler.REPAY_IHP => 'Repay IHP',
		LoanUPCodeHandler.REAL_ESTATE_OTHER => 'Real Estate (Other)',
		LoanUPCodeHandler.MITIGATION => 'Mitigation',
		LoanUPCodeHandler.INTERIM_FINANCING => 'Interim Financing',
		LoanUPCodeHandler.CONTRACTORS_MALFEASANCE => 'Contractor\'s Malfeasance',
		LoanUPCodeHandler.CUSTOM_RE => 'Custom - Re',
		LoanUPCodeHandler.CUSTOM_CONTENTS => 'Custom - Contents'
	};

	public DisbursementLineItemHandler() {}

	public List<Disbursement_Line_Item__c> createDisbursementLineItems(List<Disbursement__c> disbursements) {
		List<Disbursement_Line_Item__c> disbursementLineItems = new List<Disbursement_Line_Item__c>();
		List<Id> applicationIds = getApplicationIdsFromDisbursement(disbursements);
		List<Loan__c> loans = loanDA.getLoansByApplicationIds(applicationIds);
		Map<Loan__c, Disbursement__c> loanDisbursementMap = createLoanDisbursementMap(loans, disbursements);
		List<String> categories;

		for(Loan__c loan : loanDisbursementMap.keySet()) {
			categories = getLoanUPCodeCategories(loan);
			for(String category : categories) {
				System.debug(category);
					disbursementLineItems.add(new Disbursement_Line_Item__c(
						Disbursement__c = loanDisbursementMap.get(loan).Id, 
						Category__c = upCodeCatToLineItemCat.get(category)));
			}
		}
		return disbursementLineItems;
	}

	private List<String> getLoanUPCodeCategories(Loan__c loan) {
		List<String> categories;
		categories = String.isNotEmpty(loan.Non_Zero_Categories__c)?loan.Non_Zero_Categories__c.split(','):new List<String>();
		System.debug(categories);
		return categories;
	}

	private List<Id> getApplicationIdsFromDisbursement(List<Disbursement__c> disbursements) {
		Set<Id> applicationIds = new Set<Id>();

		for(Disbursement__c disbursement : disbursements) {
			applicationIds.add(disbursement.Loan__r.Application__c);
		}
		List<Id> appIds = new List<Id>();
		appIds.addAll(applicationIds);

		return appIds;
	}

	private Map<Loan__c, Disbursement__c> createLoanDisbursementMap(List<Loan__c> loans, List<Disbursement__c> disbursements) {
		Map<Loan__c, Disbursement__c> loanDisbursementMap = new Map<Loan__c, Disbursement__c>();
		for(Loan__c loan : loans) {
			for(Disbursement__c disbursement : disbursements) {
				if(disbursement.Loan__c == loan.Id){
					loanDisbursementMap.put(loan, disbursement);
				}
			}	
		}
		return loanDisbursementMap;
	}

}