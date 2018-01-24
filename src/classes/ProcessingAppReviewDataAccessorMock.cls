/****************************************************************
 Name: ProcessingAppReviewDataAccessorMock
============================================================
Author: Lenny/Matt
Purpose: Mock Data Accessor for Processing_Application_Review__c
============================================================

****************************************************************/

@isTest
public with sharing class ProcessingAppReviewDataAccessorMock implements ProcessingApplicationReviewDAO{

	public Integer getProcessingApplicationReviewsByAppIdsCallCount {get; private set;}
	public Integer updateProcessingApplicationReviewsCallCount {get; private set;}

	public List<Processing_Application_Review__c> getProcessingApplicationReviewsByAppIdsReturn;

	public ProcessingAppReviewDataAccessorMock() {
		getProcessingApplicationReviewsByAppIdsCallCount = 0;
		updateProcessingApplicationReviewsCallCount = 0;

		getProcessingApplicationReviewsByAppIdsReturn = new List<Processing_Application_Review__c>();
	}
	
	public List<Processing_Application_Review__c> getProcessingApplicationReviewsByProcessingApplicationReviewIds(List<Id> parIds) {
			// temporary
			return null;
	}

	public List<Processing_Application_Review__c> getProcessingApplicationReviewsByAppIds(List<Id> appIds) {
		getProcessingApplicationReviewsByAppIdsCallCount++;

		return getProcessingApplicationReviewsByAppIdsReturn;
	}

	public void updateProcessingApplicationReviews(List<Processing_Application_Review__c> processingAppReviews) {
		updateProcessingApplicationReviewsCallCount++;
	}
}