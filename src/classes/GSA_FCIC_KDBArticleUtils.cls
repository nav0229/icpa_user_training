public with sharing class GSA_FCIC_KDBArticleUtils {
	private static final String LANG_ENGLISH = 'English';
	private static final String LANG_SPANISH = 'Spanish';

	private static final String AT_USA_GOV = 'USA_gov__kav';
	private static final String AT_USA_GOV_SP ='GobiernoUSA_gov__kav';

	private static final String ATID_USA_GOV = 'USA_gov_Article_Id__c';
	private static final String ATID_USA_GOV_SP = 'GobiernoUSA_gov_Article_ID__c';

	public class CMS_Content_Article
	{

		public String cms_Id;
		public String summary;  
		public String title;
		public String article_Id;
		public String article_Vid;
		public String urlname;
		public String lang;
		public String notes;
		public String textAsset;
		public String location;
		public List<String> locationArray; // multiple URL enhancement
		public List<DataCategory> dataCategories;

		public CMS_Content_Article(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor narrative) {
			parseServiceArticle(narrative);
		}

		private void parseServiceArticle(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor narrative)
		{
			this.cms_Id = narrative.id;
			this.summary = narrative.summary;
			this.title = narrative.title;
			this.urlname = narrative.id;
			this.lang = narrative.language;

			if(narrative.location != null && narrative.location.isEmpty() == false) {
				this.location = narrative.location.get(0).url;
				this.locationArray = new List<String>();
				for(Integer i = 0; i < narrative.location.size(); i++){
					this.locationArray.add(narrative.location.get(i).url);
				}
			}
						
			if(narrative.html != null) {
				this.textAsset = narrative.html.unescapeHtml4();
			}
			else {
				this.textAsset = narrative.html;
			}

			this.dataCategories = new List<DataCategory>();
			for(List<String> categoryList : narrative.topics)
			{	
				DataCategory cat = new DataCategory();
				cat.categoryGroup = (narrative.language == 'es' || narrative.language == 'Spanish') ? 'gobiernousa_gov' : 'USA_gov';
				if(categoryList.size() > 0) {
					// we are taking the first one in the list because that is the most descriptive data category provided in the API
					// for example: the list could be Dry Cleaning, Household Assistance, East Coast Services, USA.gov
					// the way in which data categories are organized (by David Kauffman as of 12-15-15) mirror exactly this way:
					// child <- parent where the left is the lowest branch and the right is the top most branch
					// with data categories you can only pick one category per branch - so either you select a parent or a more specific child not both
					cat.categoryLabel = categoryList[0];
				}
				this.dataCategories.add(cat);
			}
			System.debug('category ' + dataCategories);
		}


		public Boolean validateArticle()
		{
			Boolean error = false;

			if(String.isEmpty(this.cms_Id) || String.isEmpty(this.summary)||String.isEmpty(this.title)||String.isEmpty(this.lang)||String.isEmpty(this.notes)||String.isEmpty(this.textAsset)||String.isEmpty(this.urlName)){
				error = true;
			}
 
			return error;
		}

/*		private String scrubURL(String url){
			url = url.replaceAll('[^A-Za-z0-9]', '');
			return url;
		}*/
	}

	public class DataCategory{
		public String categoryGroup;
		public String categoryLabel;

/*		public Boolean validateCategory(){
			Boolean error = false;
			if(String.isEmpty(this.categoryGroup) || String.isEmpty(this.categoryLabel)){
				error = true;
			}
			return error;
		}*/
	}

	private static String getArticleQuery(String language) {
		String query = 'SELECT KnowledgeArticleId, Id, Language, ';
		query += getArticleIdField(language);
		query +=' FROM ';
		query += getArticleType(language);

		return query;
	}

	public static Set<String> getOnlineArticleIdsByCMSID(List<String> cmsIds, String NOT_USED){
		Set<String> articleStringSet = new Set<String>();
		List<sObject> articles = getOnlineVersionByCMSID(cmsIds);
		
		for(sObject article : articles){
			try {
				if(article instanceOf USA_gov__kav) {
					articleStringSet.add( (String)article.get(ATID_USA_GOV) );
				} else {
					articleStringSet.add( (String)article.get(ATID_USA_GOV_SP) );
				}
			} catch (Exception e){
				// do nothing / skip
			}
		}
		return articleStringSet;
	}

	// key will be CMS Id
	// value will be Salesforce Id
	public static Map<String, String> getCMSIdTOSalesforceIdMap(List<String> cmsIds){	
		Map<String, String> articleMap = new Map<String, String>();
		
		System.debug('!@#!@$!@%!%!%!%!%! CMSIDSSSSSSSSS' + cmsIds);
		
		List<sObject> articles = getOnlineVersionByCMSID(cmsIds);
		
		System.debug('!@#!@$!@%!%!%!%!%!' + articles);
		System.debug('!@#!@$!@%!%!%!%!%!' + articles.size());

		for(sObject article : articles){
			String cmsId;
			String salesforceId;
			try {

				if(article instanceOf USA_gov__kav) {
					System.debug('!@#!@$!@%!%!%!%!%!' + 'USAUSAUSA');
					cmsId = (String) article.get(ATID_USA_GOV);
				} else {
					System.debug('!@#!@$!@%!%!%!%!%!' + 'SPANISHHHHHHHH');
					cmsId = (String) article.get(ATID_USA_GOV_SP);
				}
				
				salesforceId =  (String) article.get('KnowledgeArticleId');

				// if(cmsId == null || salesforceId) continue;
				if(cmsId == null || salesforceId == null) {
					System.debug('NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
					continue;
				}

				articleMap.put(cmsId, salesforceId);

			} catch (Exception e){
				// do nothing / skip
			}
		}

		System.debug('!@#!@$!@%!%!%!%!%!' + articleMap);

		return articleMap;
	}

	public static List<sObject> getOnlineVersionByCMSID(List<String> cmsIds){
		String queryEnglish = 'SELECT KnowledgeArticleId, Id, Language, ' + ATID_USA_GOV 
					+ ' FROM ' + AT_USA_GOV
					+ ' WHERE Language = \'en_US\''
					+ ' AND isLatestVersion = TRUE'
					+ ' AND PublishStatus = \'Online\''
					+ ' AND ' + ATID_USA_GOV + ' IN :cmsIds';
		List<sObject> englishList = Database.query(queryEnglish);

		String querySpanish = 'SELECT KnowledgeArticleId, Id, Language, ' + ATID_USA_GOV_SP 
					+ ' FROM ' + AT_USA_GOV_SP
					+ ' WHERE Language = \'en_US\''
					+ ' AND isLatestVersion = TRUE'
					+ ' AND PublishStatus = \'Online\''
					+ ' AND ' + ATID_USA_GOV_SP + ' IN :cmsIds';
		List<sObject> spanishList = Database.query(querySpanish);

		List<sObject> allList = new List<sObject>(englishList);
		allList.addAll(spanishList);
		return allList;
	}

	private static String getArticleType(String language) {
		if(language == LANG_ENGLISH) {
			return AT_USA_GOV;
		} else {
			return AT_USA_GOV_SP;
		}
	}

	private static String getArticleIdField(String language) {
		if(language == LANG_ENGLISH) {
			return ATID_USA_GOV;
		} else {
			return ATID_USA_GOV_SP;
		}
	}

	public static Boolean createArticles(List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives) {
		List<CMS_Content_Article> KBArticlesEnglish = new List<CMS_Content_Article>();
		List<CMS_Content_Article> KBArticlesSpanish = new List<CMS_Content_Article>();
		for(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor n : narratives) {
			CMS_Content_Article article = new CMS_Content_Article(n);
			String language = getLanguage(article.lang);
			if(language == LANG_ENGLISH) {
				KBArticlesEnglish.add(article);
			} else {
				KBArticlesSpanish.add(article);
			}
			
		}
		Boolean ret = callInsertArticles(KBArticlesEnglish, LANG_ENGLISH); // (D) (H) (208 is a separate error probably for Spanish errors)
		if(ret == false) {
			return ret;
		} else {
			return callInsertArticles(KBArticlesSpanish, LANG_SPANISH); // (D) (H) (208 is a separate error probably for Spanish errors)
		}
	}

	private static Boolean callInsertArticles(List<CMS_Content_Article> articles, String language) {
		try{
			Boolean ret = insertArticles(articles,language); // (C) (G)
			return ret;
		} catch(exception e) {
			System.debug('CCCCCCCC exception');
			GSA_FCIC_KBArticles_Exception excep = new GSA_FCIC_KBArticles_Exception(e.getMessage(),e);
			excep.createExceptionRecord(' | INSERT | articles = ' + articles, 'language = ' + language);
			return false;
		}
	}

	public static Boolean updateArticles(List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives) {
		System.debug(Logginglevel.INFO, 'updateArticles list');

		List<CMS_Content_Article> KBArticlesEnglish = new List<CMS_Content_Article>();
		List<CMS_Content_Article> KBArticlesSpanish = new List<CMS_Content_Article>();
		for(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor n : narratives) {
			CMS_Content_Article article = new CMS_Content_Article(n);
			String language = getLanguage(article.lang);
			if(language == LANG_ENGLISH) {
				KBArticlesEnglish.add(article);
			} else {
				KBArticlesSpanish.add(article);
			}		
		}

		Boolean ret = callUpdateArticles(KBArticlesEnglish, LANG_ENGLISH); // (2) (6)
		if(ret == false) {
			return ret;
		} else {
			return callUpdateArticles(KBArticlesSpanish, LANG_SPANISH);
		}
	}

	private static Boolean callUpdateArticles(List<CMS_Content_Article> articles, String language) {
		try{
			Boolean ret = updateKBArticles(articles,language); // (5)
			return ret;
		} catch(exception e) {
			System.debug('ZZZZZ exception');
			GSA_FCIC_KBArticles_Exception excep = new GSA_FCIC_KBArticles_Exception(e.getMessage(),e); // (1)
			excep.createExceptionRecord(' | UPDATE | articles = ' + articles, 'language = ' + language);
			return false;
		}
	}

	private static String getLanguage(String lang) {
		System.debug('~*~*~* getLanguage if(\'es\') then return SPANISH else return ENGLISH ' + lang);
		if(lang == 'es' || lang == 'Spanish') {
			return LANG_SPANISH;
		} else {
			return LANG_ENGLISH;
		}
	}
	

	private static Boolean insertArticles(List<CMS_Content_Article> articles, String language)
	{
		//System.debug('~*~*~* insertArticles in KDBArticleUtils');
		List<String> articleIds = new List<String>(); 
		Boolean success = true;
		List<sObject>  versions = new List<sObject>();
		Map<String, CMS_Content_Article> cmsContent = new Map<String,CMS_Content_Article>();
		
		//System.debug('~*~*~* expecting Language in the form of ' + LANG_ENGLISH + ' otherwise the incorrect article type will be used');
		for(CMS_Content_Article article : articles){
			//System.debug('~*~*~* language ' + language + ' article ' + article);
			sObject articleVersion = getArticleTypeRecord(language);
			setArticleFields(articleVersion,article, language);
			versions.add(articleVersion);
			cmsContent.put(article.cms_Id, article);
		}
		articleIds = insertKBArticles(versions, language); // (B) (F)
		//System.debug('insertArticles - before assignDataCategories = ' + articleIds );
		assignDataCategories(cmsContent, articleIds, language);
		publishArticles(articleIds, true);
		return success;
	}

	private static sObject getArticleTypeRecord(String language) {
		if(language == LANG_ENGLISH) {
			return new USA_gov__kav();
		} else {
			return new GobiernoUSA_gov__kav();
		}
	}

	private static void setArticleFields(sObject at, CMS_Content_Article article, String language) {
		
		System.debug('~*~*~* BEGINNING setArticleFields in KDBArticleUtils');
		
		at.put(getArticleIdField(language),article.cms_Id);
		System.debug('~*~*~* article.cms_Id ' + article.cms_Id);
		
		at.put('Title', article.title);
		System.debug('~*~*~* article.title ' + article.title);
		
		at.put('Summary', article.summary);
		System.debug('~*~*~* article.summary ' + article.summary);
		
		at.put('urlName', article.urlname);
		System.debug('~*~*~* article.urlName ' + article.urlName);

		at.put('Language__c', article.lang);
		System.debug('~*~*~* article.lang ' + article.lang);
		
		at.put('Text_Asset_Body__c', article.textAsset);
		System.debug('~*~*~* article.textAsset ' + article.textAsset);

		at.put('Agency_Website__c', article.location);
		System.debug('~*~*~* article.location ' + article.location);

		// multiple URL enhancement
		if(article.locationArray != null) {
			for(Integer i = 1; i < article.locationArray.size(); i++){
				Integer j = i + 1;
				at.put('Agency_Website_' + j + '__c', article.locationArray[i]);
				System.debug('~*~*~* article.location[' + j + ']' + article.locationArray[i]);
			}
		}

		System.debug('~*~*~* ENDING setArticleFields in KDBArticleUtils');

	}

	public static Boolean updateKBArticles(List<CMS_Content_Article> articles, String language)
	{
		Boolean success = true;
		List<String> cmsIds = new List<String>();
		List<String> articleIds = new List<String>();
		Map<String,CMS_Content_Article> content = new Map<String,CMS_Content_Article>();
		Map<String,CMS_Content_Article> content4DataCategories = new Map<String,CMS_Content_Article>();
		System.debug('Updating...');
		System.debug(validateArticles(articles));

		for(CMS_Content_Article article : articles){
			cmsIds.add(article.cms_Id);
		}
		System.debug(cmsIds);
		Map<String, String> cmsArticleMap = getCMSIdTOSalesforceIdMap(cmsIds); // CRUCIAL FOR GETTING THE EXISTING SALESFORCE ID
		for(CMS_Content_Article article : articles)
		{	
			article.article_Id = cmsArticleMap.get(article.cms_Id); // CRUCIAL FOR GETTING THE EXISTING SALESFORCE ID
			articleIds.add(article.article_Id);
			content.put(article.article_Id, article);
			content4DataCategories.put(article.cms_Id, article);
		}

		editArticles(content, language); // (4)
		assignDataCategories(content4DataCategories, articleIds, language);
		publishArticles(articleIds, true);

		return success;
	}


	public static void deleteArticles(List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives)
	{
		Map<String, List<String>> cmsIds = getListOfIds(narratives);
		archiveArticle(cmsIds.get(LANG_ENGLISH));
		archiveArticle(cmsIds.get(LANG_SPANISH));
		
	}

	private Static void archiveArticle(List<String> cmsIds) {
		List<sObject> articles = getOnlineVersionByCMSID(cmsIds);
		for(sObject article : articles) {
			KbManagement.PublishingService.archiveOnlineArticle((String)article.get('KnowledgeArticleId'),null);
		}
	}

	private static Map<String, List<String>> getListOfIds(List<GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor> narratives) {
		Map<String, List<String>> cmsIds = new Map<String, List<String>>();
		cmsIds.put(LANG_ENGLISH, new List<String>());
		cmsIds.put(LANG_SPANISH, new List<String>());
		for(GSA_FCIC_KDBArticles_WSParser.narrativeDescriptor n :narratives) {
			String language = getLanguage(n.language);
			if(language == LANG_ENGLISH) {
				cmsIds.get(LANG_ENGLISH).add(n.id);
			} else {
				cmsIds.get(LANG_SPANISH).add(n.id);
			}
			
		}

		return cmsIds;
	}

	private static void editArticles(Map<String,CMS_Content_Article> content, String language)
	{
		System.debug('beginning of editArticles');
		List<String> draftIds = new List<String>();
		Map<String, CMS_Content_Article> cmsContentMap = new Map<String,CMS_Content_Article>();
		List<String> existingDrafts = new List<String>(); // new
		for(String articleId : content.keySet())
		{
			String draftId;
			try {
				System.debug('articleId = ' + articleId);
				System.debug('article = ' + content.get(articleId));
				draftId = KbManagement.PublishingService.editOnlineArticle(articleId, false); // fails if a draft already exists :O
			} catch (Exception e){
				GSA_FCIC_KBArticles_Exception excep = new GSA_FCIC_KBArticles_Exception(e.getMessage(),e);
				excep.createExceptionRecord(' | KbManagement.PublishingService.editOnlineArticle | CMS ID = ' + content.get(articleId), language + ' TRYING ANYWAYS');
			}
			draftIds.add(draftId);
			content.get(articleId).article_Vid = draftId;
			cmsContentMap.put(content.get(articleId).cms_Id, content.get(articleId));
		}
		String query = getArticleQuery(language)+' WHERE Id in: draftIds FOR UPDATE';
		List<sObject> drafts = Database.Query(query);
		
		for(sObject draft : drafts)
		{
			System.debug('^^__^^__^^__^^__^^');
			CMS_Content_Article updates = cmsContentMap.get((String)draft.get(getArticleIdField(language)));
			System.debug('999999999999999999');
			setArticleFields(draft, updates, language);
		}

		System.debug('right before assigndatacategories in editArticles');

		update drafts;
	}

	private static void assignDataCategories(Map<String,CMS_Content_Article> cmsArticles, List<String> articleIds, String language)
	{
		Map<String, String> dataCategoryMap = getDataCategories();
		System.debug('inside assignDataCategories = '+ articleIds );
		String query = getArticleQuery(language)+' WHERE KnowledgeArticleId in :articleIds and Language = \'en_US\' and isLatestVersion = true and PublishStatus = \'Draft\'';
		List<sObject> lstArt = Database.Query(query);
		List<sObject> categories = getArticleTypeCategoryListRecord(language);
		List<CMS_Content_Article> ccaList = cmsArticles.values();
		for(CMS_Content_Article cca : ccaList){
			System.debug('~~~!!!' + cca.article_Id);
		}
		for(sObject article : lstArt)
		{
			if(cmsArticles.containsKey((String)article.get(getArticleIdField(language))))
			{
				CMS_Content_Article currentInfo = cmsArticles.get((String)article.get(getArticleIdField(language)));
				if(currentInfo.dataCategories != null && currentInfo.dataCategories.size() > 0)
				{
					for(DataCategory datcat : currentInfo.dataCategories){
						// CLC addition
						if(dataCategoryMap.containsKey(datcat.categoryLabel)){
						// end CLC
							String dataCategoryApiName = dataCategoryMap.get(datcat.categoryLabel);
							sObject categorySelected = getArticleTypeCategoryRecord(language);
							categorySelected.put('ParentId', article.Id);
							categorySelected.put('DataCategoryGroupName', datcat.categoryGroup);
							categorySelected.put('DataCategoryName', dataCategoryApiName);
							categories.add(categorySelected);
						} else if (datcat.categoryLabel == null || datcat.categoryLabel.equals('')){
							// do nothing; this is valid and we want to create it without writing an exception and without trying to associate a data category
						} else{ 
							// CLC
							String errorMessage = '\'' + datcat.categoryLabel + '\' - This data category does not exist. ArticleId = ' + article.Id;
							if(article instanceOf Usa_gov__kav) {
								errorMessage += ' | USA.gov | CMSId = ' + ((Usa_gov__kav) article).USA_gov_Article_Id__c;
							}
							else if(article instanceOf GobiernoUSA_gov__kav){
								errorMessage += ' | GobiernoUSA.gov | CMSId = ' + ((GobiernoUSA_gov__kav) article).GobiernoUSA_gov_Article_ID__c;
							}
							GSA_FCIC_KBArticles_Exception excep = new GSA_FCIC_KBArticles_Exception(errorMessage);
							excep.createExceptionRecord('', '');
							// end CLC
						}
					}
				}
			}
		}
		
		Database.SaveResult[] srList = Database.insert(categories, false);

	}

	private static Map<String, String> getDataCategories(){
		Map<String, String> dataCategoryMap = new Map<String, String>();

		List<String> objStringList = new List<String>{'KnowledgeArticleVersion'};
		List<Schema.DescribeDataCategoryGroupResult> dataGroups = Schema.describeDataCategoryGroups(objStringList);
		List<DataCategoryGroupSobjectTypePair> pairs = new List<DataCategoryGroupSobjectTypePair>();
		for(Schema.DescribeDataCategoryGroupResult singleResult : dataGroups){
			if(singleResult.getName().equals('USA_gov') || singleResult.getName().equals('GobiernoUSA_gov')){
				DataCategoryGroupSobjectTypePair p = new DataCategoryGroupSobjectTypePair();
				p.setSobject(singleResult.getSobject());
				p.setDataCategoryGroupName(singleResult.getName());
				pairs.add(p);
			}
		}

		List<DescribeDataCategoryGroupStructureResult> describeCategoryStructureResult = Schema.describeDataCategoryGroupStructures(pairs, false);

		for(DescribeDataCategoryGroupStructureResult groupStructure : describeCategoryStructureResult){    
	
			//Get the top level categories
			Schema.DataCategory[] toplevelCategories = groupStructure.getTopCategories();
			
			//Recursively get all the categories
			List<Schema.DataCategory> allCategories = getAllCategories(toplevelCategories);
			
			for(Schema.DataCategory category : allCategories) {
				//Get the name of the category
				dataCategoryMap.put(category.getLabel(), category.getName());
				
				//Get the list of sub categories in the category
				Schema.DataCategory[] childCategories = category.getChildCategories();

				if(childCategories != null){
					for(Integer i = 0; i < childCategories.size(); i++){
						dataCategoryMap.put(childCategories[i].getLabel(), childCategories[i].getName());
					}
				}
			}
		}

		return dataCategoryMap;
	}

	private static Schema.DataCategory[] getAllCategories(Schema.DataCategory [] categories){
		if(categories.isEmpty()){
			return new Schema.DataCategory[]{};
		} else {
			Schema.DataCategory[] categoriesClone = categories.clone();
			Schema.DataCategory category = categoriesClone[0];
			Schema.DataCategory[] allCategories = new Schema.DataCategory[]{category};
			categoriesClone.remove(0);
			categoriesClone.addAll(category.getChildCategories());
			allCategories.addAll(getAllCategories(categoriesClone));
			return allCategories;
		}
	}

	private static sObject getArticleTypeCategoryRecord(String language) {
		if(language == LANG_ENGLISH) {
			return new USA_gov__DataCategorySelection();
		} else {
			return new GobiernoUSA_gov__DataCategorySelection();
		}
	}

	private static list<sObject> getArticleTypeCategoryListRecord(String language) {
		if(language == LANG_ENGLISH) {
			return new List<USA_gov__DataCategorySelection>();
		} else {
			return new List<GobiernoUSA_gov__DataCategorySelection>();
		}
	}

	private static List<String> insertKBArticles(List<sObject> articles, String language)
	{
		List<String> articleIds = new List<String>();
		try {
			insert articles; // (E)
		} catch (Exception e){
			GSA_FCIC_KBArticles_Exception excep = new GSA_FCIC_KBArticles_Exception(e.getMessage(),e); // (A)
			excep.createExceptionRecord(' | INSERT | articles = ' + articles, 'language = ' + language);
		}
		List<String> versionIds = new List<String> ();
		for(sObject version : articles)
		{
			versionIds.add((String)version.get('Id'));
		}
		String query = getArticleQuery(language) +' WHERE Id in :versionIds';
		List<sObject> lstArt = Database.Query(query);
		for(sObject art : lstArt){
			articleIds.add((String)art.get('KnowledgeArticleId'));
		}
		return articleIds;
	}

	private static Void publishArticles(List<String> articleIds, Boolean flagAsNew){
	 System.debug('###########'+articleIds);
		for(String articleId : articleIds)
		{
			KbManagement.PublishingService.publishArticle(articleId, flagAsNew);
			System.debug('$$$$$$$$$$$'+articleId);
		}
	}

	private static Boolean validateArticles(List<CMS_Content_Article> articles)
	{
		for(CMS_Content_Article article : articles)
		{
			if(article.validateArticle())
				return false;
		}
		return true;
	}
}