/****************************************************************
 Name:  DebtsExpensesDataAccessor
============================================================
Author: Kevin
Data Accessor for the Debts_Expenses__c object
============================================================

****************************************************************/
public with sharing class DebtsExpensesDataAccessor implements DebtsExpensesDAO {

	private final String DEBTS_EXPENSES = 'Debts_Expenses__c';

	private Set<String> debtsExpensesFields;

	public DebtsExpensesDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.debtsExpensesFields = schemaMap.get(DEBTS_EXPENSES).getDescribe().fields.getMap().keySet();
	}

	public void updateDebtsAndExpenses(List<Debts_Expenses__c> debtsAndExpenses){
		update debtsAndExpenses;
	}

	public List<Debts_Expenses__c> getDebtsAndExpensesByApplicationId(List<Id> applicationIds){
		QueryBuilder debtsExpensesQueryBuilder = new QueryBuilder(DEBTS_EXPENSES);
		debtsExpensesQueryBuilder.addSelectField(this.debtsExpensesFields);
		debtsExpensesQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(debtsExpensesQueryBuilder.generateQuery());
	}
}