/****************************************************************
 Name: LoanConditionElementDataAccessor
============================================================
Author: Kevin
Purpose: DCMM-2148
	Data Accessor for Loan_Condition_Element__c
============================================================

****************************************************************/
public with sharing class LoanConditionElementDataAccessor implements LoanConditionElementDAO {
	public static final String SHARED_REPAIR_RESPONSIBILITY_TYPE = 'Shared Repair Responsibility';

	private final String LOAN_CONDITION_ELEMENT = 'Loan_Condition_Element__c';

	private Set<String> loanConditionElementFields;

	public LoanConditionElementDataAccessor() {
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.loanConditionElementFields = schemaMap.get(LOAN_CONDITION_ELEMENT).getDescribe().fields.getMap().keySet();
	}

	public void insertLoanConditionElements(List<Loan_Condition_Element__c> loanConditionElements){
		insert loanConditionElements;
	}

	public List<Loan_Condition_Element__c> getLoanConditionElementsByLoanConditionChecklistIds(List<Id> loanConditionIds){
		QueryBuilder loanConditionElementQueryBuilder = new QueryBuilder(LOAN_CONDITION_ELEMENT);
		loanConditionElementQueryBuilder.addSelectField(this.loanConditionElementFields);
		loanConditionElementQueryBuilder.addWhereCondition('Loan_Condition__c', loanConditionIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(loanConditionElementQueryBuilder.generateQuery());
	}

	public List<Loan_Condition_Element__c> getRequiredLoanConditionElementsByLoanConditionChecklistIds(List<Id> loanConditionIds){
		QueryBuilder loanConditionElementQueryBuilder = new QueryBuilder(LOAN_CONDITION_ELEMENT);
		loanConditionElementQueryBuilder.addSelectField(this.loanConditionElementFields);
		loanConditionElementQueryBuilder.addWhereCondition('Loan_Condition__c', loanConditionIds, QueryBuilder.ComparisonOperator.IN_LIST);
		loanConditionElementQueryBuilder.addWhereCondition('Required__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(loanConditionElementQueryBuilder.generateQuery());
	}
}