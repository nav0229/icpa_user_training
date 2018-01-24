/****************************************************************
 Name: CreditBureauDataAccessor
============================================================
Author: Lenny/Matt
Purpose: Data Accessor Class for Credit_Bureau__c
============================================================

****************************************************************/

public with sharing class CreditBureauDataAccessor implements CreditBureauDAO {

	private final String CREDIT_BUREAU = 'Credit_Bureau__c';

	private Set<String> creditBureauFields;

	public CreditBureauDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.creditBureauFields = schemaMap.get(CREDIT_BUREAU).getDescribe().fields.getMap().keySet();
	}

	public void insertCreditBureau(Credit_Bureau__c creditBureau) {
		insert creditBureau;
	}

	public void insertCreditBureaus(List<Credit_Bureau__c> creditBureaus) {
		insert creditBureaus;
	}

	public void updateCreditBureaus(List<Credit_Bureau__c> creditBureaus) {
		update creditBureaus;
	}

	public List<Credit_Bureau__c> getActiveCreditBureausById(List<Id> creditBureauIds){
		return new List<Credit_Bureau__c>([
			SELECT Id, Application__c, Applicant_Name__c
			FROM Credit_Bureau__c
			WHERE Active__c = true
			AND Id IN :creditBureauIds
		]);
	}

	public List<Credit_Bureau__c> getActiveCreditBureausByApplicationLatestFirst(Application__c app) {
		return new List<Credit_Bureau__c>([
			SELECT Id, Name, Application__c, Active__c, Credit_Score__c, CreatedDate
			FROM Credit_Bureau__c
			WHERE Application__c = :app.Id
			AND Active__c = true
			ORDER BY CreatedDate DESC
		]);
	}

	public List<Credit_Bureau__c> getActiveCreditBureausByApplicantId(List<Id> applicantIds){
		return new List<Credit_Bureau__c>([
			SELECT Id, Name
			FROM Credit_Bureau__c
			WHERE Applicant_Name__c IN :applicantIds
			AND Active__c = true
		]);
	}

	public List<Credit_Bureau__c> getActiveCreditBureausByApplicationIds(List<Id> applicationIds){
		QueryBuilder creditBureauQueryBuilder = new QueryBuilder(CREDIT_BUREAU);
		creditBureauQueryBuilder.addSelectField(this.creditBureauFields);
		creditBureauQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		creditBureauQueryBuilder.addWhereCondition('Active__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(creditBureauQueryBuilder.generateQUery());
	}
}