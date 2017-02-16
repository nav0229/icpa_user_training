@isTest
public with sharing class GSA_FCIC_CaseKpiUpdateBatchTest {

	static testMethod void testConstructor_CasesExist_CasesAreUpdated(){
		createTestCase();

		Test.startTest();
		Database.executeBatch(new GSA_FCIC_CaseKpiUpdateBatch());
		Test.stopTest();
		
		Case c = [SELECT Id, Business_Hours_Age__c FROM Case LIMIT 1];
		System.assertNotEquals(null, c.Business_Hours_Age__c);
	}

	private static void createTestCase(){
		createTestCustomSettings();
		Case c = new Case();
		insert c;
		c.Status = 'Closed';
		update c;
		c.Business_Hours_Age__c = null;
		update c;
	}

	private static void createTestCustomSettings(){
		TriggerControls__c t = new TriggerControls__c();
		t.On__c = true;
		t.Name = 'Case';
		insert t;
	}
}