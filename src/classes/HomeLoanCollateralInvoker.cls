/****************************************************************
 Name:  HomeLoanCollateralInvoker
============================================================
Author: Matt
Purpose: JIRA#1611
Invokable method for Home Loan Collateral Test
============================================================

****************************************************************/

public with sharing class HomeLoanCollateralInvoker {

	@InvocableMethod(label='Home Loan Collateral Test' description='Runs method to execute the Home Loan Collateral Test')
	public static void invokeHomeLoanCollateral (List<Id> applicationIds) {
		HomeLoanCollateral homeLoanCollateralTest = new HomeLoanCollateral();
		homeLoanCollateralTest.runHomeLoanCollateralTest(applicationIds);
	}
}