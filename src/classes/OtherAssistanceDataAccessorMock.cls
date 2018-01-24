/****************************************************************
 Name: OtherAssistanceDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor for Other_Assistance__c
============================================================

****************************************************************/

@isTest
public with sharing class OtherAssistanceDataAccessorMock implements OtherAssistanceDAO {
    public Integer getOtherAssistancebyApplicationIdCallCount {get; private set;}
    public Integer getOtherAssistancebyApplicationIdsCallCount {get; private set;}


    public List<Other_Assistance__c> getOtherAssistancebyApplicationIdReturn;
    public List<Other_Assistance__c> getOtherAssistancebyApplicationIdsReturn;
    
    public OtherAssistanceDataAccessorMock(){
        getOtherAssistancebyApplicationIdCallCount = 0;
        getOtherAssistancebyApplicationIdsCallCount = 0;


        getOtherAssistancebyApplicationIdReturn = new List<Other_Assistance__c>();
        getOtherAssistancebyApplicationIdsReturn = new List<Other_Assistance__c>();
    }

    public List<Other_Assistance__c> getOtherAssistancebyApplicationId(Id applicationId){
        getOtherAssistancebyApplicationIdCallCount++;
        return getOtherAssistancebyApplicationIdReturn;
    }

    public List<Other_Assistance__c> getOtherAssistancebyApplicationIds(List<Id> applicationId) {
        getOtherAssistancebyApplicationIdsCallCount++;
        return getOtherAssistancebyApplicationIdsReturn;
    }

}