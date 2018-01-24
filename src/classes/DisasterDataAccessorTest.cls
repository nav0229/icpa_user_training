@isTest
private class DisasterDataAccessorTest {
	
	@isTest static void getDisasterById_givenADisasterId_shouldRetrieveDisaster() {
		DisasterDataAccessor disasterDA = new DisasterDataAccessor();

		Disaster__c testDisaster = new Disaster__c(Name = 'Test Disaster');
		insert testDisaster;

		Test.startTest();
			Disaster__c retrievedDisaster = disasterDA.getDisasterById(testDisaster.Id);
		Test.stopTest();

		System.assert(
			retrievedDisaster != null,
			'With the given Id, a disaster should have been retrieved.'
		);	

		System.assertEquals(
			testDisaster.Name,
			retrievedDisaster.Name,
			'With the given Id, the test Disaster should have been returned.'
		);
	}
	
}