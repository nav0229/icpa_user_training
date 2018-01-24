/****************************************************************
 Name: ApplicationTriggerHelper
============================================================
Author: Kevin
Purpose: Trigger Helper for Application Trigger
============================================================

****************************************************************/
public with sharing class ApplicationTriggerHelper {

	@TestVisible private static ApplicationDataPopulatorInterface applicationDataPopulator = new ApplicationDataPopulator();
	@TestVisible private static ApplicationApprovalSubmitterInterface applicationApprovalSubmitter = new ApplicationApprovalSubmitter();

	public ApplicationTriggerHelper(){}

	public void beforeInsert(List<Application__c> newApplications){
		applicationDataPopulator.populateDataOnNewApplications(newApplications);
	}

	public void afterUpdate(List<Application__c> newApplications, Map<Id,Application__c> oldApplicationsMap){
		applicationApprovalSubmitter.submitSystemRecommendedApplicationsForApproval(newApplications, oldApplicationsMap);
	}
}