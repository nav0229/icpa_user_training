@isTest
public class InsuranceDataAccessorTest {
	@isTest static void updateInsurances_givenInsurances_shouldUpdateInsurnaces() {
		InsuranceDataAccessor insuranceDA = new InsuranceDataAccessor();

		Application__c testApplicaion = TestDataUtil.insertApplication();

		Insurance__c testInsurance = new Insurance__c(
			Name = 'Test insurance',
			Application__c = testApplicaion.Id
		);
		insert testInsurance;

		testInsurance.Name = 'After Update';

		Test.startTest();
			insuranceDA.updateInsurances(new List<Insurance__c>{testInsurance});
		Test.stopTest();

		Insurance__c updatedInsurance = insuranceDA.getInsurancebyApplicationIds(new List<Id>{testInsurance.Application__c}).get(0);

		System.assert(
			updatedInsurance != null,
			'With the given insurance Id, a insurance should have been retrieved.'
		);

		System.assertEquals(
			testInsurance.Id,
			updatedInsurance.Id,
			'With the given insurance Id, the test insurance that was inserted should have been returned.'
		);

		System.assertEquals(
			testInsurance.Name,
			updatedInsurance.Name,
			'The test case that was inserted should have had its Name field updated.'
		);
	}

	@isTest 
	static void getInsurancebyApplicationId_givenAnApplicationId_shouldRetrieveRelatedInsurance() {
		InsuranceDataAccessor insuranceDA = new InsuranceDataAccessor();

		Application__c testApp = TestDataUtil.insertApplication();

		Insurance__c testInsurance = new Insurance__c( Application__c = testApp.Id);
		insert testInsurance;

		Test.startTest();
			List<Insurance__c> retrievedInsurance = insuranceDA.getInsurancebyApplicationId(testApp.Id);
		Test.stopTest();

		System.assert(
			!retrievedInsurance.isEmpty(),
			'With the given Application Id, Insurance object should have been retrieved.'
		);

		System.assertEquals(
			testInsurance.Id,
			retrievedInsurance[0].Id,
			'The incorrect Insurance was retrieved for the given Application Id.'
		);
	}

	@isTest 
	static void getInsuranceByApplicationIds_givenListofApplicationIds_shouldRetrieveRelatedInsurance() {
		InsuranceDataAccessor insuranceDA = new InsuranceDataAccessor();

		Application__c testApp = TestDataUtil.insertApplication();
		Application__c testApp2 = TestDataUtil.insertApplication();

		List<Id> applicaionIds = new List<Id>();
		applicaionIds.add(testApp.Id);
		applicaionIds.add(testApp2.Id);

		List<Insurance__c> testInsurances = new List<Insurance__c>();
		testInsurances.add(new Insurance__c(Application__c = testApp.Id));
		testInsurances.add(new Insurance__c(Application__c = testApp.Id));
		testInsurances.add(new Insurance__c(Application__c = testApp2.Id));

		insert testInsurances;

		Test.startTest();
			List<Insurance__c> retrievedInsurance = insuranceDA.getInsurancebyApplicationIds(applicaionIds);
		Test.stopTest();

		System.assert(!retrievedInsurance.isEmpty(), 'With the given Application Ids, Insurance objects should have been retrieved.');

		System.assertEquals(retrievedInsurance[0].Application__c, applicaionIds[0],'The incorrect Insurance was retrieved for the Id for Application one.');
		System.assertEquals(retrievedInsurance[1].Application__c, applicaionIds[0],'The incorrect Insurance was retrieved for the Id for Application one.');
		System.assertEquals(retrievedInsurance[2].Application__c, applicaionIds[1],'The incorrect Insurance was retrieved for the Id for Application two.');
	}


}