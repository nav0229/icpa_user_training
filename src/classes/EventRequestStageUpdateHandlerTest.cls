@isTest
private class EventRequestStageUpdateHandlerTest {
	
	@isTest static void processEventRequest_givenAnEventRequestWithStageSubmitCBR_shouldEnqueueCreditProfileInitializer() {
		ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
		JobQueuerMock mockJobQueuer = new JobQueuerMock();
		EventRequestStageUpdateHandler.queuer = mockJobQueuer;
		EventRequestStageUpdateHandler.applicationDA = mockDA;
		EventRequestStageUpdateHandler handler = new EventRequestStageUpdateHandler();

		mockDA.getApplicationsByApplicationNumberReturn.add(
			new Application__c(
				Name = '11111111',
				Sub_Status__c = 'Test'
			)
		);

		Event_Request__c submitCBREvent = new Event_Request__c(
				Stage__c = EventRequestDataAccessor.STAGE_SUBMIT_CBR, 
				Application_Number__c = '11111111'
		);

		Test.startTest();
			handler.processEventRequest(new List<Event_Request__c>{submitCBREvent});
		Test.stopTest();

		System.assert(
			mockJobQueuer.queueJobCallCount > 0,
			'CBRCreditProfileInitializer job should be enqueued when Event Request with Stage: Submit CBR is provided.'
		);
	}

	//@isTest static void processEventRequest_givenAnEventRequestWithStageSubmitAutoDecline_shouldEnqueueApplicationAutoDeclineInitializer() {
	//	ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
	//	JobQueuerMock mockJobQueuer = new JobQueuerMock();
	//	EventRequestStageUpdateHandler.queuer = mockJobQueuer;
	//	EventRequestStageUpdateHandler.applicationDA = mockDA;
	//	EventRequestStageUpdateHandler handler = new EventRequestStageUpdateHandler();

	//	mockDA.getApplicationsByApplicationNumberReturn.add(
	//		new Application__c(
	//			Name = '11111111',
	//			Sub_Status__c = 'Test'
	//		)
	//	);

	//	Event_Request__c submitAutoDeclineEvent = new Event_Request__c(
	//			Stage__c = EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE, 
	//			Application_Number__c = '11111111'
	//	);

	//	Test.startTest();
	//		handler.processEventRequest(new List<Event_Request__c>{submitAutoDeclineEvent});
	//	Test.stopTest();

	//	System.assert(
	//		mockJobQueuer.queueJobCallCount > 0,
	//		'ApplicationAutoDeclineInitializer job should be enqueued when Event Request with Stage: Submit Auto Decline is provided.'
	//	);
	//}

	@isTest static void processEventRequest_givenAnEventRequestWithStageOrderCBR_shouldUpdateApplication() {
		ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
		EventRequestStageUpdateHandler.applicationDA = mockDA;
		EventRequestStageUpdateHandler handler = new EventRequestStageUpdateHandler();

		mockDA.getApplicationsByApplicationNumberReturn.add(
			new Application__c(
				Name = '11111111',
				Sub_Status__c = 'Test'
			)
		);

		Event_Request__c orderCBREvent = new Event_Request__c(
				Stage__c = 'Order CBR', 
				Application_Number__c = '11111111'
		);

		Test.startTest();
			handler.processEventRequest(new List<Event_Request__c>{orderCBREvent});
		Test.stopTest();

		System.assertEquals(
			1,
			mockDA.updateApplicationsCallCount, 
			'The Application should have been updated when Event Request with Stage: Order CBR is provided.'
		);
	}

	@isTest static void processEventRequest_givenAnEventRequestWithStageReceivedCBR_shouldUpdateApplication() {
		ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
		EventRequestStageUpdateHandler.applicationDA = mockDA;
		EventRequestStageUpdateHandler handler = new EventRequestStageUpdateHandler();

		mockDA.getApplicationsByApplicationNumberReturn.add(
			new Application__c(
				Name = '11111111',
				Sub_Status__c = 'Test'
			)
		);

		Event_Request__c receivedCBREvent = new Event_Request__c(
				Stage__c = 'Received CBR', 
				Application_Number__c = '11111111'
		);

		Test.startTest();
			handler.processEventRequest(new List<Event_Request__c>{receivedCBREvent});
		Test.stopTest();

		System.assertEquals(
			1,
			mockDA.updateApplicationsCallCount, 
			'The Application should have been updated when Event Request with Stage: Receive CBR is provided.'
		);
	}
	
	@isTest static void processEventRequest_givenAnEventRequestWithStageReceivedCBRAndCreditBureauRecordWithException_shouldAddApplicationToExceptionQueue() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauDataAccessorMock cbrMockDA = new CreditBureauDataAccessorMock(); 
		GroupDataAccessorMock groupMockDA = new GroupDataAccessorMock();
		EventRequestStageUpdateHandler.applicationDA = applicationMockDA;
		EventRequestStageUpdateHandler.creditBureauDA = cbrMockDA;
		EventRequestStageUpdateHandler.groupDA = groupMockDA;
		EventRequestStageUpdateHandler handler = new EventRequestStageUpdateHandler();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '11111111');
		applicationMockBuilder.setField('Sub_Status__c', 'Submit CBR');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();

		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApp);


		MockSObjectBuilder groupMockBuilder = new MockSObjectBuilder(Group.getSObjectType());
		groupMockBuilder.setField('DeveloperName', 'Exception_Queue');
		groupMockBuilder.setField('Type', 'Queue');
		groupMockBuilder.setField('Id', groupMockBuilder.getMockId());

		Group exceptionQueue = (Group) groupMockBuilder.build();

		groupMockDA.getGroupByDeveloperNameAndTypeReturn = exceptionQueue;


		cbrMockDA.getActiveCreditBureausByApplicationLatestFirstReturn.add(
			new Credit_Bureau__c(
				Name = 'Test CBR',
				Application__c = testApp.Id,
				Credit_Score__c = 'Zero',
				Active__c = true
			)
		);	

		Event_Request__c receivedCBREvent = new Event_Request__c(
			Stage__c = 'Received CBR', 
			Application_Number__c = '11111111'
		);

		Test.startTest();
			handler.processEventRequest(new List<Event_Request__c>{receivedCBREvent});
		Test.stopTest();

		System.assertEquals(
			exceptionQueue.Id,
			testApp.OwnerId, 
			'The Application should have been added to the Exception Queue when the most recent Credit Bureau Credit Score causes an Exception.'
		);
	}

	@isTest static void processEventRequest_givenAnEventRequestWithStageReceivedCBRAndTwoActiveCreditBureauRecords_shouldMakeOlderRecordInactiveAndEvaluateExceptionQueueCriteria() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		CreditBureauDataAccessorMock cbrMockDA = new CreditBureauDataAccessorMock(); 
		GroupDataAccessorMock groupMockDA = new GroupDataAccessorMock();
		EventRequestStageUpdateHandler.applicationDA = applicationMockDA;
		EventRequestStageUpdateHandler.creditBureauDA = cbrMockDA;
		EventRequestStageUpdateHandler.groupDA = groupMockDA;
		EventRequestStageUpdateHandler handler = new EventRequestStageUpdateHandler();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '11111111');
		applicationMockBuilder.setField('Sub_Status__c', 'Submit CBR');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApp = (Application__c) applicationMockBuilder.build();

		applicationMockDA.getApplicationsByApplicationNumberReturn.add(testApp);


		MockSObjectBuilder groupMockBuilder = new MockSObjectBuilder(Group.getSObjectType());
		groupMockBuilder.setField('DeveloperName', 'Exception_Queue');
		groupMockBuilder.setField('Type', 'Queue');
		groupMockBuilder.setField('Id', groupMockBuilder.getMockId());

		Group exceptionQueue = (Group) groupMockBuilder.build();

		groupMockDA.getGroupByDeveloperNameAndTypeReturn = exceptionQueue;


		cbrMockDA.getActiveCreditBureausByApplicationLatestFirstReturn.add(
			(Credit_Bureau__c)JSON.deserialize(
			'{"Contact":' + 
				'{"Name":"Test CBR Old",'+ 
				'"Application__c":"'+ testApp.Id +'",'+
				'"Credit_Score__c":"Zero",'+
				'"Active__c":"true",'+
				'"CreatedDate":"2015-09-13T20:30:00.000Z"}' +
			'}'
			, Credit_Bureau__c.class)
		);

		cbrMockDA.getActiveCreditBureausByApplicationLatestFirstReturn.add(
			(Credit_Bureau__c)JSON.deserialize(
			'{"Contact":' + 
				'{"Name":"Test CBR New",'+ 
				'"Application__c":"'+ testApp.Id +'",'+
				'"Credit_Score__c":"4000",'+
				'"Active__c":"true",'+
				'"CreatedDate":"2015-09-13T20:30:03.000Z"}' +
			'}'
			, Credit_Bureau__c.class)
		);

		Event_Request__c receivedCBREvent = new Event_Request__c(
			Stage__c = 'Received CBR', 
			Application_Number__c = '11111111'
		);

		Test.startTest();
			handler.processEventRequest(new List<Event_Request__c>{receivedCBREvent});
		Test.stopTest();

		System.assertEquals(
			exceptionQueue.Id, 
			testApp.OwnerId,
			'The Application should have been added to the Exception Queue when the most recent Credit Bureau Credit Score causes an Exception.'
		);

		List<Credit_Bureau__c> activeCBRs = cbrMockDA.getActiveCreditBureausByApplicationLatestFirst(testApp);

		System.assert(
			activeCBRs.size() == 1, 
			'Of the two test Credit Bureau records, only the most recent one should have remained active.'
		);
		System.assertEquals(
			'Test CBR New',
			activeCBRs[0].Name, 
			'The active Credit Bureau record should be the test record with the more recent time stamp.'
		);
	}
}