/****************************************************************
 Name: InsuranceDataAccessor
============================================================
Author: Matt
Purpose: Data Accessor for Insurance__c
============================================================

****************************************************************/

public with sharing class InsuranceDataAccessor implements InsuranceDAO {

	private final String INSURANCE = 'Insurance__c';

	private Set<String> insuranceFields;

	public InsuranceDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.insuranceFields = schemaMap.get(INSURANCE).getDescribe().fields.getMap().keySet();
	}

	public void updateInsurances(List<Insurance__c> insurances) {
		update insurances;
	}

	public List<Insurance__c> getInsuranceByApplicationId(Id applicationId){
		QueryBuilder insuranceQueryBuilder = new QueryBuilder(INSURANCE);
		insuranceQueryBuilder.addSelectField(this.insuranceFields);
		insuranceQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(insuranceQueryBuilder.generateQuery());
	}

	public List<Insurance__c> getActiveInsuranceByApplicationId(Id applicationId){
		QueryBuilder insuranceQueryBuilder = new QueryBuilder(INSURANCE);
		insuranceQueryBuilder.addSelectField(this.insuranceFields);
		insuranceQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		insuranceQueryBuilder.addWhereCondition('Active__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(insuranceQueryBuilder.generateQuery());
	}

	public List<Insurance__c> getInsuranceByApplicationIds(List<Id> applicationIds){
		QueryBuilder insuranceQueryBuilder = new QueryBuilder(INSURANCE);
		insuranceQueryBuilder.addSelectField(this.insuranceFields);
		insuranceQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(insuranceQueryBuilder.generateQuery());
	}
}