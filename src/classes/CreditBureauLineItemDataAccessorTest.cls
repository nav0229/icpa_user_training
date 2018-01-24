@isTest
private class CreditBureauLineItemDataAccessorTest {
	
	@isTest static void insertCreditBureauLineItem_givenACreditBureauLineItem_shouldInsertCreditBureauLineItem() {
		CreditBureauLineItemDataAccessor cbrLineItemDA = new CreditBureauLineItemDataAccessor();
		
		Credit_Bureau__c testCBR = new Credit_Bureau__c(
			Name = 'Test CBR',
			Credit_Score__c = 'Zero',
			Active__c = true
		);
		insert testCBR;

		Credit_Bureau_Line_Item__c testCBRLineItem = new Credit_Bureau_Line_Item__c(
			Name = 'Test Line Item',
			Credit_Bureau__c = testCBR.Id
		);

		Test.startTest();
			cbrLineItemDA.insertCreditBureauLineItem(testCBRLineItem);
		Test.stopTest();

		System.assert(testCBRLineItem.Id != null, 'The test Credit_Bureau_Line_Item__c should have been inserted and have an Id.');
	}

	@isTest static void updateCreditBureauLineItem_givenACreditBureauLineItem_shouldUpdateCreditBureauLineItem() {
		CreditBureauLineItemDataAccessor cbrLineItemDA = new CreditBureauLineItemDataAccessor();

		Credit_Bureau__c testCBR = new Credit_Bureau__c(
			Name = 'Test CBR',
			Credit_Score__c = 'Zero',
			Active__c = true
		);
		insert testCBR;

		Credit_Bureau_Line_Item__c testCBRLineItem = new Credit_Bureau_Line_Item__c(
			Name = 'Test Line Item',
			Credit_Bureau__c = testCBR.Id
		);
		insert testCBRLineItem;

		testCBRLineItem.Creditor_Name__c = 'Test Name';

		Test.startTest();
			cbrLineItemDA.updateCreditBureauLineItem(testCBRLineItem);
		Test.stopTest();

		System.assert(
			testCBRLineItem.Creditor_Name__c != null,
			'The test Credit_Bureau_Line_Item__c should have been updated and have the Creditor_Name__c field populated.'
		);
		System.assertEquals(
			testCBRLineItem.Creditor_Name__c,
			'Test Name',
			'The value of the Creditor_Name__c field of the updated test Credit_Bureau_Line_Item__c that was inserted is not what was supplied.'
		);
	}

	@isTest static void getActiveCreditBureauLineItemsByApplicationIds_givenAnAppId_shouldRetrieveCreditBureauLineItem() {
		CreditBureauLineItemDataAccessor cbrLineItemDA = new CreditBureauLineItemDataAccessor();

		Application__c testApp = new Application__c(
			Name = '11111111',
			Family_Size__c = 2
		);
		insert testApp;

		Credit_Bureau__c testCBR = new Credit_Bureau__c(
			Name = 'Test CBR',
			Application__c = testApp.Id,
			Credit_Score__c = 'Zero',
			Active__c = true
		);
		insert testCBR;

		Credit_Bureau_Line_Item__c testCBRLineItem = new Credit_Bureau_Line_Item__c(
			Name = 'Test Line Item',
			Credit_Bureau__c = testCBR.Id,
			Purpose_Of_Account_Code__c = '1'
		);
		insert testCBRLineItem;

		Test.startTest();
			List<Credit_Bureau_Line_Item__c> retrievedCBRLineItem = cbrLineItemDA.getActiveCreditBureauLineItemsByApplicationIds(new List<Id>{testApp.Id}, 
				new Set<String>{'1'}, new Set<String>(), new Set<String>(), ''); 
		Test.stopTest();

		System.assert(retrievedCBRLineItem != null, 'The test Credit_Bureau_Line_Item__c that was inserted should have been retrieved.');
		System.assertEquals(
			retrievedCBRLineItem[0].Id,
			testCBRLineItem.Id,
			'Id of retrieved Credit_Bureau_Line_Item__c should be the Id of the test Credit_Bureau_Line_Item__c.'
		);
	}
	
}