@isTest
public with sharing class PropertyDataAccessorMock implements PropertyDAO {
	public Integer getDamagedPropertiesByApplicationIdCallCount {get; private set;}
	public Integer getDamagedPropertiesAndLossVerificationsByApplicationIdsCallCount {get; private set;}
	public Integer getDamagedPropertiesAndLossVerificationsByApplicationIdCallCount {get; private set;}
	public Integer getDamagedPropertiesByApplicationIdsCallCount {get; private set;}
	public Integer updatePropertiesCallCount {get; private set;}
	
	public List<Property__c> getDamagedPropertiesByApplicationIdReturn;
	public List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn;
	public List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationIdReturn;
	public Map<Id,Property__c> getDamagedPropertiesByApplicationIdsReturn;

	public PropertyDataAccessorMock() {
		getDamagedPropertiesByApplicationIdCallCount = 0;
		getDamagedPropertiesAndLossVerificationsByApplicationIdsCallCount = 0;
		getDamagedPropertiesAndLossVerificationsByApplicationIdCallCount = 0;
		getDamagedPropertiesByApplicationIdsCallCount = 0;
		updatePropertiesCallCount = 0;

		getDamagedPropertiesByApplicationIdReturn = new List<Property__c>();
		getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn = new List<Property__c>();
		getDamagedPropertiesAndLossVerificationsByApplicationIdReturn = new List<Property__c>();
		getDamagedPropertiesByApplicationIdsReturn = new Map<Id,Property__c>();
	}

	public List<Property__c> getDamagedPropertiesByApplicationId(Id applicationId){
		getDamagedPropertiesByApplicationIdCallCount++;
		return getDamagedPropertiesByApplicationIdReturn;
	}

	public List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationId(Id applicationId){
		getDamagedPropertiesAndLossVerificationsByApplicationIdCallCount++;
		return getDamagedPropertiesAndLossVerificationsByApplicationIdReturn;
	}

	public List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationIds(List<Id> applicationId){
		getDamagedPropertiesAndLossVerificationsByApplicationIdsCallCount++;
		return getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn;
	}

	public Map<Id,Property__c> getDamagedPropertiesByApplicationIds(List<Id> applicationIds){
		getDamagedPropertiesByApplicationIdsCallCount++;
		return getDamagedPropertiesByApplicationIdsReturn;
	}

	public void updateProperties(List<Property__c> properties) {
		updatePropertiesCallCount++;
	}
}