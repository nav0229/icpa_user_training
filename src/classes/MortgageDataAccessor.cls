/****************************************************************
 Name: MortgageDataAccessor
============================================================
Author: Matt/
Purpose: 1340
Data Accessor for Mortgage__c
============================================================

****************************************************************/

public with sharing class MortgageDataAccessor implements MortgageDAO{
	private final String MORTGAGE = 'Mortgage__c';

	private Set<String> mortgageFields;

	public MortgageDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.mortgageFields = schemaMap.get(MORTGAGE).getDescribe().fields.getMap().keySet();
	}

	public void updateMortgages(List<Mortgage__c> mortgages) {
		update mortgages;
	}

	public List<Mortgage__c> getMortgageByApplicationIds(List<Id> applicationIds){
		QueryBuilder mortgageQueryBuilder = new QueryBuilder(MORTGAGE);
		mortgageQueryBuilder.addSelectField(this.mortgageFields);
		mortgageQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(mortgageQueryBuilder.generateQuery());
	}
}