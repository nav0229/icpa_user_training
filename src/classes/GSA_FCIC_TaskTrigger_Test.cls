@isTest
public class GSA_FCIC_TaskTrigger_Test{

	static testMethod void GSAFCICTaskTriggerTest(){
		TriggerControls__c triCon1 = new TriggerControls__c(Name = 'Task',On__c= true); insert triCon1;
		TriggerControls__c triCon2 = new TriggerControls__c(Name = 'Case',On__c= true); insert triCon2;
		TriggerControls__c triCon3 = new TriggerControls__c(Name = 'Contact',On__c= true); insert triCon3;
		Id recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('GSA.gov').getRecordTypeId();
		Case  cas = new Case(RecordTypeId = recTypeId,Avaya_UCID__c ='00001099181418922543',Call_Topic__c = 'Start a Business', Tier_2_Subject__c = 'Test Subject',Status = 'TRANSFER_TO_TIER2',Customer_First_Name__c = 'Test',Customer_Last_Name__c = 'User',Customer_Email_address__c = 'testuser@gmail.com',Customer_Phone__c = '0123456789'); 
		insert cas;
		Task tas = new Task(AES_SFConnector__UCID__c = '00001099181418922543',Status = 'Completed', Subject ='Email'); insert tas;
		tas.whatId= cas.Id;
		update tas;
		System.assertEquals(tas.whatId, cas.Id);
	}

	static testMethod void testStoreTemplateInformation(){
		EmailTemplate queriedTemplate;

		User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
		System.runAs(thisUser){
			Test.startTest();

			queriedTemplate = [SELECT Id, Name, Description
				FROM EmailTemplate
				LIMIT 1];

			queriedTemplate.Name = 'Name of Template';
			queriedTemplate.Description = 'TEST';
			update queriedTemplate;

			Test.stopTest();
		}

		createTriggerCustomSettings();

		GSA_FCIC_TriggerHelper_Case.isTest = true;
		RecordType rt = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Usa.gov' LIMIT 1];
		Case c = new Case();
		c.RecordTypeId = rt.Id;
		c.Customer_First_Name__c = 'Abby';
		c.Customer_Last_Name__c = 'Road';
		c.Customer_Email_address__c = 'abbyroad@gmail.com';
		c.Customer_Phone__c = '2166549873';
		insert c;

		c = [SELECT Id, CaseNumber, ContactId, Customer_First_Name__c, Customer_Last_Name__c, Customer_Email_address__c, Customer_Phone__c 
				FROM Case 
				WHERE Customer_First_Name__c = 'Abby' 
				AND Customer_Last_Name__c = 'Road'
				AND	Customer_Email_address__c = 'abbyroad@gmail.com'
				AND Customer_Phone__c = '2166549873'];

		Task task = new Task();
		task.WhatId = c.Id;
		task.Description = 'Body: ' + c.CaseNumber + '-TEST Dear Soandso, Hello! Sincerely, Me';
		insert task;

		Task queriedTask = [SELECT Id, Template_Id__c, Template_Name__c 
							FROM Task
							WHERE Id = :task.Id];

		System.assertEquals(queriedTemplate.Name, queriedTask.Template_Name__c);
		System.assertEquals(queriedTemplate.Id, queriedTask.Template_Id__c);
	}

	private static void createTriggerCustomSettings(){
		TriggerControls__c caseTrigger = new TriggerControls__c();
		caseTrigger.Name = 'Case';
		caseTrigger.On__c = true;
		insert caseTrigger;

		TriggerControls__c contactTrigger = new TriggerControls__c();
		contactTrigger.Name = 'Contact';
		contactTrigger.On__c = true;
		insert contactTrigger;

		TriggerControls__c taskTrigger = new TriggerControls__c();
		taskTrigger.Name = 'Task';
		taskTrigger.On__c = true;
		insert taskTrigger;
	}

}