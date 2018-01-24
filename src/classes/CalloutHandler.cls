/****************************************************************
 Name: CalloutHandler
============================================================
Author: Kevin
Purpose: Abstract Class to aggregate functionality shared between 
	classes performing Callouts
============================================================

****************************************************************/

public abstract class CalloutHandler {

	public static String accessToken;
	public static String accessType;

	public static final String BIZTALK = 'BIZTALK';

	protected String service;
	protected String endpoint;
	protected String body;
	protected HttpRequest request;
	protected HttpResponse response;	

	protected abstract void generateBody();
	protected abstract void handleResponse();

	public virtual void run(){
		//Login?
		//if(!hasValidLogin()){
		//	performLogin();
		//}

		generateBody();
		createHTTPRequest();
		performCallout();
		if(response != null){
			handleResponse();
		}
	}

	protected virtual void createHTTPRequest(){
		request = new HttpRequest();
		request.setEndpoint(endpoint);
		request.setTimeout(120000);

		if(body != null){
			request.setMethod('POST');
			request.setBody(body);
		} else {
			request.setMethod('GET');
		}

		//if(hasValidLogin()){
		//	addAuthHeader();
		//}
	}

	protected virtual void performCallout(){
		Http http = new Http();
		System.debug('request:'+request);
		try {
			response = http.send(request);
			System.debug('response:'+response);
		} catch(CalloutException e) {
			System.debug(e.getMessage());
			System.debug(e.getStackTraceString());
		}
	}

	//protected boolean hasValidLogin(){
	//	return !String.isBlank(accessToken);
	//}

	//protected void addAuthHeader(){
	//	request.setHeader('Authorization', accessType + ' ' + accessToken);
	//	request.setHeader('Content-Type', 'application/json');
	//}

	//private void performLogin(){

	//}

	public String getResponseBodyString(){
		try {
			return this.response.getBody();
		} catch(Exception e) {
			return e.getMessage();
		}
	}
}