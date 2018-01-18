/**
	Test class for CreateUpdateAccountHandler class

	@author	Acumen Solutions
	@since	11/10/2014
*/

@isTest
private class TestCreateUpdateAccountHandler {
	@isTest
	 static void testContactNoAccount() {
    	ID indRecTypeID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
		ID accRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
		
		List<Contact> lstCon = new List<Contact>();
    	Contact c = new Contact();
    	c.FirstName = 'FirstName';
		c.LastName = 'LastName';
		c.MailingStreet = '1600 Pennsylvania Ave';
		c.MailingPostalCode = '20500';
		c.Email = 'test@test.com';
		c.RecordTypeId = indRecTypeID;		
		
		Test.startTest();
			insert c;
			lstCon.add(c);
			CreateUpdateAccountHandler.createOrAssociateAccount(lstCon);
		Test.stopTest();
		system.assertEquals(true, lstCon.size() >0);
		
    }
    
    @isTest
    static void testContactwithAccount() {
    	ID indRecTypeID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
		ID accRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
    	
    	Account a = new Account();
		a.Name = 'FirstName-LastName';
		
		insert a; 
    	
		List<Contact> lstCon = new List<Contact>();
    	Contact c = new Contact();
    	c.FirstName = 'FirstName';
		c.LastName = 'LastName';
		c.MailingStreet = '1600 Pennsylvania Ave';
		c.MailingPostalCode = '20500';
		c.Email = 'test@test.com';
		c.RecordTypeId = indRecTypeID;
		c.AccountId = a.Id;
		
		Test.startTest();
			insert c;
			lstCon.add(c);
			CreateUpdateAccountHandler.createOrAssociateAccount(lstCon);
		Test.stopTest();
		system.assertEquals(true, lstCon.size() >0);
		
		
    }
  
}