/*-------------------------------------------------------------------------------------------------*
  TestChatterFileCollaboratorTH
  Test class for the ChatterFileCollaboratorTH class. If tests are failing, make sure that the
  Collaboration Trigger Control Status custom setting is set to enable the triggers.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Stefan Maurer      12/04/2014    1.0       Created
 *-------------------------------------------------------------------------------------------------*/
@isTest (SeeAllData=true)
private class TestChatterFileCollaboratorTH {
	
	@isTest static void testInsertFeedItem() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
		
			Test.startTest();
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);
		}
		
		System.assertEquals(1, existingLinks.size(), 'Only 1 ContentDocumentLink should exist for this User');
		System.assertEquals('C', existingLinks.get(0).ShareType, 'ShareType should be \'C\' for Collaborator.');
	}

	@isTest static void testDisabledInsertFeedItem() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			ControlledDocumentTestUtility.insertCollaborationTriggerControl(true);
			
			Test.startTest();
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(0, existingLinks.size(), 'Creation of the Control Document Link should have been prevented due to the status of the CollaborationTriggerControl custom setting.');
	}

	@isTest static void testInsertApprovalStep() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			Supplementary_Access_User__c supplement = new Supplementary_Access_User__c();
			supplement.Active__c = true;
			supplement.Controlled_Document__c = controlDoc.Id;
			supplement.User__c = testUser2.Id;
			supplement.Originating_User__c = testUser1.Id;
			supplement.Origin__c = 'Quick Share';
			insert supplement;
		
			Test.startTest();
			insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(1, existingLinks.size(), 'Only 1 ContentDocumentLink should exist for this User');
		System.assertEquals('C', existingLinks.get(0).ShareType, 'ShareType should be \'C\' for Collaborator.');
	}

	@isTest static void testDisabledInsertApprovalStep() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;
			ControlledDocumentTestUtility.insertCollaborationTriggerControl(true);
		
			Test.startTest();
			insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(0, existingLinks.size(), 'Creation of the Control Document Link should have been prevented due to the status of the CollaborationTriggerControl custom setting.');
	}

	@isTest static void testUpdateApprovalStep() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(3);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		User testUser3 = exsitingStandardUsers.get(2);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			insert step;
		
			Test.startTest();
			step.Assigned_Approver__c = testUser3.id;
			update step;
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser3.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(1, existingLinks.size(), 'Only 1 ContentDocumentLink should exist for this User');
		System.assertEquals('C', existingLinks.get(0).ShareType, 'ShareType should be \'C\' for Collaborator.');
	}

	@isTest static void testDisabledUpdateApprovalStep() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(3);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		User testUser3 = exsitingStandardUsers.get(2);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			insert step;
			ControlledDocumentTestUtility.insertCollaborationTriggerControl(true);
		
			Test.startTest();
			step.Assigned_Approver__c = testUser3.id;
			update step;
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser3.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(0, existingLinks.size(), 'Creation of the Control Document Link should have been prevented due to the status of the CollaborationTriggerControl custom setting.');
	}

	@isTest static void testDeleteApprovalStep() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			insert step;
		
			Test.startTest();
			delete step;
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(1, existingLinks.size(), 'No links should remain for this user, as the step has been deleted.');
	}

	@isTest static void testDisabledDeleteApprovalStep() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;

			Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			insert step;
			ControlledDocumentTestUtility.insertCollaborationTriggerControl(true);
		
			Test.startTest();
			delete step;
			Test.stopTest();

			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser2.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(1, existingLinks.size(), 'Link should still exist because trigger logic should have been blocked.');
	}

	@isTest static void testUpdateControlledDocument() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(3);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		User testUser3 = exsitingStandardUsers.get(2);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;
			insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
		
			Test.startTest();
			controlDoc.OwnerId = testUser3.Id;
			update controlDoc;
			Test.stopTest();
		}
		System.runAs(testUser3){
			post = ControlledDocumentTestUtility.getFeedItem(post.id);
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser3.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(1, existingLinks.size(), 'Only 1 ContentDocumentLink should exist for this User, as the owner of the ControlledDocument.');
		System.assertEquals('C', existingLinks.get(0).ShareType, 'ShareType should be \'C\' for Collaborator.');
	}

	@isTest static void testDisabledUpdateControlledDocument() {
		ControlledDocumentTestUtility.createRequiredChatterGroups();
		FeedItem post;
		List<ContentDocumentLink> existingLinks;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(3);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		User testUser3 = exsitingStandardUsers.get(2);
		
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
			post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
			insert post;
			insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
			ControlledDocumentTestUtility.insertCollaborationTriggerControl(true);
		
			Test.startTest();
			controlDoc.OwnerId = testUser3.Id;
			update controlDoc;
			Test.stopTest();
		}

		System.runAs(testUser3){
			post = ControlledDocumentTestUtility.getFeedItem(post.id);
		}
		System.runAs(testUser1){
			ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
			existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(testUser3.id, contentVer.ContentDocumentId);
		}

		System.assertEquals(0, existingLinks.size(), 'Creation of the Control Document Link should have been prevented due to the status of the CollaborationTriggerControl custom setting.');
	}
	
}