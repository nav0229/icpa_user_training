public with sharing class ChecklistItemGenerationCriteria {
	public Case relatedCase {get; private set;}
	public Application__c relatedApplication {get; private set;}
	public Loan_Condition_Checklist__c relatedLC {get; private set;}

	public ChecklistItemGenerationCriteria(Case cas, Application__c application, Loan_Condition_Checklist__c loanCondition) {
		this.relatedCase = cas;
		this.relatedApplication = application;
		this.relatedLC = loanCondition;
	}
}