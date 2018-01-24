/****************************************************************
 Name: LoanConditionChecklistDAO
============================================================
Author: 
Purpose: Data Access Object for Loan_Condition_Checklist__c
============================================================

****************************************************************/

public interface LoanConditionChecklistDAO {

	void insertLoanConditionChecklists(List<Loan_Condition_Checklist__c> loanConditionChecklists);
	List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByApplicationIds(List<Id> applicationIds);
	List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByIds(List<Id> loanConditionIds);
}