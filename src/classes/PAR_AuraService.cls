/****************************************************************
 Name: PAR_AuraService
============================================================
Author: Kirk Hendrick
Purpose: Aura Service for Processing Application Review
============================================================

****************************************************************/
public with sharing class PAR_AuraService {
	@TestVisible private static ProcessingApplicationReviewDAO processingApplicationReviewDA = new ProcessingApplicationReviewDataAccessor();

	@AuraEnabled
	public static Application__c getApplicationByPARId(Id parId) {
		try {
			// return processingApplicationReviewDA.getApplicationByPARId(parId);
			return null;
		}
		catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}