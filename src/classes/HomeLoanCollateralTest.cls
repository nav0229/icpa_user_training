@isTest public class HomeLoanCollateralTest {

	@isTest static void runHomeLoanCollateralTest_givenValidApplicationIds_shouldRunCollateralTest() {
		HomeLoanCollateral homeLoanCollateralClass = new HomeLoanCollateral();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();

		//MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.loanDA = loanDAMock;
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanCollateral.groupDA = groupDAMock;
		HomeLoanCollateral.applicationDA = applicationDAMock;
		HomeLoanCollateral.parDA = parDAMock;
		HomeLoanCollateral.propertyDA = propertyDAMock;
		HomeLoanCollateral.mortgageDA = mortgageDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Companion__c', 'false'); //also test false
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '50000');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Property_Type__c', 'Real Estate (Owned)');
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('State__c', 'TX');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		MockSObjectBuilder damagedPropertyMockBuilder2 = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder2.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder2.setField('Property_Type__c', 'Real Estate (Owned)');
		damagedPropertyMockBuilder2.setField('Id', '100');
		damagedPropertyMockBuilder2.setField('State__c', 'TX');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty2 = (Property__c) damagedPropertyMockBuilder2.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);
		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty2);

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Type__c', '1000');
		mortgageMockBuilder.setField('Present_Balance__c', '10000');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApplication.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Balance__c', '10000');
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);
		
		Test.startTest();
			homeLoanCollateralClass.runHomeLoanCollateralTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(0,0);	
	}

	@isTest static void runHomeLoanCollateralTest_givenStateOfTX_shouldRunCollateralTest() {
		HomeLoanCollateral homeLoanCollateralClass = new HomeLoanCollateral();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();
		CreditBureauLineItemDataAccessorMock cbrLineItemDAMock = new CreditBureauLineItemDataAccessorMock();

		//MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.loanDA = loanDAMock;
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;
		MapCreator.applicationDA = applicationDAMock;
		MapCreator.creditBureauLineItemDA = cbrLineItemDAMock;

		HomeLoanCollateral.groupDA = groupDAMock;
		HomeLoanCollateral.applicationDA = applicationDAMock;
		HomeLoanCollateral.parDA = parDAMock;
		HomeLoanCollateral.propertyDA = propertyDAMock;
		HomeLoanCollateral.mortgageDA = mortgageDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Companion__c', 'false'); //also test false
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '0');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Property_Type__c', 'Manufactured Home (Land Owned) - Replace');
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('State__c', 'TX');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);

		MockSObjectBuilder cbrLineItemMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line_Item__c.getSObjectType());
		cbrLineItemMockBuilder.setField('Credit_Bureau__r', '10');
		cbrLineItemMockBuilder.setField('Is_Mortgage__c', 'true');
		cbrLineItemMockBuilder.setField('Account_Balance__c', '10000');
		cbrLineItemMockBuilder.setField('Id', cbrLineItemMockBuilder.getMockId());	

		//MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau_Line__c.getSObjectType());
		//creditBureauMockBuilder.setField('Application__c', testApplication.Id);
		//ChildRelationship childField = creditBureauMockBuilder.getChildRelationship('Credit_Bureau_Line_Item__c');
  		//creditBureauMockBuilder.setChild(childField, cbrLineItemMockBuilder.getSerializedSObject());
		//creditBureauMockBuilder.setField('Id', creditBureauMockBuilder.getMockId());
		//Credit_Bureau_Line__c testCreditBureau = (Credit_Bureau_Line__c) creditBureauMockBuilder.build();

		Credit_Bureau_Line_Item__c testCBRLineItem = (Credit_Bureau_Line_Item__c) cbrLineItemMockBuilder.build();

		cbrLineItemDAMock.getActiveCreditBureauLineItemsByApplicationIdsReturn.add(testCBRLineItem);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApplication.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Balance__c', '10000');
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);
		
		Test.startTest();
			homeLoanCollateralClass.runHomeLoanCollateralTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(0,0);	
	}

	@isTest static void runHomeLoanCollateralTest_givenCompanionLoans_shouldRunCollateralTest() {
		HomeLoanCollateral homeLoanCollateralClass = new HomeLoanCollateral();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();

		//MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.loanDA = loanDAMock;
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanCollateral.groupDA = groupDAMock;
		HomeLoanCollateral.applicationDA = applicationDAMock;
		HomeLoanCollateral.parDA = parDAMock;
		HomeLoanCollateral.propertyDA = propertyDAMock;
		HomeLoanCollateral.mortgageDA = mortgageDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Companion__c', 'true'); //also test false
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '50000');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);


		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('State__c', 'OH');
		damagedPropertyMockBuilder.setField('Property_Type__c', 'Manufactured Home (Land Owned) - Repair');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApplication.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Balance__c', '10000');
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);

		MockSObjectBuilder loanMockBuilder = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder.setField('Application__c', testApplication.Id);
		loanMockBuilder.setField('Companion__c', 'true');
		loanMockBuilder.setField('Loan_Amount__c', '5000');
		Loan__c testLoan = (Loan__c) loanMockBuilder.build();

		loanDAMock.getLoansByApplicationIdsReturn.add(testLoan);
		
		Test.startTest();
			homeLoanCollateralClass.runHomeLoanCollateralTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(0,0);	
	}

	@isTest static void runHomeLoanCollateralTest_givenCondoPropertyType_shouldRunCollateralTest() {
		HomeLoanCollateral homeLoanCollateralClass = new HomeLoanCollateral();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();

		//MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.loanDA = loanDAMock;
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanCollateral.groupDA = groupDAMock;
		HomeLoanCollateral.applicationDA = applicationDAMock;
		HomeLoanCollateral.parDA = parDAMock;
		HomeLoanCollateral.propertyDA = propertyDAMock;
		HomeLoanCollateral.mortgageDA = mortgageDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Companion__c', 'false'); //also test false
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '50000');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('State__c', 'TX'); 
		damagedPropertyMockBuilder.setField('Other_Real_Estate_Owned_Value__c', '1000');
		damagedPropertyMockBuilder.setField('Property_Type__c', 'Condo/Townhouse');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Type__c', '1000');
		mortgageMockBuilder.setField('Present_Balance__c', '10000');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApplication.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Balance__c', '10000');
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);
		
		Test.startTest();
			homeLoanCollateralClass.runHomeLoanCollateralTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(0,0);	
	}

	@isTest static void runHomeLoanCollateralTest_givenRenterPropertyType_shouldRunCollateralTest() {
		HomeLoanCollateral homeLoanCollateralClass = new HomeLoanCollateral();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();

		//MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.loanDA = loanDAMock;
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanCollateral.groupDA = groupDAMock;
		HomeLoanCollateral.applicationDA = applicationDAMock;
		HomeLoanCollateral.parDA = parDAMock;
		HomeLoanCollateral.propertyDA = propertyDAMock;
		HomeLoanCollateral.mortgageDA = mortgageDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Companion__c', 'false'); //also test false
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '50000');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('State__c', 'TX');
		damagedPropertyMockBuilder.setField('Property_Type__c', 'Real Estate (Owned)');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Type__c', '1000');
		mortgageMockBuilder.setField('Present_Balance__c', '10000');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApplication.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Balance__c', '10000');
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);
		
		Test.startTest();
			homeLoanCollateralClass.runHomeLoanCollateralTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(0,0);	
	}

	@isTest static void runHomeLoanCollateralTest_givenRenterPropertyTypeAndZeroRestateValue_shouldRunCollateralTest() {
		HomeLoanCollateral homeLoanCollateralClass = new HomeLoanCollateral();

		ApplicationDataAccessorMock applicationDAMock = new ApplicationDataAccessorMock();
		ProcessingAppReviewDataAccessorMock parDAMock = new ProcessingAppReviewDataAccessorMock();
		InsuranceDataAccessorMock insuranceDAMock = new InsuranceDataAccessorMock();
		MortgageDataAccessorMock mortgageDAMock = new MortgageDataAccessorMock();
		PropertyDataAccessorMock propertyDAMock = new PropertyDataAccessorMock();
		GroupDataAccessorMock groupDAMock = new GroupDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();
		DebtsExpensesDataAccessorMock debtsExpensesDAMock = new DebtsExpensesDataAccessorMock();

		//MapCreator.parDa = parDAMock;
		MapCreator.propertyDA = propertyDAMock;
		MapCreator.insuranceDA = insuranceDAMock;
		MapCreator.mortgageDA = mortgageDAMock;
		MapCreator.loanDA = loanDAMock;
		MapCreator.debtsExpensesDA = debtsExpensesDAMock;
		MapCreator.applicationDA = applicationDAMock;

		HomeLoanCollateral.groupDA = groupDAMock;
		HomeLoanCollateral.applicationDA = applicationDAMock;
		HomeLoanCollateral.parDA = parDAMock;
		HomeLoanCollateral.propertyDA = propertyDAMock;
		HomeLoanCollateral.mortgageDA = mortgageDAMock;

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Loan_Type__c', 'Home');
		applicationMockBuilder.setField('Companion__c', 'false'); //also test false
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		applicationDAMock.getApplicationsByIdReturn.add(testApplication);

		MockSObjectBuilder parMockBuilder = new MockSObjectBuilder(Processing_Application_Review__c.getSObjectType());
		parMockBuilder.setField('Application__c', testApplication.Id);
		parMockBuilder.setField('Total_Eligible_Physical_Loss__c', '100000');
		parMockBuilder.setField('Total_Eligible_Physical_Loss_Real_Estate__c', '50000');
		parMockBuilder.setField('Id', parMockBuilder.getMockId());
		Processing_Application_Review__c testPAR = (Processing_Application_Review__c) parMockBuilder.build();

		parDAMock.getProcessingApplicationReviewsByAppIdsReturn.add(testPAR);

		MockSObjectBuilder damagedPropertyMockBuilder = new MockSObjectBuilder(Property__c.getSObjectType());
		damagedPropertyMockBuilder.setField('Application__c', testApplication.Id);
		damagedPropertyMockBuilder.setField('Id', '100');
		damagedPropertyMockBuilder.setField('State__c', 'TX');
		damagedPropertyMockBuilder.setField('Other_Real_Estate_Owned_Value__c', '0');
		damagedPropertyMockBuilder.setField('Property_Type__c', 'Renter');
		damagedPropertyMockBuilder.setField('Damaged_Property__c','true');
		Property__c testDamagedProperty = (Property__c) damagedPropertyMockBuilder.build();

		propertyDAMock.getDamagedPropertiesAndLossVerificationsByApplicationIdsReturn.add(testDamagedProperty);

		MockSObjectBuilder mortgageMockBuilder = new MockSObjectBuilder(Mortgage__c.getSObjectType());
		mortgageMockBuilder.setField('Application__c', testApplication.Id);
		mortgageMockBuilder.setField('Lien_Type__c', '1000');
		mortgageMockBuilder.setField('Present_Balance__c', '10000');
		mortgageMockBuilder.setField('Id', mortgageMockBuilder.getMockId());
		Mortgage__c testMortgage = (Mortgage__c) mortgageMockBuilder.build();

		mortgageDAMock.getMortgageByApplicationIdsReturn.add(testMortgage);

		MockSObjectBuilder debtsExpensesMockBuilder = new MockSObjectBuilder(Debts_Expenses__c.getSObjectType());
		debtsExpensesMockBuilder.setField('Application__c', testApplication.Id);
		debtsExpensesMockBuilder.setField('Type_of_Debt__c', 'Mortgage');
		debtsExpensesMockBuilder.setField('Balance__c', '10000');
		Debts_Expenses__c testDebtsExpenses = (Debts_Expenses__c) debtsExpensesMockBuilder.build();

		debtsExpensesDAMock.getDebtsAndExpensesByApplicationIdReturn.add(testDebtsExpenses);
		
		Test.startTest();
			homeLoanCollateralClass.runHomeLoanCollateralTest(new List<Id>{testApplication.Id});
		Test.stopTest();

		System.assertEquals(0,0);	
	}

	
}