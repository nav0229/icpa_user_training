@isTest
private class EventRequestGeneratorByChecklistItemTest {
	
	@isTest static void generateEventRequestsForChecklistItems_givenNoChecklistItems_shouldNotInsertEventRequest() {
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		EventRequestDataAccessorMock eventRequestMockDA = new EventRequestDataAccessorMock();
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();

		EventRequestGeneratorByChecklistItem.masterChecklistDA = masterChecklistMockDA;
    	EventRequestGeneratorByChecklistItem.eventRequestDA = eventRequestMockDA;
    	EventRequestGeneratorByChecklistItem.applicationDA = applicationMockDA;
    	EventRequestGeneratorByChecklistItem erGenerator = new EventRequestGeneratorByChecklistItem();

    	Test.startTest();
    		erGenerator.generateEventRequestsForChecklistItems(new List<Checklist_Item__c>());
    	Test.stopTest();

    	System.assertEquals(
    		0,
    		eventRequestMockDA.insertEventRequestsCallCount,
    		'With the given empty list of checklist items, no event request should have been inserted.'
    	);
	}
	
	@isTest static void generateEventRequestsForChecklistItems_givenSatisfyingChecklistItem_shouldInsertEventRequest() {
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		EventRequestDataAccessorMock eventRequestMockDA = new EventRequestDataAccessorMock();
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();

		EventRequestGeneratorByChecklistItem.masterChecklistDA = masterChecklistMockDA;
    	EventRequestGeneratorByChecklistItem.eventRequestDA = eventRequestMockDA;
    	EventRequestGeneratorByChecklistItem.applicationDA = applicationMockDA;
    	EventRequestGeneratorByChecklistItem erGenerator = new EventRequestGeneratorByChecklistItem();

    	MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApplication.Id, testApplication);

		MockSObjectBuilder masterChecklistMockBuilder = new MockSObjectBuilder(Master_Checklist__c.getSObjectType());
		masterChecklistMockBuilder.setField('Checklist_Code__c', MasterChecklistDataAccessor.LOSS_VERIFICATION_CODE);
		masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());

		Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
		masterChecklistMockDA.getMasterChecklistsMapByIdReturn.put(testMC.Id, testMC);

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Master_Checklist__c', testMC.Id);
		checklistItemMockBuilder.setField('Application__c', testApplication.Id);
		checklistItemMockBuilder.setField('Id', checklistItemMockBuilder.getMockId());

		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();	

		Test.startTest();
			erGenerator.generateEventRequestsForChecklistItems(new List<Checklist_Item__c>{testChecklistItem});
		Test.stopTest();

		System.assertNotEquals(
    		0,
    		eventRequestMockDA.insertEventRequestsCallCount,
    		'With the given list of checklist items, an event request should have been inserted.'
    	);
	}
	
}