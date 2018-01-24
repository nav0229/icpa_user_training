@isTest
private class ApplicationDataAccessorTest {
	
	@isTest static void getApplicationById_givenAnApplicationId_shouldReturnRelatedApplication(){
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApplication = TestDataUtil.insertApplication();

		Test.startTest();
			Application__c retrievedApplication = applicationDA.getApplicationById(testApplication.Id);
		Test.stopTest();

		System.assert(
			retrievedApplication != null,
			'With the given Application Id, an Application should have been returned.'
		);

		System.assertEquals(
			testApplication.Id,
			retrievedApplication.Id,
			'The incorrect Application was retrieved with the given Application Id.'
		);
	}

	@isTest static void getApplciationsById_givenAnApplicationId_shouldReturnRelatedApplication(){
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApplication = TestDataUtil.insertApplication();
		
		Test.startTest();
			List<Application__c> retrievedApplications = applicationDA.getApplicationsById(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assert(
			!retrievedApplications.isEmpty(),
			'With the given Application Id, an Application should have been returned.'
		);

		System.assertEquals(
			testApplication.Id,
			retrievedApplications[0].Id,
			'The incorrect Application was retrieved with the given Application Id.'
		);
	}

	@isTest static void getApplicationsMapById_givenAnApplicationId_shouldReturnMapOfApplicationToId(){
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApplication = TestDataUtil.insertApplication();
		
		Test.startTest();
			Map<Id,Application__c> retrievedIdToApplicationMap = applicationDA.getApplicationsMapById(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assert(
			!retrievedIdToApplicationMap.isEmpty(),
			'With the given Application Id, an (Id,Application) pair should be present in the Map.'
		);

		System.assert(
			retrievedIdToApplicationMap.containsKey(testApplication.Id),
			'The incorrect (Id,Application) pair was retrieved for the given Application Id.'
		);
	}

	@isTest static void getApplicationsAndActiveIRSTranscriptsByApplicationIds_givenAnApplicationId_shouldReturnRelatedApplication(){
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApplication = TestDataUtil.insertApplication();
		
		IRS_Transcripts__c testIRSTranscript = new IRS_Transcripts__c(
			Name = 'Test IRS Transcript',
			Active__c = true,
			Issue__c = 'IRS Offset',
			Application__c = testApplication.Id
		);
		insert testIRSTranscript;

		Test.startTest();
			List<Application__c> retrievedApplications = applicationDA.getApplicationsAndActiveIRSTranscriptsByApplicationIds(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assert(
			!retrievedApplications.isEmpty(),
			'With the given Application Id, an Application should have been returned.'
		);

		System.assertEquals(
			testApplication.Id,
			retrievedApplications[0].Id,
			'The incorrect Application was retrieved for the given Application Id.'
		);

		System.assert(
			retrievedApplications[0].IRS_Transcripts__r != null,
			'Active IRS Transcipt should have been retrieved for given Application Id.'
		);

		System.assertEquals(
			testIRSTranscript.Id,
			retrievedApplications[0].IRS_Transcripts__r[0].Id,
			'The incorrect IRS Transcript was retrieved for the given Application Id'
		);
	}

	@isTest static void getApplicationsByApplicationNumber_givenAnApplicationNumber_shouldReturnRelatedApplication() {
		insert new Application__c(Name='111111111111',Family_Size__c = 2,External_ID__c = '1346asdneufsnhadeu');
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Test.startTest();
			List<Application__c> testApp = applicationDA.getApplicationsByApplicationNumber(new List<String>{'111111111111'});
		Test.stopTest();

		System.assert(
			testApp.size() > 0, 
			'The supplied Application Number should result in an Application object being returned.'
		);

		System.assertEquals(
			'111111111111',
			testApp[0].Name, 
			'The Application returned should be the provided test application.'
		);
	}

	@isTest static void getApplicationByApplicationNumber_givenAnApplicationNumber_shouldReturnRelatedApplication() {
		insert new Application__c(Name='111111111111',Family_Size__c = 2,External_ID__c = '1346asdneufsnhadeu');
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Test.startTest();
			Application__c testApp = applicationDA.getApplicationByApplicationNumber('111111111111');
		Test.stopTest();

		System.assert(
			testApp != null, 
			'The supplied Application Number should result in an Application object being returned.'
		);
		
		System.assertEquals(
			'111111111111',
			testApp.Name, 
			'The Application returned should be the provided test application.'
		);
	}

	@isTest static void updateApplications_givenAnApplication_shouldUpdateApplication() {
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApp = new Application__c(Name='111111111111',Family_Size__c = 2,External_ID__c = '1346asdneufsnhadeu');
		insert testApp;

		testApp.Status__c = 'Accepted';

		Test.startTest();
			applicationDA.updateApplications(new List<Application__c>{testApp});
		Test.stopTest();

		Application__c updatedApp = [
			SELECT Id, Name, Status__c
			FROM Application__c
			WHERE Id = :testApp.Id
			LIMIT 1
		];

		System.assert(
			updatedApp != null, 
			'The supplied Application Id should result in an Application object being returned.'
		);

		System.assertEquals(
			testApp.Status__c, 
			updatedApp.Status__c, 
			'The Application returned has an incorrect updated Status field.'
		);
	}

	@isTest static void insertApplications_givenAnApplication_shouldInsertApplication() {
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApp = new Application__c(Name='111111111111',Family_Size__c = 2,External_ID__c = '1346asdneufsnhadeu');

		Test.startTest();
			applicationDA.insertApplications(new List<Application__c>{testApp});
		Test.stopTest();

		Application__c insertedApp = [
			SELECT Name
			FROM Application__c
			WHERE Name = '111111111111'
			LIMIT 1
		];

		System.assert(
			insertedApp != null, 
			'The supplied Application Number should result in an Application object being returned.'
		);

		System.assertEquals(
			testApp.Name, 
			insertedApp.Name, 
			'The Application returned should have been the test application that was inserted.'
		);
	}

	@isTest static void insertApplication_givenAnApplication_shouldInsertApplication() {
		ApplicationDataAccessor applicationDA = new ApplicationDataAccessor();
		Application__c testApp = new Application__c(Name='111111111111',Family_Size__c = 2,External_ID__c = '1346asdneufsnhadeu');

		Test.startTest();
			applicationDA.insertApplication(testApp);
		Test.stopTest();

		Application__c insertedApp = [
			SELECT Name
			FROM Application__c
			WHERE Name = '111111111111'
			LIMIT 1
		];

		System.assert(
			insertedApp != null, 
			'The supplied Application Number should result in an Application object being returned.'
		);

		System.assertEquals(
			testApp.Name, 
			insertedApp.Name, 
			'The Application returned should have been the test application that was inserted.'
		);
	}
}