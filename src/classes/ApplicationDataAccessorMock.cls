/****************************************************************
 Name: ApplicationDataAccessorMock
============================================================
Author: Lenny
Purpose: Mock Data Accessor Class for Application__c
============================================================

****************************************************************/

@isTest
public with sharing class ApplicationDataAccessorMock implements ApplicationDAO{
	public Integer getApplicationByIdCallCount {get; private set;}
	public Integer getApplicationsByIdCallCount { get; private set; }
	public Integer getApplicationsMapCallCount { get; private set; }
	public Integer getApplicationsByApplicationNumberCallCount { get; private set; }
	public Integer getApplicationByApplicationNumberCallCount { get; private set; }
	public Integer getApplicationsAndActiveIRSTranscriptsByApplicationIdsCallCount {get; private set;}

	public Integer updateApplicationsCallCount {get; private set;}
	public Integer insertApplicationsCallCount {get; private set;}
	public Integer insertApplicationCallCount {get; private set;}

	public Application__c getApplicationByIdReturn;
	public List<Application__c> getApplicationsByIdReturn;
	public Map<Id, Application__c> getApplicationsMapReturn;
	public List<Application__c> getApplicationsByApplicationNumberReturn;
	public Application__c getApplicationByApplicationNumberReturn;
	public List<Application__c> getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn;

	public ApplicationDataAccessorMock(){
		getApplicationByIdCallCount = 0;
		getApplicationsByIdCallCount = 0;
		getApplicationsMapCallCount = 0;
		getApplicationsByApplicationNumberCallCount = 0;
		getApplicationByApplicationNumberCallCount = 0;
		getApplicationsAndActiveIRSTranscriptsByApplicationIdsCallCount = 0;

		updateApplicationsCallCount = 0;
		insertApplicationsCallCount = 0;
		insertApplicationCallCount = 0;

		getApplicationByIdReturn = new Application__c();
		getApplicationsMapReturn = new Map<Id, Application__c>();
		getApplicationsByIdReturn = new List<Application__c>();
		getApplicationsByApplicationNumberReturn = new List<Application__c>();
		getApplicationByApplicationNumberReturn = new Application__c();
		getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn = new List<Application__c>();
	}

	public Application__c getApplicationById(Id applicationId){
		getApplicationByIdCallCount++;
		return getApplicationByIdReturn;
	}

	public List<Application__c> getApplicationsById(List<Id> appIds){
		getApplicationsByIdCallCount++;
		return getApplicationsByIdReturn;
	}

	public Map<Id, Application__c> getApplicationsMapById(List<Id> appIds){
		getApplicationsMapCallCount++;
		return getApplicationsMapReturn;
	}

	public Application__c getApplicationByApplicationNumber(String applicationNumber) {
		getApplicationByApplicationNumberCallCount++;
		return getApplicationByApplicationNumberReturn;
	}

	public List<Application__c> getApplicationsByApplicationNumber(List<String> applicationNumbers){
		getApplicationsByApplicationNumberCallCount++;
		return getApplicationsByApplicationNumberReturn;
	}

	public List<Application__c> getApplicationsAndActiveIRSTranscriptsByApplicationIds(List<Id> appIds){
		getApplicationsAndActiveIRSTranscriptsByApplicationIdsCallCount++;
		return getApplicationsAndActiveIRSTranscriptsByApplicationIdsReturn;
	}

	public void updateApplications(List<Application__c> applications){
		updateApplicationsCallCount++;
	}

	public void insertApplications(List<Application__c> applications){
		insertApplicationsCallCount++;
	}

	public void insertApplication(Application__c application) {
		insertApplicationCallCount++;
	}
}