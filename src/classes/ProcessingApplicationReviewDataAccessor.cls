/****************************************************************
 Name:  ProcessingApplicationReviewDataAccessor
============================================================
Author: Lenny
Data Accessor for the Processing_Application_Review__c object
============================================================

****************************************************************/
public with sharing class ProcessingApplicationReviewDataAccessor implements ProcessingApplicationReviewDAO{

	private static final String PROCESSING_APPLICATION_REVIEW = 'Processing_Application_Review__c';

	public List<Processing_Application_Review__c> getProcessingApplicationReviewsByProcessingApplicationReviewIds(List<Id> parIds) {
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Set<String> processingAppReviewFields = schemaMap.get(PROCESSING_APPLICATION_REVIEW).getDescribe().fields.getMap().keySet();

		QueryBuilder processingAppReviewQueryBuilder = new QueryBuilder(PROCESSING_APPLICATION_REVIEW);
		processingAppReviewQueryBuilder.addSelectField(processingAppReviewFields);
		processingAppReviewQueryBuilder.addWhereCondition('Id', parIds, QueryBuilder.ComparisonOperator.IN_LIST);

		List<Processing_Application_Review__c> processingAppReviews = new List<Processing_Application_Review__c>();
		processingAppReviews.addAll((List<Processing_Application_Review__c>)Database.query(processingAppReviewQueryBuilder.generateQuery()));

		return processingAppReviews;
	}

	public List<Processing_Application_Review__c> getProcessingApplicationReviewsByAppIds(List<Id> appIds) {
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Set<String> processingAppReviewFields = schemaMap.get(PROCESSING_APPLICATION_REVIEW).getDescribe().fields.getMap().keySet();

		QueryBuilder processingAppReviewQueryBuilder = new QueryBuilder(PROCESSING_APPLICATION_REVIEW);
		processingAppReviewQueryBuilder.addSelectField(processingAppReviewFields);
		processingAppReviewQueryBuilder.addWhereCondition('Application__c', appIds, QueryBuilder.ComparisonOperator.IN_LIST);

		List<Processing_Application_Review__c> processingAppReviews = new List<Processing_Application_Review__c>();
		processingAppReviews.addAll((List<Processing_Application_Review__c>)Database.query(processingAppReviewQueryBuilder.generateQuery()));

		return processingAppReviews;
	}

	public void updateProcessingApplicationReviews(List<Processing_Application_Review__c> processingAppReview){
		update processingAppReview;
	}
}