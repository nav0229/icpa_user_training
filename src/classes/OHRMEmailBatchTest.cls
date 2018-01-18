@isTest
private class OHRMEmailBatchTest {
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
	
	@isTest static void test_method_one() {
		
		Id devRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();

		//Create a contact data
		Contact testCon = new Contact();
		testCon.LastName ='Test';
		testCon.Person_Start_Date__c=system.today()-2;
		testCon.Affiliation__c = 'Government';
		testCon.Affiliation_Copy__c='Government';
		testCon.MAJOR_ORG__c='M';
		testCon.RecordTypeId=devRecordTypeId;
		testCon.Email='Test@gsa.gov';
		testCon.Start_Date_Email_Initiation__c=system.today()-1;
		testCon.isActive__c = true;
		//testCon.OHRM_Last_Email_Sent__c = false;
		Insert testCon;
		//Create a Task
		Task t = new Task();
		t.OwnerId = UserInfo.getUserId();
        t.Subject='Welcome';
        t.whoId= testCon.id;
        insert t;
		system.assertEquals('Test@gsa.gov',testCon.email);

		//Contact con = [select id,Start_Date_Email_Initiation__c from Contact where id=:testCon.id];
		//system.assertEquals(system.today(),testcon.Start_Date_Email_Initiation__c);
		//system.assertEquals(system.today(),testCon.Person_Start_Date__c);
		system.assertEquals('Government',testCon.Affiliation_Copy__c);
		system.assertEquals('M',testCon.MAJOR_ORG__c);
		system.assertEquals(devRecordTypeId,testCon.RecordTypeId);
		//system.assertEquals(false,testCon.OHRM_Last_Email_Sent__c);

		//Create custom setting data
		List<OHRM__c> lstTesting = new List<OHRM__c>();
		OHRM__c objCust;

		objCust = new OHRM__c(Name ='Email 1',Email_Sending_Day__c=1.0,Email_Template_Name__c='OHRM - Welcome Email');
		lstTesting.add(objCust);
		objCust = new OHRM__c(Name ='Email 2',Email_Sending_Day__c=2.0,Email_Template_Name__c='OHRM - Transit Subsidy');
		lstTesting.add(objCust);
		objCust = new OHRM__c(Name ='Email 3',Email_Sending_Day__c=3.0,Email_Template_Name__c='OHRM - Meetings and Meeting Tools');
		lstTesting.add(objCust);
		objCust = new OHRM__c(Name ='Email 4',Email_Sending_Day__c=4.0,Email_Template_Name__c='OHRM - Two Factor Authentication');
		lstTesting.add(objCust);
		objCust = new OHRM__c(Name ='Email 5',Email_Sending_Day__c=5.0,Email_Template_Name__c='OHRM - Mobile Technologies');
		lstTesting.add(objCust);
		insert lstTesting;
		
		//Retrieving the email template created in datasetup method
		List<EmailTemplate> emailTmp = [select id from EmailTemplate where Name IN ('OHRM - Welcome Email','OHRM - Transit Subsidy','OHRM - Meetings and Meeting Tools')];
		system.assertEquals(3,emailTmp.size());

		
		
		Test.startTest();
		String jobId = System.schedule('ScheduleOHRMEmailBatch',CRON_EXP,new OHRMEmailScheduler());
		Test.stopTest();
	}
}