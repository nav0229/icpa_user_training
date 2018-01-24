/****************************************************************
 Name:  PrimaryWageEarnerIdentifier
============================================================
Author: Lenny
Purpose: JIRA#1774
Responsible for identifying the primary wage earners amoung
Applicants related to the Application objects for the given 
Application IDs
============================================================

****************************************************************/
public with sharing class PrimaryWageEarnerIdentifier {
    @TestVisible
    private static ApplicantDAO applicantDA = new ApplicantDataAccessor();

	public void identifyPrimaryWageEarners(List<Id> applicationIds) {
		Map<Id, List<Applicant__c>> applicationIdToApplicantsMap = createApplicationIdToApplicantsMap(applicationIds);
		List<Applicant__c> primaryWageEarnersForApplications = new List<Applicant__c>();
		
		for(Id applicationId : applicationIds) {
            if(applicationIdToApplicantsMap.containsKey(applicationId)){
            	Applicant__c primaryWageEarner = getPrimaryWageEarner(applicationIdToApplicantsMap.get(applicationId));
                System.debug('primaryWageEarner is ' + primaryWageEarner);
            	if(primaryWageEarner != null){
                    System.debug('Setting primary wage earner to ' + primaryWageEarner);
            		primaryWageEarnersForApplications.add(primaryWageEarner);
            	}
            }
        }

        try {
        	if(!primaryWageEarnersForApplications.isEmpty()) {
                System.debug('PWE being set to ' + primaryWageEarnersForApplications);
        		applicantDA.updateApplicants(primaryWageEarnersForApplications);
        	}
        }
        catch(DmlException e) {
        	throw new PrimaryWageEarnerIdentifierException(
        		'Error updating Applicants identified as the Primary Wage Earner:' + e.getMessage() + ' ' + e.getLineNumber()
        	);
        }
	}

    private Map<Id, List<Applicant__c>> createApplicationIdToApplicantsMap(List<Id> applicationIds) {
		List<Applicant__c> relatedApplicants = applicantDA.getApplicantsByApplicationIds(applicationIds);
        Map<Id, List<Applicant__c>> applicationIdToApplicantsMap = new Map<Id, List<Applicant__c>>();
        for(Id applicationId : applicationIds) {
            List<Applicant__c> currentApplicants = new List<Applicant__c>();
            for(Applicant__c applicant : relatedApplicants) {
                if(applicationId == applicant.Application__c) {
                    currentApplicants.add(applicant);
                    System.debug('adding applicant to map : ' + applicant.Name);
                }
            }
            applicationIdToApplicantsMap.put(applicationId, currentApplicants);
        }
        return applicationIdToApplicantsMap;
    }

    private Applicant__c getPrimaryWageEarner(List<Applicant__c> relatedApplicants){
    	Applicant__c primaryWageEarner = null;

        relatedApplicants = setAplicantsPrimaryWageEarnerToFalse(relatedApplicants);

    	for(Applicant__c applicant : relatedApplicants) {

    		if(primaryWageEarner == null) {
    			primaryWageEarner = applicant;
    		}
    		else if(primaryWageEarner.Gross_Annual_Income__c < applicant.Gross_Annual_Income__c) {
    			primaryWageEarner = applicant;
    		}
            System.debug('Trying to get PWE...current one is ' + primaryWageEarner);
    	}
    	if(primaryWageEarner != null){
    		primaryWageEarner.Primary_Wage_Earner__c = true;
    	}
        System.debug('Trying to get PWE...returned one is ' + primaryWageEarner);
    	return primaryWageEarner;
    }

    private List<Applicant__c> setAplicantsPrimaryWageEarnerToFalse(List<Applicant__c> relatedApplicants) {
        for(Applicant__c applicant : relatedApplicants) {
            applicant.Primary_Wage_Earner__c = false;
        }

        return relatedApplicants;
    }

    public class PrimaryWageEarnerIdentifierException extends Exception {}
}