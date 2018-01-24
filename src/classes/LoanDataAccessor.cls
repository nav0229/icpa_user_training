/****************************************************************
 Name: LoanDataAccessor
============================================================
Author: Matt/
Purpose: Data Accessor object for Loan__c
============================================================

****************************************************************/

public with sharing class LoanDataAccessor implements LoanDAO {

	public static final String ERROR_ON_RERUN_INTERFACE = 'Error on Rerun of interface';
	public static final String ISSUES_FOUND = 'Issues found';
	public static final String READY_FOR_DISBURSEMENT = 'Ready for disbursement';
	public static final String INITIATE_DISBURSEMENT = 'Initiate Disbursement';
	public static final String AWAITING_INTERFACE_DATA = 'Awaiting interface data';
	public static final String CLOSING_DOCS_VERIFICATION_STATUS = 'Closing Docs - Verification';

	private final String LOAN = 'Loan__c';
	private final String DISBURSEMENT = 'Disbursement__c';
	private final String DISBURSEMENT_RELATIONSHIP_NAME = 'Disbursements__r';

	private Set<String> loanFields;
	private Set<String> disbursementFields;

	public LoanDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.loanFields = schemaMap.get(LOAN).getDescribe().fields.getMap().keySet();
		this.disbursementFields = schemaMap.get(DISBURSEMENT).getDescribe().fields.getMap().keySet();
	}

	public List<Loan__c> getLoansByApplicationId(Id applicationId) {
		QueryBuilder loanQueryBuilder = new QueryBuilder(LOAN);
		loanQueryBuilder.addSelectField(this.loanFields);
		loanQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(loanQueryBuilder.generateQUery());
	}

	public List<Loan__c> getLoansByApplicationIds(List<Id> applicationIds) {
		QueryBuilder loanQueryBuilder = new QueryBuilder(LOAN);
		loanQueryBuilder.addSelectField(this.loanFields);
		loanQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(loanQueryBuilder.generateQUery());
	}

	public List<Loan__c> getLoansByLoanIds(List<Id> loanIds) {
		QueryBuilder loanQueryBuilder = new QueryBuilder(LOAN);
		loanQueryBuilder.addSelectField(this.loanFields);
		loanQueryBuilder.addWhereCondition('Id', loanIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(loanQueryBuilder.generateQUery());
	}

	public void updateLoans(List<Loan__c> loans) {
		update loans;
	}
}