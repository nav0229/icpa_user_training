/****************************************************************
 Name: ProcessingApplicationReviewDAO
============================================================
Author: Lenny
Purpose: Data Access Object for Processing_Application_Review__c
============================================================

****************************************************************/

public interface ProcessingApplicationReviewDAO {
	void updateProcessingApplicationReviews(List<Processing_Application_Review__c> processingAppReviews);
	List<Processing_Application_Review__c> getProcessingApplicationReviewsByProcessingApplicationReviewIds(List<Id> parIds);
	List<Processing_Application_Review__c> getProcessingApplicationReviewsByAppIds(List<Id> appId);
}