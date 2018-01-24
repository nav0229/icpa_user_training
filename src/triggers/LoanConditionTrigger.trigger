/****************************************************************
 Name: LoanConditionTrigger
============================================================
Author: Kevin
Purpose: DCMM-2148
	Trigger for Loan_Condition_Checklist__c
============================================================

****************************************************************/
trigger LoanConditionTrigger on Loan_Condition_Checklist__c (after insert) {
	LoanConditionTriggerHelper loanConditionTriggerHelper = new LoanConditionTriggerHelper();

	if(trigger.isAfter){
		if(trigger.isInsert){
			loanConditionTriggerHelper.afterInsert(trigger.new);
		}
	}
}