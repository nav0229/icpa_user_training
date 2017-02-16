public with sharing class GSA_FCIC_KDBArticles_Service {
	private static final String LANG_ENGLISH = 'English';
	private static final String LANG_SPANISH = 'Spanish';

	public static GSA_FCIC_KDBArticles_WSParser.narrativeResponse getNarritive(Datetime dateFilter, Integer page) {

		Map<String, String> terms_filter = new Map<String,String>{'for_use_by'=>'NCC+Knowledge+Base', 'status'=>'archived,deleted,published'};
		GSA_FCIC_KDBArticles_WSParser.narrativeResponse narratives = GSA_FCIC_KDBArticles_Callout.getArticleDetails_WS(dateFilter, null, terms_filter, null, null, page, null, null);

		return narratives;
	}

	public static void processNarratives(GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp) {
		Map<String, List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>> narratives = getBucketedArticleChanges(resp);
		
		System.debug(Logginglevel.INFO, '*#*#*#*#*#*#');
		System.debug(Logginglevel.INFO, narratives);

		System.debug('~~~~~~create' + narratives.get('newArticles').size());
		System.debug('~~~~~~update' + narratives.get('updatedArticles').size());
		System.debug('~~~~~~delete' + narratives.get('deletedArticles').size());

		GSA_FCIC_KDBArticleUtils.createArticles(narratives.get('newArticles'));
		GSA_FCIC_KDBArticleUtils.updateArticles(narratives.get('updatedArticles'));
		GSA_FCIC_KDBArticleUtils.deleteArticles(narratives.get('deletedArticles'));

	}

	//Used to get a single narrative. Currently unused
	/*
	//public static GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor getNarritive(String uid) {
	//	GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor narrative = GSA_FCIC_KDBArticles_Callout.getArticleDetails_WS(uid);
	public static GSA_FCIC_KDBArticles_WSParser.narrativeResponse getNarritive(String uid) {
		GSA_FCIC_KDBArticles_WSParser.narrativeResponse narrative = GSA_FCIC_KDBArticles_Callout.getSingleArticleDetails_WS(uid);

		return narrative;
	}
	*/

	private static Map<String, List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>> getBucketedArticleChanges(GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp){
		
		Map<String, List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>> bucket = buildBucketMap();
		
		Set<String> existingRecords = getSetOfExistingArticleIds(resp.results);

		for(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor nd : resp.results) {
			if(nd.Status == 'Published') {
				System.debug('nd.Id => ' + nd.Id);
				if(existingRecords.contains(nd.Id)) {
					bucket.get('updatedArticles').add(nd);
				} else {
					bucket.get('newArticles').add(nd);
				}               
			} else {
				System.debug('|D| nd.Id => ' + nd.Id + ' buuuuut nd.Status => ' + nd.Status);
				bucket.get('deletedArticles').add(nd);
			}

		}

		return bucket;
	}

	private static Map<String, List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>> buildBucketMap () {
		Map<String, List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>> bucket = new Map<String, List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>>();
		bucket.put('newArticles', new List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>());
		bucket.put('deletedArticles', new List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>());
		bucket.put('updatedArticles', new List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor>());

		return bucket;
	}

	private static Set<String> getSetOfExistingArticleIds(List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> resp) {

		List<String> allCmsIds = new List<String>();
		for(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor article : resp){
			allCmsIds.add(article.Id);
		}
		return GSA_FCIC_KDBArticleUtils.getOnlineArticleIdsByCMSID(allCmsIds, 'NOT USED');

	}
}