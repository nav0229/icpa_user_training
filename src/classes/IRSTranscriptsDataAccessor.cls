/****************************************************************
 Name: IRSTranscriptsDataAccessor
============================================================
Author: Kevin
Purpose: Data Accessor for IRS_Transcripts__c
============================================================

****************************************************************/
public with sharing class IRSTranscriptsDataAccessor implements IRSTranscriptsDAO {

	private final String IRS_TRANSCRIPTS = 'IRS_Transcripts__c';

	private Set<String> irsTranscriptsFields;

	public IRSTranscriptsDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.irsTranscriptsFields = schemaMap.get(IRS_TRANSCRIPTS).getDescribe().fields.getMap().keySet();
	}

	public List<IRS_Transcripts__c> getIRSTranscriptsByApplicationId(Id applicationId){
		QueryBuilder irsTranscriptsQueryBuilder = new QueryBuilder(IRS_TRANSCRIPTS);
		irsTranscriptsQueryBuilder.addSelectField(this.irsTranscriptsFields);
		irsTranscriptsQueryBuilder.addSelectField('Applicant_Name__r.Name');
		irsTranscriptsQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(irsTranscriptsQueryBuilder.generateQuery());
	}

	public List<IRS_Transcripts__c> getIRSTranscriptsByApplicationIds(List<Id> applicationIds) {
		QueryBuilder irsTranscriptsQueryBuilder = new QueryBuilder(IRS_TRANSCRIPTS);
		irsTranscriptsQueryBuilder.addSelectField(this.irsTranscriptsFields);
		irsTranscriptsQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(irsTranscriptsQueryBuilder.generateQuery());
	}

	public List<IRS_Transcripts__c> getIRSTranscriptsByApplicantIds(List<Id> applicantIds) {
		QueryBuilder irsTranscriptsQueryBuilder = new QueryBuilder(IRS_TRANSCRIPTS);
		irsTranscriptsQueryBuilder.addSelectField(this.irsTranscriptsFields);
		irsTranscriptsQueryBuilder.addWhereCondition('Applicant_Name__c', applicantIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(irsTranscriptsQueryBuilder.generateQuery());
	}
}