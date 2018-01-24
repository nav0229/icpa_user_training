/****************************************************************
 Name:  FieldHistoryIssueFinder
============================================================
Author: Matt
Purpose: 1930
Finder for SBA loan history with changed data points                                                                                                               
============================================================

****************************************************************/

public with sharing class FieldHistoryIssueFinder {
    @TestVisible private static FieldHistoryDAO fieldHistoryDA = new FieldHistoryDataAccessor();
    @TestVisible private static GroupDAO groupDA = new GroupDataAccessor();

    private List<SBA_Loan_History__History> sbaLoanHistoryFieldHistories = new List<SBA_Loan_History__History>();
    private List<Other_Assistance__History> otherAssistFieldHistories = new List<Other_Assistance__History>();
    private Set<Id> apiIntegrationUserIds = new Set<Id>();

    private static final String API_INTEGRATION_USER = 'API/Integration User';
    private static final String OTHER_ASSISTANCE = 'Other Assistance';
    private static final String SBA_LOAN_HISTORY = 'SBA Loan History';
    
    public FieldHistoryIssueFinder() {
        try {
            sbaLoanHistoryFieldHistories = fieldHistoryDA.getSBAloanHistoryFieldHistoriesInPastFiveMinutes();
            otherAssistFieldHistories = fieldHistoryDA.getOtherAssistanceFieldHistoriesInPastFiveMinutes();
            apiIntegrationUserIds = getAPIIntegrationUserIds();
        }catch(QueryException e) {
            System.debug(e.getMessage());
            throw new FieldHistoryIssueFinderException('An error occurred while retrieving SBA Loan History Field Histories, Other Assistance Field Histories, or the Api Integration User Profile: ', e); 
        }   
    }

    public Boolean isFieldHistoryChanged(SBA_Loan_History__c sbaLoanHistory) {
        for(SBA_Loan_History__History sbaLoanHistoryHistory : sbaLoanHistoryFieldHistories) {
            if(sbaLoanHistoryHistory.ParentId == sbaLoanHistory.Id) {
                if(apiIntegrationUserIds.contains(sbaLoanHistoryHistory.CreatedById)) {
                    return true;
                }
            }       
        }
        return false;
    }

    public List<Disbursement_Issue__c> getDisbursementIssuesForSBALoanHistory(SBA_Loan_History__c sbaLoanHistory, Id loanId) {
        List<Disbursement_Issue__c> disbursementIssues = new List<Disbursement_Issue__c>();

        for(SBA_Loan_History__History sbaLoanHistoryHistory : sbaLoanHistoryFieldHistories) {
            if(sbaLoanHistoryHistory.ParentId == sbaLoanHistory.Id) {
                if(apiIntegrationUserIds.contains(sbaLoanHistoryHistory.CreatedById)) {
                    disbursementIssues.add(
                        new Disbursement_Issue__c(
                            Loan__c = loanId,
                            Parent_Id__c = sbaLoanHistoryHistory.ParentId + '',
                            Old_Value__c = sbaLoanHistoryHistory.OldValue + '',
                            New_Value__c = sbaLoanHistoryHistory.NewValue + '',
                            Changed_Field__c = sbaLoanHistoryHistory.Field + '',
                            Type__c = SBA_LOAN_HISTORY));
                }
            }       
        }

        return disbursementIssues;
    }

    public Boolean isFieldHistoryChanged(Other_Assistance__c otherAssist) {
        for(Other_Assistance__History otherAssistHistory : otherAssistFieldHistories) {
            System.debug('otherAssistHistory :' + otherAssistHistory);
            System.debug('otherAssist :' + otherAssist);
            if(otherAssistHistory.ParentId == otherAssist.Id) {
                if(apiIntegrationUserIds.contains(otherAssistHistory.CreatedById)) {
                    return true;
                }
            }       
        }
        return false;
    }

    public List<Disbursement_Issue__c> getDisbursementIssuesForOtherAssistance(Other_Assistance__c otherAssist, Id loanId) {
        List<Disbursement_Issue__c> disbursementIssues = new List<Disbursement_Issue__c>();

        for(Other_Assistance__History otherAssistanceHistory : otherAssistFieldHistories) {
            if(otherAssistanceHistory.ParentId == otherAssist.Id) {
                if(apiIntegrationUserIds.contains(otherAssistanceHistory.CreatedById)) {
                    disbursementIssues.add(
                        new Disbursement_Issue__c(
                            Loan__c = loanId,
                            Parent_Id__c = otherAssistanceHistory.ParentId + '',
                            Old_Value__c = otherAssistanceHistory.OldValue + '',
                            New_Value__c = otherAssistanceHistory.NewValue + '',
                            Changed_Field__c = otherAssistanceHistory.Field  + '',
                            Type__c = OTHER_ASSISTANCE));
                }
            }       
        }

        return disbursementIssues;
    }

    private Set<Id> getAPIIntegrationUserIds() {
        List<User> apiUsers = new List<User>();
        Set<Id> userIds = new Set<Id>();

        try{
            apiUsers = [SELECT Id FROM User WHERE Profile.Name = :API_INTEGRATION_USER];
        } catch(QueryException e) {
            System.debug(e);
            throw new FieldHistoryIssueFinderException('Error while getting API Integration User', e);
        }
        
        for(User user : apiUsers) {
            userIds.add(user.Id);
        }
        return userIds;
    }
    
    public class FieldHistoryIssueFinderException extends Exception {}
}