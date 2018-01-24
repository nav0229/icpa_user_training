/****************************************************************
 Name: LoanConditionChecklistDataAccessor
============================================================
Author: 
Purpose: Data Accessor for Loan_Condition_Checklist__c
============================================================

****************************************************************/

public with sharing class LoanConditionChecklistDataAccessor implements LoanConditionChecklistDAO {

	private final String LOAN_CONDITION_CHECKLIST = 'Loan_Condition_Checklist__c';

	private Set<String> loanConditionChecklistFields;

	public LoanConditionChecklistDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.loanConditionChecklistFields = schemaMap.get(LOAN_CONDITION_CHECKLIST).getDescribe().fields.getMap().keySet();
	}

	public void insertLoanConditionChecklists(List<Loan_Condition_Checklist__c> loanConditionChecklists){
		insert loanConditionChecklists;
	}

	public List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByApplicationIds(List<Id> applicationIds){
		QueryBuilder loanConditionChecklistQueryBuilder = new QueryBuilder(LOAN_CONDITION_CHECKLIST);
		loanConditionChecklistQueryBuilder.addSelectField(this.loanConditionChecklistFields);
		loanConditionChecklistQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		loanConditionChecklistQueryBuilder.addWhereCondition('Active__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(loanConditionChecklistQueryBuilder.generateQuery());
	}

	public List<Loan_Condition_Checklist__c> getActiveLoanConditionChecklistsByIds(List<Id> loanConditionIds){
		QueryBuilder loanConditionChecklistQueryBuilder = new QueryBuilder(LOAN_CONDITION_CHECKLIST);
		loanConditionChecklistQueryBuilder.addSelectField(this.loanConditionChecklistFields);
		loanConditionChecklistQueryBuilder.addWhereCondition('Id', loanConditionIds, QueryBuilder.ComparisonOperator.IN_LIST);
		loanConditionChecklistQueryBuilder.addWhereCondition('Active__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(loanConditionChecklistQueryBuilder.generateQuery());
	}
}