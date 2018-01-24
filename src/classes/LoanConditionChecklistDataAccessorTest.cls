@isTest
private class LoanConditionChecklistDataAccessorTest {
	
	@isTest static void insertLoanConditionChecklists_givenALoanConditionChecklist_shouldInsertLoanCondition() {
		LoanConditionChecklistDataAccessor loanConditionChecklistDA = new LoanConditionChecklistDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Master_Checklist__c testMC = new Master_Checklist__c(
			Name = 'Test Master Checklist',
			Checklist_Type__c = 'Loan Condition'
		);
		insert testMC;

		Loan_Condition_Checklist__c testLoanCondition = new Loan_Condition_Checklist__c(
			Name = 'Test Loan Condition Checklist',
			Application__c = testApplication.Id,
			Loan__c = testLoan.Id,
			Master_Checklist__c = testMC.Id
		);

		Test.startTest();
			loanConditionChecklistDA.insertLoanConditionChecklists(new List<Loan_Condition_Checklist__c>{testLoanCondition});
		Test.stopTest();

		System.assert(
			testLoanCondition.Id != null,
			'The test Loan Condition Checklist should have been inserted.'
		);

	}

	@isTest static void getActiveLoanConditionChecklistsByApplicationIds_givenAnApplicationId_shouldRetrieveRelatedLC() {
		LoanConditionChecklistDataAccessor loanConditionChecklistDA = new LoanConditionChecklistDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Master_Checklist__c testMC = new Master_Checklist__c(
			Name = 'Test Master Checklist',
			Checklist_Type__c = 'Loan Condition'
		);
		insert testMC;

		Loan_Condition_Checklist__c testLoanCondition = new Loan_Condition_Checklist__c(
			Name = 'Test Loan Condition Checklist',
			Application__c = testApplication.Id,
			Loan__c = testLoan.Id,
			Master_Checklist__c = testMC.Id,
			Active__c = true
		);
		insert testLoanCondition;

		Test.startTest();
			List<Loan_Condition_Checklist__c> retrievedLCs = loanConditionChecklistDA.getActiveLoanConditionChecklistsByApplicationIds(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertNotEquals(
			0,
			retrievedLCs.size(),
			'The test Loan Condition Checklist should have been retrieved given the test application Id as input.'
		);
	}
	
	@isTest static void getActiveLoanConditionChecklistsByIds_givenALoanConditionId_shouldRetrieveRelatedLC() {
		LoanConditionChecklistDataAccessor loanConditionChecklistDA = new LoanConditionChecklistDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Master_Checklist__c testMC = new Master_Checklist__c(
			Name = 'Test Master Checklist',
			Checklist_Type__c = 'Loan Condition'
		);
		insert testMC;

		Loan_Condition_Checklist__c testLoanCondition = new Loan_Condition_Checklist__c(
			Name = 'Test Loan Condition Checklist',
			Application__c = testApplication.Id,
			Loan__c = testLoan.Id,
			Master_Checklist__c = testMC.Id,
			Active__c = true
		);
		insert testLoanCondition;

		Test.startTest();
			List<Loan_Condition_Checklist__c> retrievedLCs = loanConditionChecklistDA.getActiveLoanConditionChecklistsByIds(new List<Id>{testLoanCondition.Id});
		Test.stopTest();

		System.assertNotEquals(
			0,
			retrievedLCs.size(),
			'The test Loan Condition Checklist should have been retrieved given the test Loan Condition Id as input.'
		);
	}
}