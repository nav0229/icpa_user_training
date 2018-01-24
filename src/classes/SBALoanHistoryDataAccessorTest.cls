@isTest
private class SBALoanHistoryDataAccessorTest {
	@isTest
	static void getSBALoanHistoriesByApplicationIds_givinListOfOneApplicationId_shouldReturnRelievantSBALoanHistory() {
		SBALoanHistoryDAO sbaLoanHistoryDA = new SBALoanHistoryDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();
		Applicant__c testApplicant = TestDataUtil.insertApplicant();

		SBA_Loan_History__c testSBALoanHistory = new SBA_Loan_History__c();
		testSBALoanHistory.Application__c = testApplication.Id;
		testSBALoanHistory.Applicant__c = testApplicant.Id;
		insert testSBALoanHistory;

		Test.startTest();
			List<SBA_Loan_History__c> sbaLoanHistoryResult = sbaLoanHistoryDA.getSBALoanHistoriesByApplicationIds(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertNotEquals(0, sbaLoanHistoryResult.size());
		System.assertEquals(testApplication.Id, sbaLoanHistoryResult[0].Application__c, 'The result SBA Loan History is incorrect');
	}

	@isTest
	static void getSBALoanHistoriesByApplicationIds_givinListOfApplicationIds_shouldReturnRelievantSBALoanHistories() {
		SBALoanHistoryDAO sbaLoanHistoryDA = new SBALoanHistoryDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();
		Application__c testApplication2 = TestDataUtil.insertApplication();
		Application__c testApplication3 = TestDataUtil.insertApplication();
		Applicant__c testApplicant = TestDataUtil.insertApplicant();

		List<SBA_Loan_History__c> testSBALoanHistories = new List<SBA_Loan_History__c>();

		SBA_Loan_History__c testSBALoanHistory = new SBA_Loan_History__c();
		testSBALoanHistory.Application__c = testApplication.Id;
		testSBALoanHistory.Applicant__c = testApplicant.Id;
		testSBALoanHistories.add(testSBALoanHistory);

		SBA_Loan_History__c testSBALoanHistory2 = new SBA_Loan_History__c();
		testSBALoanHistory2.Application__c = testApplication2.Id;
		testSBALoanHistory2.Applicant__c = testApplicant.Id;
		testSBALoanHistories.add(testSBALoanHistory2);

		SBA_Loan_History__c testSBALoanHistory3 = new SBA_Loan_History__c();
		testSBALoanHistory3.Application__c = testApplication3.Id;
		testSBALoanHistory3.Applicant__c = testApplicant.Id;
		testSBALoanHistories.add(testSBALoanHistory3);

		insert testSBALoanHistories;

		Test.startTest();
			List<SBA_Loan_History__c> sbaLoanHistoryResult = sbaLoanHistoryDA.getSBALoanHistoriesByApplicationIds(
				new List<Id>{testApplication.Id, testApplication2.Id, testApplication3.Id});
		Test.stopTest();

		System.assertNotEquals(0, sbaLoanHistoryResult.size());
		System.assertEquals(testApplication.Id, sbaLoanHistoryResult[0].Application__c, 'The result SBA Loan History is incorrect');
		System.assertEquals(testApplication2.Id, sbaLoanHistoryResult[1].Application__c, 'The result SBA Loan History is incorrect');
		System.assertEquals(testApplication3.Id, sbaLoanHistoryResult[2].Application__c, 'The result SBA Loan History is incorrect');
	}
}