@isTest
private class EventRequestDataAccessorTest {
	
	@isTest static void insertEventRequest_givenAnEventRequest_shouldInsertEventRequest() {
		EventRequestDataAccessor eventRequestDA = new EventRequestDataAccessor();
		
		Event_Request__c testEventRequest = new Event_Request__c(
				Application_Number__c = '11111111'
		);

		Test.startTest();
			eventRequestDA.insertEventRequest(testEventRequest);
		Test.stopTest();

		System.assert(testEventRequest.Id != null, 'The test Event Request was not inserted into the database.');
	}
	
	@isTest static void insertEventRequests_givenAnEventRequest_shouldInsertEventRequest() {
		EventRequestDataAccessor eventRequestDA = new EventRequestDataAccessor();
		
		Event_Request__c testEventRequest = new Event_Request__c(
				Application_Number__c = '11111111'
		);

		Test.startTest();
			eventRequestDA.insertEventRequests(new List<Event_Request__c>{testEventRequest});
		Test.stopTest();

		System.assert(testEventRequest.Id != null, 'The test Event Request was not inserted into the database.');
	}

	@isTest static void getEventRequestByStageAndApplicationNumber_givenAnApplicationNumber_shouldRetrieveRelatedEventRequest() {
		EventRequestDataAccessor eventRequestDA = new EventRequestDataAccessor();

		Application__c testApplication = new Application__c(Name = '11111111',Family_Size__c = 2);
		insert testApplication;

		Event_Request__c testEventRequest = new Event_Request__c( 
				Stage__c = EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE,
				Application_Number__c = '11111111'
		);
		insert testEventRequest;

		Test.startTest();
			Event_Request__c retrievedEventRequest = eventRequestDA.getEventRequestByStageAndApplicationNumber('11111111', EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE);
		Test.stopTest();

		System.assert(retrievedEventRequest != null, 'getEventRequestByApplicationNumber failed to retrieve the Event Request');
		System.assertEquals(testEventRequest.Id, retrievedEventRequest.Id, 'The Event Request retrieved is not the expected/correct record.');
	}

	@isTest static void getEventRequestsByStageAndApplicationNumbers_givenAnApplicationNumber_shouldRetrieveRelatedEventRequest() {
		EventRequestDataAccessor eventRequestDA = new EventRequestDataAccessor();

		Application__c testApplication = new Application__c(Name = '11111111',Family_Size__c = 2);
		insert testApplication;

		Event_Request__c testEventRequest = new Event_Request__c( 
				Stage__c = EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE,
				Application_Number__c = '11111111'
		);
		insert testEventRequest;

		Test.startTest();
			List<Event_Request__c> retrievedEventRequests = eventRequestDA.getEventRequestsByStageAndApplicationNumbers(new List<String>{'11111111'}, EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE);
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedEventRequests.size(), 
			'getEventRequestByApplicationNumber failed to retrieve the Event Request'
		);
		
		System.assertEquals(
			testEventRequest.Id, 
			retrievedEventRequests[0].Id, 
			'The Event Request retrieved is not the expected/correct record.'
		);
	}
	
}