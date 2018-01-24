/****************************************************************
 Name: SBALoanHistoryDAO
============================================================
Author: 
Purpose: Data Access Object for SBA_Loan_History__c
============================================================

****************************************************************/

public interface SBALoanHistoryDAO {
	List<SBA_Loan_History__c> getSBALoanHistoriesByApplicationIds(List<Id> applicationIds);
}