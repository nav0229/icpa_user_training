@isTest public class LoanTriggerHelperTest {

	@isTest static void handleReRunStatusChangesAndDisbursement_given(){

	}

	@isTest static void createEventRequestReRunRecords(){

	}

	@isTest static void getApplicationMapFromLoans(){

	}		

	@isTest static void createEventRequestOrderReRun(){

	}

	@isTest static void isloanReRunFlagStatusErrorOrBlank(){

	}

	@isTest static void assignLoanStatus(){

	}

	@isTest static void createAndInsertDisbursements_givenLoans_shouldInsertDisbursements(){
		DisbursementDataAccessorMock disbursementDAmock = new DisbursementDataAccessorMock();
		LoanTriggerHelper.disbursementDA = disbursementDAmock;

		LoanTriggerHelper loanTriggerHelp = new LoanTriggerHelper();

        List<Disbursement__c> disbursements = new List<Disbursement__c>();

        MockSObjectBuilder loanMockBuilder = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder.setField('Application__c', '100');
		loanMockBuilder.setField('Status__c', LoanDataAccessor.READY_FOR_DISBURSEMENT);
		loanMockBuilder.setField('Id', loanMockBuilder.getMockId());
		Loan__c testLoan = (Loan__c) loanMockBuilder.build();

		MockSObjectBuilder loanMockBuilder2 = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder2.setField('Application__c', '101');
		loanMockBuilder2.setField('Status__c', LoanDataAccessor.READY_FOR_DISBURSEMENT);
		loanMockBuilder2.setField('Id', loanMockBuilder2.getMockId());
		Loan__c testLoan2 = (Loan__c) loanMockBuilder2.build();

		List<Loan__c> loans = new List<Loan__c>{testLoan, testLoan2};

		Test.startTest();
			loanTriggerHelp.createAndInsertDisbursements(loans);
		Test.stopTest();

		System.assertEquals(1, disbursementDAmock.insertDisbursementsCallCount, 'Event Request data accessor was not called one time');

	}

	@isTest static void initiateDisbursementEventRequest_givenLoansAndApplicationMap_shouldCreateAndInsertEventRequests(){
		EventRequestDataAccessorMock eventRequestDAmock = new EventRequestDataAccessorMock();
		LoanTriggerHelper.eventRequestDA = eventRequestDAmock;

		LoanTriggerHelper loanTriggerHelp = new LoanTriggerHelper();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Application__c', '1');
		applicationMockBuilder.setField('Name', 'test Name');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
		Application__c testApplication = (Application__c) applicationMockBuilder.build();

		MockSObjectBuilder loanMockBuilder = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder.setField('Application__c', testApplication.Id);
		loanMockBuilder.setField('Status__c', LoanDataAccessor.INITIATE_DISBURSEMENT);
		loanMockBuilder.setField('Id', loanMockBuilder.getMockId());
		Loan__c testLoan = (Loan__c) loanMockBuilder.build();

		MockSObjectBuilder loanMockBuilder2 = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder2.setField('Application__c', testApplication.Id);
		loanMockBuilder2.setField('Status__c', LoanDataAccessor.INITIATE_DISBURSEMENT);
		loanMockBuilder2.setField('Id', loanMockBuilder2.getMockId());
		Loan__c testLoan2 = (Loan__c) loanMockBuilder2.build();

		Map<Id, Application__c> applicationMap = new Map<Id, Application__c> {testApplication.Id => testApplication};
		List<Loan__c> loans = new List<Loan__c>{testLoan, testLoan2};

		Test.startTest();
			loanTriggerHelp.initiateDisbursementEventRequest(loans, applicationMap);
		Test.stopTest();

		System.assertEquals(1, eventRequestDAmock.insertEventRequestsCallCount, 'Event Request data accessor was not called one time');
	}

}