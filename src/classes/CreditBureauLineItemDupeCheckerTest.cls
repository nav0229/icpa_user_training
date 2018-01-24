@isTest
private class CreditBureauLineItemDupeCheckerTest
{
	@isTest
	static void checkForDuplicates_givenEmptyList_shouldNotThrowError(){
		CreditBureauLineItemDupeChecker testDupeChecker = new CreditBureauLineItemDupeChecker();

		Test.startTest();
			try {
				testDupeChecker.markDuplicateRelatedCBLineItems(new List<Application__c>());
			} catch(Exception e) {
				System.assert(false);
			}
		Test.stopTest();

		System.assert(true);
	}

	@isTest
	static void checkForDuplicates_givenCBLineItemWithNoMatches_shouldNotMarkAsDuplicate(){

	}

	@isTest
	static void checkForDuplicates_givenCBLineItemWithMatch_shouldMarkAsDuplicate(){

	}

	@isTest
	static void checkForDuplicates_givenTwoMatchingCBLineItems_shouldMarkOneAsDuplicate(){

	}
}