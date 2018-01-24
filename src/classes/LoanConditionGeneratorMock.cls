@isTest
public with sharing class LoanConditionGeneratorMock implements LoanConditionGeneratorInterface {
	public Integer generateLoanConditionCallCount {get; private set;}

	public LoanConditionGeneratorMock() {
		generateLoanConditionCallCount = 0;
	}

	public void generateLoanCondition(List<Id> applicationIds){
		generateLoanConditionCallCount++;
	}
}