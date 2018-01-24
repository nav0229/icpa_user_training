/****************************************************************
 Name: DisbursementDAO
===========n=================================================
Author: 
Purpose: Data Access Object for Disbursement
============================================================

****************************************************************/

public interface DisbursementDAO {
	List<Disbursement__c> getDisbursementsByLoanIds(List<Id> loanId);
	List<Disbursement__c> getDisbursementsAndLineItemsByDisbursementIds(List<Id> disbursementIds);
	List<Disbursement__c> getDisbursementsAndLineItemsByLoanIds(List<Id> loanId);
	void updateDisbursements(List<Disbursement__c> disbursementIssues);
	void insertDisbursements(List<Disbursement__c> disbursementIssues);
}