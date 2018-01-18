@isTest
public with sharing class SDChatterFeedItemHelperTest {

	public static testMethod void testFeedItemInsert_AgencyProtestFeedItemInsertedWithoutAttachment_FeedItemInsertedSuccessfully(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c WHERE CreatedDate = TODAY];

		FeedItem item = new FeedItem();
		item.Type = 'TextPost';
		item.ParentId = apCase.Id;
		item.Body = 'AAAA';
		try {
			insert item;
		} catch (Exception e){
			System.assert(false, 'Problem inserting feed item for Agency Protest case. This should have succeeded without issue.');
		}
		System.assert(true);
	}

	public static testMethod void testFeedItemInsert_AgencyProtestFeedItemInsertedWithAttachment_FeedItemThrowsError(){
		Agency_Protest_Case__c apCase = [SELECT Id FROM Agency_Protest_Case__c WHERE CreatedDate = TODAY];

		FeedItem item = new FeedItem();
		item.Type = 'ContentPost';
		item.ParentId = apCase.Id;
		item.Body = 'AAAA';
		try {
			insert item;
		} catch (Exception e){
			System.assert(true);
			return;
		}
		System.assert(false, 'An error should have been thrown while inserting an attaching on to the feed of an Agency Protest Case.');
	}

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