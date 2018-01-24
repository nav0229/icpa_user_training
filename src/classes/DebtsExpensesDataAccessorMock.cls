/****************************************************************
 Name: DebtsExpensesDataAccessorMock
============================================================
Author: 
Purpose: Mock data accessor for Debt Expenses 
============================================================

****************************************************************/

@isTest
public with sharing class DebtsExpensesDataAccessorMock implements DebtsExpensesDAO {
	public Integer getDebtsAndExpensesByApplicationIdCallCount {get; private set;}
	public Integer updateDebtsAndExpensesCallCount {get; private set;}

	public List<Debts_Expenses__c> getDebtsAndExpensesByApplicationIdReturn;

	public DebtsExpensesDataAccessorMock() {
		updateDebtsAndExpensesCallCount = 0;
		getDebtsAndExpensesByApplicationIdCallCount = 0;

		getDebtsAndExpensesByApplicationIdReturn = new List<Debts_Expenses__c>();
	}

	public List<Debts_Expenses__c> getDebtsAndExpensesByApplicationId(List<Id> applicationIds){
		getDebtsAndExpensesByApplicationIdCallCount++;
		return getDebtsAndExpensesByApplicationIdReturn;
	}

	public void updateDebtsAndExpenses(List<Debts_Expenses__c> debstAndExpenses){
		updateDebtsAndExpensesCallCount++;
	}
}