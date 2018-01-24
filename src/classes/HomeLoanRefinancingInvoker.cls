/****************************************************************
 Name:  HomeLoanRefinancingInvoker
============================================================
Author: Matt
Purpose: JIRA#1340
Invokable method for Home Loan Refinancing Test
============================================================

****************************************************************/

public with sharing class HomeLoanRefinancingInvoker {

	@InvocableMethod(label='Home Loan Refinancing Test' description='Runs method to execute the Home Loan Refinancing Test')
	public static void invokeHomeLoanRefinancing (List<Id> applicationIds) {
		HomeLoanRefinancing homeLoanRefinancingTest = new HomeLoanRefinancing();
		homeLoanRefinancingTest.runHomeLoanRefinancingTest(applicationIds);
	}
}