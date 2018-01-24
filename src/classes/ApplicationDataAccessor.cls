/****************************************************************
 Name: ApplicationDataAccessor
============================================================
Author: Lenny
Purpose: Data Accessor Class for Application__c
============================================================

****************************************************************/

public with sharing class ApplicationDataAccessor implements ApplicationDAO {
	public static final String APP_RT_NAME_HOME = 'Home Loan Application';
	public static final String APP_RT_NAME_BUSINESS = 'Business Loan Application';

	public static final String APPLICATION_TYPE_HOME = 'Home';
	public static final String APPLICATION_TYPE_BUSINESS = 'Business';

	public static final String STAGE_ORDER_CBR = 'Order CBR';
	public static final String STAGE_SUBMIT_CBR = 'Submit CBR';
	public static final String STAGE_RECEIVED_CBR = 'Received CBR';
	public static final String STAGE_SUBMIT_AUTO_DECLINE = 'Submit Auto Decline';
	public static final String STAGE_SENT_AUTO_DECLINE = 'Sent Auto Decline';

	public static final String STATUS_SYSTEM_RECOMMENDED = 'System Recommended';

	private final String APPLICATION = 'Application__c';
	private final String IRS_TRANSCRIPTS = 'IRS_Transcripts__c';

	private final String IRS_TRANSCRIPTS_RELATIONSHIP = 'IRS_Transcripts__r';
	private final String IRS_ISSUE_TEXT_IRS_OFFSET = 'IRS Offset';

	private Set<String> applicationFields;
	private Set<String> irsTranscriptFields;

	public ApplicationDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.applicationFields = schemaMap.get(APPLICATION).getDescribe().fields.getMap().keySet();
		this.irsTranscriptFields = schemaMap.get(IRS_TRANSCRIPTS).getDescribe().fields.getMap().keySet();
	}

	public void insertApplication(Application__c application) {
		insert application;
	}

	public void insertApplications(List<Application__c> applications) {
		insert applications;
	}

	public void updateApplications(List<Application__c> applications) {
		update applications;
	}

	public Application__c getApplicationById(Id applicationId) {
		QueryBuilder applicationQueryBuilder = new QueryBuilder(APPLICATION);
		applicationQueryBuilder.addSelectField(this.applicationFields);
		applicationQueryBuilder.addWhereCondition('Id', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(applicationQueryBuilder.generateQuery());
	}

	public List<Application__c> getApplicationsById(List<Id> applicationIds) {
		QueryBuilder applicationQueryBuilder = new QueryBuilder(APPLICATION);
		applicationQueryBuilder.addSelectField(this.applicationFields);
		applicationQueryBuilder.addWhereCondition('Id', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(applicationQueryBuilder.generateQuery());
	}

	public Map<Id, Application__c> getApplicationsMapById(List<Id> applicationIds) {
		QueryBuilder applicationQueryBuilder = new QueryBuilder(APPLICATION);
		applicationQueryBuilder.addSelectField(this.applicationFields);
		applicationQueryBuilder.addWhereCondition('Id', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return new Map<Id,Application__c>((List<Application__c>)Database.query(applicationQueryBuilder.generateQuery()));
	}

	public Application__c getApplicationByApplicationNumber(String applicationNumber) {
		QueryBuilder applicationQueryBuilder = new QueryBuilder(APPLICATION);
		applicationQueryBuilder.addSelectField(this.applicationFields);
		applicationQueryBuilder.addWhereCondition('Name', applicationNumber, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(applicationQueryBuilder.generateQuery());
	}

	public List<Application__c> getApplicationsByApplicationNumber(List<String> applicationNumbers) {
		QueryBuilder applicationQueryBuilder = new QueryBuilder(APPLICATION);
		applicationQueryBuilder.addSelectField(this.applicationFields);
		applicationQueryBuilder.addWhereCondition('Name', applicationNumbers, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(applicationQueryBuilder.generateQuery());
	}

	public List<Application__c> getApplicationsAndActiveIRSTranscriptsByApplicationIds(List<Id> applicationIds) {
		QueryBuilder applicationQueryBuilder = new QueryBuilder(APPLICATION);
		applicationQueryBuilder.addSelectField(this.applicationFields);

		QueryBuilder irsTranscriptsQueryBuilder = new QueryBuilder(IRS_TRANSCRIPTS_RELATIONSHIP);
		irsTranscriptsQueryBuilder.addSelectField(this.irsTranscriptFields);
		irsTranscriptsQueryBuilder.addWhereCondition('Issue__c', IRS_ISSUE_TEXT_IRS_OFFSET, QueryBuilder.ComparisonOperator.EQUALS);

		applicationQueryBuilder.addSelectField(irsTranscriptsQueryBuilder);
		applicationQueryBuilder.addWhereCondition('Id', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);

		return Database.query(applicationQueryBuilder.generateQuery());
	}
}