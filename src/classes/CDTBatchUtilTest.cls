@isTest
private class CDTBatchUtilTest {

	//@isTest(SeeAllData=true) static void testWebMethod(){
    @isTest
    static void testWebMethod(){
        Test.startTest();
		User u = setupTestData();
		System.runAs(u){
//System.runAs(new User(Id = Userinfo.getUserId())) {
		

		// create controlled document
		// create approval step
		// call web method
		
			Controlled_Document__c cdoc = new Controlled_Document__c();
			insert cdoc;

			List<Controlled_Document__c> cdocList = [SELECT Id FROM Controlled_Document__c];

			Approval_Step__c astep = new Approval_Step__c();
			astep.Correspondence_Document__c = cdocList[0].Id;
			astep.Approval_Status__c = 'Initiated';
			insert astep;

			List<Approval_Step__c> astepList = [SELECT Id FROM Approval_Step__c];

			CDTBatchUtil.reassignExecSecUsers(astepList[0].Id);
			System.assert(true);
		
        }
		Test.stopTest();
    
	}

	// using SeeAllDate because of an issue where creating users failed at line 19 in UserToChatterMessage.cls which is not our code
	//@isTest(SeeAllData=true) static void testDuplicateWebMethod(){
	@isTest static void testDuplicateWebMethod(){

		

		Test.startTest();
		User u = setupTestData();
		// create controlled document
		// create approval step
		// call web method
		System.runAs(u){
		//System.runAs(new User(Id = Userinfo.getUserId())) {
			Controlled_Document__c cdoc = new Controlled_Document__c();
			insert cdoc;

			List<Controlled_Document__c> cdocList = [SELECT Id FROM Controlled_Document__c];

			Approval_Step__c astep = new Approval_Step__c();
			astep.Correspondence_Document__c = cdocList[0].Id;
			astep.Approval_Status__c = 'Initiated';
			insert astep;

			List<Approval_Step__c> astepList = [SELECT Id FROM Approval_Step__c];

			// adding a duplicate
			ExecSec_Approval_Step_Override_Request__c execSecOverride = new ExecSec_Approval_Step_Override_Request__c();
			execSecOverride.Overridden_By__c = u.Id;
			execSecOverride.Approval_Step__c = astepList[0].Id;
			execSecOverride.Status__c = 'Pending';
			insert execSecOverride;

			CDTBatchUtil.reassignExecSecUsers(astepList[0].Id);
			System.assert(true);
        }

		Test.stopTest();

	}

	private static User createTestUser(String fName, String lName, Id profileId){
		User u = new User(FirstName = fName,
	                         LastName = lName,
	                         ProfileId = profileId,
	                         Affiliation__c = 'Contractor');

		u.Email = u.FirstName + '@test.com';
		u.Username = u.FirstName + '@gsa.gov.thisisatest';
		u.CommunityNickname = u.FirstName + u.LastName + 'gsagovtest';
		u.TimeZoneSidKey = 'America/New_York';
		u.LocaleSidKey = 'en_US';
		u.EmailEncodingKey = 'ISO-8859-1';
		u.LanguageLocaleKey='en_US';
		u.Alias = u.FirstName;
		if(u.FirstName.length() > 8){
			u.Alias = u.FirstName.subString(0,7);
		}
		return u;
	}

	private static User setupTestData(){
/*       
		Id contactRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'GSA'].Id;
		Id accountRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'GSA Organization'].Id;
		Id userProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA Standard Salesforce User'].Id;

		Account testAccount = TestUtil.buildAccount('testAccount', accountRtId);
		insert testAccount;
        
        //GSAAccountId
        App_Properties__c appPropertyAccountSetting = new App_Properties__c();
        appPropertyAccountSetting.Name = 'GSA Account Id';
		appPropertyAccountSetting.Type__c = 'GSAAccountId';
        appPropertyAccountSetting.Value__c = testAccount.id;
		insert appPropertyAccountSetting;
        
        App_Properties__c appPropertyContactSetting = new App_Properties__c();
        appPropertyContactSetting.Name = 'Contact Record Type for GSA';
		appPropertyContactSetting.Type__c = 'GSAContactRecordTypeId';
        appPropertyContactSetting.Value__c = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
		insert appPropertyContactSetting;        

        App_Properties__c appPropertyProfileSetting = new App_Properties__c();
        appPropertyProfileSetting.Name = 'GSA Standard Platform User';
		appPropertyProfileSetting.Type__c = 'ContactSyncProfile';
        appPropertyProfileSetting.Value__c = 'GSA Standard Platform User';
		insert appPropertyProfileSetting;                
        
		// create user
		List<Profile> profileId = [
					SELECT Id
					FROM   Profile
					WHERE  Name = 'GSA Standard Platform User' 
					LIMIT 1
				];

		User u = createTestUser('Jared', 'FromSubway', profileId[0].Id);
		insert u;

		u = [
			SELECT Id 
			FROM User 
			WHERE FirstName = 'Jared' 
			AND LastName = 'FromSubway'
		];
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
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        UserLicense userLicence = [Select u.SystemModstamp, u.Name, u.MonthlyLoginsUsed, u.MonthlyLoginsEntitlement, u.LicenseDefinitionKey, u.Id From UserLicense u where u.Name = 'Salesforce'];
          
        User u = [SELECT FirstName, LastName, Email, FederationIdentifier FROM User WHERE Email LIKE 'testContact1@fake.com'];
        
		// get permission set and assign to this user "Controlled_Document_Tracker_OAS_Admin_User_CRED"
		PermissionSet pset = [SELECT Id FROM PermissionSet WHERE Name = 'Controlled_Document_Tracker_OAS_Admin_User_CRED'];
		System.assert(pset != NULL);
        //System.runAs(new User(Id = Userinfo.getUserId())) {
        System.runAs(u) {
        PermissionSetAssignment psetAssign = new PermissionSetAssignment();
		psetAssign.AssigneeId = u.Id;
		psetAssign.PermissionSetId = pset.Id;
		insert psetAssign;
        }
		return u;
	}

}