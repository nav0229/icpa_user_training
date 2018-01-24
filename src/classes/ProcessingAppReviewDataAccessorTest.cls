@isTest
private class ProcessingAppReviewDataAccessorTest {
		@isTest static void getProcessingApplicationReviewsByAppIds_givenAnAppId_shouldRetrieveRelatedProcessingApplicationReview() {
			ProcessingApplicationReviewDataAccessor processingAppReviewDA = new ProcessingApplicationReviewDataAccessor();

			Profile sysAdmin = [
				SELECT Id
				FROM Profile 
				WHERE Name ='System Administrator'
			]; 

			User testUser = new User(
				FirstName = 'Tester',
				LastName = 'Test User',
				Username = 'ProcessingAppReviewDATestUser@test.com',
				Email = 'Test@test.com',
				CommunityNickname = 'Tester',
				TimeZoneSidKey = 'America/Chicago',
				LocaleSidKey = 'en_US',
				EmailEncodingKey = 'UTF-8',
				ProfileId = sysAdmin.Id,
				LanguageLocaleKey = 'en_US',
				Alias = 'Tester'
			);
			insert testUser;

			Application__c testApplication = new Application__c(
				Name = '11111111',
				Family_Size__c = 2,
				OwnerId = testUser.Id
			);
			insert testApplication;

			Other_Assistance__c testOtherAssistance = new Other_Assistance__c(
				Name = 'Test Other Assistance',
				Application__c = testApplication.Id,
				Residence_Type__c = 'Single Family',
				Real_Estate_Grant__c = 1000
			);
			insert testOtherAssistance;

			Property__c testDamagedProperty = TestDataUtil.insertDamagedProperty(testApplication);

			Loss_Verification_Inspections__c testLV = TestDataUtil.insertLossVerification(testDamagedProperty);

			Applicant__c testApplicant = TestDataUtil.insertApplicant(testApplication);

			Insurance__c testInsurance = new Insurance__c(
				Name = 'Test Insurance',
				Application__c = testApplication.Id,
				Property__c = testDamagedProperty.Id, 
				Insurance_Recovery_Amount__c = 1000
			);
			insert testInsurance;

			MockSObjectBuilder processingAppReviewMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType())
				.setField('Name', 'Test Processing App Review')
				.setField('Application__c', testApplication.Id)
				.setField('OwnerId', testUser.Id)
				.setField('Eligibility_Test__c', 'Pass')
				.setField('Repayment_Test__c', 'Pass')
				.setField('Refinancing_Eligibility_Test__c', 'Pass')
				.setField('Collateral_Test__c', 'Pass')
				.setField('Credit_Analysis_Test__c', 'Pass')
				.setField('Loan_Officer_Recommendation__c', 'Approve');

			Processing_Application_Review__c testProcessingAppReview = (Processing_Application_Review__c)JSON.deserialize(
				processingAppReviewMockBuilder.getSerializedSObject(),
				Processing_Application_Review__c.class
			);
			insert testProcessingAppReview;

			Test.startTest();
				List<Processing_Application_Review__c> retrievedReviews = 
					processingAppReviewDA.getProcessingApplicationReviewsByAppIds(new List<Id>{testApplication.Id});
			Test.stopTest();

			System.assert(
				!retrievedReviews.isEmpty(),
				'With the given Application Id, a Processing Application Review should have been returned.'
			);

			System.assertEquals(
				testProcessingAppReview.Id,
				retrievedReviews[0].Id,
				'The retrieved Processing Application Review should be the test Processing Application Review that was inserted.'
			);
		}

		@isTest static void updateProcessingApplicationReviews_givenAnProcessingApplicationReview_shouldUpdateProcessingApplicationReview() {
			ProcessingApplicationReviewDataAccessor processingAppReviewDA = new ProcessingApplicationReviewDataAccessor();

			Profile sysAdmin = [
				SELECT Id
				FROM Profile 
				WHERE Name ='System Administrator'
			]; 

			User testUser = new User(
				FirstName = 'Tester',
				LastName = 'Test User',
				Username = 'ProcessingAppReviewDATestUser@test.com',
				Email = 'Test@test.com',
				CommunityNickname = 'Tester',
				TimeZoneSidKey = 'America/Chicago',
				LocaleSidKey = 'en_US',
				EmailEncodingKey = 'UTF-8',
				ProfileId = sysAdmin.Id,
				LanguageLocaleKey = 'en_US',
				Alias = 'Tester'
			);
			insert testUser;

			Application__c testApplication = new Application__c(
				Name = '11111111',
				Family_Size__c = 2,
				OwnerId = testUser.Id
			);
			insert testApplication;

			Other_Assistance__c testOtherAssistance = new Other_Assistance__c(
				Name = 'Test Other Assistance',
				Application__c = testApplication.Id,
				Residence_Type__c = 'Single Family',
				Real_Estate_Grant__c = 1000
			);
			insert testOtherAssistance;

			Property__c testDamagedProperty = TestDataUtil.insertDamagedProperty(testApplication);

			Loss_Verification_Inspections__c testLV = TestDataUtil.insertLossVerification(testDamagedProperty);

			Applicant__c testApplicant = TestDataUtil.insertApplicant(testApplication);

			Insurance__c testInsurance = new Insurance__c(
				Name = 'Test Insurance',
				Application__c = testApplication.Id,
				Property__c = testDamagedProperty.Id, 
				Insurance_Recovery_Amount__c = 1000
			);
			insert testInsurance;

			MockSObjectBuilder processingAppReviewMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType())
				.setField('Name', 'Test Processing App Review')
				.setField('Application__c', testApplication.Id)
				.setField('OwnerId', testUser.Id)
				.setField('Eligibility_Test__c', 'Pass')
				.setField('Repayment_Test__c', 'Pass')
				.setField('Refinancing_Eligibility_Test__c', 'Pass')
				.setField('Collateral_Test__c', 'Pass')
				.setField('Credit_Analysis_Test__c', 'Pass')
				.setField('Loan_Officer_Recommendation__c', 'Approve');

			Processing_Application_Review__c testProcessingAppReview = (Processing_Application_Review__c)JSON.deserialize(
				processingAppReviewMockBuilder.getSerializedSObject(),
				Processing_Application_Review__c.class
			);
			insert testProcessingAppReview;

			testProcessingAppReview.Cash_Available__c = 100;

			Test.startTest();
					processingAppReviewDA.updateProcessingApplicationReviews(new List<Processing_Application_Review__c>{testProcessingAppReview});
			Test.stopTest();

			List<Processing_Application_Review__c> retrievedReviews = 
					processingAppReviewDA.getProcessingApplicationReviewsByAppIds(new List<Id>{testApplication.Id});

			System.assertEquals(
				retrievedReviews[0].Cash_Available__c,
				100,
				'The test Processing Application Review that was inserted should have an updated Cash_Available__c field.'
			);
		}
}