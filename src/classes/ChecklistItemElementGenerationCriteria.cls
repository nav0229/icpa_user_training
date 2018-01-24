/****************************************************************
 Name:  ChecklistItemElementGenerationCriteria
============================================================
Author: Lenny
Purpose: JIRA#2148,2170
============================================================

****************************************************************/
public with sharing class ChecklistItemElementGenerationCriteria {
	public Loan_Condition_Element__c relatedElement {get; private set;}
	public Checklist_Item__c relatedChecklistItem {get; private set;}

	public ChecklistItemElementGenerationCriteria(Loan_Condition_Element__c element, Checklist_Item__c checklistItem) {
		this.relatedElement = element;
		this.relatedChecklistItem = checklistItem;
	}

	public ChecklistItemElementGenerationCriteria(Checklist_Item__c checklistItem) {
		this.relatedChecklistItem = checklistItem;
		this.relatedElement = new Loan_Condition_Element__c();
	}
}