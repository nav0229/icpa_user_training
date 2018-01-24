/****************************************************************
 Name:  ApplicationAutoDeclineProcessor
============================================================
Author: Lenny
Purpose: JIRA#1476
Invoked by ApplicationAutoDeclineInitializer class,
gathers and prepares data to be processed for callout request.
============================================================

****************************************************************/

public with sharing class ApplicationAutoDeclineProcessor {
	//@TestVisible
	//private EventRequestDAO eventRequestDA {
	//    get {
	//        if(this.eventRequestDA == null){
	//            this.eventRequestDA = new EventRequestDataAccessor();
	//        }
	//        return eventRequestDA;
	//    }
	//    set;
	//}

	//public ApplicationAutoDeclineProcessor(){}

	//public void sendAutoDeclineRequest(Application__c application, Event_Request__c request){
	//	//ApplicationAutoDeclineJSON.ApplicationAutoDeclineRequest request = buildAutoDeclineRequest(application, request);

	//	//ApplicationAutoDeclineCallout autoDeclineCallout = new ApplicationAutoDeclineCallout(request);
	//	//autoDeclineCallout.run();

	//	//createNewSentAutoDeclineEventRequest(application, autoDeclineCallout.isSuccess());
	//	createNewSentAutoDeclineEventRequest(application, true);//this is only here for the 8/23 demo
	//}

	//private ApplicationAutoDeclineJSON.ApplicationAutoDeclineRequest buildAutoDeclineRequest(Application__c application, Event_Request__c request){
	//	ApplicationAutoDeclineJSON.ApplicationAutoDeclineRequest newRequest = new ApplicationAutoDeclineJSON.ApplicationAutoDeclineRequest();
	//	//newRequest.applicationNumber = application.Name;
	//	//newRequest.autoDeclineStatus = 'Y';
	//	//newRequest.autoDeclineDate = application.Credit_Repayment_Test_Result_Date__c;
	//	//newRequest.submittedDate = request.Request_Date__c;

	//	return newRequest;
	//}

	//private void createNewSentAutoDeclineEventRequest(Application__c application, Boolean isSuccess){
	//	Event_Request__c newEventRequest = new Event_Request__c(
	//		Stage__c = EventRequestDataAccessor.STAGE_SENT_AUTO_DECLINE,
	//		Application_Number__c = application.Name
	//		);

	//	if(isSuccess){
	//		newEventRequest.Status__c = EventRequestDataAccessor.STATUS_SUCCESS;
	//	} else {
	//		newEventRequest.Status__c = EventRequestDataAccessor.STATUS_FAILURE;
	//	}

	//	eventRequestDA.insertEventRequest(newEventRequest);
	//}
}