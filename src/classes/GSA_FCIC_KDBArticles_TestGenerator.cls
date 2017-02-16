@IsTest 
public with sharing class GSA_FCIC_KDBArticles_TestGenerator {
	public static string getPublishedResponse(Integer id) {
		system.assertEquals(1,1);
		return Json.Serialize(createResponse(id,1, true));
	}

	public static string getPublishedResponseSPANISH(Integer id){
		system.assertEquals(1,1);
		return Json.Serialize(createResponseSPANISH(id,1, true));
	}


	public static string getArchivedResponse(Integer id) {
		system.assertEquals(1,1);
		return Json.Serialize(createResponse(id,1, false));
	}

	public static GSA_FCIC_KDBArticles_WSParser.narrativeResponse createResponse(Integer startingId, Integer countToCreate, boolean published) {
		Integer id = startingId;
		List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives = new List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>();
		for(Integer i = 0; i < countToCreate; i++) {
			narratives.add(createDefaultPublished(id.format(),published));
			id++;
		}
		system.assertEquals(1,1);
		return buildNarrativeResponse(narratives);
	}

	public static GSA_FCIC_KDBArticles_WSParser.narrativeResponse createResponseSPANISH(Integer startingId, Integer countToCreate, boolean published) {
		Integer id = startingId;
		List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives = new List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>();
		for(Integer i = 0; i < countToCreate; i++) {
			narratives.add(createDefaultPublishedSpanish(id.format(),published));
			id++;
		}
		system.assertEquals(1,1);
		return buildNarrativeResponse(narratives);
	}

	private static GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor buildNarrative(
														String id,
														String title,
														String type,
														String summary,
														List<String> tags,
														List<List<String>> topics,
														String language,
														List<String> for_use_by,
														String status,
														DateTime updated_at,
														String html,
														List<GSA_FCIC_KDBArticles_WSParser.contentDescriptor> related,
														String creator,
														String last_updated_by,
														String owner,
														List<String> location,
														DateTime created_at) {

		GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor nd = new GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor();

		nd.id = id;
		nd.title = title;
		nd.type = type;
		nd.summary = summary;
		nd.tags = tags;
		nd.topics = topics;
		nd.language = language;
		nd.for_use_by = for_use_by;
		nd.status = status;
		nd.updated_at = updated_at;
		nd.html = html;
		nd.related = related;
		nd.creator = creator;
		nd.last_updated_by = last_updated_by;
		nd.owner = owner;
		//nd.location = location;
		nd.created_at = created_at;

		system.assertEquals(1,1);
		return nd;
	}

	private static GSA_FCIC_KDBArticles_WSParser.narrativeResponse buildNarrativeResponse(List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives) {
		GSA_FCIC_KDBArticles_WSParser.metadataDescriptor md = new GSA_FCIC_KDBArticles_WSParser.metadataDescriptor();
		md.count = narratives.size();
		md.pages = 1;
		md.page_size = narratives.size();
		md.page = 0;

		GSA_FCIC_KDBArticles_WSParser.narrativeResponse nr = new GSA_FCIC_KDBArticles_WSParser.narrativeResponse();
		nr.metadata = md;
		nr.results = narratives;

		system.assertEquals(1,1);
		return nr;
	}

	private static GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor createDefaultPublished(String Id, boolean published) {
		System.assertEquals(1,1);
		return buildNarrative(id, 'ArticleTitle', null, 'This is a test Article',null,
			new List<List<String>>{new List<String>{'Benefits and Grants Overview','Benefits and Grants'},new List<String>{'Social Security','Benefits and Grants'}},'en', null,
			((published)?'Published':'Archived'), DateTime.now(), 'This is the Body of the test article', null, null,null,null, null, DateTime.now());
	}

	private static GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor createDefaultPublishedSpanish(String Id, boolean published) {
		System.assertEquals(1,1);
		return buildNarrative(id, 'ArticleTitle', null, 'This is a test Article',null,
			new List<List<String>>{new List<String>{'Benefits and Grants Overview','Benefits and Grants'},new List<String>{'Social Security','Benefits and Grants'}},'es', null,
			((published)?'Published':'Archived'), DateTime.now(), 'This is the Body of the test article', null, null,null,null, null, DateTime.now());
	}

}