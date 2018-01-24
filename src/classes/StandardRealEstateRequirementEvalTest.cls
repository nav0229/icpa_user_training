@isTest
private class StandardRealEstateRequirementEvalTest {
    
    @isTest static void evaluateStandardRealEstateRequirement_givenAnApplicationIdWithValidRelatedObjects_shouldCreateNewLoanConditionChecklist() {
        LossVerificationDataAccessorMock lossVerificationMockDA = new LossVerificationDataAccessorMock();
        LoanConditionChecklistDataAccessorMock loanConditionMockDA = new LoanConditionChecklistDataAccessorMock();
        MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
        LoanDataAccessorMock loanMockDA = new LoanDataAccessorMock();
        StandardRealEstateRequirementEvaluator.lossVerificationDA = lossVerificationMockDA;
        StandardRealEstateRequirementEvaluator.loanConditionDA = loanConditionMockDA;
        StandardRealEstateRequirementEvaluator.masterChecklistDA = masterChecklistMockDA;
        StandardRealEstateRequirementEvaluator.loanDA = loanMockDA;
        StandardRealEstateRequirementEvaluator stdRealEstateEval = new StandardRealEstateRequirementEvaluator();

        MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
        applicationMockBuilder.setField('Name', '12345678');
        applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

        Application__c testApp = (Application__c) applicationMockBuilder.build();

        MockSObjectBuilder loanMockBuilder = new MockSObjectBuilder(Loan__c.getSObjectType());
        loanMockBuilder.setField('Name', 'Test Loan');
        loanMockBuilder.setField('Application__c', testApp.Id);
        loanMockBuilder.setField('Id', loanMockBuilder.getMockId());

        Loan__c testLoan = (Loan__c) loanMockBuilder.build();
        loanMockDA.getLoansByApplicationIdsReturn.add(testLoan);

        MockSObjectBuilder lossVerificationMockBuilder = new MockSObjectBuilder(Loss_Verification_Inspections__c.getSObjectType());
        lossVerificationMockBuilder.setField('Name', 'Test Loss Verification');
        lossVerificationMockBuilder.setField('Application__c', testApp.Id);
        lossVerificationMockBuilder.setField('Loan__c', testLoan.Id);
        lossVerificationMockBuilder.setField('Real_Estate_Verified_Loss__c', '100.01');
        lossVerificationMockBuilder.setField('Id', lossVerificationMockBuilder.getMockId());

        Loss_Verification_Inspections__c testLossVerification = (Loss_Verification_Inspections__c) lossVerificationMockBuilder.build();
        lossVerificationMockDA.getLossVerificationsByLoanIdsReturn.add(testLossVerification);

        MockSObjectBuilder masterChecklistMockBuilder = new MockSObjectBuilder(Master_Checklist__c.getSObjectType());
        masterChecklistMockBuilder.setField('Name', 'Test RE STD Document Checklist');
        masterChecklistMockBuilder.setField('Checklist_Code__c', 'RE-STD');
        masterChecklistMockBuilder.setField('Id', masterChecklistMockBuilder.getMockId());

        Master_Checklist__c testMasterChecklist = (Master_Checklist__c) masterChecklistMockBuilder.build();
        masterChecklistMockDA.getMasterChecklistByChecklistCodeReturn = testMasterChecklist;

        Test.startTest();
            stdRealEstateEval.evaluateStandardRealEstateRequirement(new List<Id>{testApp.Id});
        Test.stopTest();

        System.assert(
            loanConditionMockDA.insertLoanConditionChecklistsCallCount > 0,
            'With the given Application Id and related objects, a Loan Condition junction object should have been created.'
        );
    }

    @isTest static void evaluateStandardRealEstateRequirement_givenAnApplicationIdWithNoRelatedObjects_shouldNotCreateNewLoanConditionChecklist() {
        LossVerificationDataAccessorMock lossVerificationMockDA = new LossVerificationDataAccessorMock();
        LoanConditionChecklistDataAccessorMock loanConditionMockDA = new LoanConditionChecklistDataAccessorMock();
        MasterChecklistDataAccessorMock masterChecklistMockDA = new MasterChecklistDataAccessorMock();
        LoanDataAccessorMock loanMockDA = new LoanDataAccessorMock();
        StandardRealEstateRequirementEvaluator.lossVerificationDA = lossVerificationMockDA;
        StandardRealEstateRequirementEvaluator.loanConditionDA = loanConditionMockDA;
        StandardRealEstateRequirementEvaluator.masterChecklistDA = masterChecklistMockDA;
        StandardRealEstateRequirementEvaluator.loanDA = loanMockDA;
        StandardRealEstateRequirementEvaluator stdRealEstateEval = new StandardRealEstateRequirementEvaluator();

        MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
        applicationMockBuilder.setField('Name', '12345678');
        applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

        Application__c testApp = (Application__c) applicationMockBuilder.build();

        Test.startTest();
            stdRealEstateEval.evaluateStandardRealEstateRequirement(new List<Id>{testApp.Id});
        Test.stopTest();

        System.assert(
            loanConditionMockDA.insertLoanConditionChecklistsCallCount == 0,
            'With the given Application Id and no related objects, a Loan Condition junction object should not have been created.'
        );
    }
}