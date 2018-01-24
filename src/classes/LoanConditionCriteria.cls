/****************************************************************
 Name: LoanConditionCriteria
============================================================
Author: Kevin
Purpose: DCMM-2148
	Wrapper class to house the various components necessary for
	determining which Loan Condition Elements should be generated
============================================================

****************************************************************/
public with sharing class LoanConditionCriteria {
	public Loan_Condition_Checklist__c loanCondition { get; private set; }
	public Property__c property { get; private set; }
	public List<UP_Codes__c> upCodes { get; private set; }

	public LoanConditionCriteria(
		Loan_Condition_Checklist__c loanCondition,
		Property__c property,
		List<UP_Codes__c> upCodes
	){
		this.loanCondition = loanCondition;
		this.property = property;
		this.upCodes = upCodes;
	}
}