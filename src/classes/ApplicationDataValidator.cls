/****************************************************************
 Name: ApplicationDataValidator
============================================================
Author: Kevin
Purpose: DCMM-2132
	Validates the data related to an application to determine
	if it is ready for further processing.
============================================================

****************************************************************/
public with sharing class ApplicationDataValidator {
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static ApplicantDAO applicantDA = new ApplicantDataAccessor();
	@TestVisible private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();
	@TestVisible private static GroupDAO groupDA = new GroupDataAccessor();

	private final String ERROR_QUEUE_DEV_NAME = 'Error_Queue';
	private final String QUEUE = 'Queue';

	public ApplicationDataValidator(){}

	public void validateApplicationData(List<Id> applicationIds){
		List<Application__c> applications = applicationDA.getApplicationsById(applicationIds);
		Map<Id,Applicant__c> applicationIdToPrimaryApplicantMap = constructPrimaryApplicantMap(applicationIds);

		List<Application__c> validApplications = new List<Application__c>();
		List<Application__c> invalidApplicatons = new List<Application__c>();

		for(Application__c application : applications){
			if(applicationHasPrimaryApplicant(application, applicationIdToPrimaryApplicantMap)){
				validApplications.add(application);
			} else {
				invalidApplicatons.add(application);
			}
		}

		if(!validApplications.isEmpty()){
			System.debug('validApplications:'+validApplications);
			createSubmitCBREventRequestsForValidApplications(validApplications);
		}
		if(!invalidApplicatons.isEmpty()){
			assignInvalidApplicationsToErrorQueue(invalidApplicatons);
		}
	}

	private Map<Id,Applicant__c> constructPrimaryApplicantMap(List<Id> applicationIds){
		Map<Id,Applicant__c> applicationIdToPrimaryApplicantMap = new Map<Id,Applicant__c>();
		for(Applicant__c applicant : applicantDA.getPrimaryApplicantsByApplicationId(applicationIds)){
			applicationIdToPrimaryApplicantMap.put(applicant.Application__c, applicant);
		}
		return applicationIdToPrimaryApplicantMap;
	}

	private Boolean applicationHasPrimaryApplicant(Application__c application, Map<Id,Applicant__c> applicationIdToPrimaryApplicantMap){
		if(applicationIdToPrimaryApplicantMap.containsKey(application.Id)){
			return true;
		} else {
			return false;
		}
	}

	private void createSubmitCBREventRequestsForValidApplications(List<Application__c> validApplications){
		List<Event_Request__c> eventRequests = new List<Event_Request__c>();
		for(Application__c application : validApplications){
			eventRequests.add(new Event_Request__c(
				Application_Number__c = application.Name,
				Stage__c = EventRequestDataAccessor.STAGE_SUBMIT_CBR
			));
		}
		eventRequestDA.insertEventRequests(eventRequests);
	}

	private void assignInvalidApplicationsToErrorQueue(List<Application__c> invalidApplicatons){
		Group errorQueue = groupDA.getGroupByDeveloperNameAndType(ERROR_QUEUE_DEV_NAME, QUEUE);
		for(Application__c application : invalidApplicatons){
			application.OwnerId = errorQueue.Id;
		}
		applicationDA.updateApplications(invalidApplicatons);
	}
}