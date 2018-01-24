/****************************************************************
 Name: LoanConditionElementTrigger
============================================================
Author: Kevin
Purpose: DCMM-2148
	Trigger for Loan_Condition_Element__c
============================================================

****************************************************************/
trigger LoanConditionElementTrigger on Loan_Condition_Element__c (after insert, after update) {
	LoanConditionElementTriggerHelper loanConditionElementTriggerHelper = new LoanConditionElementTriggerHelper();

	if(trigger.isAfter){
		if(trigger.isInsert){
			loanConditionElementTriggerHelper.afterInsert(trigger.new);
		} else if(trigger.isUpdate){
			loanConditionElementTriggerHelper.afterUpdate(trigger.new, trigger.oldMap);
		}
	}
}