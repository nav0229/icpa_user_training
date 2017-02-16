public with sharing class GSA_FCIC_KDBArticles_WSParser {
	
	// for single response / testing
	/*	
	public static narrativeDescriptor parseSingleNarrative(String resp) {
		narrativeDescriptor ret = (narrativeDescriptor)JSON.deserialize(resp, narrativeDescriptor.class);

		return ret;
	}
	*/
	
	public static narrativeResponse parseNarratives(String resp) {
		narrativeResponse ret = (narrativeResponse)JSON.deserialize(resp, narrativeResponse.class);

		return ret;
	}

	/*	
	public static List<contentDescriptor> parseContentDescriptors(String resp) {
		List<contentDescriptor> ret = (List<contentDescriptor>)JSON.deserialize(resp, List<contentDescriptor>.class);

		return ret;
	}
	*/

	// for single response / testing
	/*	
	public static String getRequest(String api_key) {
		return getRequest(api_key, null, null, null, null, null,null,null,null);
	}
	*/

	/*
	public static String getRequest(String api_key, String query_filter, String result_filter, String sortField, Boolean sortDesc) {
		return getRequest(api_key, null, null, query_filter, result_filter, null, null, sortField, sortDesc);
	}
	*/

	public static String getRequest(String api_key, Datetime dateFilter, String query, String terms_filter, String result_filter, Integer page_size, Integer page, String sortField, Boolean sortDesc) {
		//System.JSONGenerator gen = JSON.createGenerator(true);
		//gen.writeStartObject();
		String body = '';
		body = addParamToBody(body,'api_key', api_key);
		body = addParamToBody(body,'query', query);
		body = addParamToBody(body,'terms_filter', terms_filter);
		body = addParamToBody(body,'result_filter', result_filter);
		body = addParamToBody(body,'page_size', page_size);
		body = addParamToBody(body,'page', page);
		body = addParamToBody(body,'date_filter', dateFilter);
		body = addParamToBody(body,'sort', (sortDesc == true && sortField != null)?'-'+sortField:sortField);
		
		//gen.writeEndObject();
		//gen.close();

		//return gen.getAsString();

		return body;

	}

	private static String addParamToBody(String body, String fieldname, String value) {
		
		if(value != null) {
			if(body != '') body += '&';
			body += fieldName+'='+value;
		}

		return body;
	}

	private static String addParamToBody(String body, String fieldname, Integer value) {
		if(value != null) {
			if(body != '') body += '&';
			body += fieldName+'='+value.format();
		}

		return body;
	}

	private static String addParamToBody(String body, String fieldname, DateTime value) {
		if(value != null) {
			if(body != '') body += '&';
			body += fieldName+'='+value.format('yyy-MM-dd\'T\'HH:mm:ss.SSS');
		}

		return body;
	}

	public class narrativeDescriptor {
		public String id; //The Unique ID of the Content Item 
		public String title; //The long version of the Content Item Title
		public String type; //Name of the content type of hte content item
		public String summary; //A brief description about the Content item
		public List<String> tags; //Main keywords related to the Content Item
		public List<List<String>> topics; //Taxonomy location
		public String language; //{English, Spanish, Other}
		public List<String> for_use_by; //{usa.gov, gobiernousa.gov,kids.usa.gov, Contact Center, Print CAH, Print Guia} TODO: Verify field name when service built
		public String status; //{Created, Updated, Archived, Deleted}
		public DateTime updated_at; //Date of last Status Activity
		public String html; //The main body of the text item
		public List<contentDescriptor> related; //Urls of related Content
		public String creator; //The user who created the Content Item
		public String last_updated_by; //The user who last changed the status of the Content Item
		public String owner; //The user respondible for maintaining the content item
		public List<locationDescriptor> location;
		public DateTime created_at;
		
	}

	// added 5/22 by Christian Coleman
	public class locationDescriptor {
		public String page_title;
		public String url;
	}

	public class contentDescriptor {
		public String uid; //The Unique ID of the Content Item 
		public String title; //The long version of the Content Item Title
		public String type; //Name of the content type of hte content item
		public String status; //{Created, Updated, Archived, Deleted}
		public Date status_change_date; //Date of last Status Activity

	}

	public class metadataDescriptor {
		public Integer count;
		public Integer pages;
		public Integer page_size;
		public Integer page;
		public String message;
	}

	public class narrativeResponse {
		public metadataDescriptor metadata;
		public List<narrativeDescriptor> results;
	}


}