/****************************************************************
 Name: ApplicationDAO
============================================================
Author: Lenny
Purpose: Data Access Object for Application__c
============================================================

****************************************************************/
public interface ApplicationDAO {
	void insertApplication(Application__c application);
	void insertApplications(List<Application__c> applications);
	void updateApplications(List<Application__c> applications);

	Application__c getApplicationById(Id applicationId);
	List<Application__c> getApplicationsById(List<Id> applicationIds);
	Map<Id, Application__c> getApplicationsMapById(List<Id> applicationIds);
	Application__c getApplicationByApplicationNumber(String applicationNumber);
	List<Application__c> getApplicationsByApplicationNumber(List<String> applicationNumbers);
	List<Application__c> getApplicationsAndActiveIRSTranscriptsByApplicationIds(List<Id> applicationIds);
}