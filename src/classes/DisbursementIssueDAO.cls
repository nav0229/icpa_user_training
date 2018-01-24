/****************************************************************
 Name: DisbursementIssueDAO
============================================================
Author: Matt
Purpose: Data Access Object for Disbursement Object
============================================================

****************************************************************/

public interface DisbursementIssueDAO {
	List<Disbursement_Issue__c> getDisbursementIssuesByLoanIds(List<Id> loanId);

	void updateDisbursementIssues(List<Disbursement_Issue__c> disbursementIssues);
	void insertDisbursementIssues(List<Disbursement_Issue__c> disbursementIssues);
}