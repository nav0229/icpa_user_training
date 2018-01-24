/****************************************************************
 Name:  ApplicationAutoDeclineInitializer
============================================================
Author: Lenny
Purpose: JIRA#1476 
Invoked by EventRequestStageUpdateHandler class,
gathers and prepares data to be processed for callout request.
============================================================

****************************************************************/

public with sharing class ApplicationAutoDeclineInitializer implements Queueable{
	//private static final String APPLICATION = 'Application__c';
	//private static final String EVENT_REQUEST = 'Event_Request__c';

	//private String applicationNumber;

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

	//@TestVisible
	//private ApplicationDAO applicationDA {
	//    get {
	//        if(this.applicationDA == null){
	//            this.applicationDA = new ApplicationDataAccessor();
	//        }
	//        return applicationDA;
	//    }
	//    set;
	//}

	//public ApplicationAutoDeclineInitializer(String appNumber){
	//	this.applicationNumber = appNumber;
	//}

	public void execute(QueueableContext context) {
		//Application__c application = applicationDA.getApplicationByApplicationNumber(this.applicationNumber);
		//Event_Request__c request = eventRequestDA.getEventRequestByStageAndApplicationNumber(application.Name, EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE);

		//if(application == null){
		//	throw new ApplicationAutoDeclineInitializerException('Error: Unable to find Application with Application Number: '+this.applicationNumber);
		//}
		//else if(request == null) {
		//	throw new ApplicationAutoDeclineInitializerException('Error: Unable to find Submit Auto Decline Event Request for Application Number: '+this.applicationNumber);
		//}
		
		//ApplicationAutoDeclineProcessor autoDeclineProcessor = new ApplicationAutoDeclineProcessor();
		//autoDeclineProcessor.sendAutoDeclineRequest(application, request);
	}

	//public class ApplicationAutoDeclineInitializerException extends Exception {}
}