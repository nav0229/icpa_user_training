/****************************************************************
 Name:  EventRequestInterfaceReRunHandler
============================================================
Author: Matt
Purpose: 1930
Handler for ReRun Complete Event Requests                                                                                                  
============================================================

****************************************************************/

public with sharing class EventRequestInterfaceReRunHandler {
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static SBALoanHistoryDAO sbaLoanHistoryDA = new SBALoanHistoryDataAccessor();
	@TestVisible private static OtherAssistanceDAO otherAssistanceDa = new OtherAssistanceDataAccessor();
	@TestVisible private static LoanDAO loanDA = new LoanDataAccessor();
	@TestVisible private static FieldHistoryIssueFinder fieldHistoryFinder;
	@TestVisible private static DisbursementIssueDAO disbursementIssueDA = new DisbursementIssueDataAccessor();

	private List<Id> applicationIds = new List<Id>();
	public EventRequestInterfaceReRunHandler() {}

	public void handleEventHistoryRecords(List<Event_Request__c> eventRequests) {
		List<Event_Request__c> validReRunEventRecords = new List<Event_Request__c>();

		for(Event_Request__c eventRequest : eventRequests) {
			if(eventRequest.Stage__c ==  EventRequestDataAccessor.STAGE_RECEIVED_LOAN_HISTORY_RERUN || eventRequest.Stage__c == EventRequestDataAccessor.STAGE_RECEIVED_OTHER_ASSISTANCE_RERUN) {
				validReRunEventRecords.add(eventRequest);
			}
		}

		if(!validReRunEventRecords.isEmpty()) {
			fieldHistoryFinder = new FieldHistoryIssueFinder();
			setAndUpdateLoanStatus(validReRunEventRecords);
		}
	}

	private void setAndUpdateLoanStatus(List<Event_Request__c> eventRequests) {
		Map<Id, Application__c> applicationMap;
		Map<Event_Request__c, Id> eventRequestAppIdMap;
		Map<Id, Loan__c> appIdLoanMap;
		Map<Id, Other_Assistance__c> appIdOtherAssistMap;
		Map<Id, SBA_Loan_History__c> appIdSBALoanHistoryMap;
		List<Disbursement_Issue__c> disbursementIssues = new List<Disbursement_Issue__c>();

		try{
			applicationMap = createApplicationMap(eventRequests);
			eventRequestAppIdMap = createEventRequestApplicationMap(eventRequests, applicationMap);
			appIdLoanMap = createApplicationLoanMap(applicationMap.keySet());
			appIdOtherAssistMap = createAppOtherAssistMap(applicationMap.keySet());
			appIdSBALoanHistoryMap = createAppSBALoanHistoryMap(applicationMap.keySet());
		}catch(Exception e) {
			System.debug(e.getMessage());
			throw new EventRequestInterfaceReRunHandlerException('An error occurred while retrieving Application Ids, SBA Loan Histories, or Other Assistances :' + e.getMessage());
		}
		
		for(Event_Request__c eventRequest : eventRequestAppIdMap.keySet()) {
			Loan__c loan = appIdLoanMap.get(eventRequestAppIdMap.get(eventRequest));
			SBA_Loan_History__c sbaLoanHistory = appIdSBALoanHistoryMap.get(eventRequestAppIdMap.get(eventRequest));
			Other_Assistance__c otherAssistance = appIdOtherAssistMap.get(eventRequestAppIdMap.get(eventRequest));

			if(eventRequest.Status__c == EventRequestDataAccessor.ERROR) {
				if(eventRequest.Stage__c == EventRequestDataAccessor.STAGE_RECEIVED_LOAN_HISTORY_RERUN) {
					loan.SBA_Loan_History_ReRun_Results__c = LoanDataAccessor.ERROR_ON_RERUN_INTERFACE;
				}
				else if(eventRequest.Stage__c == EventRequestDataAccessor.STAGE_RECEIVED_OTHER_ASSISTANCE_RERUN) {
					loan.Other_Assistance_ReRun_Results__c = LoanDataAccessor.ERROR_ON_RERUN_INTERFACE;
				}					
			}else{
				if(eventRequest.Stage__c == EventRequestDataAccessor.STAGE_RECEIVED_LOAN_HISTORY_RERUN) {
					if(fieldHistoryFinder.isFieldHistoryChanged(sbaLoanHistory)) {
						loan.SBA_Loan_History_ReRun_Results__c = LoanDataAccessor.ISSUES_FOUND;
						disbursementIssues.addAll(fieldHistoryFinder.getDisbursementIssuesForSBALoanHistory(sbaLoanHistory, loan.Id));
					}else{
						loan.SBA_Loan_History_ReRun_Results__c = LoanDataAccessor.READY_FOR_DISBURSEMENT;
					}		
				}
				else if(eventRequest.Stage__c == EventRequestDataAccessor.STAGE_RECEIVED_OTHER_ASSISTANCE_RERUN) {
					if(fieldHistoryFinder.isFieldHistoryChanged(otherAssistance)) {
						loan.Other_Assistance_ReRun_Results__c = LoanDataAccessor.ISSUES_FOUND;
						disbursementIssues.addAll(fieldHistoryFinder.getDisbursementIssuesForOtherAssistance(otherAssistance, loan.Id));
					}else{
						loan.Other_Assistance_ReRun_Results__c = LoanDataAccessor.READY_FOR_DISBURSEMENT;
					}
				}		
			}
			appIdLoanMap.get(eventRequestAppIdMap.get(eventRequest)).SBA_Loan_History_ReRun_Results__c = loan.SBA_Loan_History_ReRun_Results__c;
			appIdLoanMap.get(eventRequestAppIdMap.get(eventRequest)).Other_Assistance_ReRun_Results__c = loan.Other_Assistance_ReRun_Results__c;
		}

		updateLoansAndInsertDisbursementIssues(appIdLoanMap.values(), disbursementIssues);
	}

	private Map<Id, Application__c> createApplicationMap(List<Event_Request__c> eventRequests) {
		List<String> applicationNumbers = new List<String>();
		Map<Id,Application__c> applicationMap;

		for(Event_Request__c eventRequest : eventRequests) {
			applicationNumbers.add(eventRequest.Application_Number__c);
		}

		try{
			applicationMap = new Map<Id,Application__c>(applicationDA.getApplicationsByApplicationNumber(applicationNumbers));
		}catch(Exception e) {
			throw new EventRequestInterfaceReRunHandlerException('An error occurred while retrieving applications :' + e.getMessage());
		}

		return applicationMap;
	}

	private Map<Event_Request__c, Id> createEventRequestApplicationMap(List<Event_Request__c> eventRequests, Map<Id, Application__c> applicationMap) {
		Map<Event_Request__c, Id> eventRequestApplicationIdMap = new Map<Event_Request__c, Id>();

		for(Application__c application : applicationMap.values()) {
			for(Event_Request__c eventRequest : eventRequests) {
				if(eventRequest.Application_Number__c == application.Name) {
					eventRequestApplicationIdMap.put(eventRequest, application.Id);
				}
			}
		}
		return eventRequestApplicationIdMap;
	}

	private Map<Id, Loan__c> createApplicationLoanMap(Set<Id> applicationIds) {
		Map<Id, Loan__c> appIdLoanMap = new Map<Id, Loan__c>();
		List<Loan__c> loans;
		try{
			loans = loanDA.getLoansByApplicationIds(new List<Id>(applicationIds));
		}catch(Exception e) {
			throw new EventRequestInterfaceReRunHandlerException('An error occurred while retrieving loan records :' + e.getMessage());
		}

		for(Loan__c loan : loans) {
			for(Id appId : applicationIds) {
				if(loan.Application__c == appId) {
					appIdLoanMap.put(appId, loan);
				}
			}
		}
		return appIdLoanMap;
	}

	private Map<Id, SBA_Loan_History__c> createAppSBALoanHistoryMap(Set<Id> applicationIds) {
		Map<Id, SBA_Loan_History__c> applicationSBALoanHistoryMap = new Map<Id, SBA_Loan_History__c>();
		List<SBA_Loan_History__c> sbaLoanHistories;
		try{
			sbaLoanHistories = sbaLoanHistoryDA.getSBALoanHistoriesByApplicationIds(new List<Id>(applicationIds));
		}catch(Exception e) {
			throw new EventRequestInterfaceReRunHandlerException('An error occurred while retrieving loan records :' + e.getMessage());
		}

		for(SBA_Loan_History__c sbaLoanHistory : sbaLoanHistories) {
			for(Id appId : applicationIds) {
				if(sbaLoanHistory.Application__c == appId) {
					applicationSBALoanHistoryMap.put(appId, sbaLoanHistory);
				}
			}
		}
		return applicationSBALoanHistoryMap;
	}

	private Map<Id, Other_Assistance__c> createAppOtherAssistMap(Set<Id> applicationIds) {
		Map<Id, Other_Assistance__c> applicationOtherAssistMap = new Map<Id, Other_Assistance__c>();
		List<Other_Assistance__c> otherAssistances;
		try{
			otherAssistances = otherAssistanceDa.getOtherAssistancebyApplicationIds(new List<Id>(applicationIds));
		}catch(Exception e) {
			throw new EventRequestInterfaceReRunHandlerException('An error occurred while retrieving loan records :' + e.getMessage());
		}

		for(Other_Assistance__c otherAssistance : otherAssistances) {
			for(Id appId : applicationIds) {
				if(otherAssistance.Application__c == appId) {
					applicationOtherAssistMap.put(appId, otherAssistance);
				}
			}
		}

		return applicationOtherAssistMap;
	}

	private void updateLoansAndInsertDisbursementIssues(List<Loan__c> loans, List<Disbursement_Issue__c> disbursementIssues){
		try{
			loanDA.updateLoans(loans);
			disbursementIssueDA.insertDisbursementIssues(disbursementIssues);
		}catch(Exception e) {
			System.debug(e.getMessage());
			throw new EventRequestInterfaceReRunHandlerException('An error occurred while updating loan records and inserting Disbursement Issues :' + e.getMessage());
		}
	}	

	public class EventRequestInterfaceReRunHandlerException extends Exception {}
}