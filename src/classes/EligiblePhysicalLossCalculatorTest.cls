@isTest
public class EligiblePhysicalLossCalculatorTest {

	@isTest static void calculateEligiblePhysicalLoss_givenValidData_shouldCalculateEligiblePhysicalLoss() {
		EligiblePhysicalLossCalculator eligiblePhysicalLossCalc = new EligiblePhysicalLossCalculator();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		OtherAssistanceDataAccessorMock otherAssistanceDAMock = new OtherAssistanceDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();

		EligiblePhysicalLossCalculator.applicationDA = applicationDAMock;
		MapCreator.applicationDA = applicationDAMock;
		MapCreator.otherAssistanceDA = otherAssistanceDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.propertyDA = propertyDAMock;

		List<Processing_Application_Review__c> testPARs = new List<Processing_Application_Review__c>();
		List<Loss_Verification_Inspections__c> testLVs = new List<Loss_Verification_Inspections__c>();
		
		//need to make an application
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		applicationMockBuilder.setField('Total_Eligible_Physical_Loss__c', '0');
		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationDAMock.getApplicationsByIdReturn.add(testApplication);	//List<Application__c>

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		parMockBuilder.setField('Total_Motor_Vehicle_Uncompensated_Loss__c', '0');
		parMockBuilder.setField('Total_Real_Estate_Uncompensated_Loss__c', '0');
		parMockBuilder.setField('Total_Contents_Uncompensated_Loss__c', '0');
		parMockBuilder.setField('Total_Uncompensated_Physical_Loss__c', '0');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Cont_Motor__c', '0');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '0');
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '0');
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();
		testPARs.add(testPAR);

		//need to make a Damaged Property that points to that application
		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', damagedPropertyMockBuilder.getMockId());
		damagedPropertyMockBuilder.setField('Damaged_Property__c', 'true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		//create LVs
		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', testDamagedProperty.Id);
		lvMockBuilder.setField('Motor_Vehicle_Verified_Loss__c', '100000');
		lvMockBuilder.setField('Real_Estate_Verified_Loss__c', '100000');
		lvMockBuilder.setField('Contents_Verified_Loss__c', '0');
		lvMockBuilder.setField('Verified_Loss_for_Landscape__c', '30000');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		Loss_Verification_Inspections__c testLV = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		testLVs.add(testLV);
		
		lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', testDamagedProperty.Id);
		lvMockBuilder.setField('Motor_Vehicle_Verified_Loss__c', '0');
		lvMockBuilder.setField('Real_Estate_Verified_Loss__c', '0');
		lvMockBuilder.setField('Contents_Verified_Loss__c', '1000');
		lvMockBuilder.setField('Verified_Loss_for_Landscape__c', '0');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		Loss_Verification_Inspections__c testLV2 = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		testLVs.add(testLV2);

		lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', testDamagedProperty.Id);
		lvMockBuilder.setField('Motor_Vehicle_Verified_Loss__c', '0');
		lvMockBuilder.setField('Real_Estate_Verified_Loss__c', '0');
		lvMockBuilder.setField('Contents_Verified_Loss__c', '0');
		lvMockBuilder.setField('Verified_Loss_for_Landscape__c', '1000');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		Loss_Verification_Inspections__c testLV3 = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		testLVs.add(testLV3);

		testDamagedProperty.Loss_Verifications__r.add(testLV);
		testDamagedProperty.Loss_Verifications__r.add(testLV2);
		testDamagedProperty.Loss_Verifications__r.add(testLV3);


		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		//create other assistance 
		MockSObjectBuilder otherAssistanceMockBuilder = new MockSObjectBuilder(Other_Assistance__c.getSObjectType());
		otherAssistanceMockBuilder.setField('Application__c', testApplication.Id);
		otherAssistanceMockBuilder.setField('Real_Estate_Grant__c', '1000');
		otherAssistanceMockBuilder.setField('Contents_Grant__c', '500');
		otherAssistanceMockBuilder.setField('Total_FEMA_amount_for_Real_Estate__c', '10000');
		otherAssistanceMockBuilder.setField('Id', otherAssistanceMockBuilder.getMockId());
		Other_Assistance__c testOtherAssistance = (Other_Assistance__c) otherAssistanceMockBuilder.build();

		otherAssistanceDAMock.getOtherAssistancebyApplicationIdsReturn.add(testOtherAssistance);

		//create Insurance
		//attach to application 
		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Insurance_Reimbursement_for_Auto__c', '1000');
		insuranceMockBuilder.setField('Insurance_Reimbursement_for_Contents__c', '500');
		insuranceMockBuilder.setField('Insurance_Reimbursement_for_Real_Estate__c', '10000');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		insuranceDAMock.getInsuranceByApplicationIdsReturn.add(testInsurance);

		Test.startTest();
			eligiblePhysicalLossCalc.calculateEligiblePhysicalLoss(testPARs);
		Test.stopTest();	

		System.assertEquals(1, applicationDAMock.getApplicationsByIdCallCount, 'Application DA was called an incorrect number of times');
		System.assertEquals(1, propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsCallCount, 'Damaged Property DA was called an incorrect number of times');
		System.assertEquals(1, otherAssistanceDAMock.getOtherAssistancebyApplicationIdsCallCount, 'Other Assistance DA was called an incorrect number of times');
		System.assertEquals(1, insuranceDAMock.getInsuranceByApplicationIdsCallCount, 'Insurance DA was called an incorrect number of times');
	}

	@isTest static void calculateEligiblePhysicalLossForApplication_givenValidData_shouldReturnPARWithCalculatedValues() {
		EligiblePhysicalLossCalculator eligiblePhysicalLossCalc = new EligiblePhysicalLossCalculator();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		OtherAssistanceDataAccessorMock otherAssistanceDAMock = new OtherAssistanceDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();

		EligiblePhysicalLossCalculator.applicationDA = applicationDAMock;
		MapCreator.applicationDA = applicationDAMock;
		MapCreator.otherAssistanceDA = otherAssistanceDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.propertyDA = propertyDAMock;

		List<Loss_Verification_Inspections__c> testLVs = new List<Loss_Verification_Inspections__c>();
		List<Other_Assistance__c> testOAs = new List<Other_Assistance__c>();
		List<Insurance__c> testInsurances = new List<Insurance__c>();
		
		//need to make an application
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		applicationMockBuilder.setField('Total_Eligible_Physical_Loss__c', '0');
		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationDAMock.getApplicationsByIdReturn.add(testApplication);	//List<Application__c>

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		parMockBuilder.setField('Total_Motor_Vehicle_Uncompensated_Loss__c', '0');
		parMockBuilder.setField('Total_Real_Estate_Uncompensated_Loss__c', '0');
		parMockBuilder.setField('Total_Contents_Uncompensated_Loss__c', '0');
		parMockBuilder.setField('Total_Uncompensated_Physical_Loss__c', '0');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Cont_Motor__c', '0');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '0');
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '0');
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		//create LVs
		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		lvMockBuilder.setField('Motor_Vehicle_Verified_Loss__c', '0');
		lvMockBuilder.setField('Real_Estate_Verified_Loss__c', '1000000');
		lvMockBuilder.setField('Contents_Verified_Loss__c', '0');
		lvMockBuilder.setField('Verified_Loss_for_Landscape__c', '0');
		Loss_Verification_Inspections__c testLV = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		testLVs.add(testLV);
		
		lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		lvMockBuilder.setField('Motor_Vehicle_Verified_Loss__c', '70000');
		lvMockBuilder.setField('Real_Estate_Verified_Loss__c', '0');
		lvMockBuilder.setField('Contents_Verified_Loss__c', '0');
		lvMockBuilder.setField('Verified_Loss_for_Landscape__c', '0');
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		Loss_Verification_Inspections__c testLV2 = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		testLVs.add(testLV2);

		lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		lvMockBuilder.setField('Motor_Vehicle_Verified_Loss__c', '0');
		lvMockBuilder.setField('Real_Estate_Verified_Loss__c', '0');
		lvMockBuilder.setField('Contents_Verified_Loss__c', '5000');
		lvMockBuilder.setField('Verified_Loss_for_Landscape__c', '5000');
		Loss_Verification_Inspections__c testLV3 = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		testLVs.add(testLV3);

		//create other assistance 
		MockSObjectBuilder otherAssistanceMockBuilder = new MockSObjectBuilder(Other_Assistance__c.getSObjectType());
		otherAssistanceMockBuilder.setField('Application__c', testApplication.Id);
		otherAssistanceMockBuilder.setField('Real_Estate_Grant__c', '10000');
		otherAssistanceMockBuilder.setField('Contents_Grant__c', '500');
		otherAssistanceMockBuilder.setField('Total_FEMA_amount_for_Real_Estate__c', '10000');
		otherAssistanceMockBuilder.setField('Id', otherAssistanceMockBuilder.getMockId());
		Other_Assistance__c testOtherAssistance = (Other_Assistance__c) otherAssistanceMockBuilder.build();

		testOAs.add(testOtherAssistance);

		//create Insurance
		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Insurance_Reimbursement_for_Auto__c', '30000');
		insuranceMockBuilder.setField('Insurance_Reimbursement_for_Contents__c', '1000');
		insuranceMockBuilder.setField('Insurance_Reimbursement_for_Real_Estate__c', '100000');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		testInsurances.add(testInsurance);

		Test.startTest();
			Processing_Application_Review__c resultPAR = eligiblePhysicalLossCalc.calculateEligiblePhysicalLossForApplication(
				testPAR, testLVs, testOAs, testInsurances);
		Test.stopTest();	

		System.assertEquals(40000, resultPAR.Total_Motor_Vehicle_Uncompensated_Loss__c, 'Total_Motor_Vehicle_Uncompensated_Loss__c is incorrect');
		System.assertEquals(880000, resultPAR.Total_Real_Estate_Uncompensated_Loss__c, 'Total_Real_Estate_Uncompensated_Loss__c is incorrect');
		System.assertEquals(3500, resultPAR.Total_Contents_Uncompensated_Loss__c, 'Total_Contents_Uncompensated_Loss__c is incorrect');
		System.assertEquals(923500, resultPAR.Total_Uncompensated_Physical_Loss__c, 'Total_Uncompensated_Physical_Loss__c is incorrect');

		System.assertEquals(40000, resultPAR.Total_Eligible_Physical_Loss_Cont_Motor__c, 'Total_Eligible_Physical_Loss_Cont_Motor__c is incorrect');
		System.assertEquals(200000, resultPAR.Total_Eligible_Physical_Loss_Real_Estate__c, 'Total_Eligible_Physical_Loss_Real_Estate__c is incorrect');
		System.assertEquals(240000, resultPAR.Total_Eligible_Physical_Loss__c, 'Total_Eligible_Physical_Loss__c is incorrect');
	}
}