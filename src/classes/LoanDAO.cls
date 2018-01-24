/****************************************************************
 Name: LoanDAO
============================================================
Author: 
Purpose: Data Access object for Loan__c
============================================================

****************************************************************/

public interface LoanDAO {
	List<Loan__c> getLoansByApplicationId(Id applicationId);
	List<Loan__c> getLoansByApplicationIds(List<Id> applicationIds);
	List<Loan__c> getLoansByLoanIds(List<Id> loanIds);
	void updateLoans(List<Loan__c> loans);
}