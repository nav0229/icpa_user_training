/****************************************************************
 Name: DisasterDataAccessor
============================================================
Author: 
Purpose: Data Access for Disaster__c
============================================================

****************************************************************/

public with sharing class DisasterDataAccessor implements DisasterDAO {

	private final String DISASTER = 'Disaster__c';

	private Set<String> disasterFields;

	public DisasterDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.disasterFields = schemaMap.get(DISASTER).getDescribe().fields.getMap().keySet();
	}

	public Disaster__c getDisasterById(Id disasterId){
		QueryBuilder disasterQueryBuilder = new QueryBuilder(DISASTER);
		disasterQueryBuilder.addSelectField(this.disasterFields);
		disasterQueryBuilder.addWhereCondition('Id', disasterId, QueryBuilder.ComparisonOperator.EQUALS);
		disasterQueryBuilder.setLimit(1);
		return Database.query(disasterQueryBuilder.generateQUery());
	}
}