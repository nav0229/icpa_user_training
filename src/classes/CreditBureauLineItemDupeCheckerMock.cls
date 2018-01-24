@isTest
public with sharing class CreditBureauLineItemDupeCheckerMock implements CreditBureauLineItemDupeCheckerInterface {
	public Integer checkForDuplicatesCallCount {get; private set;}

	public CreditBureauLineItemDupeCheckerMock() {
		checkForDuplicatesCallCount = 0;
	}

	public void markDuplicateRelatedCBLineItems(List<Application__c> applicationsForCBLineItemDedupe){
		checkForDuplicatesCallCount++;
	}
}