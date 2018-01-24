/****************************************************************
 Name:  LoanTriggerHelper
============================================================
Author: Matt
Purpose: Trigger helper for Loans triggers                                                                                                     
============================================================

****************************************************************/

public with sharing class LoanTriggerHelper {

    @TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
    @TestVisible private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();
    @TestVisible private static DisbursementDAO disbursementDA = new DisbursementDataAccessor();

    public LoanTriggerHelper() {}

    public void handleReRunStatusChangesAndDisbursement(List<Loan__c> newLoans, Map<Id, Loan__c> oldLoans) {

        Map<Id, Application__c> applicationMap = getApplicationMapFromLoans(newLoans);

        createEventRequestReRunRecords(newLoans, applicationMap);

        List<Loan__c> changedLoans = assignLoanStatus(newLoans, oldLoans);
        changedLoans = calculateUPCodeTotals(changedLoans);
    
        createAndInsertDisbursements(changedLoans);
        initiateDisbursementEventRequest(changedLoans, applicationMap);
    }

    @TestVisible
    private void createEventRequestReRunRecords(List<Loan__c> loans, Map<Id, Application__c> applicationMap) {
        List<Event_Request__c> eventRequests = new List<Event_Request__c>();

        for(Loan__c loan : loans) {
            if(loan.Status__c == LoanDataAccessor.AWAITING_INTERFACE_DATA) {
                if(isloanReRunFlagStatusErrorOrBlank(loan.SBA_Loan_History_ReRun_Results__c)) {
                    eventRequests.add(createEventRequestOrderReRun(applicationMap.get(loan.Application__c), EventRequestDataAccessor.STAGE_ORDER_LOAN_HISTORY_RERUN));
                }
                if(isloanReRunFlagStatusErrorOrBlank(loan.Other_Assistance_ReRun_Results__c)) {
                    eventRequests.add(createEventRequestOrderReRun(applicationMap.get(loan.Application__c), EventRequestDataAccessor.STAGE_ORDER_OTHER_ASSISTANCE_RERUN));
                }
            }
        }

        try{
            eventRequestDA.insertEventRequests(eventRequests);
        }catch(DmlException e) {
            System.debug(e);
            throw new LoanTriggerHelperException('An error occurred inserting ReRun order Event Requests', e); 
        }
    }  

    @TestVisible
    private Map<Id, Application__c> getApplicationMapFromLoans(List<Loan__c> loans) {
        List<Id> applicationIds = new List<Id>();

        for(Loan__c loan : loans) {
            applicationIds.add(loan.Application__c);
        }

        try{
            return new Map<Id, Application__c>(applicationDA.getApplicationsById(applicationIds));
        }catch(QueryException e) {
            System.debug(e.getMessage());
            throw new LoanTriggerHelperException('An error occurred getting applications', e); 
        }   
    }

    @TestVisible
    private Event_Request__c createEventRequestOrderReRun(Application__c application, String stage) {
        return new Event_Request__c(
            Name = application.Name + '-' + stage,
            Request_Date__c = System.now(),
            Application_Number__c = application.Name + '', 
            Stage__c = stage,
            Status__c = 'Success'
            );
    }

    @TestVisible
    private Boolean isloanReRunFlagStatusErrorOrBlank(String flag) {

        return (flag == LoanDataAccessor.ERROR_ON_RERUN_INTERFACE || flag == null || flag == '');
    }

    @TestVisible
    private List<Loan__c> assignLoanStatus(List<Loan__c> newLoans, Map<Id, Loan__c> oldLoans) {
        List<Loan__c> changedLoans = new List<Loan__c>();

        for(Loan__c newLoan : newLoans) {
            if( newLoan.SBA_Loan_History_ReRun_Results__c != oldLoans.get(newLoan.Id).SBA_Loan_History_ReRun_Results__c ||
                newLoan.Other_Assistance_ReRun_Results__c != oldLoans.get(newLoan.Id).Other_Assistance_ReRun_Results__c ) {

                changedLoans.add(newLoan);
            }
        }

        for(Loan__c loan : changedLoans) {
            if( loan.SBA_Loan_History_ReRun_Results__c == LoanDataAccessor.ERROR_ON_RERUN_INTERFACE ||
                loan.Other_Assistance_ReRun_Results__c == LoanDataAccessor.ERROR_ON_RERUN_INTERFACE) {

                loan.Status__c = LoanDataAccessor.ERROR_ON_RERUN_INTERFACE;
            }
            else if(loan.SBA_Loan_History_ReRun_Results__c == LoanDataAccessor.ISSUES_FOUND ||
                    loan.Other_Assistance_ReRun_Results__c == LoanDataAccessor.ISSUES_FOUND) {

                loan.Status__c = LoanDataAccessor.ISSUES_FOUND;
            }
            else if(loan.SBA_Loan_History_ReRun_Results__c == LoanDataAccessor.READY_FOR_DISBURSEMENT &&
                    loan.Other_Assistance_ReRun_Results__c == LoanDataAccessor.READY_FOR_DISBURSEMENT) {

                loan.Status__c = LoanDataAccessor.READY_FOR_DISBURSEMENT;
            }
        }

        return changedLoans;
    }

    @TestVisible
    private List<Loan__c> calculateUPCodeTotals(List<Loan__c> loans) {
        LoanUPCodeHandler loanUPCodeHandler = new LoanUPCodeHandler();
        Set<Loan__c> loanSet = new Set<Loan__c>();

        for(Loan__c loan : loans) {
            if(loan.Status__c == LoanDataAccessor.READY_FOR_DISBURSEMENT) {
                loanSet.add(loan);
            }
        } 

        loanSet = loanUPCodeHandler.setUPCodeTotalAmounts(loanSet);
        loans.clear();
        loans.addAll(loanSet);

        return loans;
    }

    @TestVisible
    private void createAndInsertDisbursements(List<Loan__c> loans) {
        List<Disbursement__c> disbursements = new List<Disbursement__c>();

        System.debug('Loan size to create disbursements : ' + loans.size());

        for(Loan__c loan : loans) {
            if(loan.Status__c == LoanDataAccessor.READY_FOR_DISBURSEMENT) {
                disbursements.add(new Disbursement__c(Name = 'Disb1' + '-' + loan.Name , Loan__c = loan.Id, Disbursement_Number__c = 1));
            }
        }

        try{
            disbursementDA.insertDisbursements(disbursements);
        }catch(DmlException e) {
            System.debug(e.getMessage());
            throw new LoanTriggerHelperException('An error occurred inserting initial disbursement', e); 
        }   
    }

    @TestVisible
    private void initiateDisbursementEventRequest(List<Loan__c> loans, Map<Id, Application__c> applicationMap) {
        List<Event_Request__c> eventRequests = new List<Event_Request__c>();

        for(Loan__c loan : loans) {
            if(loan.Status__c == LoanDataAccessor.INITIATE_DISBURSEMENT) {
                //set up outbound message for initating disbursement
                eventRequests.add(new Event_Request__c(
                    Name = applicationMap.get(loan.Application__c).Name + '-' + EventRequestDataAccessor.STAGE_ORDER_DISBURSEMENT,
                    Request_Date__c = System.now(),
                    Application_Number__c = applicationMap.get(loan.Application__c).Name + '',
                    Stage__c = EventRequestDataAccessor.STAGE_ORDER_DISBURSEMENT,
                    Status__c = 'Success'));
            }
        }

        try{
            eventRequestDA.insertEventRequests(eventRequests);
        }catch(DmlException e) {
            System.debug(e.getMessage());
            throw new LoanTriggerHelperException('An error occurred inserting Order Disbursement order Event Requests', e); 
        }
    }

    public class LoanTriggerHelperException extends Exception {}
}