@isTest private class ApplicationIRSActualIncomeUpdaterTest {

	@isTest static void updateApplicationIRSActualIncome_givenListOfIRSTranscripts_shouldUpdateIRSActualIncome() {
		//create fake mock da
		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ApplicationIRSActualIncomeUpdater.applicationDA = applicationDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '12345678');
		applicationMockBuilder.setField('Monthly_Fixed_Debt__c', '10');
		applicationMockBuilder.setField('IRS_Actual_Income__c', '0');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApp = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApp);

		MockSObjectBuilder irsTranscriptMockBuilder = new MockSObjectBuilder(IRS_Transcripts__c.getSObjectType());
		irsTranscriptMockBuilder.setField('Application__c', testApp.Id);
		irsTranscriptMockBuilder.setField('Actual_Gross_Annual_Income__c', '100');
		irsTranscriptMockBuilder.setField('Id', irsTranscriptMockBuilder.getMockId());
		IRS_Transcripts__c testIRSTranscript = (IRS_Transcripts__c) irsTranscriptMockBuilder.build();
		//create fake irs transcript
		//create fake application

		ApplicationIRSActualIncomeUpdater appIRSupdater = new ApplicationIRSActualIncomeUpdater();
		Test.startTest();
			appIRSupdater.updateApplicationIRSActualIncome(new List<IRS_Transcripts__c>{testIRSTranscript});
		Test.stopTest();

		System.assertEquals(100, testApp.IRS_Actual_Income__c, 'The Actual_Gross_Annual_Income__c was not sent to the application properly');
		System.assertEquals(1, applicationDAMock.updateApplicationsCallCount, 'The application was not updated');

	}
}