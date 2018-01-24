/****************************************************************
 Name:  PrimaryApplicantHandlerInterface
============================================================
Author: Lenny
Purpose: Interface for PrimaryApplicantHandler
============================================================

****************************************************************/

public interface PrimaryApplicantHandlerInterface {
	void updatePrimaryApplicantsAfterUpdate(Map<Id, Applicant__c> oldApplicants, List<Applicant__c> updatedApplicants);
	void updatePrimaryApplicants(List<Applicant__c> newPrimaryApplicants);
	void setPrimaryApplicantsIfNone(List<Applicant__c> newApplicants);
}