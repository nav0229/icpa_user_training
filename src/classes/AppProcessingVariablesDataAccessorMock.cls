/****************************************************************
 Name: AppProcessingVariablesDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor Class for AppProcessingVariables
============================================================

****************************************************************/

@isTest
public with sharing class AppProcessingVariablesDataAccessorMock implements AppProcessingVariablesDAO {
	public Integer getNewestActiveAppProcessingVariableByTypeCallCount {get; private set;}

	public App_Processing_Variables__c getNewestActiveAppProcessingVariableByTypeReturn;

	public AppProcessingVariablesDataAccessorMock() {
		getNewestActiveAppProcessingVariableByTypeCallCount = 0;

		getNewestActiveAppProcessingVariableByTypeReturn = new App_Processing_Variables__c();
	}

	public App_Processing_Variables__c getNewestActiveAppProcessingVariableByType(String appType){
		getNewestActiveAppProcessingVariableByTypeCallCount++;
		return getNewestActiveAppProcessingVariableByTypeReturn;
	}
}