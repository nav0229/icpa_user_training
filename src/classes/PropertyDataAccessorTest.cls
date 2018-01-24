@isTest
private class PropertyDataAccessorTest {
	
	@isTest
	static void getDamagedPropertiesAndLossVerificationsByApplicationId_givenAnApplicationId_shouldRetrieveRelatedDamagedPropertiesAndLossVerifications() {
		PropertyDataAccessor propertyDA = new PropertyDataAccessor();
		List<Property__c> damagedProperties = new List<Property__c>();
		List<Property__c> damagedPropertyDAresult = new List<Property__c>();
		List<Loss_Verification_Inspections__c> lostVerifications = new List<Loss_Verification_Inspections__c>();

		Application__c testApplication = TestDataUtil.insertApplication();

		
		damagedProperties.add(TestDataUtil.insertDamagedProperty(testApplication));
		damagedProperties.add(TestDataUtil.insertDamagedProperty(testApplication));
				
		lostVerifications.add(TestDataUtil.insertLossVerification(damagedProperties[0]));
		lostVerifications.add(TestDataUtil.insertLossVerification(damagedProperties[0]));
		lostVerifications.add(TestDataUtil.insertLossVerification(damagedProperties[1]));		

		Test.startTest();
			damagedPropertyDAresult = propertyDA.getDamagedPropertiesAndLossVerificationsByApplicationId(testApplication.Id);
		Test.stopTest();

		List<Loss_Verification_Inspections__c> damagedPropertyOneLVs = new List<Loss_Verification_Inspections__c>();
		damagedPropertyOneLVs.addAll(damagedPropertyDAresult[0].Loss_Verifications__r);

		List<Loss_Verification_Inspections__c> damagedPropertyTwoLVs = new List<Loss_Verification_Inspections__c>();
		damagedPropertyTwoLVs.addAll(damagedPropertyDAresult[1].Loss_Verifications__r);

		System.assertEquals(damagedPropertyDAresult.size(), 2, 'The data accessor did not return the correct number of damaged properties');
		System.assertEquals(2, damagedPropertyOneLVs.size(), 'The first damaged property did not have the correct number of loss verifications');
		System.assertEquals(1, damagedPropertyTwoLVs.size(), 'The second damaged property did not have the correct number of loss verifications');

	}

	@isTest
	static void getDamagedPropertiesAndLossVerificationsByApplicationIds_givenApplicationIds_shouldRetrieveRelatedDamagedPropertiesAndLossVerifications() {
		PropertyDataAccessor propertyDA = new PropertyDataAccessor();
		List<Property__c> damagedProperties = new List<Property__c>();
		List<Property__c> damagedPropertyDAresult = new List<Property__c>();
		List<Application__c> applications = new List<Application__c>();
		List<Loss_Verification_Inspections__c> lostVerifications = new List<Loss_Verification_Inspections__c>();
		List<Id> applicationIds = new List<Id>();

		applications.add(TestDataUtil.insertApplication());
		applications.add(TestDataUtil.insertApplication());

		applicationIds.add(applications[0].Id);
		applicationIds.add(applications[1].Id);
		
		damagedProperties.add(TestDataUtil.insertDamagedProperty(applications[0]));
		damagedProperties.add(TestDataUtil.insertDamagedProperty(applications[1]));
				
		lostVerifications.add(TestDataUtil.insertLossVerification(damagedProperties[0]));
		lostVerifications.add(TestDataUtil.insertLossVerification(damagedProperties[1]));		
		lostVerifications.add(TestDataUtil.insertLossVerification(damagedProperties[1]));	

		Test.startTest();
			damagedPropertyDAresult = propertyDA.getDamagedPropertiesAndLossVerificationsByApplicationIds(applicationIds);
		Test.stopTest();

		List<Loss_Verification_Inspections__c> appOnedamagedPropertyLVs = new List<Loss_Verification_Inspections__c>();
		appOnedamagedPropertyLVs.addAll(damagedPropertyDAresult[0].Loss_Verifications__r);

		List<Loss_Verification_Inspections__c> appTwodamagedPropertyLVs = new List<Loss_Verification_Inspections__c>();
		appTwodamagedPropertyLVs.addAll(damagedPropertyDAresult[1].Loss_Verifications__r);

		System.assertEquals(damagedPropertyDAresult.size(), 2, 'The data accessor did not return the correct number of damaged properties');
		System.assertEquals(1, appOnedamagedPropertyLVs.size(), 'The first damaged property did not have the correct number of loss verifications');
		System.assertEquals(2, appTwodamagedPropertyLVs.size(), 'The second damaged property did not have the correct number of loss verifications');
		System.assertEquals(applications[0].Id, damagedPropertyDAresult[0].Application__c, 'The first damaged property did not have the correct application Id');
		System.assertEquals(applications[1].Id, damagedPropertyDAresult[1].Application__c, 'The second damaged property did not have the correct application Id');
	}
	
}