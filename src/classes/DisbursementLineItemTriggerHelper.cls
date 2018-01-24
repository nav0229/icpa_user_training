/****************************************************************
 Name: DisbursementLineItemTrigger
============================================================
Author: Matt
Purpose: Trigger helper for Disbursement Line Items
============================================================

****************************************************************/

public with sharing class DisbursementLineItemTriggerHelper {
	@TestVisible public static LoanDAO loanDA = new LoanDataAccessor();
	@TestVisible public static DisbursementDAO disbursementDA = new DisbursementDataAccessor();

	private final Map<String, List<String>> categoryToLoanDisbursedFieldMap = new Map<String, List<String>>
	{
		'Contents' => new list<String>{'Disbursed_Amount_Contents__c', 'Balance_Contents__c', 'Total_Eligible_Contents__c', '0'},
		'Motor Vehicle' => new list<String>{'Disbursed_Amount_Motor_Vehicle__c', 'Balance_Motor_Vehicle__c', 'Total_Eligible_Motor_Vehicle__c', '0'},
		'Real Estate (Repair/Replace)' => new list<String>{'Disbursed_Amount_Real_Estate_Repair__c', 'Balance_Real_Estate_Repair__c', 'Total_Eligible_Real_Estate_Repair__c', '0'},
		'Refinancing' => new list<String>{'Disbursed_Amount_Refinancing__c', 'Balance_Refinancing__c', 'Total_Eligible_Refinancing__c', '0'},
		'Repay IHP' => new list<String>{'Disbursed_Amount_Repay_IHP__c', 'Balance_Repay_IHP__c', 'Total_Eligible_Repay_IHP__c', '0'},
		'Real Estate (Other)' => new list<String>{'Disbursed_Amount_Real_Estate_Other__c', 'Balance_Real_Estate_Other__c', 'Total_Eligible_Real_Estate_Other__c', '0'},
		'Mitigation' => new list<String>{'Disbursed_Amount_Mitigation__c', 'Balance_Mitigation__c', 'Total_Eligible_Mitigation__c', '0'},
		'Interim Financing' => new list<String>{'Disbursed_Amount_Interim_Financing__c', 'Balance_Interim_Financing__c', 'Total_Eligible_Interim_Financing__c', '0'},
		'Contractor\'s Malfeasance' => new list<String>{'Disbursed_Amt_Contractor_Malfeasance__c', 'Balance_Contractor_Malfeasance__c', 'Total_Eligible_Contractor_Malfeasance__c', '0'},
		'Custom - Re' => new list<String>{'Disbursed_Amount_Custom_RE__c', 'Balance_Custom_RE__c', 'Total_Eligible_Custom_RE__c', '0'},
		'Custom - Contents' => new list<String>{'Disbursed_Amount_Custom_Contents__c', 'Balance_Custom_Contents__c', 'Total_Eligible_Custom_Contents__c', '0'}
	};

	public DisbursementLineItemTriggerHelper() {
		
	}

	public void afterUpdate(List<Disbursement_Line_Item__c> disbursementLineItems) {
		Map<Loan__c,List<Disbursement_Line_Item__c>> loanDisbursementLineItemMap = createLoanDisbursementLineItemMap(disbursementLineItems);
		Set<Loan__c> loansToUpdate = new Set<Loan__c>();

		for(Loan__c loan : loanDisbursementLineItemMap.keySet()) {
			for(Disbursement_Line_Item__c lineItem : loanDisbursementLineItemMap.get(loan)) {
				if(lineItem.Disbursed_Amount__c != null && lineItem.Category__c != null) {

					categoryToLoanDisbursedFieldMap.get(lineItem.Category__c)[3] = String.valueOf(Decimal.ValueOf(categoryToLoanDisbursedFieldMap.get(lineItem.Category__c)[3]) +
						lineItem.Disbursed_Amount__c);


				}
			}
			loan = assignAndResetDisbursedAmount(loan);
			loansToUpdate.add(loan);
		}
		updateLoans(loansToUpdate);
	}


	private Loan__c assignAndResetDisbursedAmount(Loan__c loan) {
		for(List<String> values : categoryToLoanDisbursedFieldMap.values()) {
			loan.put(values[0], Decimal.ValueOf(values[3]));
			loan.put(values[1], (Decimal) loan.get(values[2]) - (Decimal) loan.get(values[0]));
		}

		return loan;
	}

	private Boolean lineItemChanged(List<Disbursement_Line_Item__c> disbursementLineItems, Disbursement_Line_Item__c dli) {
		for(Disbursement_Line_Item__c dliList : disbursementLineItems) {
			if(dliList.Id == dli.Id) {
				return true;
			}
		}
		return false;
	}

	private Map<Loan__c,List<Disbursement_Line_Item__c>> createLoanDisbursementLineItemMap(List<Disbursement_Line_Item__c> disbursementLineItems){
		Map<Loan__c,List<Disbursement_Line_Item__c>> loanLineItemMap = new Map<Loan__c,List<Disbursement_Line_Item__c>>();
		List<Id> disbursementIds = getDisbursementIds(disbursementLineItems);
		List<Disbursement__c> disbursements;
		Set<Id> loanIds = new Set<Id>();
		List<Id> loanIdList = new List<Id>();
		List<Loan__c> loans;

		try{
			disbursements = disbursementDA.getDisbursementsAndLineItemsByDisbursementIds(disbursementIds);
			for(Disbursement__c disbursement : disbursements){
				loanIds.add(disbursement.Loan__c);
			}
			loanIdList.addAll(loanIds);
			loans = loanDA.getLoansByLoanIds(loanIdList);
			disbursements = disbursementDA.getDisbursementsAndLineItemsByLoanIds(loanIdList);
		}catch(QueryException e) {
			System.debug(e.getMessage());
			throw new DisbursementLineItemTriggerHelperException('Error getting disbursement and loan records');
		}

		for(Loan__c loan : loans) {
			List<Disbursement_Line_Item__c> dli = new List<Disbursement_Line_Item__c>();
			for(Disbursement__c disbursement : disbursements) {
				if(loan.Id == disbursement.Loan__c) {
					dli.addAll(disbursement.Disbursement_Line_Items__r);
				}
			}
			loanLineItemMap.put(loan, dli);
		}

		return loanLineItemMap;
	}

	private List<Id> getDisbursementIds(List<Disbursement_Line_Item__c> disbursementLineItems) {
		Set<Id> idSet = new Set<Id>();
		List<Id> idList = new List<Id>();
		for(Disbursement_Line_Item__c dli : disbursementLineItems) {
			idSet.add(dli.Disbursement__c);
		}
		idList.addAll(idSet);
		return idList;
	}

	private Decimal getCategoryOfDisbursed(Loan__c loan, String category) {
		Decimal total = (Decimal)loan.get(categoryToLoanDisbursedFieldMap.get(category)[0]);
		if(total == null) {
			return 0;
		}
		return total;
	}

	private void updateLoans(Set<Loan__c> loans) {
		List<Loan__c> loanList = new List<Loan__c>();
		loanList.addAll(loans);
		try{
			loanDA.updateLoans(loanList);
		}catch(DmlException e) {
			System.debug(e.getMessage());
			throw new DisbursementLineItemTriggerHelperException('Error accured while updating loan records');
		}
	}

	private class DisbursementLineItemTriggerHelperException extends Exception {}
}