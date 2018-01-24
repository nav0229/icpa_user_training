/****************************************************************
 Name: DisbursementIssueDataAccessor
============================================================
Author: Matt
Purpose: Data Accessor object for Disbursement Issue
============================================================z 

****************************************************************/

public with sharing class DisbursementIssueDataAccessor implements DisbursementIssueDAO {

	private final String DISBURSEMENT_ISSUE = 'Disbursement_Issue__c';
	
	private Set<String> disbursementIssueFields;

	public DisbursementIssueDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.disbursementIssueFields = schemaMap.get(DISBURSEMENT_ISSUE).getDescribe().fields.getMap().keySet();
	}

	public List<Disbursement_Issue__c> getDisbursementIssuesByLoanIds(List<Id> loanId){
		QueryBuilder disbursementIssueQueryBuilder = new QueryBuilder(DISBURSEMENT_ISSUE);
		disbursementIssueQueryBuilder.addSelectField(this.disbursementIssueFields);
		disbursementIssueQueryBuilder.addWhereCondition('Loan__c', loanId, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(disbursementIssueQueryBuilder.generateQUery());
	}

	public void updateDisbursementIssues(List<Disbursement_Issue__c> disbursementIssues) {
		update disbursementIssues;
	}

	public void insertDisbursementIssues(List<Disbursement_Issue__c> disbursementIssues) {
		insert disbursementIssues;
	}

}