@isTest
private class DebtsExpensesDataAccessorTest {
	
	@isTest static void getDebtsAndExpensesByApplicationId_givenAnApplicationId_shouldRetrieveRelatedDebtExpense() {
		DebtsExpensesDataAccessor debtExpenseDA = new DebtsExpensesDataAccessor();
		Application__c testApplication = new Application__c(Name='123456789',Family_Size__c = 2);
		insert testApplication;

		Debts_Expenses__c testDebtExpense = new Debts_Expenses__c(
			Application__c = testApplication.Id,
			Name = 'Test Debt Expense',
			Balance__c = 1000
		);
		insert testDebtExpense;

		Test.startTest();
			List<Debts_Expenses__c> retrievedDebtsExpenses = debtExpenseDA.getDebtsAndExpensesByApplicationId(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assert(
			!retrievedDebtsExpenses.isEmpty(),
			'With the given Application Id, Debts/Expenses should have been retrieved.'
		);

		System.assertEquals(
			testDebtExpense.Id,
			retrievedDebtsExpenses[0].Id,
			'The incorrect Debts/Expenses record was retrieved for the given Application Id.'
		);
	}
	
	@isTest static void updateDebtsAndExpenses_givenADebtExpense_shouldUpdateDebtExpense() {
		DebtsExpensesDataAccessor debtExpenseDA = new DebtsExpensesDataAccessor();
		Application__c testApplication = new Application__c(Name='123456789',Family_Size__c = 2);
		insert testApplication;

		Debts_Expenses__c testDebtExpense = new Debts_Expenses__c(
			Application__c = testApplication.Id,
			Name = 'Test Debt Expense',
			Balance__c = 1000
		);
		insert testDebtExpense;

		testDebtExpense.Balance__c = 5000;

		Test.startTest();
			debtExpenseDA.updateDebtsAndExpenses(new List<Debts_Expenses__c>{testDebtExpense});
		Test.stopTest();

		Debts_Expenses__c updatedDebtExpense = [
			SELECT Id, Name, Balance__c
			FROM Debts_Expenses__c
			WHERE Id = :testDebtExpense.Id
			LIMIT 1
		];

		System.assert(
			updatedDebtExpense != null,
			'A Debt/Expense record should exist for the given Debt/Expense Id.'
		);

		System.assertEquals(
			testDebtExpense.Balance__c,
			updatedDebtExpense.Balance__c,
			'The Debt/Expense record for the given Debt/Expense Id should have been updated.'
		);
	}
	
}