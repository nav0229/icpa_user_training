/****************************************************************
 Name: CBRCreditProfileProcessor
============================================================
Author: Kevin
Purpose: JIRA#1336
	lass that requests a CBR Credit Profile given an Application and Primary Applicant
============================================================

****************************************************************/

public with sharing class CBRCreditProfileProcessor implements CBRCreditProfileProcessorInterface {

	@TestVisible
	private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();

	public CBRCreditProfileProcessor(){}

	public void sendCreditProfileRequest(Application__c application, Applicant__c primaryApplicant){
		CBRCreditProfileJSON.CBRCreditProfileRequest request = buildCreditProfileRequest(application, primaryApplicant);

		CBRCreditProfileCallout creditProfileCallout = new CBRCreditProfileCallout(request);
		creditProfileCallout.run();

		createNewOrderCBREventRequest(application, creditProfileCallout.isSuccess());
	}

	private CBRCreditProfileJSON.CBRCreditProfileRequest buildCreditProfileRequest(Application__c application, Applicant__c primaryApplicant){
		CBRCreditProfileJSON.CBRCreditProfileRequest newRequest = new CBRCreditProfileJSON.CBRCreditProfileRequest();
		newRequest.applicationNumber = application.Name;
		newRequest.applicationSFID = application.Id;

		CBRCreditProfileJSON.Applicants applicant = new CBRCreditProfileJSON.Applicants();
		applicant.isPrimary = 'true';
		applicant.ssn = primaryApplicant.Contact__r.Social_Security_Number__c;
		applicant.applicantSFID = primaryApplicant.Id;

		CBRCreditProfileJSON.Name name = new CBRCreditProfileJSON.Name();
		name.surname = primaryApplicant.Contact__r.LastName;
		name.firstName = primaryApplicant.Contact__r.FirstName;

		CBRCreditProfileJSON.CurrentAddress currentAddress = new CBRCreditProfileJSON.CurrentAddress();
		currentAddress.street = primaryApplicant.Contact__r.MailingStreet;
		currentAddress.city = primaryApplicant.Contact__r.MailingCity;
		currentAddress.state = primaryApplicant.Contact__r.MailingState;
		currentAddress.zip = primaryApplicant.Contact__r.MailingPostalCode;

		applicant.name = name;
		applicant.currentAddress = currentAddress;

		newRequest.applicants = new List<CBRCreditProfileJSON.Applicants>{applicant};

		return newRequest;
	}

	private void createNewOrderCBREventRequest(Application__c application, Boolean isSuccess){
		Event_Request__c newEventRequest = new Event_Request__c(
			Stage__c = EventRequestDataAccessor.STAGE_ORDER_CBR,
			Application_Number__c = application.Name
			);

		if(isSuccess){
			newEventRequest.Status__c = EventRequestDataAccessor.STATUS_SUCCESS;
		} else {
			newEventRequest.Status__c = EventRequestDataAccessor.STATUS_FAILURE;
		}

		try {
			eventRequestDA.insertEventRequest(newEventRequest);
		} catch(DmlException e) {
			System.debug(e.getMessage());
			throw new CBRCreditProfileProcessorException(e.getMessage());
		}
	}

	public class CBRCreditProfileProcessorException extends Exception {}
}