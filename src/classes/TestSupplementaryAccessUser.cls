@isTest (SeeAllData=true)
public class TestSupplementaryAccessUser{

	static testmethod void testSupplementaryAccessUserGranterApprvlStep(){
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> existingStandardUsers = ControlledDocumentTestUtility.getStandardUsersWithDelegatedApprovers(2);
		User testUser1 = existingStandardUsers.get(0);
		User testUser2 = existingStandardUsers.get(1);

		// 4 queries - 9/4/2015 
		System.debug('#1 OF QUERIES SO FAR = ' + Limits.getQueries());

		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;

			// 7 queries - 9/4/2015
			System.debug('#2 OF QUERIES SO FAR = ' + Limits.getQueries());

			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			// 11 queries - 9/4/2015
			System.debug('#3 OF QUERIES SO FAR = ' + Limits.getQueries());

			Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.Id, '1', testUser2.Id);
			insert step;

			// 25 queries - 9/4/2015
			System.debug('#4 OF QUERIES SO FAR = ' + Limits.getQueries());

			step = [
				SELECT Id, Marked_for_Deletion__c 
				FROM Approval_Step__c 
				WHERE Correspondence_Document__c = :controlDoc.Id
				AND Sequence__c = '1'
			];

			////////////////////
			Test.startTest();
			////////////////////

			ControlledDocumentTestUtility.initiateApprovalStep(step.Id);

			// 54 queries (without Test.startTest()/Test.stopTest()) - 9/4/2015
			System.debug('#5 OF QUERIES SO FAR = ' + Limits.getQueries());

			ControlledDocumentTestUtility.recallApprovalStep(step.Id);

			////////////////////
			Test.stopTest();
			////////////////////

			// 80 queries (without Test.startTest()/Test.stopTest()) - 9/4/2015
			System.debug('#6 OF QUERIES SO FAR = ' + Limits.getQueries());

			step.Marked_for_Deletion__c = true;
			update step;

			// Never make it here due to, "Too many SOQL queries: 101" (without Test.startTest()/Test.stopTest()) - 9/4/2015
			System.debug('#7 OF QUERIES SO FAR = ' + Limits.getQueries());

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);

			System.debug('EXISTINGLINKS == ' + existingLinks);
			System.assertEquals(1, existingLinks.size());
		}

	}

	static testmethod void testSupplementaryAccessUserGranterQuickShare(){

		ControlledDocumentTestUtility.createRequiredChatterGroups();
		List<User> existingStandardUsers = ControlledDocumentTestUtility.getStandardUsersWithDelegatedApprovers(3);
		User testUser1 = existingStandardUsers.get(0);
		User testUser2 = existingStandardUsers.get(1);
		User testUser3 = existingStandardUsers.get(2);

		System.runAs(testUser2){

			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;

			Feeditem post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			/////////////////////
			Supplementary_Access_User__c supplement = new Supplementary_Access_User__c();
			supplement.Active__c = true;
			supplement.Controlled_Document__c = controlDoc.Id;
			insert supplement;
			/////////////////////

			SupplementaryAccessUserGranterQuickShare.addShareForQuickShareUser(controlDoc.Id, testUser1.Id, new Set<Id>{testUser2.Id}, false);

			SupplementaryAccessUserGranterQuickShare.disableShareForQuickShareUser(controlDoc.Id, testuser1.Id, new Set<Id>{}, false);

		}

		System.assert(true); // TODO:

	}

	static testmethod void testSupplementaryAccessUserGranterQuickShareEXECSEC(){

		ControlledDocumentTestUtility.createRequiredChatterGroups();
		List<User> existingStandardUsers = ControlledDocumentTestUtility.getStandardUsersWithDelegatedApprovers(3);
		User testUser1 = existingStandardUsers.get(0);
		User testUser2 = existingStandardUsers.get(1);
		User testUser3 = existingStandardUsers.get(2);

		System.runAs(testUser2){

			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;

			Feeditem post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;
			
			SupplementaryAccessUserGranterQuickShare.addShareForQuickShareUser(controlDoc.Id, testUser1.Id, new Set<Id>{testUser2.Id}, true);

			SupplementaryAccessUserGranterQuickShare.disableShareForQuickShareUser(controlDoc.Id, testuser1.Id, new Set<Id>{}, true);
		
		}

		System.assert(true); // TODO:

	}

	static testmethod void testSupplementaryAccessUserGranterUser(){
		
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		List<User> existingStandardUsers = ControlledDocumentTestUtility.getStandardUsersWithDelegatedApprovers(3);
		User testUser1 = existingStandardUsers.get(0);
		User testUser2 = existingStandardUsers.get(1);
		User testUser3 = existingStandardUsers.get(2);

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;

		Approval_Step__c step = new Approval_Step__c();
		step.Correspondence_Document__c = controlDoc.Id;
		step.Assigned_Approver__c = testUser1.Id;
		insert step;

		////////////////////
		Test.startTest();
		////////////////////

		ControlledDocumentTestUtility.initiateApprovalStep(step.Id);

		////////////////////
		Test.stopTest();
		////////////////////

		Supplementary_Access_User__c supplement = new Supplementary_Access_User__c();
		supplement.Active__c = true;
		supplement.Controlled_Document__c = controlDoc.Id;
		supplement.User__c = testUser1.Id;
		supplement.Originating_User__c = testUser3.Id;
		supplement.Origin__c = 'Quick Share';
		insert supplement;

		testUser1.DelegatedApproverId = testUser2.Id;
		update testUser1;

		System.assert(true); // TODO:

	}

	static testmethod void testSupplementaryAccessUserTrigger(){

		ControlledDocumentTestUtility.createRequiredChatterGroups();
		List<User> existingStandardUsers = ControlledDocumentTestUtility.getStandardUsersWithDelegatedApprovers(2);
		User testUser1 = existingStandardUsers.get(0);
		User testUser2 = existingStandardUsers.get(1);

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;

		Supplementary_Access_User__c supplement = new Supplementary_Access_User__c();
		supplement.Active__c = true;
		supplement.Controlled_Document__c = controlDoc.Id;
		insert supplement;

		delete supplement;

		List<Supplementary_Access_User__c> supplementList = [SELECT Id FROM Supplementary_Access_User__c WHERE Controlled_Document__c = :controlDoc.Id];

		System.assertEquals(0, supplementList.size());

	}

}