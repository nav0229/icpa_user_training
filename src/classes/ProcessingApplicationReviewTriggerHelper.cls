/****************************************************************
 Name: ProcessingApplicationReviewTriggerHelper
============================================================
Author: Matt
Purpose: Trigger Helper for ProcessingApplicationReview Trigger
============================================================

****************************************************************/

public with sharing class ProcessingApplicationReviewTriggerHelper {
	public ProcessingApplicationReviewTriggerHelper() {}

	public void beforeInsert(List<Processing_Application_Review__c> processingApplicationReviewList){
		EligiblePhysicalLossCalculator eligiblePhysicalLossCalculator = new EligiblePhysicalLossCalculator();
	    eligiblePhysicalLossCalculator.calculateEligiblePhysicalLoss(processingApplicationReviewList);
    }
}