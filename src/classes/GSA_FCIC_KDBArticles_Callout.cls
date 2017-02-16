//TO DO:  WHEN Webservice and their parameters and callout formats are done, refactor redundant callout code

global with sharing class GSA_FCIC_KDBArticles_Callout {
	//private static String ARTICLE_ENDPOINT_BASE = 'http://dev-api.ctacdev.com/api/v1/usagov/';
	private static String ARTICLE_NARRATIVES_TAIL = 'narratives';
	private static String ARTICLE_CHANGES_TAIL = 'changes/narratives';
	private static final Integer CALLOUT_TIMEOUT_MS = 60000;
	private static final String API_KEY = 'nhDDY3PIS2OJtiFyAva27CItXCUmIKupE3N1VLc2';
	private static final String HTTP_GET_METHOD = 'GET';
	private static final String USERNAME_WS = null;
	private static final String PASSWORD_WS = null;
	
	/* TESTING
	//public static GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor getArticleDetails_WS(String articleId) {
	public static GSA_FCIC_KDBArticles_WSParser.narrativeResponse getSingleArticleDetails_WS(String articleId) {
		KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');

		System.debug('****Starting Callout');

		String endpoint = settings.Endpoint__c + ARTICLE_NARRATIVES_TAIL;

		System.debug('****Calling out');
		
		String body = 'api_key=nhDDY3PIS2OJtiFyAva27CItXCUmIKupE3N1VLc2&terms_filter=id:' + articleId;

		System.debug(endpoint + '?' + body);

		calloutResponse response;
		
		response = callContent_WS(endpoint, body);

		System.debug('****Response   ' + response);

		if(response.isError) {
			return null;
		} else {
			//return GSA_FCIC_KDBArticles_WSParser.parseSingleNarrative(response.body);
			return GSA_FCIC_KDBArticles_WSParser.parseNarratives(response.body);
		}

	}
	*/

	public static GSA_FCIC_KDBArticles_WSParser.narrativeResponse getArticleDetails_WS(Datetime dateFilter, String query, Map<String,String> terms_filter, List<String> result_filter, Integer page_size, Integer page, String sortField, Boolean sortDesc) {
		KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');
		
		System.debug('****Starting Callout');

		String endpoint = settings.Endpoint__c + ARTICLE_NARRATIVES_TAIL;
		
		System.debug('****Calling out');		
		
		page_size = (page_size == null)?(Integer)settings.Page_Size__c:page_size;

		// how the unique request is built
		String body = GSA_FCIC_KDBArticles_WSParser.getRequest(settings.API_Key__c, dateFilter.addDays(settings.Date_Delta__c.intValue()), query, buildQueryFilter(terms_filter), buildResultFilter(result_filter), page_size, page, sortField, sortDesc);
		
		System.debug(endpoint + '?' + body);
		
		calloutResponse response;
		
		try{
			response = callContent_WS(endpoint, body);
		} catch(GSA_FCIC_KBArticles_Exception e) {
			e.createExceptionRecord();
			return null;
		}

		System.debug('****Response   ' +response);
		
		return GSA_FCIC_KDBArticles_WSParser.parseNarratives(response.body);
	}


	private static calloutResponse callContent_WS(String endpoint, String body) {
		HTTPRequest req = getRequestHeaders(endpoint, HTTP_GET_METHOD, USERNAME_WS, PASSWORD_WS, body);
		calloutResponse response = sendRequest(req);
		if(response.isError) {
			throw new GSA_FCIC_KBArticles_Exception(response.status);
		}
		return response;
	}

	// the magic
	private static HTTPRequest getRequestHeaders(String endpoint, String method, String username, String password, String body) {
		System.Httprequest req = new System.Httprequest();
		req.setEndpoint(endpoint+'?'+body);
		System.debug(endpoint + '?' + body);
		req.setMethod(method);
		//TODO: Figure out autentication 
		req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		system.debug('****Body   ' +body);
		system.debug('*** req '+req.getBody());
		return req;
	}

	private static calloutResponse sendRequest(Httprequest req) {
		Http http = new Http();
		HTTPResponse res;
		
		req.setTimeout(CALLOUT_TIMEOUT_MS);
		try {
		   // if(!Test.isRunningTest()){
			res = http.send(req);
			system.debug('*** RES '+res);
		//}
		} catch(System.CalloutException e) {
			return new calloutResponse(e);
		}
		
		return new calloutResponse(res);
	}


	private static String buildQueryFilter(Map<String,String> fieldValuePairs) {
		
		String ret = '';
		if(fieldValuePairs == null) {
			return null;
		}
		for(String field : fieldValuePairs.keySet()) {
			if(ret != '') {
				ret += '::';
			}
			ret += field + ':' + fieldValuePairs.get(field);
		}

		if(ret == '') {
			return null;
		} else {
			return ret;
		}
	}

	private static String buildResultFilter( List<String> resultFilter) {
		
		String ret = '';
		if(resultFilter == null) {
			return null;
		}
		for(String field:resultFilter) {
			if(ret != '') {
				ret += '|';
			}
			ret += field;
		}
		if(ret == '') {
			return null;
		} else {
			return ret;
		}
	}

	private class calloutResponse {
		public boolean isError;
		public Integer statusCode;
		public String status;
		public String body;

		public calloutResponse(HTTPResponse res) {

			statusCode = res.getStatusCode();
			status = res.getStatus();
			if(statusCode == 200) {
				isError = false;
				body = res.getBody();
			} else {
				isError = true;
			}
		}

		public calloutResponse(System.CalloutException e) {
			isError = true;
			statusCode = -1;
			status = e.getMessage();
		}
	}

}