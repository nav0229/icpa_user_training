/****************************************************************
 Name: LoanConditionGeneratorInvoker
============================================================
Author: Lenny
Purpose: DCMM-2138
	Invocable Method for Loan Condition Generation
============================================================

****************************************************************/
public with sharing class LoanConditionGeneratorInvoker {

	@InvocableMethod(label='Evaluate Automated Loan Conditions' description='Runs method to evaluate whether to create Loan conditions')
	public static void invokeLoanConditionGenerator (List<Id> applicationIds) {
		if(applicationIds.size() != 1){
			throw new LoanConditionsGeneratorInvokerException(
                'This operation cannot be invoked for bulk updates'
            );
            return;  
        }

		LoanConditionGenerator lcGenerator = new LoanConditionGenerator();
		lcGenerator.generateLoanCondition(applicationIds);
	}

	public class LoanConditionsGeneratorInvokerException extends Exception {}
}