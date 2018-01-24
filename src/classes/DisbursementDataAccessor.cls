/****************************************************************
 Name: DisbursementDataAccessor
============================================================
Author: Matt
Purpose: Data Accessor object for Disbursements
============================================================

****************************************************************/

public with sharing class DisbursementDataAccessor implements DisbursementDAO {

	private final String DISBURSEMENT = 'Disbursement__c';
	private final String LINE_ITEM = 'Disbursement_Line_Item__c';
	private final String LINE_ITEM_RELATIONSHIP_NAME = 'Disbursement_Line_Items__r';
	
	private Set<String> disbursementFields;
	private Set<String> lineItemFields;

	public DisbursementDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.disbursementFields = schemaMap.get(DISBURSEMENT).getDescribe().fields.getMap().keySet();
		this.lineItemFields = schemaMap.get(LINE_ITEM).getDescribe().fields.getMap().keySet();
	}

	public List<Disbursement__c> getDisbursementsByLoanIds(List<Id> loanId){
		QueryBuilder disbursementIssueQueryBuilder = new QueryBuilder(DISBURSEMENT);
		disbursementIssueQueryBuilder.addSelectField(this.disbursementFields);
		disbursementIssueQueryBuilder.addWhereCondition('Loan__c', loanId, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(disbursementIssueQueryBuilder.generateQUery());
	}

	public List<Disbursement__c> getDisbursementsAndLineItemsByDisbursementIds(List<Id> disbursementIds) {
		QueryBuilder disbursementQueryBuilder = new QueryBuilder(DISBURSEMENT);
		disbursementQueryBuilder.addSelectField(this.disbursementFields);

		QueryBuilder lineItemQueryBuilder = new QueryBuilder(LINE_ITEM_RELATIONSHIP_NAME);
		lineItemQueryBuilder.addSelectField(this.lineItemFields);
		disbursementQueryBuilder.addSelectField(lineItemQueryBuilder);

		disbursementQueryBuilder.addWhereCondition('Id', disbursementIds, QueryBuilder.ComparisonOperator.IN_LIST);

		return Database.query(disbursementQueryBuilder.generateQuery());
	}

	public List<Disbursement__c> getDisbursementsAndLineItemsByLoanIds(List<Id> loanId) {
		QueryBuilder disbursementQueryBuilder = new QueryBuilder(DISBURSEMENT);
		disbursementQueryBuilder.addSelectField(this.disbursementFields);

		QueryBuilder lineItemQueryBuilder = new QueryBuilder(LINE_ITEM_RELATIONSHIP_NAME);
		lineItemQueryBuilder.addSelectField(this.lineItemFields);
		disbursementQueryBuilder.addSelectField(lineItemQueryBuilder);

		disbursementQueryBuilder.addWhereCondition('Loan__c', loanId, QueryBuilder.ComparisonOperator.IN_LIST);

		return Database.query(disbursementQueryBuilder.generateQuery());
	}

	public void updateDisbursements(List<Disbursement__c> disbursementIssues) {
		update disbursementIssues;
	}

	public void insertDisbursements(List<Disbursement__c> disbursementIssues) {
		insert disbursementIssues;
	}

}