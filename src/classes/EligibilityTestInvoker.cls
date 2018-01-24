/****************************************************************
 Name:  EligibilityTestInvoker
============================================================
Author: Matt
Purpose: JIRA#1464, 1465, 1466
Invokable method for Eligibility Test
============================================================

****************************************************************/

public with sharing class EligibilityTestInvoker {

	@InvocableMethod(label='Run Eligibility Test' description='Runs method to assign a Pass or Fail to \'Eligibility Test\' Field')
	public static void invokeEligibilityTest (List<Id> applicationIds) {
		EligibilityTest eTest = new EligibilityTest();
		eTest.runEligibilityTests(applicationIds);
	}
}