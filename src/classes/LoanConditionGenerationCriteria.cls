/****************************************************************
 Name: LoanConditionGenerationCriteria
============================================================
Author: Lenny
Purpose: DCMM-2138
	Wrapper class to house the various components necessary for
	determining which Loan Conditions should be generated
============================================================

****************************************************************/
public with sharing class LoanConditionGenerationCriteria {
	public Application__c application {get; private set;}
	public List<UP_Codes__c> relatedUPCodes {get; private set;}
	public Property__c relatedProperty {get; private set;}

	public LoanConditionGenerationCriteria(Application__c application, List<UP_Codes__c> upCodes){
		this.application = application;
		this.relatedUPCodes = upCodes;
		this.relatedProperty = new Property__c();
	}

	public LoanConditionGenerationCriteria(Application__c application, List<UP_Codes__c> upCodes, Property__c property){
		this.application = application;
		this.relatedUPCodes = upCodes;
		this.relatedProperty = property;
	}
}