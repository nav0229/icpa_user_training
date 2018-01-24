/****************************************************************
 Name: ApplicationDataAccessor
============================================================
Author: Kevin
Purpose: Data Accessor for Applicant__c
============================================================

****************************************************************/
public with sharing class ApplicantDataAccessor implements ApplicantDAO {

	private final String APPLICANT = 'Applicant__c';
	private final String CONTACT = 'Contact';
	private final String RELATED_CONTACT_PREPEND = 'Contact__r.';

	private Set<String> applicantFields;
	private Set<String> relatedContactFields = new Set<String>();

	public ApplicantDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.applicantFields = schemaMap.get(APPLICANT).getDescribe().fields.getMap().keySet();

		for(String contactField : schemaMap.get(CONTACT).getDescribe().fields.getMap().keySet()){
			this.relatedContactFields.add(RELATED_CONTACT_PREPEND + contactField);
		}
	}

	public void updateApplicants(List<Applicant__c> applicants) {
		update applicants;
	}

	public List<Applicant__c> getApplicantsByApplicantIds(List<Id> applicantIds) {
		QueryBuilder applicantQueryBuilder = new QueryBuilder(APPLICANT);
		applicantQueryBuilder.addSelectField(this.applicantFields);
		applicantQueryBuilder.addWhereCondition('Id', applicantIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(applicantQueryBuilder.generateQuery());
	}

	public List<Applicant__c> getApplicantsByApplicationId(Id applicationId) {
		QueryBuilder applicantQueryBuilder = new QueryBuilder(APPLICANT);
		applicantQueryBuilder.addSelectField(this.applicantFields);
		applicantQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(applicantQueryBuilder.generateQuery());
	}

	public List<Applicant__c> getApplicantsByApplicationIds(List<Id> applicationIds) {
		QueryBuilder applicantQueryBuilder = new QueryBuilder(APPLICANT);
		applicantQueryBuilder.addSelectField(this.applicantFields);
		applicantQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(applicantQueryBuilder.generateQuery());
	}

	public List<Applicant__c> getPrimaryApplicantsByApplicationId(List<Id> applicationIds) {
		QueryBuilder applicantQueryBuilder = new QueryBuilder(APPLICANT);
		applicantQueryBuilder.addSelectField(this.applicantFields);
		applicantQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		applicantQueryBuilder.addWhereCondition('Primary_Applicant__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(applicantQueryBuilder.generateQuery());
	}

	public Applicant__c getPrimaryApplicantAndRelatedContactByApplicationId(Id applicationId) {
		QueryBuilder applicantQueryBuilder = new QueryBuilder(APPLICANT);
		applicantQueryBuilder.addSelectField(this.applicantFields);
		applicantQueryBuilder.addSelectField(this.relatedContactFields);
		applicantQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		applicantQueryBuilder.addWhereCondition('Primary_Applicant__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(applicantQueryBuilder.generateQuery());
	}

	public List<Applicant__c> getApplicantsAndRelatedContactsByApplicationId(Id applicationId) {
		QueryBuilder applicantQueryBuilder = new QueryBuilder(APPLICANT);
		applicantQueryBuilder.addSelectField(this.applicantFields);
		applicantQueryBuilder.addSelectField(this.relatedContactFields);
		applicantQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(applicantQueryBuilder.generateQuery());
	}
}