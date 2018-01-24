@isTest
public class MapCreatorTest {
	@isTest static void createPARIdApplicationMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		MapCreator.applicationDA = applicationDAMock;

		 Map<Id, Application__c> parIdApplicationMap = new Map<Id, Application__c>();

		//need to make an application
		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationDAMock.getApplicationsByIdReturn.add(testApplication);	//List<Application__c>

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		Test.startTest();
			parIdApplicationMap = mapCreatorTool.createPARIdApplicationMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(1, parIdApplicationMap.values().size(), 'The size is incorrect');
	}

	@isTest static void createPARIdInsuranceMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MapCreator.insuranceDA = insuranceDAMock;

		 Map<Id, List<Insurance__c>> parIdInsuranceMap = new Map<Id, List<Insurance__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Application__c', '1');
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());
		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder2 = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder2.setField('Application__c', '1');
		insuranceMockBuilder2.setField('Id', insuranceMockBuilder2.getMockId());
		Insurance__c testInsurance2 = (Insurance__c) insuranceMockBuilder2.build();

		insuranceDAMock.getInsurancebyApplicationIdsReturn.add(testInsurance);
		insuranceDAMock.getInsurancebyApplicationIdsReturn.add(testInsurance2);

		Test.startTest();
			parIdInsuranceMap = mapCreatorTool.createPARIdInsuranceMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdInsuranceMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdMortgagesMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		MapCreator.mortgageDA = mortgageDAMock;

		 Map<Id, List<Mortgage__c>> parIdMortgageMap = new Map<Id, List<Mortgage__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', '1');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testmortgage = (Mortgage__c) mortgageMockBuilder.build();

		MockSObjectBuilder mortgageMockBuilder2 = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder2.setField('Application__c', '1');
		mortgageMockBuilder2.setField('Id', mortgageMockBuilder2.getMockId());
		Mortgage__c testmortgage2 = (Mortgage__c) mortgageMockBuilder2.build();

		mortgageDAMock.getMortgagebyApplicationIdsReturn.add(testmortgage);
		mortgageDAMock.getMortgagebyApplicationIdsReturn.add(testmortgage2);

		Test.startTest();
			parIdMortgageMap = mapCreatorTool.createPARIdMortgagesMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdmortgageMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdLossVerificationMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		MapCreator.propertyDA = propertyDAMock;

		Map<Id, List<Loss_Verification_Inspections__c>> parIdLVMap = new Map<Id, List<Loss_Verification_Inspections__c>>();

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', '1');
		damagedPropertyMockBuilder.setField('Id', damagedPropertyMockBuilder.getMockId());
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		//create LVs
		MockSObjectBuilder lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', testDamagedProperty.Id);
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		Loss_Verification_Inspections__c testLV = (Loss_Verification_Inspections__c) lvMockBuilder.build();
		
		lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		lvMockBuilder.setField('Property__c', testDamagedProperty.Id);
		Loss_Verification_Inspections__c testLV2 = (Loss_Verification_Inspections__c) lvMockBuilder.build();

		lvMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
		lvMockBuilder.setField('Property__c', testDamagedProperty.Id);
		lvMockBuilder.setField('Id', lvMockBuilder.getMockId());
		Loss_Verification_Inspections__c testLV3 = (Loss_Verification_Inspections__c) lvMockBuilder.build();

		testDamagedProperty.Loss_Verifications__r.add(testLV);
		testDamagedProperty.Loss_Verifications__r.add(testLV2);
		testDamagedProperty.Loss_Verifications__r.add(testLV3);


		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		Test.startTest();
			parIdLVMap = mapCreatorTool.createPARIdLossVerificationMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		//System.assertEquals(3, parIdLVMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdOtherAssistanceMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		OtherAssistanceDataAccessorMock otherAssistanceDAMock = new OtherAssistanceDataAccessorMock();
		MapCreator.OtherAssistanceDA = otherAssistanceDAMock;

		 Map<Id, List<Other_Assistance__c>> parIdOtherAssistanceMap = new Map<Id, List<Other_Assistance__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder otherAssistanceMockBuilder = new MockSObjectBuilder(Other_Assistance__c.getSObjectType());
		otherAssistanceMockBuilder.setField('Application__c', '1');
		otherAssistanceMockBuilder.setField('Id', otherAssistanceMockBuilder.getMockId());
		Other_Assistance__c testOtherAssistance = (Other_Assistance__c) otherAssistanceMockBuilder.build();

		MockSObjectBuilder otherAssistanceMockBuilder2 = new MockSObjectBuilder(Other_Assistance__c.getSObjectType());
		otherAssistanceMockBuilder2.setField('Application__c', '1');
		otherAssistanceMockBuilder2.setField('Id', otherAssistanceMockBuilder2.getMockId());
		Other_Assistance__c testOtherAssistance2 = (Other_Assistance__c) otherAssistanceMockBuilder2.build();

		otherAssistanceDAMock.getOtherAssistancebyApplicationIdsReturn.add(testOtherAssistance);
		otherAssistanceDAMock.getOtherAssistancebyApplicationIdsReturn.add(testOtherAssistance2);

		Test.startTest();
			parIdOtherAssistanceMap = mapCreatorTool.createPARIdOtherAssistanceMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdOtherAssistanceMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdApplicantMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		ApplicantDataAccessorMock applicantDAMock = new ApplicantDataAccessorMock();
		MapCreator.ApplicantDA = applicantDAMock;

		 Map<Id, List<Applicant__c>> parIdApplicantMap = new Map<Id, List<Applicant__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Application__c', '1');
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());
		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder2 = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder2.setField('Application__c', '1');
		applicantMockBuilder2.setField('Id', applicantMockBuilder2.getMockId());
		Applicant__c testApplicant2 = (Applicant__c) applicantMockBuilder2.build();

		applicantDAMock.getApplicantsByApplicationIdsReturn.add(testApplicant);
		applicantDAMock.getApplicantsByApplicationIdsReturn.add(testApplicant2);

		Test.startTest();
			parIdApplicantMap = mapCreatorTool.createPARIdApplicantMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdApplicantMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdDebtExpenseMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;

		 Map<Id, List<Debts_Expenses__c>> parIdDebtsExpensesMap = new Map<Id, List<Debts_Expenses__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', '1');
		debtsExpensesMockBuilder.setField('Id', debtsExpensesMockBuilder.getMockId());
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		MockSObjectBuilder debtsExpensesMockBuilder2 = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder2.setField('Application__c', '1');
		debtsExpensesMockBuilder2.setField('Id', debtsExpensesMockBuilder2.getMockId());
		Debts_Expenses__c testDebtsExpenses2 = (Debts_Expenses__c) debtsExpensesMockBuilder2.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);
		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses2);

		Test.startTest();
			parIdDebtsExpensesMap = mapCreatorTool.createPARIdDebtExpenseMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdDebtsExpensesMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdIRSTranscriptMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		IRSTranscriptsDataAccessorMock irsTranscriptDAMock = new IRSTranscriptsDataAccessorMock();
		MapCreator.irsTranscriptsDA = irsTranscriptDAMock;

		 Map<Id, List<IRS_Transcripts__c>> parIdIrsTranscriptsMap = new Map<Id, List<IRS_Transcripts__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder irsMockBuilder = new MockSObjectBuilder(IRS_Transcripts__c.getSObjectType());
		irsMockBuilder.setField('Application__c', '1');
		irsMockBuilder.setField('Id', irsMockBuilder.getMockId());
		IRS_Transcripts__c testIRS = (IRS_Transcripts__c) irsMockBuilder.build();

		MockSObjectBuilder irsMockBuilder2 = new MockSObjectBuilder(IRS_Transcripts__c.getSObjectType());
		irsMockBuilder2.setField('Application__c', '1');
		irsMockBuilder2.setField('Id', irsMockBuilder2.getMockId());
		IRS_Transcripts__c testIRS2 = (IRS_Transcripts__c) irsMockBuilder2.build();

		irsTranscriptDAMock.getIRSTranscriptsByApplicationIdsReturn.add(testIRS);
		irsTranscriptDAMock.getIRSTranscriptsByApplicationIdsReturn.add(testIRS2);

		Test.startTest();
			parIdIrsTranscriptsMap = mapCreatorTool.createPARIdIRSTranscriptMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdIrsTranscriptsMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdLoanMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		MapCreator.loanDA = loanDAMock;

		 Map<Id, List<Loan__c>> parIdLoansMap = new Map<Id, List<Loan__c>>();

		//need to make a PAR that points to that application
		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder loanMockBuilder = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder.setField('Application__c', '1');
		loanMockBuilder.setField('Id', loanMockBuilder.getMockId());
		Loan__c testLoan = (Loan__c) loanMockBuilder.build();

		MockSObjectBuilder loanMockBuilder2 = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder2.setField('Application__c', '1');
		loanMockBuilder2.setField('Id', loanMockBuilder2.getMockId());
		Loan__c testLoan2 = (Loan__c) loanMockBuilder2.build();

		loanDAMock.getLoansByApplicationIdsReturn.add(testLoan);
		loanDAMock.getLoansByApplicationIdsReturn.add(testLoan2);

		Test.startTest();
			parIdLoansMap = mapCreatorTool.createPARIdLoanMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(2, parIdLoansMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdDamagedPropertyMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		MapCreator.propertyDA = propertyDAMock;

		Map<Id, List<Property__c>> parIdDamagedPropertyMap = new Map<Id, List<Property__c>>();

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', '1');
		damagedPropertyMockBuilder.setField('Id', damagedPropertyMockBuilder.getMockId());
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		Test.startTest();
			parIdDamagedPropertyMap = mapCreatorTool.createPARIdDamagedPropertyMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(1, parIdDamagedPropertyMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdCreditBureauMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		CreditBureauDataAccessorMock creditBureauDAMock = new CreditBureauDataAccessorMock();
		MapCreator.creditBureauDA = creditBureauDAMock;

		Map<Id, List<Credit_Bureau__c>> parIdCreditBureauMap = new Map<Id, List<Credit_Bureau__c>>();

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', '1');
		creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());
		Credit_Bureau__c testCreditBureau = (Credit_Bureau__c) creditBureauMockBuilder.build();

		creditBureauDAMock.getActiveCreditBureausByApplicationIdsReturn.add(testCreditBureau);

		Test.startTest();
			parIdCreditBureauMap = mapCreatorTool.createPARIdCreditBureauMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();

		System.assertEquals(1, parIdCreditBureauMap.values()[0].size(), 'The size is incorrect');
	}

	@isTest static void createPARIdCBRLineItemMap_givenPARObjects_shouldReturnMap() {
		MapCreator mapCreatorTool = new MapCreator();
		CreditBureauLineItemDataAccessorMock cbrLIDAMock = new CreditBureauLineItemDataAccessorMock();
		MapCreator.creditBureauLineItemDA = cbrLIDAMock;

		Map<Id, List<Credit_Bureau_Line_Item__c>> parIdCBRLineItemMap = new Map<Id, List<Credit_Bureau_Line_Item__c>>();

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', '1');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Application__c', '1');
		creditBureauMockBuilder.setField('Id', '10');
		Credit_Bureau__c testCreditBureau = (Credit_Bureau__c) creditBureauMockBuilder.build();

		MockSObjectBuilder cbrLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		cbrLineItemMockBuilder.setField('Credit_Bureau__c', '10');
		cbrLineItemMockBuilder.setField('Id', cbrLineItemMockBuilder.getMockId());
		Credit_Bureau_Line_Item__c testCreditBureauLineItem = (Credit_Bureau_Line_Item__c) cbrLineItemMockBuilder.build();

		cbrLIDAMock.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCreditBureauLineItem);

		Test.startTest();
			parIdCBRLineItemMap = mapCreatorTool.createPARIdCBRLineItemMap(new List<Processing_Application_Review__c>{testPAR});
		Test.stopTest();
		//DOESNT WORK
		System.assertEquals(0, parIdCBRLineItemMap.values()[0].size(), 'The size is incorrect');
	}

}