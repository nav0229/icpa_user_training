/****************************************************************
 Name:  ChecklistItemGeneratorByInterfaceCase
============================================================
Author: Kevin
Purpose: JIRA#2466                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemGeneratorByInterfaceCase extends ChecklistItemGenerator {

	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static CreditBureauDAO creditBureauDA = new CreditBureauDataAccessor();
	@TestVisible private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();
	@TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();

	@TestVisible private static EventRequestGenByChecklistItemInterface eventRequestGenerator = new EventRequestGeneratorByChecklistItem();

	public ChecklistItemGeneratorByInterfaceCase(){}

	public void handleChecklistGeneration(List<SObject> sObjects){
		if(sObjects == null || sObjects.isEmpty()){
			return;
		}

		List<Case> cases;
		try{
			cases = (List<Case>)sObjects;
		}
		catch (TypeException e) {
			System.debug(e);
			throw new ChecklistItemGeneratorByInterfaceCaseException('handleChecklistGeneration requires a List of Cases as input. ', e);
		}

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id interfaceRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_INTERFACE).getRecordTypeId();

		List<Case> interfaceCases = new List<Case>();

		for(Case cas : cases){
			if(cas.RecordTypeId == interfaceRecordTypeId){
				interfaceCases.add(cas);
			}
		}

		if(!interfaceCases.isEmpty()) {
			generateChecklistItems(interfaceCases);
		}
	}

	private void generateChecklistItems(List<Case> cases){
		List<Id> applicationIds = new List<Id>();
		for(Case cas : cases){
			applicationIds.add(cas.Application__c);
		}

		if(applicationIds.isEmpty()){
			return;
		}

		Map<Id,Application__c> relatedApplicationIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);
		Map<Id,List<Credit_Bureau__c>> applicationIdToCBRListMap = buildApplicationIdToCBRListMap(applicationIds);
		Map<Id,Event_Request__c> applicationIdToEventRequestMap = buildApplicationIdToEventRequestMap(relatedApplicationIdToApplicationMap.values());
		List<Checklist_Item__c> checklistItemsToInsert = new List<Checklist_Item__c>();
		
		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();
		for(Case cas : cases) {
			checklistItemsToInsert.addAll(
				createApplicableChecklistItemsForCases(
					cas, 
					relatedApplicationIdToApplicationMap.get(cas.Application__c), 
					applicationIdToCBRListMap.containsKey(cas.Application__c) ? applicationIdToCBRListMap.get(cas.Application__c) : new List<Credit_Bureau__c>(),
					applicationIdToEventRequestMap.get(cas.Application__c),
					checklistCodeToMasterChecklistMap
				)
			);
		}

		try {
			checklistItemDA.insertChecklistItems(checklistItemsToInsert);
			eventRequestGenerator.generateEventRequestsForChecklistItems(checklistItemsToInsert);
		} catch(DmlException e) {
			System.debug(e);
			throw new ChecklistItemGeneratorByInterfaceCaseException('Error occurred while attempting to insert new Checklist_Item__c.', e);
		}
	}

	@TestVisible
	private List<Checklist_Item__c> createApplicableChecklistItemsForCases(
		Case cas,
		Application__c relatedApplication,
		List<Credit_Bureau__c> creditBureaus,
		Event_Request__c relatedRequest,
		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap
	){
		List<Checklist_Item__c> newChecklistItems = new List<Checklist_Item__c>();

		if(relatedApplication != null && checklistCodeToMasterChecklistMap.containsKey(MasterChecklistDataAccessor.CBR_CODE)){
			if(validCreditBureausCheck(creditBureaus, relatedRequest)){
				newChecklistItems.add(
					generateNewApplicationLevelChecklistItem(
						checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE), 
						cas, 
						relatedApplication, 
						ChecklistItemDataAccessor.RECEIVED_STATUS, 
						ChecklistItemDataAccessor.INTERFACE_TYPE
					)
				);
			} else {
				newChecklistItems.add(
					generateNewApplicationLevelChecklistItem(
						checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE), 
						cas, 
						relatedApplication, 
						ChecklistItemDataAccessor.FAILED_STATUS,
						ChecklistItemDataAccessor.INTERFACE_TYPE
					)
				);	
			}

			for(String checklistCode : MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES){
				if(checklistCodeToMasterChecklistMap.containsKey(checklistCode)){
					newChecklistItems.add(
						generateNewApplicationLevelChecklistItem(
							checklistCodeToMasterChecklistMap.get(checklistCode), 
							cas, 
							relatedApplication, 
							ChecklistItemDataAccessor.REQUESTED_STATUS, 
							ChecklistItemDataAccessor.INTERFACE_TYPE
						)
					);
				}
			}
		}

		return newChecklistItems;
	}

	private Boolean validCreditBureausCheck(List<Credit_Bureau__c> relatedCBRs, Event_Request__c cbrEventRequest) {
		if(cbrEventRequest != null && cbrEventRequest.Status__c == EventRequestDataAccessor.STATUS_FAILURE) {
			return false;
		}

		if(relatedCBRs == null || relatedCBRs.isEmpty()){
			return false;
		}

		for(Credit_Bureau__c cbr : relatedCBRs) {
			if(cbr.CBR_Request_Result__c == 'Error' || cbr.CBR_Request_Result__c == null) {
				return false;
			}
		}
		return true;
	}

	private Map<Id,List<Credit_Bureau__c>> buildApplicationIdToCBRListMap(List<Id> applicationIds) {
		Map<Id,List<Credit_Bureau__c>> applicationIdToCBRListMap = new Map<Id,List<Credit_Bureau__c>>();

		List<Credit_Bureau__c> relatedCBRs = creditBureauDA.getActiveCreditBureausByApplicationIds(applicationIds);

		for(Credit_Bureau__c cbr : relatedCBRs) {
			if(applicationIdToCBRListMap.containsKey(cbr.Application__c)) {
				applicationIdToCBRListMap.get(cbr.Application__c).add(cbr);
			}
			else {
				applicationIdToCBRListMap.put(cbr.Application__c, new List<Credit_Bureau__c>{cbr});
			}
		}
		
		return applicationIdToCBRListMap;
	}

	private Map<Id,Event_Request__c> buildApplicationIdToEventRequestMap(List<Application__c> relatedApplications){
		Map<Id,Event_Request__c> applicationIdToEventRequestMap = new Map<Id,Event_Request__c>();
		List<String> applicationNumbers = new List<String>();

		for(Application__c application : relatedApplications) {
			applicationNumbers.add(application.Name);
		}

		List<Event_Request__c> relatedCBRRequests = eventRequestDA.getEventRequestsByStageAndApplicationNumbers(
			applicationNumbers, 
			EventRequestDataAccessor.STAGE_RECEIVED_CBR
		);

		for(Application__c application : relatedApplications) {
			for(Event_Request__c request : relatedCBRRequests) {
				if(request.Application_Number__c == application.Name){
					applicationIdToEventRequestMap.put(application.Id, request);
				}
			}
		}

		return applicationIdToEventRequestMap;
	}

	public class ChecklistItemGeneratorByInterfaceCaseException extends Exception {}
}