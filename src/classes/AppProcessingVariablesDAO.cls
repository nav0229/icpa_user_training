/****************************************************************
 Name: AppProcessingVariablesDAO
============================================================
Author: Kevin
Purpose: Data Access Object for App_Processing_Variables__c
============================================================

****************************************************************/
public interface AppProcessingVariablesDAO {
	App_Processing_Variables__c getNewestActiveAppProcessingVariableByType(String appType);
}