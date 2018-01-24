/****************************************************************
 Name: InsuranceDataAccessorMock
============================================================
Author: Matt
Purpose: Mock Data Accessor for Insurance__c
============================================================

****************************************************************/

@isTest
public with sharing class InsuranceDataAccessorMock implements InsuranceDAO {
	public Integer updateInsurancesCallCount {get; private set;}

	public Integer getInsuranceByApplicationIdCallCount {get; private set;}
	public Integer getActiveInsuranceByApplicationIdCallCount {get; private set;}
	public Integer getInsuranceByApplicationIdsCallCount {get; private set;}

	public List<Insurance__c> getInsuranceByApplicationIdReturn;
	public List<Insurance__c> getActiveInsuranceByApplicationIdReturn;
	public List<Insurance__c> getInsuranceByApplicationIdsReturn;
	
	public InsuranceDataAccessorMock(){
		updateInsurancesCallCount = 0;

		getInsuranceByApplicationIdCallCount = 0;
		getActiveInsuranceByApplicationIdCallCount = 0;
		getInsuranceByApplicationIdsCallCount = 0;

		getInsuranceByApplicationIdReturn = new List<Insurance__c>();
		getActiveInsuranceByApplicationIdReturn = new List<Insurance__c>();
		getInsuranceByApplicationIdsReturn = new List<Insurance__c>();
	}

	public void updateInsurances(List<Insurance__c> insurances) {
		updateInsurancesCallCount++;
	}

	public List<Insurance__c> getInsuranceByApplicationId(Id appId){
		getInsuranceByApplicationIdCallCount++;
		return getInsuranceByApplicationIdReturn;
	}

	public List<Insurance__c> getActiveInsuranceByApplicationId(Id applicationId){
		getActiveInsuranceByApplicationIdCallCount++;
		return getActiveInsuranceByApplicationIdReturn;
	}

	public List<Insurance__c> getInsuranceByApplicationIds(List<Id> applicationIds){
		getInsuranceByApplicationIdsCallCount++;
		return getInsuranceByApplicationIdsReturn;
	}
}