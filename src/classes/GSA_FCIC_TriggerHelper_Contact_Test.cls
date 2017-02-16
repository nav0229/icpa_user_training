@isTest
public class GSA_FCIC_TriggerHelper_Contact_Test{

	private final static String CONTACT_TYPE = 'FCIC_Individual';
	private final static String DUPE_CONTACT_TYPE = 'FCIC_Duplicate';

	static testMethod void validateCreateAccount(){
		Test.startTest();

		createTriggerCustomSettings();
		RecordType rt = getRecordTypeForContact();

		Contact contact = new Contact();
		contact.RecordTypeId = rt.Id;
		contact.FirstName = 'Test';
		contact.LastName = 'User';
		contact.Phone = '1234567890';
		contact.Email = 'a@b.com';
		insert contact;

		Account account = [SELECT Id FROM Account
						WHERE Name = 'Test User'
						AND Phone = '1234567890'
						AND Email__c = 'a@b.com'];

		System.assertNotEquals(account, null);

		Test.stopTest();
	}

	static testMethod void validateUpdateAccount(){
		Test.startTest();

		createTriggerCustomSettings();
		RecordType rt = getRecordTypeForContact();

		Contact contact = new Contact();
		contact.RecordTypeId = rt.Id;
		contact.FirstName = 'Test';
		contact.LastName = 'User';
		contact.Phone = '1234567890';
		contact.Email = 'a@b.com';
		insert contact;

		Account account = [SELECT Id FROM Account
						WHERE Name = 'Test User'
						AND Phone = '1234567890'
						AND Email__c = 'a@b.com'];

		contact = [SELECT Id, FirstName, LastName, Phone, Email, AccountId
					FROM Contact
					WHERE FirstName = 'Test'
					AND LastName = 'User'
					AND Phone = '1234567890'
					AND Email = 'a@b.com'];

		contact.Email = 'b@c.com';
		update contact;

		System.assertEquals(contact.AccountId, account.Id);

		Test.stopTest();
	}

	static testMethod void validateDedupContact(){
		Test.startTest();

		createTriggerCustomSettings();
		RecordType rt = getRecordTypeForContact();
		RecordType dupeRt = getDuplicateRecordType();

		Contact contactOne = new Contact();
		contactOne.RecordTypeId = rt.Id;
		contactOne.FirstName = 'Test';
		contactOne.LastName = 'User';
		contactOne.Phone = '1234567890';
		contactOne.Email = 'a@b.com';
		insert contactOne;

		Contact contactTwo = new Contact();
		contactTwo.RecordTypeId = rt.Id;
		contactTwo.FirstName = 'Test';
		contactTwo.LastName = 'User';
		contactTwo.Phone = '1234567890';
		contactTwo.Email = 'a@b.com';
		insert contactTwo;

		List<Contact> contactList = [SELECT Id, RecordTypeId FROM Contact
									WHERE FirstName = 'Test'
									AND LastName = 'User'
									AND Phone = '1234567890'
									AND Email = 'a@b.com'];

		System.assertEquals(2, contactList.size());

		System.assertNotEquals(contactList[0].RecordTypeId, contactList[1].RecordTypeId);

		Test.stopTest();
	}

	private static void setupTestData(){
		System.assertEquals(1,1);
		createTriggerCustomSettings();
		getRecordTypeForContact();
	}

	private static RecordType getRecordTypeForContact(){
		return [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Contact' AND DeveloperName = :CONTACT_TYPE LIMIT 1];
	}

	private static RecordType getDuplicateRecordType(){
		return [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Contact' AND DeveloperName = :DUPE_CONTACT_TYPE LIMIT 1];
	}

	private static void createTriggerCustomSettings(){
		TriggerControls__c contactTrigger = new TriggerControls__c();
		contactTrigger.Name = 'Contact';
		contactTrigger.On__c = true;
		insert contactTrigger;
	}

}