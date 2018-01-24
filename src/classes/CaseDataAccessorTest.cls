@isTest
private class CaseDataAccessorTest {
	
	@isTest static void getCasesByCaseIds_givenACaseId_shouldRetrieveCase() {
		CaseDataAccessor caseDA = new CaseDataAccessor();

		Case testCase = new Case(
			Status = 'Requested',
			Origin = 'Application Requirement'
		);
		insert testCase;

		Test.startTest();
			List<Case> retrievedCases = caseDA.getCasesByCaseIds(new List<Id>{testCase.Id});
		Test.stopTest();

		System.assert(
			!retrievedCases.isEmpty(),
			'With the given Case Id, a Case should have been retrieved.'
		);

		System.assertEquals(
			testCase.Id,
			retrievedCases[0].Id,
			'With the given Case Id, the test case that was inserted should have been returned.'
		);
	}
	
	@isTest static void getCasesByApplicationIdsAndRecordType_GivenAnApplicationIdAndRecordType_shouldRetrieveCase() {
		CaseDataAccessor caseDA = new CaseDataAccessor();

		Application__c testApplication = TestDataUtil.insertApplication();

		Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
		Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
		Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CaseDataAccessor.RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

		Case testCase = new Case(
			Status = 'Requested',
			Origin = 'Application Requirement',
			RecordTypeId = docRequestRecordTypeId,
			Application__c = testApplication.Id
		);
		insert testCase;

		Test.startTest();
			List<Case> retrievedCases = caseDA.getCasesByApplicationIdsAndRecordType(new List<Id>{testApplication.Id}, testCase.RecordTypeId);
		Test.stopTest();

		System.assert(
			!retrievedCases.isEmpty(),
			'With the given Case Id, a Case should have been retrieved.'
		);

		System.assertEquals(
			testCase.Id,
			retrievedCases[0].Id,
			'With the given Case Id, the test case that was inserted should have been returned.'
		);
	}
	
	@isTest static void updateCases_givenACase_shouldUpdateCase() {
		CaseDataAccessor caseDA = new CaseDataAccessor();

		Case testCase = new Case(
			Status = 'Requested',
			Origin = 'Application Requirement',
			Subject = 'Before Update'
		);
		insert testCase;

		testCase.Subject = 'After Update';

		Test.startTest();
			caseDA.updateCases(new List<Case>{testCase});
		Test.stopTest();

		Case updatedCase = caseDA.getCasesByCaseIds(new List<Id>{testCase.Id}).get(0);

		System.assert(
			updatedCase != null,
			'With the given Case Id, a Case should have been retrieved.'
		);

		System.assertEquals(
			testCase.Id,
			updatedCase.Id,
			'With the given Case Id, the test case that was inserted should have been returned.'
		);

		System.assertEquals(
			testCase.Subject,
			updatedCase.Subject,
			'The test case that was inserted should have had its Subject field updated.'
		);
	}
}