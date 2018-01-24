/****************************************************************
 Name:  PrimaryApplicantHandler
============================================================
Author: Lenny
Purpose: JIRA#1870
Responsible for resolving identifying new Applicants marked
as Primary Applicant, and propogating the change to former
Primary Applicant and Application
============================================================

****************************************************************/
public with sharing class PrimaryApplicantHandler implements PrimaryApplicantHandlerInterface {
	@TestVisible
	private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	@TestVisible
	private static ApplicantDAO applicantDA = new ApplicantDataAccessor();

	public void updatePrimaryApplicantsAfterUpdate(Map<Id, Applicant__c> oldApplicants, List<Applicant__c> updatedApplicants) {
		List<Applicant__c> updatedPrimaryApplicants = new List<Applicant__c>();
		for(Applicant__c applicant : updatedApplicants) {
			if(applicant.Primary_Applicant__c == true && oldApplicants.get(applicant.Id).Primary_Applicant__c != true){
				updatedPrimaryApplicants.add(applicant);
			}
		}
		updatePrimaryApplicants(updatedPrimaryApplicants);
	}

	public void updatePrimaryApplicants(List<Applicant__c> newPrimaryApplicants) {
		Map<Id, Applicant__c> applicationIdToNewPrimaryApplicantsMap = new Map<Id, Applicant__c>();
		List<Id> relatedApplicationIds = new List<Id>();

		for(Applicant__c applicant : newPrimaryApplicants) {
			if(applicant.Primary_Applicant__c == true){
				applicationIdToNewPrimaryApplicantsMap.put(applicant.Application__c, applicant);
				relatedApplicationIds.add(applicant.Application__c);
			}
		}

		List<Application__c> relatedApplications = new List<Application__c>();
		List<Applicant__c> relatedPrimaryApplicants = new List<Applicant__c>();
		if(!relatedApplicationIds.isEmpty()){
			relatedApplications = applicationDA.getApplicationsById(relatedApplicationIds);
			relatedPrimaryApplicants = applicantDA.getPrimaryApplicantsByApplicationId(relatedApplicationIds);
		}

		for(Applicant__c primaryApplicant : relatedPrimaryApplicants) {
			Applicant__c newPrimaryApplicant = applicationIdToNewPrimaryApplicantsMap.get(primaryApplicant.Application__c);
			if(primaryApplicant.Id != newPrimaryApplicant.Id){
				primaryApplicant.Primary_Applicant__c = false;
			}
		}

		for(Application__c application : relatedApplications) {
			application.Primary_Applicant_Name__c = applicationIdToNewPrimaryApplicantsMap.get(application.Id).Name;
		}

		try {
			if(!relatedApplications.isEmpty()){
				applicationDA.updateApplications(relatedApplications);
			}
			if(!relatedPrimaryApplicants.isEmpty()){
				applicantDA.updateApplicants(relatedPrimaryApplicants);
			}
		}
		catch (DmlException e) {
			for(Applicant__c applicant : applicationIdToNewPrimaryApplicantsMap.values()){
				applicant.addError('Error updating Primary Applicant in Primary Applicant Handler: ' + e.getMessage());
			}
		}
	}

	public void setPrimaryApplicantsIfNone(List<Applicant__c> newApplicants) {
		Map<Id, Applicant__c> applicationIdToNewApplicantsMap = new Map<Id, Applicant__c>();
		List<Id> relatedApplicationIds = new List<Id>();

		for(Applicant__c applicant : newApplicants) {
			relatedApplicationIds.add(applicant.Application__c);
			if(applicationIdToNewApplicantsMap.containsKey(applicant.Application__c)){
				if(applicant.Primary_Applicant__c == true){
					applicationIdToNewApplicantsMap.put(applicant.Application__c, applicant);
				}
			}
			else{
				applicationIdToNewApplicantsMap.put(applicant.Application__c, applicant);
			}
		}

		List<Applicant__c> relatedPrimaryApplicants = new List<Applicant__c>();
		if(!relatedApplicationIds.isEmpty()){
			relatedPrimaryApplicants = applicantDA.getPrimaryApplicantsByApplicationId(relatedApplicationIds);
		}

		for(Applicant__c applicant : applicationIdToNewApplicantsMap.values()) {
			Boolean noPrimaryApplicants = true;
			for(Applicant__c primaryApplicant : relatedPrimaryApplicants) {
				if(applicant.Application__c == primaryApplicant.Application__c) {
					noPrimaryApplicants = false;
				}
			}
			if(noPrimaryApplicants){
				applicant.Primary_Applicant__c = true;
			} 
		}
	}
}