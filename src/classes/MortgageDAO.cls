/****************************************************************
 Name: MortgageDAO
============================================================
Author: Matt/
Purpose: 1340
Data Access Object for Mortgage__c
============================================================

****************************************************************/

public interface MortgageDAO {
	void updateMortgages(List<Mortgage__c> mortgages);

	List<Mortgage__c> getMortgageByApplicationIds(List<Id> applicationIds);
}