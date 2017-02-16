@isTest
private class GSA_FCIC_KDBArticles_ServiceTest {

	static testMethod void testPublishService() {
	  
	  //KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');   
		KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3);
		insert kbSync ;
		system.assert(kbSync.API_Key__c == '1234');
		test.starttest();
		Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(200,'Sucess',GSA_FCIC_KDBArticles_TestGenerator.getPublishedResponse(100),null));
		DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
		GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,1);
		system.debug('testPublishService resp');
		system.debug(resp);
		GSA_FCIC_KDBArticles_Service.processNarratives(resp);

		List<USA_gov__kav> returnedArticles = [SELECT KnowledgeArticleId, Id, Language, USA_gov_Article_Id__c from USA_gov__kav WHERE Language = 'en_US' and isLatestVersion = true and PublishStatus = 'Online' and USA_gov_Article_Id__c = '100'];
		system.assertEquals(returnedArticles.size(), 1);
		test.stoptest();
	}

	static testMethod void testUpdateService() {
	  
	  	//KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');   
		KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3);
		insert kbSync ;

		USA_gov__kav article = new USA_gov__kav();
		article.USA_gov_Article_Id__c = '100';
		article.urlName = '100';
		article.Title = 'Test Article';
		insert article;

		List<USA_gov__kav> insertedArticle = [SELECT KnowledgeArticleId, Id, Language, USA_gov_Article_Id__c from USA_gov__kav WHERE Id = :article.Id];

		system.assertEquals(insertedArticle.size(), 1);

		KbManagement.PublishingService.publishArticle(insertedArticle[0].KnowledgeArticleId, true);
		system.assert(kbSync.API_Key__c == '1234');
		test.starttest();
		Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(200,'Sucess',GSA_FCIC_KDBArticles_TestGenerator.getPublishedResponse(100),null));
		DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
		GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,1);
		system.debug('testUpdateService resp');
		system.debug(resp);
		GSA_FCIC_KDBArticles_Service.processNarratives(resp);

		List<USA_gov__kav> returnedArticles = [SELECT KnowledgeArticleId, Id, Language, USA_gov_Article_Id__c from USA_gov__kav WHERE Language = 'en_US' and isLatestVersion = true and PublishStatus = 'Online' and USA_gov_Article_Id__c = '100'];
		system.assertEquals(returnedArticles.size(), 1);
		test.stoptest();
	}

	static testMethod void testUpdateServiceSPANISH(){

		//KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');   
		KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3);
		insert kbSync ;

		GobiernoUSA_gov__kav article = new GobiernoUSA_gov__kav();
		article.GobiernoUSA_gov_Article_ID__c = '100';
		article.urlName = '100';
		article.Title = 'Test Article';
		insert article;

		List<GobiernoUSA_gov__kav> insertedArticle = [SELECT KnowledgeArticleId, Id, Language, GobiernoUSA_gov_Article_ID__c from GobiernoUSA_gov__kav WHERE Id = :article.Id];

		system.assertEquals(insertedArticle.size(), 1);

		KbManagement.PublishingService.publishArticle(insertedArticle[0].KnowledgeArticleId, true);
		system.assert(kbSync.API_Key__c == '1234');
		test.starttest();
		Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(200,'Sucess',GSA_FCIC_KDBArticles_TestGenerator.getPublishedResponseSPANISH(100),null));
		DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
		GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,1);
		system.debug('testUpdateService resp');
		system.debug(resp);
		GSA_FCIC_KDBArticles_Service.processNarratives(resp);

		List<GobiernoUSA_gov__kav> returnedArticles = [SELECT KnowledgeArticleId, Id, Language, GobiernoUSA_gov_Article_ID__c from GobiernoUSA_gov__kav WHERE Language = 'en_US' and isLatestVersion = true and PublishStatus = 'Online' and GobiernoUSA_gov_Article_ID__c = '100'];
		system.assertEquals(returnedArticles.size(), 1);
		test.stoptest();		
	}

	static testMethod void testArchiveService() {
	  
	  //KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');   
		KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3);
		insert kbSync ;

		USA_gov__kav article = new USA_gov__kav();
		article.USA_gov_Article_Id__c = '100';
		article.urlName = '100';
		article.Title = 'Test Article';
		insert article;

		List<USA_gov__kav> insertedArticle = [SELECT KnowledgeArticleId, Id, Language, USA_gov_Article_Id__c from USA_gov__kav WHERE Id = :article.Id];

		system.assertEquals(insertedArticle.size(), 1);

		KbManagement.PublishingService.publishArticle(insertedArticle[0].KnowledgeArticleId, true);
		system.assert(kbSync.API_Key__c == '1234');
		test.starttest();
		Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(200,'Sucess',GSA_FCIC_KDBArticles_TestGenerator.getArchivedResponse(100),null));
		DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
		GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,1);
		system.debug('testArchiveService resp');
		system.debug(resp);
		GSA_FCIC_KDBArticles_Service.processNarratives(resp);
		List<USA_gov__kav> returnedArticles = [SELECT KnowledgeArticleId, Id, Language, USA_gov_Article_Id__c from USA_gov__kav WHERE Language = 'en_US' and isLatestVersion = true and PublishStatus = 'Online' and USA_gov_Article_Id__c = '100'];
		system.assertEquals(returnedArticles.size(), 0);

		test.stoptest();
	}

}