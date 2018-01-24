/****************************************************************
 Name: ApplicationValidator
============================================================
Author: Kevin
Purpose: DCMM-2132
	Invocable class that starts the Application Validation process
============================================================

****************************************************************/
public with sharing class ApplicationValidator {

	private static ApplicationDataValidator applicationDataValidator = new ApplicationDataValidator();

	@InvocableMethod(label='Validate Application Data' description='Validates that all required Application data is present and the Application is ready for processing')
	public static void validateApplicationData (List<Id> applicationIds){
		applicationDataValidator.validateApplicationData(applicationIds);
	}
}