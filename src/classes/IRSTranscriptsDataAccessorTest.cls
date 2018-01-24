@isTest
private class IRSTranscriptsDataAccessorTest {
	
	@isTest static void getIRSTranscriptsByApplicantIds_givenAnApplicantId_shouldRetrieveIRSTranscript() {
		IRSTranscriptsDataAccessor transcriptDA = new IRSTranscriptsDataAccessor();

		Applicant__c testApplicant = TestDataUtil.insertApplicant();

		IRS_Transcripts__c testTranscript = new IRS_Transcripts__c(
			Name = 'Test IRS Transcript',
			Applicant_Name__c = testApplicant.Id,
			Application__c = testApplicant.Application__c
		);
		insert testTranscript;

		Test.startTest();
			List<IRS_Transcripts__c> retrievedTranscripts = transcriptDA.getIRSTranscriptsByApplicantIds(new List<Id>{testApplicant.Id});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedTranscripts.size(),
			'With the given Applicant Id, one IRS Transcript should have been returned.'
		);

		System.assertEquals(
			testTranscript.Id,
			retrievedTranscripts[0].Id,
			'The retrieved IRS Transcript should be the test transcript that was inserted.'
		);
	}
	
	@isTest static void getIRSTranscriptsByApplicationIds_givenAnApplicationId_shouldRetrieveIRSTranscript() {
		IRSTranscriptsDataAccessor transcriptDA = new IRSTranscriptsDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		IRS_Transcripts__c testTranscript = new IRS_Transcripts__c(
			Name = 'Test IRS Transcript',
			Application__c = testApplication.Id
		);
		insert testTranscript;

		Test.startTest();
			List<IRS_Transcripts__c> retrievedTranscripts = transcriptDA.getIRSTranscriptsByApplicationIds(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedTranscripts.size(),
			'With the given Applicant Id, one IRS Transcript should have been returned.'
		);

		System.assertEquals(
			testTranscript.Id,
			retrievedTranscripts[0].Id,
			'The retrieved IRS Transcript should be the test transcript that was inserted.'
		);
	}

	@isTest static void getIRSTranscriptsByApplicationId_givenAnApplicationId_shouldRetrieveIRSTranscript() {
		IRSTranscriptsDataAccessor transcriptDA = new IRSTranscriptsDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		IRS_Transcripts__c testTranscript = new IRS_Transcripts__c(
			Name = 'Test IRS Transcript',
			Application__c = testApplication.Id
		);
		insert testTranscript;

		Test.startTest();
			List<IRS_Transcripts__c> retrievedTranscripts = transcriptDA.getIRSTranscriptsByApplicationId(testApplication.Id);
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedTranscripts.size(),
			'With the given Applicant Id, one IRS Transcript should have been returned.'
		);

		System.assertEquals(
			testTranscript.Id,
			retrievedTranscripts[0].Id,
			'The retrieved IRS Transcript should be the test transcript that was inserted.'
		);
	}
	
}