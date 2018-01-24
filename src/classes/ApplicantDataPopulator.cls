/****************************************************************
 Name: ApplicantDataPopulator
============================================================
Author: Kevin
Purpose: 
============================================================

****************************************************************/
public with sharing class ApplicantDataPopulator {
	
	public ApplicantDataPopulator(){}

	public void populateDataOnNewApplicants(List<Applicant__c> applicants){
		populateApplicantLegalName(applicants);
	}

	private void populateApplicantLegalName(List<Applicant__c> applicants){
		for(Applicant__c applicant : applicants){
			if(String.isBlank(applicant.Legal_Name__c)){
				applicant.Legal_Name__c = applicant.Name;
			}
		}
	}
}