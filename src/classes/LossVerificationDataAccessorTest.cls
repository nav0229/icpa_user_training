@isTest
private class LossVerificationDataAccessorTest {
	
	@isTest static void getLossVerificationsByLoanIds_givenALoanId_shouldRetrieveLossVerification() {
		LossVerificationDataAccessor lossVerificationDA = new LossVerificationDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Property__c testProperty = new Property__c(
			Name = 'Test Property',
			Application__c = testApplication.Id
		);
		insert testProperty;

		Loss_Verification_Inspections__c testLV = new Loss_Verification_Inspections__c(
			Name= 'Test LV',
			Property__c = testProperty.Id,
			Loan__c = testLoan.Id
		);
		insert testLV;

		Test.startTest();
			List<Loss_Verification_Inspections__c> retrievedLVs = lossVerificationDA.getLossVerificationsByLoanIds(new Set<Id>{testLoan.Id});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedLVs.size(),
			'With the given Loan Id, one Loss Verification should have been retrieved'
		);

		System.assertEquals(
			testLV.Id,
			retrievedLVs[0].Id,
			'The retrieved Loss Verification should be the test Loss Verification that was inserted.'
		);
	}
	
	@isTest static void getLossVerificationsByApplicationIds_givenAnApplicationId_shouldRetrieveLossVerification() {
		LossVerificationDataAccessor lossVerificationDA = new LossVerificationDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Property__c testProperty = new Property__c(
			Name = 'Test Property',
			Application__c = testApplication.Id
		);
		insert testProperty;

		Loss_Verification_Inspections__c testLV = new Loss_Verification_Inspections__c(
			Name= 'Test LV',
			Property__c = testProperty.Id,
			Loan__c = testLoan.Id
		);
		insert testLV;

		Test.startTest();
			List<Loss_Verification_Inspections__c> retrievedLVs = lossVerificationDA.getLossVerificationsByApplicationIds(new Set<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedLVs.size(),
			'With the given Loan Id, one Loss Verification should have been retrieved'
		);

		System.assertEquals(
			testLV.Id,
			retrievedLVs[0].Id,
			'The retrieved Loss Verification should be the test Loss Verification that was inserted.'
		);	
	}
	
	@isTest static void getLossVerificationsByApplicationId_givenAnApplicationId_shouldRetrieveLossVerification() {
		LossVerificationDataAccessor lossVerificationDA = new LossVerificationDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Loan__c testLoan = new Loan__c(
			Name = 'Test Loan',
			Application__c = testApplication.Id
		);
		insert testLoan;

		Property__c testProperty = new Property__c(
			Name = 'Test Property',
			Application__c = testApplication.Id
		);
		insert testProperty;

		Loss_Verification_Inspections__c testLV = new Loss_Verification_Inspections__c(
			Name= 'Test LV',
			Property__c = testProperty.Id,
			Loan__c = testLoan.Id
		);
		insert testLV;

		Test.startTest();
			List<Loss_Verification_Inspections__c> retrievedLVs = lossVerificationDA.getLossVerificationsByApplicationId(testApplication.Id);
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedLVs.size(),
			'With the given Loan Id, one Loss Verification should have been retrieved'
		);

		System.assertEquals(
			testLV.Id,
			retrievedLVs[0].Id,
			'The retrieved Loss Verification should be the test Loss Verification that was inserted.'
		);
	}
}