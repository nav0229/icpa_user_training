/****************************************************************
 Name:  ApplicantsEligibility
============================================================
Author: Matt
Purpose: JIRA#2186 (1464, 1465, 1466)
Class the handles the Applicants Eligibility Tests
============================================================

****************************************************************/

public with sharing class ApplicantsEligibility {
	public ApplicantsEligibility() {}

	public Processing_Application_Review__c runApplicantTest(Processing_Application_Review__c par, List<Applicant__c> applicants) {
		par.Applicant_Eligibility_Test_Time__c = System.now();

		if(applicants.isEmpty()) {
			return par;
		}
		
		par.U_S_Citizen__c = checkIfApplicantsAreUScitizen(applicants);
		par.No_Character_Issues__c = checkIfApplicantsHasCharacterIssues(applicants);

		return par;
	}

	private String checkIfApplicantsAreUScitizen(List<Applicant__c> applicants) {
		for(Applicant__c applicant : applicants) {
			if(applicant.U_S_Citizen__c == false) {
				return 'Fail';
			}
		}

		return 'Pass';
	}

	private String checkIfApplicantsHasCharacterIssues(List<Applicant__c> applicants) {
		for(Applicant__c applicant : applicants) {
			if(applicant.Character_Issues__c) {
				return 'Fail';
			}
		}

		return 'Pass';
	}
}