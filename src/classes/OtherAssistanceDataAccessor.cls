/****************************************************************
 Name: OtherAssistanceDataAccessor
============================================================
Author: Matt
Purpose: Data Accessor for Other_Assistance__c
============================================================

****************************************************************/

public with sharing class OtherAssistanceDataAccessor implements OtherAssistanceDAO {

	private final String OTHER_ASSISTANCE = 'Other_Assistance__c';

	private Set<String> otherAssitanceFields;

	public OtherAssistanceDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.otherAssitanceFields = schemaMap.get(OTHER_ASSISTANCE).getDescribe().fields.getMap().keySet();
	}
	
	public List<Other_Assistance__c> getOtherAssistancebyApplicationId(Id applicationId) {
		QueryBuilder otherAssistanceQueryBuilder = new QueryBuilder(OTHER_ASSISTANCE);
		otherAssistanceQueryBuilder.addSelectField(this.otherAssitanceFields);
		otherAssistanceQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(otherAssistanceQueryBuilder.generateQuery());
	}

	public List<Other_Assistance__c> getOtherAssistancebyApplicationIds(List<Id> applicationIds) {
		QueryBuilder otherAssistanceQueryBuilder = new QueryBuilder(OTHER_ASSISTANCE);
		otherAssistanceQueryBuilder.addSelectField(this.otherAssitanceFields);
		otherAssistanceQueryBuilder.addWhereCondition('Application__c', new List<Id>(applicationIds), QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(otherAssistanceQueryBuilder.generateQuery());
	}
}