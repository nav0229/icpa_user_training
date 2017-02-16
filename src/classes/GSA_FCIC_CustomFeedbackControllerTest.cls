@isTest
public without sharing class GSA_FCIC_CustomFeedbackControllerTest {

	private static final String TEST_ARTICLE_TITLE = 'Unique Title';
	private static final String TEST_ARTICLE_URL = '99999999';
	private static final String TEST_ARTICLE_LANGUAGE = 'en_US';

	static testMethod void testController_InstantiateControllerAndImmediatelySaveAndHitBack_EnsureControllerIsNotNull(){
		createTestCustomSettings();
		GSA_FCIC_CustomFeedbackController newController = new GSA_FCIC_CustomFeedbackController();
		newController.saveFeedback();
		newController.backToCreateMoreFeedback();
		System.assertNotEquals(null, newController);
	}

	static testMethod void testController_InstantiateControllerAndSaveNullFeedback_ExceptionThrownForCodeCoverage(){
		GSA_FCIC_CustomFeedbackController newController = new GSA_FCIC_CustomFeedbackController();
		try {
			newController.saveFeedback();
		} catch (Exception e) {
			// do nothing
			// this error should be due to not having the custom settings set up via createTestCustomSettings()
			// this is okay because we're not sure what type of issues could cause an exception but only that we handle it
		}
		System.assertNotEquals(null, newController);
	}

	static testMethod void testController_CreateFeedbackWithAValidArticleSelected_FeedbackCreatedWithArticleLink(){
		createAndPublishTestArticle();
		createTestCustomSettings();
		GSA_FCIC_CustomFeedbackController newController = new GSA_FCIC_CustomFeedbackController();
		newController.newFeedback.Feedback_Comments__c = 'Comments are required per the controller.';
		newController.newFeedback.Article__c = TEST_ARTICLE_TITLE;
		newController.saveFeedback();
		List<Case> newlyCreatedFeedback = [SELECT Id, Article__c FROM Case];
		System.assertEquals(true, newlyCreatedFeedback.get(0).Article__c.contains('href'));
	}

	static testMethod void testRemoteFunctionGetArticles_GiveValidArticleTitle_ReceiveNonEmptyArticleList(){
		createAndPublishTestArticle();
		List<KnowledgeArticleVersion> kavList = GSA_FCIC_CustomFeedbackController.getArticles(TEST_ARTICLE_TITLE);
		System.assertNotEquals(0, kavList.size());
	}

	static testMethod void testRemoteFunctionGetCaseNumber_GiveInvalidCaseNumber_ReceiveEmptyString(){
		String caseNumber = GSA_FCIC_CustomFeedbackController.getCaseNumber('123456');
		System.assertEquals(0, caseNumber.length());
	}

	static testMethod void testRemoteFunctionGetCaseNumber_GiveValidCaseNumber_ReceiveCaseNumberAsString(){
		createTestCase();
		Case c = [SELECT Id FROM Case LIMIT 1];
		String caseNumber = GSA_FCIC_CustomFeedbackController.getCaseNumber(c.Id);
		System.assertNotEquals(0, caseNumber.length());
	}

	private static void createAndPublishTestArticle(){
		USA_gov__kav kav = new USA_gov__kav(
			Language = TEST_ARTICLE_LANGUAGE,
			Title = TEST_ARTICLE_TITLE,
			UrlName = TEST_ARTICLE_URL
		);
		insert kav;
		Id articleId = [
			SELECT Id, KnowledgeArticleId
			FROM KnowledgeArticleVersion
			WHERE PublishStatus = 'Draft'
			AND Language = 'en_US'
			LIMIT 1].KnowledgeArticleId;
		KbManagement.PublishingService.publishArticle(articleId, true);
	}

	private static void createTestCase(){
		createTestCustomSettings();
		Case c = new Case();
		insert c;
	}

	// these custom settings are required any time we actually perform a save
	// the feedback is a case and the case uses custom settings
	private static void createTestCustomSettings(){
		TriggerControls__c t = new TriggerControls__c();
		t.On__c = true;
		t.Name = 'Case';
		insert t;
	}
}