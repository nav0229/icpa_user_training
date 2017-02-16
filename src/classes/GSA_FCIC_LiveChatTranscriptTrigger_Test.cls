@isTest
public class GSA_FCIC_LiveChatTranscriptTrigger_Test{

	static testMethod void GSAFCICLiveChatTranscriptTriggerTest(){
		Test.startTest();
	
		TriggerControls__c triCon1 = new TriggerControls__c(Name = 'LiveChatTranscript', On__c = true); insert triCon1;
		TriggerControls__c triCon2 = new TriggerControls__c(Name = 'Case', On__c = true); insert triCon2;
		TriggerControls__c triCon3 = new TriggerControls__c(Name = 'Contact', On__c = true); insert triCon3;
		
		Id recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('GSA.gov').getRecordTypeId();
		Case c = new Case(RecordTypeId = recTypeId, 
								Call_Topic__c = 'Start a Business', 
								Tier_2_Subject__c = 'Test Subject', 
								Status = 'TRANSFER_TO_TIER2', 
								Customer_First_Name__c = 'Test', 
								Customer_Last_Name__c = 'User', 
								Customer_Email_address__c = 'testuser@gmail.com', 
								Customer_Phone__c = '0123456789'); 
		insert c;

		Skill skill = [SELECT Id, MasterLabel, DeveloperName FROM Skill LIMIT 1];
		
		LiveChatButton  liveButton = [SELECT Id, MasterLabel, DeveloperName FROM LiveChatButton LIMIT 1];

		LiveChatVisitor visitor = new LiveChatVisitor();
		insert visitor;

		LiveChatTranscript live = new LiveChatTranscript(Body = 'Test Body', 
														LiveChatButtonId = liveButton.Id, 
														SkillId = skill.Id, 
														Status = 'Missed', 
														CaseId = c.Id, 
														StartTime = System.Today(), 
														EndTime = system.Today(), 
														LiveChatVisitorId = visitor.Id); 
		insert live;

		System.assertNotEquals(null, live);

		Test.stopTest();
	}
	
}