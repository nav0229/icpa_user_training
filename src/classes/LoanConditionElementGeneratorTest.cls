@isTest
private class LoanConditionElementGeneratorTest
{
	@isTest
	static void generateLoanConditionElements_givenOCSHDLoanCondition_shouldCallInsertLoanConditionElements(){
		LoanConditionElementDataAccessorMock mockLoanConditionElementDA = new LoanConditionElementDataAccessorMock();
		LoanConditionElementGenerator.loanConditionElementDA = mockLoanConditionElementDA;

		MockSObjectBuilder loanConditionBuilder = new MockSObjectBuilder(Loan_Condition_Checklist__c.getSObjectType());
		loanConditionBuilder.setField('Loan_Condition_Code__c', 'OC-SHD');
		Loan_Condition_Checklist__c testLoanCondition = (Loan_Condition_Checklist__c) loanConditionBuilder.build();

		Test.startTest();
			LoanConditionElementGenerator testElementGenerator = new LoanConditionElementGenerator();
			testElementGenerator.generateLoanConditionElements(new List<Loan_Condition_Checklist__c>{testLoanCondition});
		Test.stopTest();

		System.assertEquals(1, mockLoanConditionElementDA.insertLoanConditionElementsCallCount);
	}
}