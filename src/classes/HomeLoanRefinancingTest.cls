@isTest
public class HomeLoanRefinancingTest {

	@isTest static void runHomeLoanRefinancingTest_givenValidData_ShouldRunHomeLoanRefinancingTest(){
		HomeLoanRefinancing homeLoanRefinancingClass = new HomeLoanRefinancing();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();

		MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanRefinancing.groupDA = groupDAMock;
		HomeLoanRefinancing.parDA = parDAMock;
		HomeLoanRefinancing.applicationDA = applicationDAMock;

		//create Insurance
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Id', '10');
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', '100');
		lvMockBuilder.setField('Fair_Market_Value_of_Land__c', '1000');
		lvMockBuilder.setField('Fair_Market_Value_of_Structure__c', '500');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		ChildRelationship childField = damagedPropertyMockBuilder.getChildRelationship('Loss_Verifications__r');
        damagedPropertyMockBuilder.setChild(childField, lvMockBuilder.getSerializedSObject());
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Real_Estate_Uncompensated_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '150000');
		parMockBuilder.setField('Credit_Elsewhere_Test__c', 'Below Market Rate');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);
		
		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Balance__c', '1000');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);


		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Insurance_Recovery_for_Real_Estate_Final__c', 'YES');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		insuranceDAMock.getInsurancebyApplicationIdsReturn.add(testInsurance);

		Test.startTest();
			homeLoanRefinancingClass.runHomeLoanRefinancingTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(1, groupDAMock.getGroupByDeveloperNameAndTypeCallCount, 'getGroupByDeveloperNameAndType was not called once');
		System.assertEquals(1, parDAMock.getProcessingApplicationReviewsByAppIdsCallCount, 'getProcessingApplicationReviewsByAppIds was not called once');
		System.assertEquals(1, parDAMock.updateProcessingApplicationReviewsCallCount, 'updateProcessingApplicationReviews was not called once');
		System.assertEquals(1, applicationDAMock.updateApplicationsCallCount, 'updateApplications was not called once');
	}

	@isTest static void runHomeLoanRefinancingTest_givenNoLienBalance_ShouldRunHomeLoanRefinancingTest(){
		HomeLoanRefinancing homeLoanRefinancingClass = new HomeLoanRefinancing();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();

		MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanRefinancing.groupDA = groupDAMock;
		HomeLoanRefinancing.parDA = parDAMock;
		HomeLoanRefinancing.applicationDA = applicationDAMock;

		//create Insurance
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Id', '10');
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', '100');
		lvMockBuilder.setField('Fair_Market_Value_of_Land__c', '1000');
		lvMockBuilder.setField('Fair_Market_Value_of_Structure__c', '500');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		ChildRelationship childField = damagedPropertyMockBuilder.getChildRelationship('Loss_Verifications__r');
        damagedPropertyMockBuilder.setChild(childField, lvMockBuilder.getSerializedSObject());
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Real_Estate_Uncompensated_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '150000');
		parMockBuilder.setField('Credit_Elsewhere_Test__c', 'Below Market Rate');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);
		
		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Balance__c', '0');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);


		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Insurance_Recovery_for_Real_Estate_Final__c', 'YES');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		insuranceDAMock.getInsurancebyApplicationIdsReturn.add(testInsurance);

		Test.startTest();
			homeLoanRefinancingClass.runHomeLoanRefinancingTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(1, groupDAMock.getGroupByDeveloperNameAndTypeCallCount, 'getGroupByDeveloperNameAndType was not called once');
		System.assertEquals(1, parDAMock.getProcessingApplicationReviewsByAppIdsCallCount, 'getProcessingApplicationReviewsByAppIds was not called once');
		System.assertEquals(1, parDAMock.updateProcessingApplicationReviewsCallCount, 'updateProcessingApplicationReviews was not called once');
		System.assertEquals(1, applicationDAMock.updateApplicationsCallCount, 'updateApplications was not called once');
	}

	@isTest static void runHomeLoanRefinancingTest_givenInsuranceFailure_ShouldRunHomeLoanRefinancingTest(){
		HomeLoanRefinancing homeLoanRefinancingClass = new HomeLoanRefinancing();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();

		MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanRefinancing.groupDA = groupDAMock;
		HomeLoanRefinancing.parDA = parDAMock;
		HomeLoanRefinancing.applicationDA = applicationDAMock;

		//create Insurance
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Id', '10');
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', '100');
		lvMockBuilder.setField('Fair_Market_Value_of_Land__c', '1000');
		lvMockBuilder.setField('Fair_Market_Value_of_Structure__c', '500');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		ChildRelationship childField = damagedPropertyMockBuilder.getChildRelationship('Loss_Verifications__r');
        damagedPropertyMockBuilder.setChild(childField, lvMockBuilder.getSerializedSObject());
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Real_Estate_Uncompensated_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '150000');
		parMockBuilder.setField('Credit_Elsewhere_Test__c', 'Below Market Rate');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);
		
		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Balance__c', '1000');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);


		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Insurance_Recovery_for_Real_Estate_Final__c', 'NO');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		insuranceDAMock.getInsurancebyApplicationIdsReturn.add(testInsurance);

		Test.startTest();
			homeLoanRefinancingClass.runHomeLoanRefinancingTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(1, groupDAMock.getGroupByDeveloperNameAndTypeCallCount, 'getGroupByDeveloperNameAndType was not called once');
		System.assertEquals(1, parDAMock.getProcessingApplicationReviewsByAppIdsCallCount, 'getProcessingApplicationReviewsByAppIds was not called once');
		System.assertEquals(1, parDAMock.updateProcessingApplicationReviewsCallCount, 'updateProcessingApplicationReviews was not called once');
		System.assertEquals(1, applicationDAMock.updateApplicationsCallCount, 'updateApplications was not called once');
	}

	@isTest static void runHomeLoanRefinancingTest_givenMortgageLienNotTaxes_ShouldRunHomeLoanRefinancingTest(){
		HomeLoanRefinancing homeLoanRefinancingClass = new HomeLoanRefinancing();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();

		MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanRefinancing.groupDA = groupDAMock;
		HomeLoanRefinancing.parDA = parDAMock;
		HomeLoanRefinancing.applicationDA = applicationDAMock;

		//create Insurance
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Id', '10');
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', '100');
		lvMockBuilder.setField('Fair_Market_Value_of_Land__c', '1000');
		lvMockBuilder.setField('Fair_Market_Value_of_Structure__c', '500');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		ChildRelationship childField = damagedPropertyMockBuilder.getChildRelationship('Loss_Verifications__r');
        damagedPropertyMockBuilder.setChild(childField, lvMockBuilder.getSerializedSObject());
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Real_Estate_Uncompensated_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '150000');
		parMockBuilder.setField('Credit_Elsewhere_Test__c', 'Below Market Rate');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);
		
		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Balance__c', '1000');
		mortgageMockBuilder.setField('Debt_Must_Be_Secured_By_An_Eligible_Lien__c', 'YES');
		mortgageMockBuilder.setField('Lien_not_due_Taxes_Mechanics_Other__c', 'YES');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);


		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Insurance_Recovery_for_Real_Estate_Final__c', 'YES');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		insuranceDAMock.getInsurancebyApplicationIdsReturn.add(testInsurance);

		Test.startTest();
			homeLoanRefinancingClass.runHomeLoanRefinancingTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(1, groupDAMock.getGroupByDeveloperNameAndTypeCallCount, 'getGroupByDeveloperNameAndType was not called once');
		System.assertEquals(1, parDAMock.getProcessingApplicationReviewsByAppIdsCallCount, 'getProcessingApplicationReviewsByAppIds was not called once');
		System.assertEquals(1, parDAMock.updateProcessingApplicationReviewsCallCount, 'updateProcessingApplicationReviews was not called once');
		System.assertEquals(1, applicationDAMock.updateApplicationsCallCount, 'updateApplications was not called once');
	}
}