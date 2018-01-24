/****************************************************************
 Name: IRSTranscriptsDataAccessorMock
============================================================
Author: Kevin
Purpose: Mock Data Accessor for IRS_Transcripts__c
============================================================

****************************************************************/
@isTest 
public with sharing class IRSTranscriptsDataAccessorMock implements IRSTranscriptsDAO {
    
    public Integer getIRSTranscriptsByApplicantIdsCallCount { get; private set; }
    public Integer getIRSTranscriptsByApplicationIdsCallCount {get; private set;}

    public List<IRS_Transcripts__c> getIRSTranscriptsByApplicantIdsReturn;
    public List<IRS_Transcripts__c> getIRSTranscriptsByApplicationIdsReturn;

    public IRSTranscriptsDataAccessorMock(){
        getIRSTranscriptsByApplicantIdsCallCount = 0;
        getIRSTranscriptsByApplicationIdsCallCount = 0;

        getIRSTranscriptsByApplicantIdsReturn = new List<IRS_Transcripts__c>();
        getIRSTranscriptsByApplicationIdsReturn = new List<IRS_Transcripts__c>();
    }

    public List<IRS_Transcripts__c> getIRSTranscriptsByApplicantIds(List<Id> applicantIds){
        getIRSTranscriptsByApplicantIdsCallCount++;
        return getIRSTranscriptsByApplicantIdsReturn;
    }
    public List<IRS_Transcripts__c> getIRSTranscriptsByApplicationId(Id applicationsId){
       
        return null;
    }

    public List<IRS_Transcripts__c> getIRSTranscriptsByApplicationIds(List<Id> applicationIds){
        getIRSTranscriptsByApplicationIdsCallCount++;
        return getIRSTranscriptsByApplicationIdsReturn;
    }
}