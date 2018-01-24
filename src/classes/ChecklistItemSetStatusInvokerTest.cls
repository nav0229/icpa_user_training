@isTest
private class ChecklistItemSetStatusInvokerTest {
	@isTest
	static void setStatusOfChecklistItem_givenListOfCaseIds_willChangeChecklistAndCaseStatus() {
		ChecklistItemDataAccessorMock checklistItemDAMock = new ChecklistItemDataAccessorMock();
		CaseDataAccessorMock caseDAMock = new CaseDataAccessorMock();
		LoanDataAccessorMock loanDAMock = new LoanDataAccessorMock();

		ChecklistItemSetStatusInvoker.checklistDA = checklistItemDAMock;
		ChecklistItemSetStatusInvoker.caseDA = caseDAMock;
		ChecklistItemSetStatusInvoker.loanDA = loanDAMock;

		MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
		caseMockBuilder.setField('Status', 'Valid');
		caseMockBuilder.setField('Id', caseMockBuilder.getMockId());
		Case testCase = (Case) caseMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder.setField('Borrower_s_Signature_Required__c', 'true');
		checklistItemMockBuilder.setField('Checklist_Item_Status__c', 'Valid');
		checklistItemMockBuilder.setField('Case__c', testCase.Id);
		checklistItemMockBuilder.setField('Id', checklistItemMockBuilder.getMockId());
		Checklist_Item__c testChecklistItem = (Checklist_Item__c) checklistItemMockBuilder.build();

		MockSObjectBuilder checklistItemMockBuilder2 = new MockSObjectBuilder(Checklist_Item__c.getSObjectType());
		checklistItemMockBuilder2.setField('Borrower_s_Signature_Required__c', 'true');
		checklistItemMockBuilder2.setField('Checklist_Item_Status__c', 'Valid');
		checklistItemMockBuilder2.setField('Case__c', testCase.Id);
		checklistItemMockBuilder2.setField('Id', checklistItemMockBuilder2.getMockId());
		Checklist_Item__c testChecklistItem2 = (Checklist_Item__c) checklistItemMockBuilder2.build();

		MockSObjectBuilder loanMockBuilder = new MockSObjectBuilder(Loan__c.getSObjectType());
		loanMockBuilder.setField('Status__c', '');
		loanMockBuilder.setField('Id', loanMockBuilder.getMockId());
		Loan__c testloan = (Loan__c) loanMockBuilder.build();

		checklistItemDAMock.getChecklistItemsByCaseIdsReturn.add(testChecklistItem);
		checklistItemDAMock.getChecklistItemsByCaseIdsReturn.add(testChecklistItem2);

		caseDAMock.getCasesByCaseIdsReturn.add(testCase);

		loanDAMock.getLoansByApplicationIdsReturn.add(testloan);

		Test.startTest();
			ChecklistItemSetStatusInvoker.setStatusOfChecklistItem(new List<Id>());
		Test.stopTest();

		System.assertEquals(1, checklistItemDAMock.getChecklistItemsByCaseIdsCallCount, 'Checklist item DA get method as not called the correct number of times.');
		System.assertEquals(1, caseDAMock.getCasesByCaseIdsCallCount, 'Case DA get method was not called the correct number of times.');

		System.assertEquals(1, checklistItemDAMock.updateChecklistItemsCallCount, 'Checklist item DA update method was not called the correct number of times.');
		System.assertEquals(1, caseDAMock.updateCasesCallCount, 'Case DA update method was not called the correct number of times.');
	}
}