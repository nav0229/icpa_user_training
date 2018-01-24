/****************************************************************
 Name: OtherAssistanceDAO
============================================================
Author: 
Purpose: Data Access Object for Other_Assistance__c
============================================================

****************************************************************/

public interface OtherAssistanceDAO {
	List<Other_Assistance__c> getOtherAssistancebyApplicationId(Id appId);
	List<Other_Assistance__c> getOtherAssistancebyApplicationIds(List<Id> appId);
}