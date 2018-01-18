@isTest
public class TestLocationAndStageHistoryHelper{

	static testMethod void testCheckAndUpdateHistory(){
		Controlled_Document__c newControlledDocument = new Controlled_Document__c();
		newControlledDocument.Current_Location__c = 'Region 1A';
		newControlledDocument.Stage__c = 'Awaiting Closure';
		insert newControlledDocument;

		newControlledDocument.Current_Location__c = 'ID - OCIO Office of the Deputy Chief Info Officer & Chief Technology Officer';
		newControlledDocument.Current_Region__c = 'National Capital Region';
		
        update newControlledDocument;

		newControlledDocument.Stage__c = 'Initiated';
		update newControlledDocument;

		List<Location_and_Stage_History__c> histories = [SELECT Id, Name 
													FROM Location_and_Stage_History__c 
													LIMIT 10];

		System.assertEquals(3, histories.size());

		UpdateDaysOpenOnApprovalStepsBatch.isBatchOn = true;

		Datetime current = System.now();
		Date currDate = current.date();
		Time currTime = current.time();
		Datetime currentLocal = Datetime.newInstance(currDate, currTime);

		for(Location_and_Stage_History__c history : histories){
			history.Start_Date__c = currentLocal;
		}

		update histories;
	}

	static testMethod void testInsertClosedControlledDocument(){
		Controlled_Document__c newControlledDocument = new Controlled_Document__c();
		newControlledDocument.Originating_Office__c = 'Some Office';
		newControlledDocument.Stage__c = 'Closed';
		insert newControlledDocument;

		List<Location_and_Stage_History__c> history = [SELECT Id, Active__c 
													FROM Location_and_Stage_History__c 
													WHERE Name = 'Some Office'];

		System.assertEquals(history.size(), 0);
	}

	static testMethod void testSubOfficePopulation(){
		Controlled_Document__c newControlledDocument = new Controlled_Document__c();
		newControlledDocument.Originating_Office__c = 'Some Office Test ABC';
		newControlledDocument.Sub_Division__c = 'Potato';
		insert newControlledDocument;

		Controlled_Document__c getCD = [SELECT Id, Current_Location__c 
											FROM Controlled_Document__c 
											WHERE Originating_Office__c = 'Some Office Test ABC'];
		System.assertEquals(getCD.Current_Location__c, 'Potato');
	}

}