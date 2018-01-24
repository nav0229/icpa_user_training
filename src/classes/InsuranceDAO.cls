/****************************************************************
 Name: InsuranceDAO
============================================================
Author: 
Purpose: Data Access Object for Insurance__c
============================================================

****************************************************************/

public interface InsuranceDAO {
	void updateInsurances(List<Insurance__c> insurances);
	List<Insurance__c> getInsuranceByApplicationId(Id applicationId);
	List<Insurance__c> getActiveInsuranceByApplicationId(Id applicationId);
	List<Insurance__c> getInsuranceByApplicationIds(List<Id> applicationIds);
}