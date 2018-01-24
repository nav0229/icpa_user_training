/****************************************************************
 Name: CBRCreditProfileCallout
============================================================
Author: Kevin
Purpose: JIRA#1336
	Class to perform CBR Credit Profile Request Callout
============================================================

****************************************************************/
public with sharing class CBRCreditProfileCallout extends CalloutHandler {
	
	private String jsonRequestBody;

	public CBRCreditProfileJSON.CBRCreditProfileResponse creditProfileResponse;
	
	public CBRCreditProfileCallout(CBRCreditProfileJSON.CBRCreditProfileRequest creditProfileRequest){
		this.service = CalloutHandler.BIZTALK;
		this.endpoint = BiztalkEndpoint.setEndpoint('CreditProfile');
		this.jsonRequestBody = JSON.serialize(creditProfileRequest);
	}

	public override void handleResponse(){}

	public override void generateBody(){
		this.body = this.jsonRequestBody;
	}

	public Boolean isSuccess(){
		if(this.response.getStatusCode() == 200){
			return true;
		} else {
			return false;
		}
	}

	public class CBRCreditProfileException extends Exception {}
}