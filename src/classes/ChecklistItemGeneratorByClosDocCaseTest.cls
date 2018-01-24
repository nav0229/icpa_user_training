@isTest
private class ChecklistItemGeneratorByClosDocCaseTest {
	
	@isTest static void handleChecklistGeneration_givenAListOfClosingDocumentCases_shouldGenerateChecklistItemsAndElements() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		LoanConditionChecklistDataAccessorMock loanConditionChecklistMockDA = new LoanConditionChecklistDataAccessorMock();
		LoanConditionElementDataAccessorMock loanConditionElementMockDA = new LoanConditionElementDataAccessorMock();
		ChecklistItemElementDataAccessorMock checklistItemElementMockDA = new ChecklistItemElementDataAccessorMock();
		ChecklistItemDrawloopNextPopulatorMock drawloopNextPopulatorMock = new ChecklistItemDrawloopNextPopulatorMock();

		ChecklistItemGeneratorByClosingDocCase.applicationDA = applicationMockDA;
		ChecklistItemGeneratorByClosingDocCase.checklistItemDA = checklistItemMockDA;
		ChecklistItemGenerator.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemGeneratorByClosingDocCase.loanConditionChecklistDA = loanConditionChecklistMockDA;
		ChecklistItemGeneratorByClosingDocCase.loanConditionElementDA = loanConditionElementMockDA;
		ChecklistItemGeneratorByClosingDocCase.checklistItemElementDA = checklistItemElementMockDA;
		ChecklistItemGeneratorByClosingDocCase.drawloopNextPopulator = drawloopNextPopulatorMock;
		ChecklistItemGeneratorByClosingDocCase generator = new ChecklistItemGeneratorByClosingDocCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApplication.Id, testApplication);

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id closingDocRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_CLOSING_DOCUMENT).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', closingDocRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();
		masterChecklistMockDA.getMasterChecklistsByChecklistCodesReturn.addAll(checklistCodeToMasterChecklistMap.values());

		MockSObjectBuilder loanConditionMockBuilder = new MockSObjectBuilder(Loan_Condition_Checklist__c.getSObjectType());
		loanConditionMockBuilder.setField('Name', 'Test Loan Condition');
		loanConditionMockBuilder.setField('Active__c', 'true');
		loanConditionMockBuilder.setField('Loan_Condition_Type__c', 'Property');
		loanConditionMockBuilder.setField('Master_Checklist__c', checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.OC_SHD_LOAN_CONDITION_CODE).Id);
		loanConditionMockBuilder.setField('Application__c', testApplication.Id);
		loanConditionMockBuilder.setField('Id', loanConditionMockBuilder.getMockId());
		
		Loan_Condition_Checklist__c testLoanCondition = (Loan_Condition_Checklist__c) loanConditionMockBuilder.build();
		loanConditionChecklistMockDA.getActiveLoanConditionChecklistsByApplicationIdsReturn.add(testLoanCondition);

		MockSObjectBuilder loanConditionElementMockBuilder = new MockSObjectBuilder(Loan_Condition_Element__c.getSObjectType());
		loanConditionElementMockBuilder.setField('Name', 'Test Loan Condition Element');
		loanConditionElementMockBuilder.setField('Loan_Condition__c', testLoanCondition.Id);
		loanConditionElementMockBuilder.setField('Element_Type__c', LoanConditionElementDataAccessor.SHARED_REPAIR_RESPONSIBILITY_TYPE);
		loanConditionElementMockBuilder.setField('Id', loanConditionElementMockBuilder.getMockId());
		
		Loan_Condition_Element__c testLoanConditionElement = (Loan_Condition_Element__c) loanConditionElementMockBuilder.build();
		loanConditionElementMockDA.getLoanConditionElementsByLoanConditionChecklistIdsReturn.add(testLoanConditionElement);

		Test.startTest();
			generator.handleChecklistGeneration(new List<Case>{testCase});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.insertChecklistItemsCallCount,
			'Checklist Items should have been inserted with the given case and valid related objects.'
		);

		System.assertNotEquals(
			0,
			checklistItemElementMockDA.insertChecklistItemElementsCallCount,
			'Checklist Item Elements should have been inserted with the given case and valid related objects.'
		);
	}

	@isTest static void handleChecklistGeneration_givenAListOfApplications_shouldCauseAnError() {
		ChecklistItemGeneratorByClosingDocCase generator = new ChecklistItemGeneratorByClosingDocCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Test.startTest();
			Boolean invalidTypeExceptionOccurred = false;
			try{
				generator.handleChecklistGeneration(new List<Application__c>{testApplication});
			}
			catch (ChecklistItemGeneratorByClosingDocCase.ChecklistItemGeneratorByClosingDocCaseException e){
				invalidTypeExceptionOccurred = true;
			}
		Test.stopTest();

		System.assert(
			invalidTypeExceptionOccurred,
			'When the handleChecklistGeneration is passed a list of objects other than Event Request, an exception should occur.'
		);	
	}

	@isTest static void createApplicableChecklistItemsForCases_givenAClosingDocumentCaseAndOCSHDLoanCondition_shouldGenerateChecklistItem() {
		ChecklistItemGeneratorByClosingDocCase generator = new ChecklistItemGeneratorByClosingDocCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id closingDocRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_CLOSING_DOCUMENT).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', closingDocRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		generator.checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		MockSObjectBuilder loanConditionMockBuilder = new MockSObjectBuilder(Loan_Condition_Checklist__c.getSObjectType());
		loanConditionMockBuilder.setField('Name', 'Test Loan Condition');
		loanConditionMockBuilder.setField('Active__c', 'true');
		loanConditionMockBuilder.setField('Loan_Condition_Type__c', 'Property');
		loanConditionMockBuilder.setField('Master_Checklist__c', generator.checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.OC_SHD_LOAN_CONDITION_CODE).Id);
		loanConditionMockBuilder.setField('Id', loanConditionMockBuilder.getMockId());

		Loan_Condition_Checklist__c testLoanCondition = (Loan_Condition_Checklist__c) loanConditionMockBuilder.build();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(testCase, testApplication, new List<Loan_Condition_Checklist__c>{testLoanCondition});
		Test.stopTest();

		System.assertNotEquals(
			0,
			createdItems.size(),
			'Checklist Item should have been created with the given case and loan condition.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenAClosingDocumentCaseAndCondiminiumRepairsLoanCondition_shouldGenerateChecklistItem() {
		ChecklistItemGeneratorByClosingDocCase generator = new ChecklistItemGeneratorByClosingDocCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id closingDocRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_CLOSING_DOCUMENT).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', closingDocRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		generator.checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		MockSObjectBuilder loanConditionMockBuilder = new MockSObjectBuilder(Loan_Condition_Checklist__c.getSObjectType());
		loanConditionMockBuilder.setField('Name', 'Test Loan Condition');
		loanConditionMockBuilder.setField('Active__c', 'true');
		loanConditionMockBuilder.setField('Loan_Condition_Type__c', 'Property');
		loanConditionMockBuilder.setField('Master_Checklist__c', generator.checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.LC_CONDOMINIUM_REPAIRS).Id);
		loanConditionMockBuilder.setField('Id', loanConditionMockBuilder.getMockId());

		Loan_Condition_Checklist__c testLoanCondition = (Loan_Condition_Checklist__c) loanConditionMockBuilder.build();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(testCase, testApplication, new List<Loan_Condition_Checklist__c>{testLoanCondition});
		Test.stopTest();

		System.assertNotEquals(
			0,
			createdItems.size(),
			'Checklist Item should have been created with the given case and loan condition.'
		);
	}


	private static Map<String, Master_Checklist__c> buildChecklistCodeToMasterChecklistMap(){
		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = new Map<String, Master_Checklist__c>();
		List<String> checklistCodes = new List<String>();
		checklistCodes.addAll(MasterChecklistDataAccessor.CHECKLIST_CODES);
		MockSObjectBuilder masterChecklistMockBuilder = new MockSObjectBuilder(Master_Checklist__c.getSObjectType());

		for(String code : checklistCodes) {
			masterChecklistMockBuilder.setField('Checklist_Code__c', code);
			masterChecklistMockBuilder.setField('Name', 'Test MC ' + code);
			masterChecklistMockBuilder.setField('Checklist_Description__c', 'Description ' + code);
			masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());
			Master_Checklist__c testMC = (Master_Checklist__c) masterChecklistMockBuilder.build();
			checklistCodeToMasterChecklistMap.put(code, testMC);
		}
		return checklistCodeToMasterChecklistMap;
	}
	
}