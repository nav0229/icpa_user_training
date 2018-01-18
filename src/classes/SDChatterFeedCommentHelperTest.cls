@isTest
public with sharing class SDChatterFeedCommentHelperTest {

	public static testMethod void testFeedCommentInsert_AgencyProtestCommentInsertedWithoutAttachment_CommentInsertedSuccessfully(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c WHERE CreatedDate = TODAY];

		FeedItem item = new FeedItem();
		item.Type = 'TextPost';
		item.ParentId = apCase.Id;
		item.Body = 'AAAA';
		insert item;

		FeedComment comment = new FeedComment();
		comment.FeedItemId = item.Id;
		comment.CommentType = 'TextComment';
		comment.CommentBody = 'AAAAAAAAAAA';
		try {
			insert comment;
		} catch (Exception e){
			System.assert(false, 'There was a problem inserting a feed comment without an attachment on Suspension & Debarment record.');
			return;
		}
	}

	public static testMethod void testFeedCommentInsert_AgencyProtestCommentInsertedWithAttachment_CommentThrowsError(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c WHERE CreatedDate = TODAY];

		FeedItem item = new FeedItem();
		item.Type = 'TextPost';
		item.ParentId = apCase.Id;
		item.Body = 'AAAA';
		insert item;

		FeedComment comment = new FeedComment();
		comment.FeedItemId = item.Id;
		comment.CommentType = 'ContentComment';
		comment.CommentBody = 'AAAAAAAAAAA';
		try {
			insert comment;
		} catch (Exception e){
			System.assert(true); // error thrown, perfect
			return; // return ensures we don't hit the assert(false) below
		}
		System.assert(false, 'An attachment was allowed to upload via a comment on Suspension & Debarment record. This should have failed.');
	}

	/**
		The following commented out methods test the blocking of Suspension and Debarment records from having
		attachments attached in Chatter. These can't pass right now because currently the Suspension and Debarment
		records do not have 'feeds' enabled. If they are enabled you can use the below test methods to ensure things
		work as originally intended.
	 */

	/*public static testMethod void testFeedCommentInsert_SuspensionAndDebarmentCommentInsertedWithoutAttachment_CommentInsertedSuccessfully(){
		Suspension_and_Debarment_Case__c sdCase = [SELECT Id FROM Suspension_and_Debarment_Case__c WHERE CreatedDate = TODAY];

		FeedItem item = new FeedItem();
		item.Type = 'TextPost';
		item.ParentId = sdCase.Id;
		item.Body = 'AAAA';
		insert item;

		FeedComment comment = new FeedComment();
		comment.FeedItemId = item.Id;
		comment.CommentType = 'TextComment';
		comment.CommentBody = 'AAAAAAAAAAA';

		try {
			insert comment;
		} catch (Exception e){
			System.assert(false, 'There was a problem inserting a feed comment without an attachment on Suspension & Debarment record.');
			return;
		}
		System.assert(true);
	}*/

	/*public static testMethod void testFeedCommentInsert_SuspensionDebarmentCommentInsertedWithAttachment_CommentThrowsError(){
		Suspension_and_Debarment_Case__c sdCase = [SELECT Id FROM Suspension_and_Debarment_Case__c WHERE CreatedDate = TODAY];

		FeedItem item = new FeedItem();
		item.Type = 'TextPost';
		item.ParentId = sdCase.Id;
		item.Body = 'AAAA';
		insert item;

		FeedComment comment = new FeedComment();
		comment.FeedItemId = item.Id;
		comment.CommentType = 'ContentComment';
		comment.CommentBody = 'AAAAAAAAAAA';
		try {
			insert comment;
		} catch (Exception e){
			System.assert(true); // error thrown, perfect
			return; // return ensures we don't hit the assert(false) below
		}
		System.assert(false, 'An attachment was allowed to upload via a comment on Suspension & Debarment record. This should have failed.');
	}*/

	@testSetup static void createTestData(){

		Suspension_and_Debarment_Case__c sdCase;
		Agency_Protest_Case__c apCase;

		try {
			sdCase = new Suspension_and_Debarment_Case__c();
			insert sdCase;
		} catch (Exception e){
			System.assert(false, 'Problem while creating a Suspension and Debarment case. Were new validation rules added?');
			return;
		}

		try {
			apCase = new Agency_Protest_Case__c();
			insert apCase;
		} catch (Exception e){
			System.assert(false, 'Problem while creating an Agency Protest case. Were new validation rules added?');
			return;
		}

		// required due to other project's code - ChatterFileCollaboratorTH
		Controlled_Document_Admin__c cda = new Controlled_Document_Admin__c();
		cda.Name = 'ADMINUSER';
		cda.UserName__c = UserInfo.getUserName();
		insert cda;
	}

}