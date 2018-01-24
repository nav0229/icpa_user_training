/****************************************************************
 Name:  MiscellaneousExceptions
============================================================
Author: Matt
Purpose: JIRA#2209 (2186)
Class the handles the Miscellaneous Exceptions Tests
============================================================

****************************************************************/

public with sharing class MiscellaneousExceptions {
	public MiscellaneousExceptions() {}

	public Processing_Application_Review__c runMiscellaneousTest(Processing_Application_Review__c par, Application__c application, List<IRS_Transcripts__c> irsTranscripts, List<Other_Assistance__c> otherAssistances, List<Applicant__c> applicants, List<Mortgage__c> mortgages) {
		par.Miscellaneous_Exceptions_Test_Time__c = System.now();

		if(isAnyObjectEmpty(application, irsTranscripts, otherAssistances, applicants, mortgages)) {
			return par;
		}

		par.Condo_HOA_fee_not_listed_on_Application__c = getCondoHOAfeeNotListedOnApplication(mortgages);
		par.Grants_not_listed_on_application__c = getGrantsNotListedOnApplication(otherAssistances);
		par.IRS_Transcript_s_Received__c = isIRSrequestStatusReceived(irsTranscripts);
		par.Not_an_SBA_Employee__c = areApplicantsNotSBAemployee(applicants);
		
		return par;
	}

	private Boolean isAnyObjectEmpty(Application__c application, List<IRS_Transcripts__c> irsTranscripts, List<Other_Assistance__c> otherAssistances, List<Applicant__c> applicants, List<Mortgage__c> mortgages) {
		if(application == null || irsTranscripts.isEmpty() || otherAssistances.isEmpty() || applicants.isEmpty() || mortgages.isEmpty()){
			return true;
		}

		return false;
	}
	
	private String getCondoHOAfeeNotListedOnApplication(List<Mortgage__c> mortgages) {
		Decimal total = 0;

		for(Mortgage__c mortgage : mortgages) {
			if(mortgage.Condo_HOA_Fees__c != null) {
				total += mortgage.Condo_HOA_Fees__c;
			}
		}

		if(total > 0) {
			return 'Fail';
		}
		return 'Pass';
	}

	private String getGrantsNotListedOnApplication(List<Other_Assistance__c> otherAssistances) {
		Decimal total = 0;

		for(Other_Assistance__c oa : otherAssistances) {
			if(oa.State_Grant__c != null) {
				total += oa.State_Grant__c;
			}
			if(oa.Total_Amount_of_Other_Assistance__c != null) {
				total += oa.Total_Amount_of_Other_Assistance__c;
			}
			if(oa.Total_FEMA_amount_for_Real_Estate__c != null) {
				total += oa.Total_FEMA_amount_for_Real_Estate__c;
			}
		}

		if(total == 0) {
			return 'Pass';
		}

		return 'Fail';
	}

	private String isIRSrequestStatusReceived(List<IRS_Transcripts__c> irsTranscripts) {
		for(IRS_Transcripts__c irsTranscript : irsTranscripts) {
			if(irsTranscript.IRS_Request_Status__c != 'Received'){
				return 'Fail';
			}
		}
		return 'Pass';
	}
	
	private String areApplicantsNotSBAemployee(List<Applicant__c> applicants) {
		for(Applicant__c applicant : applicants) {
			if(applicant.SBA_Employee__c) {
				return 'Fail';
			}
		}
		return 'Pass';
	}
}