/****************************************************************
 Name: LossVerificationDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor for Loss_Verification_Inspections__c
============================================================

****************************************************************/

@isTest
public with sharing class LossVerificationDataAccessorMock implements LossVerificationDAO {
    public Integer getLossVerificationsByLoanIdsCallCount {get; private set;}
    public Integer getLossVerificationsByApplicationIdsCallCount {get; private set;}
    public Integer getLossVerificationsByApplicationIdCallCount {get; private set;}
    public Integer getLossVerificationsAndRelatedUPCodesByApplicationIdCallCount {get; private set;}
    public Integer getLossVerificationsAndRelatedUPCodesByApplicationIdsCallCount {get; private set;}

    public List<Loss_Verification_Inspections__c> getLossVerificationsByLoanIdsReturn;
    public List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationIdsReturn;
    public List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationIdReturn;
    public List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationIdReturn;
    public List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationIdsReturn;
    
    public LossVerificationDataAccessorMock(){
        getLossVerificationsByLoanIdsCallCount = 0;
        getLossVerificationsByApplicationIdsCallCount = 0;
        getLossVerificationsByApplicationIdCallCount = 0;
        getLossVerificationsAndRelatedUPCodesByApplicationIdCallCount = 0;
        getLossVerificationsAndRelatedUPCodesByApplicationIdSCallCount = 0;

        getLossVerificationsByLoanIdsReturn = new List<Loss_Verification_Inspections__c>();
        getLossVerificationsByApplicationIdsReturn = new List<Loss_Verification_Inspections__c>();
        getLossVerificationsByApplicationIdReturn = new List<Loss_Verification_Inspections__c>();
        getLossVerificationsAndRelatedUPCodesByApplicationIdReturn = new List<Loss_Verification_Inspections__c>();
        getLossVerificationsAndRelatedUPCodesByApplicationIdSReturn = new List<Loss_Verification_Inspections__c>();
    }

    public List<Loss_Verification_Inspections__c> getLossVerificationsByLoanIds(Set<Id> loanIds){
        getLossVerificationsByLoanIdsCallCount++;
        return getLossVerificationsByLoanIdsReturn;
    }

    public List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationIds(Set<Id> applicationIds){
        getLossVerificationsByApplicationIdsCallCount++;
        return getLossVerificationsByApplicationIdsReturn;
    }

    public List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationId(Id applicationId){
        getLossVerificationsByApplicationIdCallCount++;
        return getLossVerificationsByApplicationIdReturn;
    }

    public List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationId(Id applicationId){
        getLossVerificationsAndRelatedUPCodesByApplicationIdCallCount++;
        return getLossVerificationsAndRelatedUPCodesByApplicationIdReturn;
    }

    public List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationIds(List<Id> applicationIdS){
        getLossVerificationsAndRelatedUPCodesByApplicationIdSCallCount++;
        return getLossVerificationsAndRelatedUPCodesByApplicationIdSReturn;
    }
}