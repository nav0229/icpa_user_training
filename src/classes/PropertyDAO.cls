/****************************************************************
 Name: PropertyDAO
============================================================
Author: 
Purpose: Data Access Object for Property
============================================================

****************************************************************/

public interface PropertyDAO {
	void updateProperties(List<Property__c> properties);
	List<Property__c> getDamagedPropertiesByApplicationId(Id applicationId);
	List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationId(Id applicationId);
	List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationIds(List<Id> applicationId);
	Map<Id,Property__c> getDamagedPropertiesByApplicationIds(List<Id> applicationIds);
}