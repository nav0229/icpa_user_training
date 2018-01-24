/****************************************************************
 Name: CreditBureauDAO
============================================================
Author: Lenny
Purpose: Data Access Object for Credit_Bureau__c
============================================================

****************************************************************/
public interface CreditBureauDAO {
	void insertCreditBureau(Credit_Bureau__c creditBureau);
	void insertCreditBureaus(List<Credit_Bureau__c> creditBureaus);
	void updateCreditBureaus(List<Credit_Bureau__c> creditBureaus);

	List<Credit_Bureau__c> getActiveCreditBureausById(List<Id> creditBureauIds);
	List<Credit_Bureau__c> getActiveCreditBureausByApplicationLatestFirst(Application__c app);
	List<Credit_Bureau__c> getActiveCreditBureausByApplicantId(List<Id> applicantIds);
	List<Credit_Bureau__c> getActiveCreditBureausByApplicationIds(List<Id> applicationIds);
}