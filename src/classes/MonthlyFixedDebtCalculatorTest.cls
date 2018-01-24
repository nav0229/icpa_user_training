@isTest
private class MonthlyFixedDebtCalculatorTest {
	
	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdAndRelatedRevolvingCBRLineItem_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();


		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Creditor_Type__c', 'R');
		creditBureauLineItemMockBuilder.setField('Account_Balance__c', '1500');
		creditBureauLineItemMockBuilder.setField('Monthly_Payments__c', '100');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assertEquals(
			100,
			testApp.Monthly_Fixed_Debt__c,
			'With the given related Credit Bureau Line Item, Monthly Fixed Debt should be 100'
		);

	}

	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdAndRelatedRevolvingCBRLineItemThatRequiresTheThreePercentRule_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();


		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Creditor_Type__c', 'R');
		creditBureauLineItemMockBuilder.setField('Account_Balance__c', '1500');
		creditBureauLineItemMockBuilder.setField('Monthly_Payments__c', '0');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assertEquals(
			testCBRLineItem.Account_Balance__c * 0.03,
			testApp.Monthly_Fixed_Debt__c,
			'With the given related Credit Bureau Line Item, Monthly Fixed Debt should be ' + (testCBRLineItem.Account_Balance__c * 0.03)
		);

	}
	
	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdAndRelatedInstallmentCBRLineItem_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();


		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Creditor_Type__c', 'I');
		creditBureauLineItemMockBuilder.setField('Account_Balance__c', '1500');
		creditBureauLineItemMockBuilder.setField('Monthly_Payments__c', '100');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assertEquals(
			100,
			testApp.Monthly_Fixed_Debt__c,
			'With the given related Credit Bureau Line Item, Monthly Fixed Debt should be 100'
		);
	}

	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdAndRelatedDebtExpense_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApp.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Medical Costs');
		debtsExpensesMockBuilder.setField('Monthly_Payment__c', '100');
		debtsExpensesMockBuilder.setField('Is_Included_in_MFD_Calc__c', 'false');
		debtsExpensesMockBuilder.setField('Id', debtsExpensesMockBuilder.getMockId());

		Debts_Expenses__c testDebtExpense = (Debts_Expenses__c) debtsExpensesMockBuilder.build();
		debtsExpensesMockDA.getDebtsAndExpensesByApplicationIdReturn.add(testDebtExpense);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assert(
			testDebtExpense.Is_Included_in_MFD_Calc__c,
			'The test debt expense related to the test Application should be marked as included in MFD calculation'
		);

		System.assertEquals(
			100,
			testApp.Monthly_Fixed_Debt__c,
			'With the given Debt Expense, Monthly Fixed Debt should be 100'
		);
	}

	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdAndRelatedMortgageDebtExpense_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApp.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Monthly_Payment__c', '100');
		debtsExpensesMockBuilder.setField('Is_Included_in_MFD_Calc__c', 'false');
		debtsExpensesMockBuilder.setField('Id', debtsExpensesMockBuilder.getMockId());

		Debts_Expenses__c testDebtExpense = (Debts_Expenses__c) debtsExpensesMockBuilder.build();
		debtsExpensesMockDA.getDebtsAndExpensesByApplicationIdReturn.add(testDebtExpense);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assert(
			testDebtExpense.Is_Included_in_MFD_Calc__c,
			'The test debt expense related to the test Application should be marked as included in MFD calculation'
		);

		System.assertEquals(
			100,
			testApp.Monthly_Fixed_Debt__c,
			'With the given Debt Expense, Monthly Fixed Debt should be 100'
		);
	}

	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdRelatedRevolvingCBRLineItemAndRelatedDebtExpense_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('Gross_Monthly_Income_rollup__c', '100');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();

		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Creditor_Type__c', 'R');
		creditBureauLineItemMockBuilder.setField('Account_Balance__c', '1500');
		creditBureauLineItemMockBuilder.setField('Monthly_Payments__c', '100');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApp.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Medical Costs');
		debtsExpensesMockBuilder.setField('Monthly_Payment__c', '100');
		debtsExpensesMockBuilder.setField('Is_Included_in_MFD_Calc__c', 'false');
		debtsExpensesMockBuilder.setField('Id', debtsExpensesMockBuilder.getMockId());

		Debts_Expenses__c testDebtExpense = (Debts_Expenses__c) debtsExpensesMockBuilder.build();
		debtsExpensesMockDA.getDebtsAndExpensesByApplicationIdReturn.add(testDebtExpense);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assert(
			testDebtExpense.Is_Included_in_MFD_Calc__c,
			'The test debt expense related to the test Application should be marked as included in MFD calculation'
		);

		System.assertEquals(
			200,
			testApp.Monthly_Fixed_Debt__c,
			'With the given Debt Expense and Credit Bureau Line Item, Monthly Fixed Debt should be 200'
		);
	}

	@isTest static void calculateTotalMonthlyFixedDebt_givenAnApplicationIdWithIRSActualIncome_shouldUpdateMonthlyFixedDebt() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemMockDA = new CreditBureauLineItemDataAccessorMock(); 
		DebtsExpensesDataAccessorMock debtsExpensesMockDA = new DebtsExpensesDataAccessorMock();
		MonthlyFixedDebtCalculator.applicationDA = applicationMockDA;
		MonthlyFixedDebtCalculator.creditBureauLineItemDA = cbrLineItemMockDA;
		MonthlyFixedDebtCalculator.debtsExpensesDA = debtsExpensesMockDA;
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '0');
		applicationMockBuilder.setField('IRS_Actual_Income__c', '100');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApp.Id, testApp);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', testApp.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();

		MockSObjectBuilder creditBureauLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		creditBureauLineItemMockBuilder.setField('Credit_Bureau__c', testCBR.Id);
		creditBureauLineItemMockBuilder.setField('Creditor_Type__c', 'R');
		creditBureauLineItemMockBuilder.setField('Account_Balance__c', '1500');
		creditBureauLineItemMockBuilder.setField('Monthly_Payments__c', '100');
		creditBureauLineItemMockBuilder.setField('Id', creditBureauLineItemMockBuilder.getMockId());

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c)creditBureauLineItemMockBuilder.build();
		testCBRLineItem.Credit_Bureau__r = testCBR;
		cbrLineItemMockDA.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApp.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Medical Costs');
		debtsExpensesMockBuilder.setField('Monthly_Payment__c', '100');
		debtsExpensesMockBuilder.setField('Is_Included_in_MFD_Calc__c', 'false');
		debtsExpensesMockBuilder.setField('Id', debtsExpensesMockBuilder.getMockId());

		Debts_Expenses__c testDebtExpense = (Debts_Expenses__c) debtsExpensesMockBuilder.build();
		debtsExpensesMockDA.getDebtsAndExpensesByApplicationIdReturn.add(testDebtExpense);

		Test.startTest();
			mfdCalculator.calculateTOtalMonthlyFixedDebt(new List<Id>{testApp.Id});
		Test.stopTest();

		System.assert(
			applicationMockDA.updateApplicationsCallCount > 0,
			'Update Application should have been called, but was not'
		);

		System.assert(
			testDebtExpense.Is_Included_in_MFD_Calc__c,
			'The test debt expense related to the test Application should be marked as included in MFD calculation'
		);

		System.assertEquals(
			200,
			testApp.Monthly_Fixed_Debt__c,
			'With the given Debt Expense and Credit Bureau Line Item, Monthly Fixed Debt should be 200'
		);
	}
}