/****************************************************************
 Name: StandardRealEstateRequirementEvalInvoker
============================================================
Author: 
Purpose: Invocable Method for Evaluate Standard Real Estate Requirement
============================================================

****************************************************************/

public with sharing class StandardRealEstateRequirementEvalInvoker {

	@InvocableMethod(label='Evaluate Standard Real Estate Requirement' description='Runs method to evaluate whether to include Standard Real Estate Requirement in LAA')
	public static void invokeStandardRealEstateRequirementEvaluator (List<Id> applicationIds) {
		StandardRealEstateRequirementEvaluator stdRealEstateEvaluator = new StandardRealEstateRequirementEvaluator();
		stdRealEstateEvaluator.evaluateStandardRealEstateRequirement(applicationIds);
	}
}