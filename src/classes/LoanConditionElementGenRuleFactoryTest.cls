@isTest
private class LoanConditionElementGenRuleFactoryTest
{
	@isTest
	static void sharedRepairResponsibilityRule_whenApplied_shouldReturnLoanConditionElement(){
		LoanConditionElementGeneratorRuleFactory.SharedRepairResponsibilityRule testRule = new LoanConditionElementGeneratorRuleFactory.SharedRepairResponsibilityRule();

		LoanConditionCriteria testLoanConditionCriteria = new LoanConditionCriteria(new Loan_Condition_Checklist__c(), null, null);

		Test.startTest();
			Loan_Condition_Element__c resultElement = testRule.applyRuleAndCreateLoanConditionElement(testLoanConditionCriteria);
		Test.stopTest();
		System.assertNotEquals(null, resultElement);
		System.assertNotEquals(null, resultElement.Name);
		System.assertNotEquals(null, resultElement.Element_Type__c);
		System.assertNotEquals(null, resultElement.Required__c);
	}

	@isTest
	static void policyTypeRule_whenApplied_shouldReturnLoanConditionElement(){
		LoanConditionElementGeneratorRuleFactory.PolicyTypeRule testRule = new LoanConditionElementGeneratorRuleFactory.PolicyTypeRule();

		LoanConditionCriteria testLoanConditionCriteria = new LoanConditionCriteria(new Loan_Condition_Checklist__c(), null, null);

		Test.startTest();
			Loan_Condition_Element__c resultElement = testRule.applyRuleAndCreateLoanConditionElement(testLoanConditionCriteria);
		Test.stopTest();

		System.assertNotEquals(null, resultElement);
		System.assertNotEquals(null, resultElement.Name);
		System.assertNotEquals(null, resultElement.Element_Type__c);
		System.assertNotEquals(null, resultElement.Required__c);
	}

	@isTest
	static void policyNumberRule_whenApplied_shouldReturnLoanConditionElement(){
		LoanConditionElementGeneratorRuleFactory.PolicyNumberRule testRule = new LoanConditionElementGeneratorRuleFactory.PolicyNumberRule();

		LoanConditionCriteria testLoanConditionCriteria = new LoanConditionCriteria(new Loan_Condition_Checklist__c(), null, null);

		Test.startTest();
			Loan_Condition_Element__c resultElement = testRule.applyRuleAndCreateLoanConditionElement(testLoanConditionCriteria);
		Test.stopTest();

		System.assertNotEquals(null, resultElement);
		System.assertNotEquals(null, resultElement.Name);
		System.assertNotEquals(null, resultElement.Element_Type__c);
		System.assertNotEquals(null, resultElement.Required__c);
	}

	@isTest
	static void nameOfPolicyHolderRule_whenApplied_shouldReturnLoanConditionElement(){
		LoanConditionElementGeneratorRuleFactory.NameOfPolicyHolderRule testRule = new LoanConditionElementGeneratorRuleFactory.NameOfPolicyHolderRule();

		LoanConditionCriteria testLoanConditionCriteria = new LoanConditionCriteria(new Loan_Condition_Checklist__c(), null, null);

		Test.startTest();
			Loan_Condition_Element__c resultElement = testRule.applyRuleAndCreateLoanConditionElement(testLoanConditionCriteria);
		Test.stopTest();

		System.assertNotEquals(null, resultElement);
		System.assertNotEquals(null, resultElement.Name);
		System.assertNotEquals(null, resultElement.Element_Type__c);
		System.assertNotEquals(null, resultElement.Required__c);
	}
}