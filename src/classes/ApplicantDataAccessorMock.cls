/****************************************************************
 Name: ApplicantDataAccessorMock
============================================================
Author: Kevin
Purpose: Mock Data Accessor Class for Application__c
============================================================

****************************************************************/
@isTest 
public with sharing class ApplicantDataAccessorMock implements ApplicantDAO {
    public Integer getApplicantsByApplicationIdCallCount { get; private set; }
    public Integer getApplicantsByApplicationIdsCallCount { get; private set; }
    public Integer getPrimaryApplicantsByApplicationIdCallCount { get; private set; }

    public Integer getPrimaryApplicantAndRelatedContactByApplicationIdCallCount { get; private set; }
    public Integer getApplicantsAndRelatedContactsByApplicationIdCallCount { get; private set; }
    public Integer getApplicantsByApplicantIdsCallCount {get; private set;}

    public Integer updateApplicantsCallCount { get; private set; }

    public List<Applicant__c> getApplicantsByApplicationIdReturn;
    public List<Applicant__c> getApplicantsByApplicationIdsReturn;
    public List<Applicant__c> getPrimaryApplicantsByApplicationIdReturn;
    public List<Applicant__c> getApplicantsByApplicantIdsReturn;

    public Applicant__c getPrimaryApplicantAndRelatedContactByApplicationIdReturn;
    public List<Applicant__c> getApplicantsAndRelatedContactsByApplicationIdReturn;

    public ApplicantDataAccessorMock(){
        getApplicantsByApplicationIdCallCount = 0;
        getApplicantsByApplicationIdsCallCount = 0;
        getPrimaryApplicantsByApplicationIdCallCount = 0;

        getPrimaryApplicantAndRelatedContactByApplicationIdCallCount = 0;
        getApplicantsAndRelatedContactsByApplicationIdCallCount = 0;
        getApplicantsByApplicantIdsCallCount = 0;

        updateApplicantsCallCount = 0;

        getApplicantsByApplicationIdReturn = new List<Applicant__c>();
        getApplicantsByApplicationIdsReturn = new List<Applicant__c>();
        getPrimaryApplicantsByApplicationIdReturn = new List<Applicant__c>();
        getApplicantsByApplicantIdsReturn = new List<Applicant__c>();

        getPrimaryApplicantAndRelatedContactByApplicationIdReturn = null;
        getApplicantsAndRelatedContactsByApplicationIdReturn = new List<Applicant__c>();
    }
    public List<Applicant__c> getApplicantsByApplicantIds(List<Id> applicantIds){
        getApplicantsByApplicantIdsCallCount++;
        return getApplicantsByApplicantIdsReturn;
    }

    public List<Applicant__c> getApplicantsByApplicationId(Id applicationId){
        getApplicantsByApplicationIdCallCount++;
        return getApplicantsByApplicationIdReturn;
    }

    public List<Applicant__c> getApplicantsByApplicationIds(List<Id> applicationId){
        getApplicantsByApplicationIdsCallCount++;
        return getApplicantsByApplicationIdsReturn;
    }

    public List<Applicant__c> getPrimaryApplicantsByApplicationId(List<Id> applicationIds){
        getPrimaryApplicantsByApplicationIdCallCount++;
        return getPrimaryApplicantsByApplicationIdReturn;
    }

    public Applicant__c getPrimaryApplicantAndRelatedContactByApplicationId(Id applicationId){
        getPrimaryApplicantAndRelatedContactByApplicationIdCallCount++;
        return getPrimaryApplicantAndRelatedContactByApplicationIdReturn;
    }

    public List<Applicant__c> getApplicantsAndRelatedContactsByApplicationId(Id applicationId){
        getApplicantsAndRelatedContactsByApplicationIdCallCount++;
        return getApplicantsAndRelatedContactsByApplicationIdReturn;
    }

    public void updateApplicants(List<Applicant__c> applicants) {
        updateApplicantsCallCount++;
    }
}