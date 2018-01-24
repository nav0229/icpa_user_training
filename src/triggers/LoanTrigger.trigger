/****************************************************************
 Name:  LoanTrigger
============================================================
Author: Matt
Purpose: Trigger for Loans                                                                                                            
============================================================

****************************************************************/

trigger LoanTrigger on Loan__c (before update) {
	LoanTriggerHelper loanTriggerHelper = new LoanTriggerHelper();

	if(trigger.isBefore) {
		if(trigger.isUpdate) {
			loanTriggerHelper.handleReRunStatusChangesAndDisbursement(trigger.new, trigger.oldMap);
		}
	}
}