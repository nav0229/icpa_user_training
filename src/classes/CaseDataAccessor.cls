/****************************************************************
 Name: CaseDataAccessor
============================================================
Author: 
Purpose: Data Accessor for Case
============================================================

****************************************************************/

public with sharing class CaseDataAccessor implements CaseDAO {
	public static final String RTNAME_DOCUMENT_REQUEST = 'Document Request';
	public static final String RTNAME_CLOSING_DOCUMENT = 'Closing Document';
	public static final String RTNAME_INTERFACE = 'Interface';
	public static final String RTNAME_SYSTEM_GENERATED = 'System Generated';

	private final String CASE_OBJECT = 'Case';

	private Set<String> caseFields;

	public CaseDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.caseFields = schemaMap.get(CASE_OBJECT).getDescribe().fields.getMap().keySet();
	}

	public void updateCases(List<Case> cases) {
		update cases;
	}

	public List<Case> getCasesByCaseIds(List<Id> caseIds) {
		QueryBuilder caseQueryBuilder = new QueryBuilder(CASE_OBJECT);
        caseQueryBuilder.addSelectField(this.caseFields);
        caseQueryBuilder.addWhereCondition('Id', caseIds, QueryBuilder.ComparisonOperator.IN_LIST);
        return Database.query(caseQueryBuilder.generateQuery());
	}

	public List<Case> getCasesByApplicationIdsAndRecordType(List<Id> applicationIds, Id recordTypeId){
		QueryBuilder caseQueryBuilder = new QueryBuilder(CASE_OBJECT);
        caseQueryBuilder.addSelectField(this.caseFields);
        caseQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
        caseQueryBuilder.addWhereCondition('RecordTypeId', recordTypeId, QueryBuilder.ComparisonOperator.EQUALS);
        return Database.query(caseQueryBuilder.generateQuery());
	}
	
	public List<Case> getCasesByApplicationIds(List<Id> applicationIds){
		QueryBuilder caseQueryBuilder = new QueryBuilder(CASE_OBJECT);
        caseQueryBuilder.addSelectField(this.caseFields);
        caseQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
        return Database.query(caseQueryBuilder.generateQuery());
	}
}