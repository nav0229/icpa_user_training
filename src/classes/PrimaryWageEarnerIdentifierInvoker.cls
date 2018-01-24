/****************************************************************
 Name:  PrimaryWageEarnerIdentifierInvoker
============================================================
Author: Lenny
Purpose: JIRA#1774
Invokable method for Primary Wage Earner Identifier
============================================================

****************************************************************/

public with sharing class PrimaryWageEarnerIdentifierInvoker {

	@InvocableMethod(label='Identify Primary Wage Earner' description='Runs method to identify the primary wage earner Applicant for Applications')
	public static void invokePrimaryWageEarnerIdentifier (List<Id> applicationIds) {
		PrimaryWageEarnerIdentifier primaryIdentifier = new PrimaryWageEarnerIdentifier();
		primaryIdentifier.identifyPrimaryWageEarners(applicationIds);
	}
}