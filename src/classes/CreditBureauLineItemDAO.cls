/****************************************************************
 Name: CreditBureauLineItemDAO
============================================================
Author: Kevin
Purpose: Data Access Object for Credit_Bureau_Line_Item__c
============================================================

****************************************************************/
public interface CreditBureauLineItemDAO {
	void insertCreditBureauLineItem(Credit_Bureau_Line_Item__c cbrLineItem);
	void updateCreditBureauLineItem(Credit_Bureau_Line_Item__c cbrLineItem);
	void updateCreditBureauLineItems(List<Credit_Bureau_Line_Item__c> cbLineItems);

	List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIds(List<Id> applicationIds);
	List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicantId(List<Id> applicantIds);
	List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIds(List<Id> appIds, Set<String> purposeOfAccountCodes, 
		Set<String> paymentStatusCodes, Set<String> accountConditionCodes, String paymentStatusForeclose);
}