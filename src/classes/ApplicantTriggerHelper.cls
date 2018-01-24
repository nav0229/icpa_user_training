/****************************************************************
 Name:  ApplicantTriggerHelper
============================================================
Author: Lenny/Kevin
Purpose: JIRA#1870/1774
============================================================
*/
public with sharing class ApplicantTriggerHelper {
    @TestVisible private static PrimaryApplicantHandlerInterface primaryHandler = new PrimaryApplicantHandler();
    @TestVisible private static ApplicantDataPopulator applicantDataPopulator = new ApplicantDataPopulator();
    
    public static void beforeInsertApplicants(List<Applicant__c> newApplicants){
        applicantDataPopulator.populateDataOnNewApplicants(newApplicants);
        primaryHandler.setPrimaryApplicantsIfNone(newApplicants);
    }

    public static void afterUpdateApplicants(Map<Id, Applicant__c> oldApplicants, List<Applicant__c> updatedApplicants){
        primaryHandler.updatePrimaryApplicantsAfterUpdate(oldApplicants, updatedApplicants);
    }

    public static void afterInsertApplicants(List<Applicant__c> newApplicants){
        primaryHandler.updatePrimaryApplicants(newApplicants);
     }
}