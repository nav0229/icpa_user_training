/************************************************************************
    Unit Test UserTrigger
    -------------------------------------------------------------------
    Author                 Date         Version     Description
    -------------------------------------------------------------------
    
    Smitha Unnivelan       05/29/2014               
*************************************************************************/
@isTest
public class ChatterFeedToUserTest{
    /*
    static testMethod void testInsertUser(){
    
        List<User> newUsers = populateUser();
        
        insert newUsers;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
       
        List<String> serializedUsers = new List<String>();
        for(User user : newUsers){
            
            String serializedUser = JSON.serialize(user);
            serializedUsers.add(serializedUser);
       
        }
    
        System.runAs(thisUser) {
            Test.startTest();
            CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers,serializedUsers);
            Test.stopTest();
        }
        
        User queriedUser = [Select id, Name from User where Username =: 'donald@email.com'];
        
        Contact contactQueried = [Select LastName, Email from Contact where Email =: 'donald@email.com'];
        
        System.assertEquals('Donald Smith', queriedUser.Name);
        System.assertEquals('Smith', contactQueried.LastName);
        
        newUsers.get(0).FirstName = 'DonaldDuck';
        
        update newUsers;
        
        queriedUser = [Select id, Name from User where Username =: 'donald@e1mail.com'];
        
        System.assertEquals('DonaldDuck Smith', queriedUser.Name); 
        
    }
*/
    static testMethod void testInsertUser(){
        
        /*
        List<CollaborationGroup> cgList = [ SELECT Id FROM CollaborationGroup WHERE Name = 'Chatter Support and Training' ];
        if (cgList.isEmpty()) 
        {
            CollaborationGroup cg = new CollaborationGroup(
  				Name = 'Chatter Support and Training',
  				CollaborationType = 'Public'
			);
			insert cg;
        }
        */
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
        List<User> newUsers = testUsers;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        List<String> serializedUsers = new List<String>();
        for(User user : newUsers){
            String serializedUser = JSON.serialize(user);
            serializedUsers.add(serializedUser);
        }
        System.runAs(thisUser) {
        	TEST.startTest();
        	CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers,serializedUsers);
            TEST.stopTest();
        }
        /*
        User queriedUser = [Select id, Name from User where Username =: 'testContact1@gsa.testUser'];
        
        Contact contactQueried = [Select LastName, Email from Contact where Email =: 'testContact1@fake.com'];
        System.assertEquals('fN1 lN1', queriedUser.Name);
        System.assertEquals('lN1', contactQueried.LastName);
        
        newUsers.get(0).FirstName = 'fN1updated';
        
        update newUsers;
        
        queriedUser = [Select id, Name from User where Username =: 'testContact1@gsa.testUser'];
        
        System.assertEquals('fN1updated lN1', queriedUser.Name); 
*/
    }
    
    public static list<User> populateUser(){
       List<User> userReturned = new List<User>();
       User user = new User();
       user.Username='donald@e1mail.com';
       user.Alias='DS';
       user.CommunityNickname='DS';
       user.TimeZoneSidKey='GMT';
       user.LocaleSidKey='en_US';
       user.EmailEncodingKey = 'ISO-8859-1';
       Profile profile = [Select Id from Profile where Name = 'GSA Standard Salesforce User'];
       System.debug('Profile: '+profile.Id);
       user.ProfileId = profile.Id ;
       user.LastName='Smith';
       user.FirstName='Donald';
       user.Email='donald@email.com';
       user.LanguageLocaleKey = 'en_US';
       user.FederationIdentifier = '482a7bc9-82d0-472e-8334-9d40d8cgabcd';
       user.Affiliation__c = 'government';
       user.MAJOR_ORG__c = 'A'; 
       user.isActive = true;
       userReturned.add(user);  
       System.assert(!userReturned.isEmpty());    
       return userReturned;
    }
}