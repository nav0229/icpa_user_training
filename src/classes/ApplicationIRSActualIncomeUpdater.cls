/****************************************************************
 Name: ApplicationIRSActualIncomeUpdater
============================================================
Author: Matt
Purpose: Class that handles the updating of the IRS Actual Income 
	field on application when an irs transcript is recieved.
============================================================

****************************************************************/

public with sharing class ApplicationIRSActualIncomeUpdater {

	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	public ApplicationIRSActualIncomeUpdater() {}

	public void updateApplicationIRSActualIncome(List<IRS_Transcripts__c> newTranscripts) {
		List<Application__c> applications;
		List<Id> applicationIds = new List<Id>();

		for(IRS_Transcripts__c irsTranscript : newTranscripts) {
			applicationIds.add(irsTranscript.Application__c);
		}

		applications = getApplicationsById(applicationIds);

		for(Application__c application : applications) {
			for(IRS_Transcripts__c irsTranscript : newTranscripts) {
				if(application.Id == irsTranscript.Application__c) {
					if(irsTranscript.Actual_Gross_Annual_Income__c != null){
						application.IRS_Actual_Income__c = irsTranscript.Actual_Gross_Annual_Income__c;
					}					
				}
			}
		}

		updateApplications(applications);
	}

	private List<Application__c> getApplicationsById(List<Id> applicationIds) {
		try{
			return applicationDA.getApplicationsById(applicationIds);
		}catch(QueryException e) {
			throw new ApplicationIRSActualIncomeUpdaterException('Error while getting applications from application ids.');
		}
	}

	private void updateApplications(List<Application__c> applications) {
		try {
			applicationDA.updateApplications(applications);
		}catch(DmlException e) {
			throw new ApplicationIRSActualIncomeUpdaterException('Error while updated applications after updating IRS Actual Income field.');
		}
	}

	private class ApplicationIRSActualIncomeUpdaterException extends Exception {}
}