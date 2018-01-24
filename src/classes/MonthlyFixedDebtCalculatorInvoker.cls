/****************************************************************
 Name:  MonthlyFixedDebtCalculatorInvoker
============================================================
Author: Lenny
Purpose: JIRA#1775
This class is to be called by ProcessBuilder to invoke the
MonthlyFixedDebtCalculator.calculateTotalMonthlyFixedDebt
method using the provided Application IDs
============================================================

****************************************************************/
public with sharing class MonthlyFixedDebtCalculatorInvoker {

	@InvocableMethod(label='Calculate Monthly Fixed Debt' description='Runs method to calculate monthly fixed debt for Applications')
	public static void invokeMonthlyFixedDebtCalculator (List<Id> applicationIds) {
		MonthlyFixedDebtCalculator mfdCalculator = new MonthlyFixedDebtCalculator();
		mfdCalculator.calculateTotalMonthlyFixedDebt(applicationIds);
	}
}