/****************************************************************
 Name: EventRequestDataAccessor
============================================================
Author: Lenny/Matt
Purpose: Data Accessor Class for Event_Request__c
============================================================

****************************************************************/

public with sharing class EventRequestDataAccessor implements EventRequestDAO {
	public static final String STAGE_ORDER_CBR = 'Order CBR';
	public static final String STAGE_SUBMIT_CBR = 'Submit CBR';
	public static final String STAGE_RECEIVED_CBR = 'Received CBR';
	public static final String STAGE_RECEIVED_CBR_DEDUPED = 'Received CBR Deduped';
	public static final String STAGE_RE_ORDER_CBR = 'Received Re-Order CBR';
	public static final String STAGE_SUBMIT_AUTO_DECLINE = 'Submit Auto Decline';
	public static final String STAGE_SENT_AUTO_DECLINE = 'Sent Auto Decline';
	public static final String STAGE_ORDER_LOAN_HISTORY = 'Order Loan History';
	public static final String STAGE_RECEIVE_LOAN_HISTORY = 'Receive Loan History';
	public static final String STAGE_ORDER_FLOOD_MAPPING = 'Order Flood Mapping';
	public static final String STAGE_RECEIVED_FLOOD_MAPPING = 'Received Flood Mapping';
	public static final String STAGE_ORDER_LV_INSPECTION = 'Order LV Inspection';
	public static final String STAGE_RECIEVED_LV_INSPECTION = 'Received LV Inspection';
	public static final String STAGE_ORDER_OTHER_ASSISTANCE_RERUN = 'Order Other Assistance ReRun';
	public static final String STAGE_RECEIVED_OTHER_ASSISTANCE_RERUN = 'Received Other Assistance ReRun';
	public static final String STAGE_ORDER_LOAN_HISTORY_RERUN = 'Order Loan History ReRun';
	public static final String STAGE_RECEIVED_LOAN_HISTORY_RERUN = 'Received Loan History ReRun';
	public static final String STAGE_ORDER_DISBURSEMENT = 'Order Disbursement';
	public static final String ERROR = 'Error';

	public static final String STATUS_SUCCESS = 'Success';
	public static final String STATUS_FAILURE = 'Failure';

	private final String EVENT_REQUEST = 'Event_Request__c';

	private Set<String> eventRequestFields;

	public EventRequestDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.eventRequestFields = schemaMap.get(EVENT_REQUEST).getDescribe().fields.getMap().keySet();
	}

	public void insertEventRequest(Event_Request__c eventRequest){
		insert eventRequest;
	}

	public void insertEventRequests(List<Event_Request__c> eventRequests) {
		insert eventRequests;
	}

	public Event_Request__c getEventRequestByStageAndApplicationNumber(String applicationNumber, String stage) {
		QueryBuilder eventRequestQueryBuilder = new QueryBuilder(EVENT_REQUEST);
		eventRequestQueryBuilder.addSelectField(this.eventRequestFields);
		eventRequestQueryBuilder.addWhereCondition('Application_Number__c', applicationNumber, QueryBuilder.ComparisonOperator.EQUALS);
		eventRequestQueryBuilder.addWhereCondition('Stage__c', stage, QueryBuilder.ComparisonOperator.EQUALS);
		return (Event_Request__c)Database.query(eventRequestQueryBuilder.generateQuery());
	}

	public List<Event_Request__c> getEventRequestsByStageAndApplicationNumbers(List<String> applicationNumbers, String stage) {
		QueryBuilder eventRequestQueryBuilder = new QueryBuilder(EVENT_REQUEST);
		eventRequestQueryBuilder.addSelectField(this.eventRequestFields);
		eventRequestQueryBuilder.addWhereCondition('Application_Number__c', applicationNumbers, QueryBuilder.ComparisonOperator.IN_LIST);
		eventRequestQueryBuilder.addWhereCondition('Stage__c', stage, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(eventRequestQueryBuilder.generateQuery());
	}
}