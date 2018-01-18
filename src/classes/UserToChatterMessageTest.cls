/*
    Created By - Damien Phillippi - 10/17/2011
    This Test class is meant to fail if the Groups/Users/Document do not exist in the Org.
    This way the code can only be deployed if those things exist
*/
@isTest(seeAllData=true)
private class UserToChatterMessageTest
{    
    static testMethod void userCreation()
    {
        
        /*
         User aUser = new User();
        aUser.UserName = 'abcd@email.com';
        aUser.LastName = 'dcba';
        aUser.email = 'abcd@email.com';
        aUser.alias = 'abcd';
        aUser.TimeZoneSidKey = 'America/New_York';
        aUser.EmailEncodingKey = 'ISO-8859-1';
        aUser.LanguageLocaleKey = 'en_US';
        aUser.LocaleSidKey = 'en_US';
        aUser.ProfileId = [select Id from Profile where Name = 'GSA Standard Platform User' limit 1].id;
		*/
        test.startTest();
        List<CollaborationGroup> cgList = [ SELECT Id FROM CollaborationGroup WHERE Name = 'Chatter Support and Training' ];
        if (cgList.isEmpty()) 
        {
            CollaborationGroup cg = new CollaborationGroup(
  				Name = 'Chatter Support and Training',
  				CollaborationType = 'Public'
			);
			insert cg;
        }
        
		Id accountRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'GSA Organization'].Id;
		Id userProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA Standard Salesforce User'].Id;

		Account testAccount = TestUtil.buildAccount('testAccount123', accountRtId);
		insert testAccount;
        
        //GSAAccountId
        App_Properties__c appPropertyAccountSetting = new App_Properties__c();
        appPropertyAccountSetting.Name = 'GSA Account Id123';
		appPropertyAccountSetting.Type__c = 'GSAAccountId';
        appPropertyAccountSetting.Value__c = testAccount.id;
		insert appPropertyAccountSetting;
        
		List<User> testUsers = new List<User>();
		for(Integer i = 1; i < 4; i++) {
			testUsers.add(TestUtil.buildUser(i, userProfileId, 'testContact' + i + '@fake.com'));
		}

        
        App_Properties__c appPropertyContactSetting = new App_Properties__c();
        appPropertyContactSetting.Name = 'Contact Record Type for GSA123';
		appPropertyContactSetting.Type__c = 'GSAContactRecordTypeId';
        appPropertyContactSetting.Value__c = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
		insert appPropertyContactSetting;        

        App_Properties__c appPropertyProfileSetting = new App_Properties__c();
        appPropertyProfileSetting.Name = 'GSA Standard Platform User123';
		appPropertyProfileSetting.Type__c = 'ContactSyncProfile';
        appPropertyProfileSetting.Value__c = 'GSA Standard Platform User';
		insert appPropertyProfileSetting;        
        
		// By-pass User Trigger
		//////PublicUserGroupHandler.disableGroupMemberRecalculation = true;
		//PublicUserGroupHandler.disableGroupMemberRecalculation = true;
		insert testUsers;
		System.assert(!testUsers.isEmpty());
		test.stopTest();
        
        //Makes sure User is following items correctly.
        //testFuture(aUser.Id);
    }
    //@future
    public static void testFuture(Id userId)
    {
        Test.startTest();
    //  System.assert([SELECT Id FROM CollaborationGroupMember WHERE MemberId =: userId AND CollaborationGroup.Name =: 'Chatter Support and Training'].size() == 1);
        //HERESystem.assert([SELECT Id FROM CollaborationGroupMember WHERE MemberId =: userId AND CollaborationGroup.Name =: 'GSA Central'].size() == 1);
        Id chattyId = [SELECT Id FROM User WHERE (Alias = 'Chatty' OR LastName = 'Chatty' OR CommunityNickName = 'Chatty') LIMIT 1].Id;
        System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: chattyId AND SubscriberId =: userId].size() == 1);
        //System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: userId AND SubscriberId =: chattyId].size() == 1);
        //HEREId docFollowId = [SELECT Id FROM ContentDocument WHERE Title = 'Chatter - Getting Started' LIMIT 1].Id;
        //HEREId docId = [Select c.Title, c.IsLatest, c.Id From ContentVersion c WHERE Title = 'Chatter - Getting Started' and isLatest=true].id;
        //HERESystem.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: docFollowId AND SubscriberId =: userId].size() == 1);
        //System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: docId AND SubscriberId =: userId].size() == 1);
        UserToChatterMessage.followUser(new Set<Id>{userId});
        Test.stopTest();
    }
    
   /* 
    @@@ 
    static testMethod void userUpdates()
    {
        User aUser = new User();
        aUser.UserName = 'abcd@email.com';
        aUser.LastName = 'dcba';
        aUser.email = 'abcd@email.com';
        aUser.alias = 'abcd';
        aUser.TimeZoneSidKey = 'America/New_York';
        aUser.EmailEncodingKey = 'ISO-8859-1';
        aUser.LanguageLocaleKey = 'en_US';
        aUser.LocaleSidKey = 'en_US';
        aUser.ProfileId = [select Id from Profile where Name = 'GSA Standard Platform User' limit 1].id;
        aUser.IsActive = false;
        test.startTest();
        insert aUser;
        test.stopTest();
        
        //Makes sure User is following items correctly.
        testFutureInactive(aUser.Id);
    }
    
    
    public static void testFutureInactive(Id userId)
    {
        System.assert([SELECT Id FROM CollaborationGroupMember WHERE MemberId =: userId AND CollaborationGroup.Name =: 'Chatter Support and Training'].size() == 0);
        System.assert([SELECT Id FROM CollaborationGroupMember WHERE MemberId =: userId AND CollaborationGroup.Name =: 'GSA Central'].size() == 0);
        Id chattyId = [SELECT Id FROM User WHERE (Alias = 'Chatty' OR LastName = 'Chatty' OR CommunityNickName = 'Chatty') LIMIT 1].Id;
        System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: chattyId AND SubscriberId =: userId].size() == 0);
        //System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: userId AND SubscriberId =: chattyId].size() == 0);
        Id docFollowId = [SELECT Id FROM ContentDocument WHERE Title = 'Chatter - Getting Started' LIMIT 1].Id;
        Id docId = [Select c.Title, c.IsLatest, c.Id From ContentVersion c WHERE Title = 'Chatter - Getting Started' and isLatest=true].id;
        System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: docFollowId AND SubscriberId =: userId].size() == 0);
        //System.assert([SELECT Id FROM EntitySubscription WHERE ParentId =: docId AND SubscriberId =: userId].size() == 0);
        
    }
   @@@
    */
}