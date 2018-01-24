/****************************************************************
 Name: ApplicationDAO
============================================================
Author: Kevin
Purpose: Data Access Object for Applicant__c
============================================================

****************************************************************/
public interface ApplicantDAO {
	void updateApplicants(List<Applicant__c> applicants);

	List<Applicant__c> getApplicantsByApplicantIds(List<Id> applicantIds);
	List<Applicant__c> getApplicantsByApplicationId(Id applicationId);
	List<Applicant__c> getApplicantsByApplicationIds(List<Id> applicationId);
	List<Applicant__c> getPrimaryApplicantsByApplicationId(List<Id> applicationIds);

	Applicant__c getPrimaryApplicantAndRelatedContactByApplicationId(Id applicationId);
	List<Applicant__c> getApplicantsAndRelatedContactsByApplicationId(Id applicationId);
}