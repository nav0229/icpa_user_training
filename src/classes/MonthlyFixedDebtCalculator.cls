/****************************************************************
 Name:  MonthlyFixedDebtCalculator
============================================================
Author: Lenny/Matt
Purpose: JIRA#1775
Responsible for calculating the Monthly Fixed Debt field 
value on the Application object for the given Application IDs
============================================================

****************************************************************/
public with sharing class MonthlyFixedDebtCalculator {
    @TestVisible
    private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

    @TestVisible
    private static CreditBureauLineItemDAO creditBureauLineItemDA = new CreditBureauLineItemDataAccessor();

    @TestVisible
    private static DebtsExpensesDAO debtsExpensesDA = new DebtsExpensesDataAccessor();

    private static final Set<String> INCLUDED_LIABILITY_TYPES = new Set<String>{
        'Rent',
        'Housing',
        'Alimony',
        'Condo/Assoc Fee',
        'Child Care',
        'Child Support',
        'Medical Costs',
        'Hazard Insurance',
        'Renters Insurance',
        'Flood Insurance',
        'Real Estate Taxes',
        'Taxes',
        'Tuition for Medical Disability',
        'ELA'
    };

    public void calculateTotalMonthlyFixedDebt(List<Id> applicationIds) {
        Map<Id, Application__c> appIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);

        Map<Id, List<Credit_Bureau_Line_Item__c>> appIdToCBRLineItemsMap = createAppIdsToCBRLineItemsMap(applicationIds);
        List<Debts_Expenses__c> relatedDebtsExpenses = debtsExpensesDA.getDebtsAndExpensesByApplicationId(applicationIds);
        Map<Id, List<Debts_Expenses__c>> appIdToDebtsExpensesMap = createAppIdsToDebtsExpensesMap(applicationIds, relatedDebtsExpenses);

        for(Id appId : applicationIds) {
            if(appIdToApplicationMap.containsKey(appId)){
                Application__c app = appIdToApplicationMap.get(appId);
                app.Monthly_Fixed_Debt__c = 0;
                app.Monthly_Fixed_Debt__c += sumMonthlyPaymentsFromCreditBureauLineItems(appIdToCBRLineItemsMap.get(appId));
                app.Monthly_Fixed_Debt__c += sumMonthlyPaymentsFromDebtsExpenses(appIdToDebtsExpensesMap.get(appId), appIdToCBRLineItemsMap.get(appId));

                if(app.Monthly_Fixed_Debt__c != null && app.Monthly_Fixed_Debt__c > 0) {
                    if(app.IRS_Actual_Income__c > 0){
                        app.MAFD__c = (app.Monthly_Fixed_Debt__c / (app.IRS_Actual_Income__c / 12)) * 100;
                    }else if(app.Gross_Monthly_Income_rollup__c > 0) {
                        app.MAFD__c = (app.Monthly_Fixed_Debt__c / app.Gross_Monthly_Income_rollup__c) * 100;
                    }
                }
                //old code
                //if(app.Monthly_Fixed_Debt__c!=null && app.Monthly_Fixed_Debt__c>0 && app.Gross_Monthly_Income_rollup__c>0){
                //    app.MAFD__c = (app.Monthly_Fixed_Debt__c/ app.Gross_Monthly_Income_rollup__c)*100;
                //}
            }
        }

        try {
            if(appIdToApplicationMap.values() != null) {        
                applicationDA.updateApplications(appIdToApplicationMap.values());
            }
            if(relatedDebtsExpenses != null) {
                debtsExpensesDA.updateDebtsAndExpenses(relatedDebtsExpenses);
            }
        }
        catch (DmlException e) {
            throw new MonthlyFixedDebtCalculatorException(
                'Error updating Applications or Debts/Expenses during Monthly Fixed Debt Calculation: ' 
                + e.getMessage()
            );
        }
    }

    private Map<Id, List<Credit_Bureau_Line_Item__c>> createAppIdsToCBRLineItemsMap(List<Id> applicationIds) {
		List<Credit_Bureau_Line_Item__c> relatedLineItems = creditBureauLineItemDA.getActiveCreditBureauLineItemsByApplicationIds(applicationIds);
        Map<Id, List<Credit_Bureau_Line_Item__c>> appIdToCBRLineItemsMap = new Map<Id, List<Credit_Bureau_Line_Item__c>>();
        for(Id appId : applicationIds) {
            List<Credit_Bureau_Line_Item__c> currentLineItems = new List<Credit_Bureau_Line_Item__c>();
            for(Credit_Bureau_Line_Item__c lineItem : relatedLineItems) {
                if(appId == lineItem.Credit_Bureau__r.Application__c) {
                    currentLineItems.add(lineItem);
                }
            }
            appIdToCBRLineItemsMap.put(appId, currentLineItems);
        }
        return appIdToCBRLineItemsMap;
    }

    private Map<Id, List<Debts_Expenses__c>> createAppIdsToDebtsExpensesMap(List<Id> applicationIds, 
    	List<Debts_Expenses__c> relatedDebtsExpenses) {
        Map<Id, List<Debts_Expenses__c>> appIdToDebtsExpensesMap = new Map<Id, List<Debts_Expenses__c>>();
        for(Id appId : applicationIds) {
            List<Debts_Expenses__c> currentDebtsExpenses = new List<Debts_Expenses__c>();
            for(Debts_Expenses__c debtExpense : relatedDebtsExpenses) {
                if(appId == debtExpense.Application__c) {
                    currentDebtsExpenses.add(debtExpense);
                }
            }
            appIdToDebtsExpensesMap.put(appId, currentDebtsExpenses);
        }   
        return appIdToDebtsExpensesMap;
    }

    private Decimal sumMonthlyPaymentsFromCreditBureauLineItems(List<Credit_Bureau_Line_Item__c> lineItems){
        Decimal sum = 0;
        for(Credit_Bureau_Line_Item__c lineItem : lineItems){
            if(lineItem.Account_Balance__c > 0 && !lineItem.Is_Duplicate__c){
	            if(lineItem.Creditor_Type__c == 'R'){
	                if(lineItem.Monthly_Payments__c > 0) {
	                    sum += lineItem.Monthly_Payments__c;
	                }
	                else {
	                    sum += calculateSBAThreePercentRule(lineItem.Account_Balance__c);
	                }
	            }
	            else if(lineItem.Creditor_Type__c == 'I') {
	                if(lineItem.Monthly_Payments__c != null && lineItem.Account_Balance__c > (lineItem.Monthly_Payments__c * 10)){
	                    sum += lineItem.Monthly_Payments__c;
	                }
	            }
        	}
        }
        return sum;
    }

    private Decimal calculateSBAThreePercentRule(Decimal accountBalance){
        Decimal monthlyPayment = accountBalance * 0.03;
        if(monthlyPayment <= 20) {
            monthlyPayment = 20;
        }
        else if(accountBalance == 0) {
            monthlyPayment = 0;
        }
        return monthlyPayment; 
    }

    private Decimal sumMonthlyPaymentsFromDebtsExpenses(List<Debts_Expenses__c> debtsExpenses, List<Credit_Bureau_Line_Item__c> lineItems) {
        Decimal sum = 0;
        Boolean activeMortgageInCBR = checkActiveMortgageInCBR(lineItems);
        for(Debts_Expenses__c debtExpense : debtsExpenses) {
            if(debtExpense.Type_of_Debt__c == 'Mortgage' && !activeMortgageInCBR && debtExpense.Monthly_Payment__c != null){
                sum += debtExpense.Monthly_Payment__c;
                debtExpense.Is_Included_in_MFD_Calc__c = true;
            }
            else if(INCLUDED_LIABILITY_TYPES.contains(debtExpense.Type_of_Debt__c) && debtExpense.Monthly_Payment__c != null){
                sum += debtExpense.Monthly_Payment__c;
                debtExpense.Is_Included_in_MFD_Calc__c = true;
            }
            else {
                debtExpense.Is_Included_in_MFD_Calc__c = false;
            }
        }
        return sum;
    }

    private Boolean checkActiveMortgageInCBR(List<Credit_Bureau_Line_Item__c> lineItems){
        Boolean activeMortgageInCBR = false;
        for(Credit_Bureau_Line_Item__c lineItem : lineItems) {
            if(lineItem.Purpose_Of_Account__c == 'M') {
                activeMortgageInCBR = true;
            }
        }
        return activeMortgageInCBR;
    }

    public class MonthlyFixedDebtCalculatorException extends Exception {}
}