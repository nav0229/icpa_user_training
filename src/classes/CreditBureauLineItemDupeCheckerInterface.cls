/****************************************************************
 Name: CreditBureauLineItemDupeCheckerInterface
============================================================
Author: 
Purpose: Interface for CreditBureauLineItemDupeChecker
============================================================

****************************************************************/

public interface CreditBureauLineItemDupeCheckerInterface {
	void markDuplicateRelatedCBLineItems(List<Application__c> applicationsForCBLineItemDedupe);
}