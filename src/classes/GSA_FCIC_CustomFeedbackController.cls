global with sharing class GSA_FCIC_CustomFeedbackController {

	public boolean createdFeedback {get; set;}
	public Case newFeedback {get; set;}
	private String errorMessage;

	public GSA_FCIC_CustomFeedbackController(){
		initateFeedbackObject();
	}

	public void backToCreateMoreFeedback(){
		initateFeedbackObject();
	}

	public void saveFeedback(){
		try{
			if(!populateArticleURL()){
				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, errorMessage));
			} else {
				Database.DMLOptions dmlo = new Database.DMLOptions();
				dmlo.AssignmentRuleHeader.useDefaultRule = true;
				Database.insert(newFeedback, dmlo);
				createdFeedback = true;
			}
		}
		catch (DmlException e){
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error inserting feedback: ' + e.getMessage()));
		}
	}

	private void initateFeedbackObject(){
		createdFeedback = false;
		newFeedback = new Case();
		newFeedback.RecordTypeId = getContentFeedbackRecordType();
		newFeedback.Origin = 'Web';
	}

	private boolean populateArticleURL(){
		String s = newFeedback.Article__c;
		if (String.isBlank(s) || String.isBlank(newFeedback.Feedback_Comments__c)) {
			errorMessage = 'Please fill out all required fields.';
			return false;
		} else {
			List<KnowledgeArticleVersion> kavList = [
				SELECT Id, UrlName, Title, ArticleType
				FROM KnowledgeArticleVersion
				WHERE PublishStatus = 'Online'
				AND Language = 'en_US'
				AND Title = :s];
			if(kavList.size() == 0){
				newFeedback.Article__c = null;
			} else {
				KnowledgeArticleVersion kav = kavList.get(0);
				String articleType = ((String)kav.ArticleType).replace('__kav','');
				newFeedback.Article__c = '<b><a href="/articles/en_US/' + articleType + '/' +	kav.UrlName + '">' + kav.Title + '</a></b>';
			}
			return true;
		}
	}

	private String getContentFeedbackRecordType(){
		List<RecordType> rtList = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'Content Feedback'];
		if(rtList.size() == 0){
			return '';
		}
		return rtList.get(0).Id;
	}

	@RemoteAction
	global static List<KnowledgeArticleVersion> getArticles(String name){
		String likeString = '%' + name + '%';
		return [
			SELECT Id, UrlName, Title
			FROM KnowledgeArticleVersion
			WHERE PublishStatus = 'Online'
			AND Language = 'en_US'
			AND Title
			LIKE :likeString
			LIMIT 10];
	}

	@RemoteAction
	global static String getCaseNumber(String id){
		List<Case> caseList = [SELECT Id, CaseNumber FROM Case WHERE Id = :id];
		if(caseList.size() != 0){
			return caseList.get(0).CaseNumber;
		} else {
			return '';
		}
	}

}