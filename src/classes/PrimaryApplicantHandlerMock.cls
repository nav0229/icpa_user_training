/****************************************************************
 Name:  PrimaryApplicantHandlerMock
============================================================
Author: Lenny
Purpose: Mock for PrimaryApplicantHandler
============================================================

****************************************************************/

@isTest
public with sharing class PrimaryApplicantHandlerMock implements PrimaryApplicantHandlerInterface {
	public Integer updatePrimaryApplicantsAfterUpdateCallCount {get; private set;}
	public Integer updatePrimaryApplicantsCallCount {get; private set;}
	public Integer setPrimaryApplicantsIfNoneCallCount {get; private set;}

	public PrimaryApplicantHandlerMock() {
		updatePrimaryApplicantsAfterUpdateCallCount = 0;
		updatePrimaryApplicantsCallCount = 0;
		setPrimaryApplicantsIfNoneCallCount = 0;
	}

	public void updatePrimaryApplicantsAfterUpdate(Map<Id, Applicant__c> oldApplicants, List<Applicant__c> updatedApplicants){
		updatePrimaryApplicantsAfterUpdateCallCount++;
	}

	public void updatePrimaryApplicants(List<Applicant__c> newPrimaryApplicants){
		updatePrimaryApplicantsCallCount++;
	}

	public void setPrimaryApplicantsIfNone(List<Applicant__c> newApplicants){
		setPrimaryApplicantsIfNoneCallCount++;
	}
}