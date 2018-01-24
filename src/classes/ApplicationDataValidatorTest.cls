@isTest
private class ApplicationDataValidatorTest
{
	@isTest
	static void validateApplicationData_givenValidApplication_shouldInsertEventRequest(){
		Id testApplicationId = MockSObjectBuilder.getMockId(Application__c.getSObjectType());
		Application__c testApplication = new Application__c(Id = testApplicationId);

		ApplicationDataAccessorMock mockApplicationDA = new ApplicationDataAccessorMock();
		mockApplicationDA.getApplicationsByIdReturn = new List<Application__c>{testApplication};

		Applicant__c testPrimaryApplicant = new Applicant__c(Application__c = testApplicationId, Primary_Applicant__c = true);

		ApplicantDataAccessorMock mockApplicantDA = new ApplicantDataAccessorMock();
		mockApplicantDA.getPrimaryApplicantsByApplicationIdReturn = new List<Applicant__c>{testPrimaryApplicant};

		EventRequestDataAccessorMock mockEventRequestDA = new EventRequestDataAccessorMock();

		ApplicationDataValidator.applicationDA = mockApplicationDA;
		ApplicationDataValidator.applicantDA = mockApplicantDA;
		ApplicationDataValidator.eventRequestDA = mockEventRequestDA;

		Test.startTest();
			ApplicationDataValidator testDataValidator = new ApplicationDataValidator();
			testDataValidator.validateApplicationData(new List<Id>{testApplicationId});
		Test.stopTest();

		System.assertEquals(1, mockEventRequestDA.insertEventRequestsCallCount);
	}

	@isTest
	static void validateApplicationData_givenInvalidApplication_shouldAssignToErrorQueue(){
		Id testApplicationId = MockSObjectBuilder.getMockId(Application__c.getSObjectType());
		Application__c testApplication = new Application__c(Id = testApplicationId);

		ApplicationDataAccessorMock mockApplicationDA = new ApplicationDataAccessorMock();
		mockApplicationDA.getApplicationsByIdReturn = new List<Application__c>{testApplication};

		ApplicantDataAccessorMock mockApplicantDA = new ApplicantDataAccessorMock();
		mockApplicantDA.getPrimaryApplicantsByApplicationIdReturn = new List<Applicant__c>();

		Group testGroup = new Group(Id = MockSObjectBuilder.getMockId(Group.getSObjectType()));

		GroupDataAccessorMock mockGroupDA = new GroupDataAccessorMock();
		mockGroupDA.getGroupByDeveloperNameAndTypeReturn = testGroup;

		ApplicationDataValidator.applicationDA = mockApplicationDA;
		ApplicationDataValidator.applicantDA = mockApplicantDA;
		ApplicationDataValidator.groupDA = mockGroupDA;

		Test.startTest();
			ApplicationDataValidator testDataValidator = new ApplicationDataValidator();
			testDataValidator.validateApplicationData(new List<Id>{testApplicationId});
		Test.stopTest();

		System.assertEquals(testApplication.OwnerId, testGroup.Id);
	}
}