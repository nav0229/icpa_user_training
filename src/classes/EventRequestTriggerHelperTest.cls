@isTest
private class EventRequestTriggerHelperTest {
	
	@isTest static void afterInsert_givenAListOfEventRequests_shouldInvokeProcessEventRequest() {
		Event_Request__c testEventRequest = new Event_Request__c(Stage__c = 'Order CRB');
		EventRequestStageUpdateHandlerMock mockHandler = new EventRequestStageUpdateHandlerMock();
		EventRequestTriggerHelper.stageUpdateHandler = mockHandler;
		EventRequestTriggerHelper helper = new EventRequestTriggerHelper();
		
		Test.startTest();
			helper.afterInsert(new List<Event_Request__c>{testEventRequest});
		Test.stopTest();

		System.assertEquals(1,mockHandler.processEventRequestCallCount, 
			'processEventRequest method should have been called by in afterInsert method.'
		);	
	}
	
}