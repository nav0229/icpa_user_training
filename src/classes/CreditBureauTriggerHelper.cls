/****************************************************************
 Name: CreditBureauTriggerHelper
============================================================
Author: Matt
Purpose: 
	Trigger helper for Credit_Bureau__c
============================================================

****************************************************************/

public with sharing class CreditBureauTriggerHelper {
	
	@TestVisible
	private static ApplicantDAO applicantDA = new ApplicantDataAccessor();

	public CreditBureauTriggerHelper() {
		
	}

	public void afterInsert(List<Credit_Bureau__c> newCBItems) {
		copyCreditScoreToApplicant(newCBItems);
	}

	private void copyCreditScoreToApplicant(List<Credit_Bureau__c> newCBItems) {
		List<Id> applicantIds = new List<Id>();
		List<Applicant__c> applicants = new List<Applicant__c>();

		for(Credit_Bureau__c cbr : newCBItems) {
			if(cbr.Applicant_Name__c != null) {
				applicantIds.add(cbr.Applicant_Name__c);
			}
		}

		try{
			applicants = applicantDA.getApplicantsByApplicantIds(applicantIds);
		}catch(QueryException e) {
            throw new CreditBureauTriggerHelperException('Error when retrieving applicants: ' + e.getMessage());
		}

		for(Applicant__c applicant : applicants) {
			for(Credit_Bureau__c cbr : newCBItems) {
				if(cbr.Applicant_Name__c != null && cbr.Credit_Score__c != null && cbr.Applicant_Name__c == applicant.Id) {
					if(cbr.Credit_Score__c == 'Zero') {
						applicant.Credit_Score__c = 0;
					}else{
						applicant.Credit_Score__c = Integer.valueOf(cbr.Credit_Score__c);
					}
				}
			}
		}

		try{
			applicantDA.updateApplicants(applicants);
		}catch(DmlException e) {
            throw new CreditBureauTriggerHelperException('Error updating applicants: ' + e.getMessage());
		}
	}

	public class CreditBureauTriggerHelperException extends Exception {}
}