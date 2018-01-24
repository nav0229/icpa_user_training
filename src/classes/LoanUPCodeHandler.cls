/****************************************************************
 Name:  LoanUPCodeHandler
============================================================
Author: Matt
Purpose: helper for handling upcode amounts for Loans                                                                                                  
============================================================

****************************************************************/

public with sharing class LoanUPCodeHandler {
	@TestVisible private static LossVerificationDAO lossVerificationDA = new LossVerificationDataAccessor();

	public static final String CONTENTS = 'CONTENTS';
	public static final String MOTOR_VEHICLE = 'MOTOR VEHICLE';
	public static final String REAL_ESTATE_REPAIR_REPLACE = 'REAL ESTATE (REPAIR/REPLACE)';
	public static final String REFINANCING = 'REFINANCING';
	public static final String REPAY_IHP = 'REPAY IHP';
	public static final String REAL_ESTATE_OTHER = 'REAL ESTATE (OTHER)';
	public static final String MITIGATION = 'MITIGATION';
	public static final String INTERIM_FINANCING = 'INTERIM FINANCING';
	public static final String CONTRACTORS_MALFEASANCE = 'CONTRACTOR\'S MALFEASANCE';
	public static final String CUSTOM_RE = 'CUSTOM - RE';
	public static final String CUSTOM_CONTENTS = 'CUSTOM - CONTENTS';

	private final Map<String, List<String>> fieldTotalAPI = new Map<String, List<String>>{
		CONTENTS => new list<String>{'Total_Eligible_Contents__c', 'Balance_Contents__c'},
		MOTOR_VEHICLE => new list<String>{'Total_Eligible_Motor_Vehicle__c', 'Balance_Motor_Vehicle__c'},
		REAL_ESTATE_REPAIR_REPLACE => new list<String>{'Total_Eligible_Real_Estate_Repair__c', 'Balance_Real_Estate_Repair__c'},
		REFINANCING => new list<String>{'Total_Eligible_Refinancing__c', 'Balance_Refinancing__c'},
		REPAY_IHP => new list<String>{'Total_Eligible_Repay_IHP__c', 'Balance_Repay_IHP__c'},
		REAL_ESTATE_OTHER => new list<String>{'Total_Eligible_Real_Estate_Other__c', 'Balance_Real_Estate_Other__c'},
		MITIGATION => new list<String>{'Total_Eligible_Mitigation__c', 'Balance_Mitigation__c'},
		INTERIM_FINANCING => new list<String>{'Total_Eligible_Interim_Financing__c', 'Balance_Interim_Financing__c'},
		CONTRACTORS_MALFEASANCE => new list<String>{'Total_Eligible_Contractor_Malfeasance__c', 'Balance_Contractor_Malfeasance__c'},
		CUSTOM_RE => new list<String>{'Total_Eligible_Custom_RE__c', 'Balance_Custom_RE__c'},
		CUSTOM_CONTENTS => new list<String>{'Total_Eligible_Custom_Contents__c', 'Balance_Custom_Contents__c'}
	};

	public LoanUPCodeHandler() {}

	public Set<Loan__c> setUPCodeTotalAmounts(Set<Loan__c> loans) {
		Map<Loan__c, List<UP_Codes__c>> loanUPCodeMap = createLoanUpCodeMap(loans);
		Set<Loan__c> finishedLoans = new Set<Loan__c>();

		for(Loan__c loan : loanUPCodeMap.keySet()) {
			finishedLoans.add(setAmountSumsForCategories(loan, loanUPCodeMap.get(loan)));
		}

		return finishedLoans;
	}

	private Loan__c setAmountSumsForCategories(Loan__c loan, List<UP_Codes__c> upCodes) {
		Set<String> nonZeroCategories = new Set<String>();
		List<String> nonZeroCategoriesList = new List<String>();
		Decimal catTotal = 0;

		for(UP_Codes__c upCode : upCodes) {
			if(upCode.Amount__c > 0 && upCode.New_Category__c != null) {
				catTotal = getCategoryTotal(loan, upCode);
				loan.put(fieldTotalAPI.get(upCode.New_Category__c)[0], (catTotal + upCode.Amount__c));
				nonZeroCategories.add(upCode.New_Category__c);
			}
		}

		nonZeroCategoriesList.addAll(nonZeroCategories);
		loan.Non_Zero_Categories__c = String.join(nonZeroCategoriesList,',');

		return loan;
	}

	private Decimal getCategoryTotal(Loan__c loan, UP_Codes__c upCode) {
		Decimal total = (Decimal)loan.get(fieldTotalAPI.get(upcode.New_Category__c)[0]);

		if(total == null) {
			return 0;
		}
		return total;
	}

	private Map<Loan__c, List<UP_Codes__c>> createLoanUpCodeMap(Set<Loan__c> loans) {
		Map<Loan__c, List<UP_Codes__c>> loanUpCodeMap = new Map<Loan__c, List<UP_Codes__c>>();
		List<Loss_Verification_Inspections__c> lvs;
		Set<Id> applicationIds = new Set<Id>();
		for(Loan__c loan : loans) {
			applicationIds.add(loan.Application__c);
		}
		
		List<Id> appIdList = new List<Id>();
		appIdList.addAll(applicationIds);
		try{
			lvs = lossVerificationDA.getLossVerificationsAndRelatedUPCodesByApplicationIds(appIdList);
		}catch(Exception e) {
			System.debug(e.getMessage());
			throw new LoanUPCodeHandlerException('Error accured while getting Loss verifications and UP Codes by Applications Ids', e);
		}

		for(Loan__c loan : loans) {
			for(Loss_Verification_Inspections__c lv : lvs) {
				if(lv.Property__r.Application__r.Id == loan.Application__c) {
					loanUpCodeMap.put(loan, lv.UP_Codes__r);
				}
			}
		}

		return loanUpCodeMap;
	}

	public class LoanUPCodeHandlerException extends Exception{}
}