/****************************************************************
 Name: AppProcessingVariablesDataAccessor
============================================================
Author: Kevin
Purpose: Data Accessor Class for App_Processing_Variables__c
============================================================

****************************************************************/
public with sharing class AppProcessingVariablesDataAccessor implements AppProcessingVariablesDAO {

	private final String APP_PROCESSING_VARIABLES = 'App_Processing_Variables__c';

	private Set<String> appProcessingVariablesFields;

	public AppProcessingVariablesDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.appProcessingVariablesFields = schemaMap.get(APP_PROCESSING_VARIABLES).getDescribe().fields.getMap().keySet();
	}

	public App_Processing_Variables__c getNewestActiveAppProcessingVariableByType(String applicationType) {
		QueryBuilder appProcVariablesQueryBuilder = new QueryBuilder(APP_PROCESSING_VARIABLES);
        appProcVariablesQueryBuilder.addSelectField(this.appProcessingVariablesFields);
        appProcVariablesQueryBuilder.addWhereCondition('Application_Type__c', applicationType, QueryBuilder.ComparisonOperator.EQUALS);
        appProcVariablesQueryBuilder.setLimit(1);
        return Database.query(appProcVariablesQueryBuilder.generateQuery());
	}
}