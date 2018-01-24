/****************************************************************
 Name: DebtsExpensesDAO
============================================================
Author: Kevin
Purpose: Data Access Objecet for DebtsExpenses
============================================================

****************************************************************/

public interface DebtsExpensesDAO {
	void updateDebtsAndExpenses(List<Debts_Expenses__c> debstAndExpenses);

	List<Debts_Expenses__c> getDebtsAndExpensesByApplicationId(List<Id> applicationIds);
}