@isTest
private class ChecklistItemGeneratorByDocReqCaseTest {
	
	@isTest static void handleChecklistGeneration_givenAListOfDocumentRequestCases_shouldGenerateChecklistItems() {
		ApplicationDataAccessorMock applicationMockDA = new ApplicationDataAccessorMock();
		ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
		CreditBureauDataAccessorMock creditBureauMockDA = new CreditBureauDataAccessorMock();
		EventRequestDataAccessorMock eventRequestMockDA = new EventRequestDataAccessorMock();
		InsuranceDataAccessorMock insuranceMockDA = new InsuranceDataAccessorMock();
		ChecklistItemDataAccessorMock checklistItemMockDA = new ChecklistItemDataAccessorMock();
		MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
		EventRequestGeneratorByChecklistItemMock eventRequestGeneratorMock = new EventRequestGeneratorByChecklistItemMock();

		ChecklistItemGeneratorByDocRequestCase.applicationDA = applicationMockDA;
		ChecklistItemGeneratorByDocRequestCase.applicantDA = applicantMockDA;
		ChecklistItemGeneratorByDocRequestCase.creditBureauDA = creditBureauMockDA;
		ChecklistItemGeneratorByDocRequestCase.eventRequestDA = eventRequestMockDA;
		ChecklistItemGeneratorByDocRequestCase.insuranceDA = insuranceMockDA;
		ChecklistItemGeneratorByDocRequestCase.checklistItemDA = checklistItemMockDA;
		ChecklistItemGeneratorByDocRequestCase.eventRequestGenerator = eventRequestGeneratorMock;
		ChecklistItemGenerator.masterChecklistDA = masterChecklistMockDA;
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();
		applicationMockDA.getApplicationsMapReturn.put(testApplication.Id, testApplication);

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();
		applicantMockDA.getApplicantsByApplicationIdsReturn.add(testApplicant);

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Name', 'Test Insurance');
		insuranceMockBuilder.setField('Type_of_Insurance_Coverage__c', 'Flood');
		insuranceMockBuilder.setField('Insurance_Company_Name__c', 'Test Insurance Company');
		insuranceMockBuilder.setField('Insurance_Agent_Phone_Number__c', '123-456-7890');
		insuranceMockBuilder.setField('Insurance_Policy_Number__c', '1234567890');
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());

		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();
		insuranceMockDA.getInsuranceByApplicationIdsReturn.add(testInsurance);

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();
		eventRequestMockDA.getEventRequestsByStageAndApplicationNumbersReturn.add(testRequest);

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);
		creditBureauMockBuilder.setField('Applicant_Name__c', testApplicant.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Success');

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();
		creditBureauMockDA.getActiveCreditBureausByApplicationIdsReturn.add(testCBR);

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();
		masterChecklistMockDA.getMasterChecklistsByChecklistCodesReturn.addAll(checklistCodeToMasterChecklistMap.values());

		Test.startTest();
			generator.handleChecklistGeneration(new List<Case>{testCase});
		Test.stopTest();

		System.assertNotEquals(
			0,
			checklistItemMockDA.insertChecklistItemsCallCount,
			'Checklist Items should have been inserted with the given case and valid related objects.'
		);

	}
	
	@isTest static void createApplicableChecklistItemsForCases_givenAnApplicantEmployedLessThanTwoYears_shouldCreatePaystubChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '1');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>(),
				new List<Credit_Bureau__c>(),
				null,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		//The default checklist items and a CBR CI will always be created, so base size of generated items is #default docs + 1
		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 2,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean lessThanTwoYearsEmployedChecklistCreated = false;
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.PAYSTUB_CODE).Id){
				lessThanTwoYearsEmployedChecklistCreated = true;
			}
		}

		System.assert(
			lessThanTwoYearsEmployedChecklistCreated,
			'Paystub checklist should be created if there is an applicant that has been employed less than two years.'
		);

	}

	@isTest static void createApplicableChecklistItemsForCases_givenANonUSCitizenApplicant_shouldGenerateResidentCardRequestChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'false');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>(),
				new List<Credit_Bureau__c>(),
				null,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		//The default checklist items and a CBR CI will always be created, so base size of generated items is #default docs + 1
		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 2,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean usResidentChecklistCreated = false;
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.RESIDENT_CARD_REQUEST_CODE).Id){
				usResidentChecklistCreated = true;
			}
		}

		System.assert(
			usResidentChecklistCreated,
			'Resident Card Request checklist should be created if there is an applicant that is not a US Citizen.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenAGreaterThanThresholdLegalRepFee_shouldGenerateRepresentativeInfoChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '10000');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>(),
				new List<Credit_Bureau__c>(),
				null,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		//The default checklist items and a CBR CI will always be created, so base size of generated items is #default docs + 1
		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 2,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean representativeNameChecklistCreated = false;
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.REPRESENTATIVE_NAME_CODE).Id){
				representativeNameChecklistCreated = true;
			}
		}

		System.assert(
			representativeNameChecklistCreated,
			'Representative name request checklist should be created if there is an applicant that has a Legal fee over the Threshold.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenIncompleteInsuranceInfo_shouldGenerateInsuranceInfoChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Name', 'Test Insurance');
		insuranceMockBuilder.setField('Type_of_Insurance_Coverage__c', 'Flood');
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());

		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>{testInsurance},
				new List<Credit_Bureau__c>(),
				null,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		//The default checklist items and a CBR CI will always be created, so base size of generated items is #default docs + 1
		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 2,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean insuranceInfoChecklistCreated = false;
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.INSURANCE_INFO_CODE).Id){
				insuranceInfoChecklistCreated = true;
			}
		}

		System.assert(
			insuranceInfoChecklistCreated,
			'Insurance Info request checklist it should be created if there is an incomplete Insurance record.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenAPassingCreditBureau_shouldGenerateReceivedCBRChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Name', 'Test Insurance');
		insuranceMockBuilder.setField('Type_of_Insurance_Coverage__c', 'Flood');
		insuranceMockBuilder.setField('Insurance_Company_Name__c', 'Test Insurance Company');
		insuranceMockBuilder.setField('Insurance_Agent_Phone_Number__c', '123-456-7890');
		insuranceMockBuilder.setField('Insurance_Policy_Number__c', '1234567890');
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());

		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);
		creditBureauMockBuilder.setField('Applicant_Name__c', testApplicant.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Success');

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>{testInsurance},
				new List<Credit_Bureau__c>{testCBR},
				testRequest,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 1,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean cbrChecklistCreated = false;
		Checklist_Item__c cbrChecklist = new Checklist_Item__c();
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE).Id){
				cbrChecklistCreated = true;
				cbrChecklist = item;
			}
		}

		System.assert(
			cbrChecklistCreated,
			'CBR Code checklist item should be created if there is an existing Credit Bureau record.'
		);

		System.assertEquals(
			ChecklistItemDataAccessor.RECEIVED_STATUS,
			cbrChecklist.Checklist_Item_Status__c,
			'With the valid CBR information, a successful checklist item should have been created.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenAFailingCreditBureau_shouldGenerateFailedCBRChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Name', 'Test Insurance');
		insuranceMockBuilder.setField('Type_of_Insurance_Coverage__c', 'Flood');
		insuranceMockBuilder.setField('Insurance_Company_Name__c', 'Test Insurance Company');
		insuranceMockBuilder.setField('Insurance_Agent_Phone_Number__c', '123-456-7890');
		insuranceMockBuilder.setField('Insurance_Policy_Number__c', '1234567890');
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());

		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);
		creditBureauMockBuilder.setField('Applicant_Name__c', testApplicant.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Error');

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>{testInsurance},
				new List<Credit_Bureau__c>{testCBR},
				testRequest,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 1,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean cbrChecklistCreated = false;
		Checklist_Item__c cbrChecklist = new Checklist_Item__c();
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE).Id){
				cbrChecklistCreated = true;
				cbrChecklist = item;
			}
		}

		System.assert(
			cbrChecklistCreated,
			'CBR Code checklist item should be created if there is an existing Credit Bureau record.'
		);

		System.assertEquals(
			ChecklistItemDataAccessor.FAILED_STATUS,
			cbrChecklist.Checklist_Item_Status__c,
			'With the invalid CBR information, a failed checklist item should have been created.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenAFailedEventRequest_shouldGenerateFailedCBRChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Name', 'Test Insurance');
		insuranceMockBuilder.setField('Type_of_Insurance_Coverage__c', 'Flood');
		insuranceMockBuilder.setField('Insurance_Company_Name__c', 'Test Insurance Company');
		insuranceMockBuilder.setField('Insurance_Agent_Phone_Number__c', '123-456-7890');
		insuranceMockBuilder.setField('Insurance_Policy_Number__c', '1234567890');
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());

		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_FAILURE);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);
		creditBureauMockBuilder.setField('Applicant_Name__c', testApplicant.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Error');

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>{testInsurance},
				new List<Credit_Bureau__c>{testCBR},
				testRequest,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 1,
			createdItems.size(),
			'With the given parameters, three checklist items should have been created.'
		);

		Boolean cbrChecklistCreated = false;
		Checklist_Item__c cbrChecklist = new Checklist_Item__c();
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.CBR_CODE).Id){
				cbrChecklistCreated = true;
				cbrChecklist = item;
			}
		}

		System.assert(
			cbrChecklistCreated,
			'CBR Code checklist item should be created if there is an existing Credit Bureau record.'
		);

		System.assertEquals(
			ChecklistItemDataAccessor.FAILED_STATUS,
			cbrChecklist.Checklist_Item_Status__c,
			'With the error on the related Event Request, a failed checklist item should have been created.'
		);
	}

	@isTest static void createApplicableChecklistItemsForCases_givenValidParameters_shouldGenerateRequestedIRSTranscriptChecklistItem() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Legal_Representative_Fee__c', '300');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Requested');
		caseMockBuilder.setField('Origin', 'Application Requirement');
		caseMockBuilder.setField('RecordTypeId', docRequestRecordTypeId);
		caseMockBuilder.setField('Application__c', testApplication.Id);
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
		applicantMockBuilder.setField('Name', 'Test Applicant');
		applicantMockBuilder.setField('Years_Employed__c', '3');
		applicantMockBuilder.setField('U_S_Citizen__c', 'true');
		applicantMockBuilder.setField('Application__c', testApplication.Id);
		applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

		Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

		MockSObjectBuilder insuranceMockBuilder = new MockSObjectBuilder(Insurance__c.getSObjectType());
		insuranceMockBuilder.setField('Name', 'Test Insurance');
		insuranceMockBuilder.setField('Type_of_Insurance_Coverage__c', 'Flood');
		insuranceMockBuilder.setField('Insurance_Company_Name__c', 'Test Insurance Company');
		insuranceMockBuilder.setField('Insurance_Agent_Phone_Number__c', '123-456-7890');
		insuranceMockBuilder.setField('Insurance_Policy_Number__c', '1234567890');
		insuranceMockBuilder.setField('Application__c', testApplication.Id);
		insuranceMockBuilder.setField('Id', insuranceMockBuilder.getMockId());

		Insurance__c testInsurance = (Insurance__c) insuranceMockBuilder.build();

		MockSObjectBuilder eventRequestMockBuilder = new MockSObjectBuilder(Event_Request__c.getSObjectType());
		eventRequestMockBuilder.setField('Application_Number__c', testApplication.Name);
		eventRequestMockBuilder.setField('Status__c', EventRequestDataAccessor.STATUS_SUCCESS);
		eventRequestMockBuilder.setField('Id', eventRequestMockBuilder.getMockId());

		Event_Request__c testRequest = (Event_Request__c) eventRequestMockBuilder.build();

		MockSObjectBuilder creditBureauMockBuilder = new MockSObjectBuilder(Credit_Bureau__c.getSObjectType());
		creditBureauMockBuilder.setField('Name', 'Test Credit Bureau');
		creditBureauMockBuilder.setField('Application__c', testApplication.Id);
		creditBureauMockBuilder.setField('Applicant_Name__c', testApplicant.Id);
		creditBureauMockBuilder.setField('Active__c', 'true');
		creditBureauMockBuilder.setField('CBR_Request_Result__c', 'Success');

		Credit_Bureau__c testCBR = (Credit_Bureau__c) creditBureauMockBuilder.build();

		Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = buildChecklistCodeToMasterChecklistMap();

		Test.startTest();
			List<Checklist_Item__c> createdItems = generator.createApplicableChecklistItemsForCases(
				testCase,
				new List<Applicant__c>{testApplicant},
				testApplication,
				new List<Insurance__c>{testInsurance},
				new List<Credit_Bureau__c>{testCBR},
				testRequest,
				checklistCodeToMasterChecklistMap
			);
		Test.stopTest();

		//The default checklist items and a CBR CI will always be created, so base size of generated items is #default docs + 1
		System.assertEquals(
			MasterChecklistDataAccessor.DEFAULT_DOC_REQ_CODES.size() + 1,
			createdItems.size(),
			'With the given parameters, two checklist items should have been created.'
		);

		Boolean irsTranscriptChecklistCreated = false;
		for(Checklist_Item__c item : createdItems){
			if(item.Master_Checklist__c == checklistCodeToMasterChecklistMap.get(MasterChecklistDataAccessor.IRS_TRANSCRIPT_CODE).Id){
				irsTranscriptChecklistCreated = true;
			}
		}

		System.assert(
			irsTranscriptChecklistCreated,
			'IRS Transcript checklist item should be created if there are valid parameters provided.'
		);

	}

	@isTest static void handleChecklistGeneration_givenAListOfApplications_shouldCauseAnError() {
		ChecklistItemGeneratorByDocRequestCase generator = new ChecklistItemGeneratorByDocRequestCase();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', 'Test Application');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		Test.startTest();
			Boolean invalidTypeExceptionOccurred = false;
			try{
				generator.handleChecklistGeneration(new List<Application__c>{testApplication});
			}
			catch (ChecklistItemGeneratorByDocRequestCase.ChecklistItemGeneratorByDocRequestCaseException e){
				invalidTypeExceptionOccurred = true;
			}
		Test.stopTest();

		System.assert(
			invalidTypeExceptionOccurred,
			'When the handleChecklistGeneration is passed a list of objects other than Event Request, an exception should occur.'
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