/****************************************************************
 Name: SBALoanHistoryDataAccessor
============================================================
Author: 
Purpose: Data Accessor for SBA_Loan_History__c
============================================================

****************************************************************/

public with sharing class SBALoanHistoryDataAccessor implements SBALoanHistoryDAO {

	private final String SBA_LOAN_HISTORY = 'SBA_Loan_History__c';

	private Set<String> sbaLoanHistoryFields;

	public SBALoanHistoryDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.sbaLoanHistoryFields = schemaMap.get(SBA_LOAN_HISTORY).getDescribe().fields.getMap().keySet();
	}

	public List<SBA_Loan_History__c> getSBALoanHistoriesByApplicationIds(List<Id> applicationIds){
		QueryBuilder sbaLoanHistoryQueryBuilder = new QueryBuilder(SBA_LOAN_HISTORY);
		sbaLoanHistoryQueryBuilder.addSelectField(this.sbaLoanHistoryFields);
		sbaLoanHistoryQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(sbaLoanHistoryQueryBuilder.generateQuery());
	}
}