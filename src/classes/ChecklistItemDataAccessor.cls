/****************************************************************
 Name:  ChecklistItemDataAccessor
============================================================
Author: Lenny
Data Accessor for Checklist_Item__c object
============================================================

****************************************************************/

public with sharing class ChecklistItemDataAccessor implements ChecklistItemDAO {
	public static final string REQUESTED_STATUS = 'Requested';
	public static final string RECEIVED_STATUS = 'Received';
	public static final string VALID_STATUS = 'Valid';
	public static final string INVALID_STATUS = 'Invalid';
	public static final string FAILED_STATUS = 'Failed';
	public static final string PENDING_CASE_MANAGER_REVIEW_STATUS = 'Pending Case Manager Review';
	public static final string PENDING_BORROWERS_VERIFICATION_STATUS = 'Pending Borrower\'s Verification';
	public static final string FINALIZED_STATUS = 'Finalized';
	public static final string AVAILABLE_STATUS = 'Available';

	public static final string DOC_GATHERING_TYPE = 'Document Gathering';
	public static final string CLOSING_DOC_TYPE = 'Closing Documents';
	public static final string INTERFACE_TYPE = 'Interface';
	public static final string SYSTEM_GENERATED_TYPE = 'System Generated';

	private final String CHECKLIST_ITEM = 'Checklist_Item__c';

	private Set<String> checklistItemFields;

	public ChecklistItemDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.checklistItemFields = schemaMap.get(CHECKLIST_ITEM).getDescribe().fields.getMap().keySet();
	}

	public void insertChecklistItems(List<Checklist_Item__c> checklistItems) {
		insert checklistItems;
	}

	public void updateChecklistItems(List<Checklist_Item__c> checklistItems) {
		update checklistItems;
	}

	public List<Checklist_Item__c> getChecklistItemsByApplicationIdsAndMasterChecklistId(List<Id> applicationIds, Id checklistId) {
		QueryBuilder checklistItemQueryBuilder = new QueryBuilder(CHECKLIST_ITEM);
		checklistItemQueryBuilder.addSelectField(this.checklistItemFields);
		checklistItemQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		checklistItemQueryBuilder.addWhereCondition('Master_Checklist__c', checklistId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(checklistItemQueryBuilder.generateQuery());
	}

	public List<Checklist_Item__c> getChecklistItemsByCaseIds(List<Id> caseIds) {
		QueryBuilder checklistItemQueryBuilder = new QueryBuilder(CHECKLIST_ITEM);
		checklistItemQueryBuilder.addSelectField(this.checklistItemFields);
		checklistItemQueryBuilder.addWhereCondition('Case__c', caseIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(checklistItemQueryBuilder.generateQuery());
	}

	public List<Checklist_Item__c> getChecklistItemsByChecklistItemIds(Set<Id> checklistItemIds) {
		QueryBuilder checklistItemQueryBuilder = new QueryBuilder(CHECKLIST_ITEM);
		checklistItemQueryBuilder.addSelectField(this.checklistItemFields);
		checklistItemQueryBuilder.addSelectField('Master_Checklist__r.Name');
		checklistItemQueryBuilder.addWhereCondition('Id', new List<Id>(checklistItemIds), QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(checklistItemQueryBuilder.generateQuery());
	}

	public List<Checklist_Item__c> getLoanClosingChecklistItemsByLoanIds(List<Id> loanIds){
		QueryBuilder checklistItemQueryBuilder = new QueryBuilder(CHECKLIST_ITEM);
		checklistItemQueryBuilder.addSelectField(this.checklistItemFields);
		checklistItemQueryBuilder.addWhereCondition('Loan__c', loanIds, QueryBuilder.ComparisonOperator.IN_LIST);
		checklistItemQueryBuilder.addWhereCondition('Type__c', CLOSING_DOC_TYPE, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(checklistItemQueryBuilder.generateQuery());
	}
}