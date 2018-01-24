/****************************************************************
 Name:  ApplicationAutoDeclineCallout
============================================================
Author: Lenny
Purpose: JIRA#1476
Extension of CalloutHandler to perform callout to
notify DLAP of an Auto Decline Application
============================================================

****************************************************************/

public with sharing class ApplicationAutoDeclineCallout extends CalloutHandler{
	//private String jsonRequestBody;

	//public ApplicationAutoDeclineJSON.ApplicationAutoDeclineResponse autoDeclineResponse;
	
	//public ApplicationAutoDeclineCallout(ApplicationAutoDeclineJSON.ApplicationAutoDeclineRequest autoDeclineRequest){
	//	this.service = CalloutHandler.BIZTALK;
	//	//this.endpoint = 
	//	this.jsonRequestBody = JSON.serialize(autoDeclineRequest);
	//}

	public override void handleResponse(){
	//	try {
	//		this.autoDeclineResponse = (ApplicationAutoDeclineJSON.ApplicationAutoDeclineResponse)JSON.deserialize(this.response.getBody(), ApplicationAutoDeclineJSON.ApplicationAutoDeclineResponse.class);
	//	} catch(JSONException e) {
	//		System.debug('Error occurred parsing autoDeclineResponse: '+e.getMessage());
	//		throw new ApplicationAutoDeclineException(e.getMessage());
	//	}
	}

	public override void generateBody(){
	//	this.body = this.jsonRequestBody;
	}

	//public Boolean isSuccess(){
	//	if(this.response.getStatusCode() == 200){
	//		return true;
	//	} else {
	//		return false;
	//	}
	//}

	//public class ApplicationAutoDeclineException extends Exception {}
}