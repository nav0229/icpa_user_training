@isTest
private class LoanDataAccessorTest {
	
	@isTest static void getLoansByApplicationId_givenAnApplicationId_shouldRetrieveLoan() {
		LoanDataAccessor loanDA = new LoanDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Test.startTest();
			List<Loan__c> retrievedLoans = loanDA.getLoansByApplicationId(testApplication.Id);
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedLoans.size(),
			'With the given Application Id, one Loan should have been retrieved.'
		);

		System.assertEquals(
			testLoan.Id,
			retrievedLoans[0].Id,
			'The retrieved loan should be the test loan that was inserted.'
		);
	}
	
	@isTest static void getLoansByApplicationIds_givenAnApplicationId_shouldRetrieveLoan() {
		LoanDataAccessor loanDA = new LoanDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Test.startTest();
			List<Loan__c> retrievedLoans = loanDA.getLoansByApplicationIds(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedLoans.size(),
			'With the given Application Id, one Loan should have been retrieved.'
		);

		System.assertEquals(
			testLoan.Id,
			retrievedLoans[0].Id,
			'The retrieved loan should be the test loan that was inserted.'
		);
	}

	@isTest static void updateLoans_givenListOfLoans_ShouldUpdateLoans() {
		LoanDataAccessor loanDA = new LoanDataAccessor();
		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Before Update',
			Application__c = testApplication.Id
		);
		insert testLoan;

		testLoan.Name = 'After Update';

		Test.startTest();
			 loanDA.updateLoans(new List<Loan__c>{testLoan});
		Test.stopTest();

		List<Loan__c> retrievedLoans = loanDA.getLoansByApplicationIds(new List<Id>{testApplication.Id});

		System.assertEquals(
			testLoan.Id,
			retrievedLoans[0].Id,
			'The retrieved loan should be the test loan that was inserted.'
		);

		System.assertEquals(
			testLoan.Name,
			retrievedLoans[0].Name,
			'The retrieved loan should have the same name as the loan that was inserted.'
		);
	}
}