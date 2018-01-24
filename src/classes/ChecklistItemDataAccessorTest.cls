@isTest
private class ChecklistItemDataAccessorTest {
	
	@isTest static void insertChecklistItems_givenAChecklistItem_shouldInsertChecklistItem() {
		ChecklistItemDataAccessor checklistItemDA = new ChecklistItemDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test MC',
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Case testCase = TestDataUtil.insertCase();

		Checklist_Item__c testChecklistItem = new Checklist_Item__c(
			Case__c = testCase.Id,
			Master_Checklist__c = testMasterChecklist.Id,
			Application__c = testCase.Application__c
		);

		Test.startTest();
			checklistItemDA.insertChecklistItems(new List<Checklist_Item__c>{testChecklistItem});
		Test.stopTest();

		System.assert(
			testChecklistItem.Id != null,
			'The given checklist item should have been inserted.'
		);
	}
	
	@isTest static void updateChecklistItems_givenAChecklistItem_shouldUpdateChecklistItem() {
		ChecklistItemDataAccessor checklistItemDA = new ChecklistItemDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test MC',
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Case testCase = TestDataUtil.insertCase();

		Checklist_Item__c testChecklistItem = new Checklist_Item__c(
			Case__c = testCase.Id,
			Master_Checklist__c = testMasterChecklist.Id,
			Application__c = testCase.Application__c
		);
		insert testChecklistItem;

		testChecklistItem.Name = 'Test Checklist Item';

		Test.startTest();
			checklistItemDA.updateChecklistItems(new List<Checklist_Item__c>{testChecklistItem});
		Test.stopTest();

		Checklist_Item__c updatedChecklistItem = [
			SELECT Id, Name
			FROM Checklist_Item__c
			WHERE Id =:testChecklistItem.Id
			LIMIT 1
		];

		System.assert(
			updatedChecklistItem != null,
			'With the given checklist item Id, a checklist item should have been retrieved.'
		);

		System.assertEquals(
			testChecklistItem.Name,
			updatedChecklistItem.Name,
			'The test checklist item that was inserted should have been updated.'
		);
	}

	@isTest static void getChecklistItemsByApplicationIdsAndMasterChecklistId_givenAnAppIdAndMasterChecklistId_shouldRetrieveChecklistItem() {
		ChecklistItemDataAccessor checklistItemDA = new ChecklistItemDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test MC',
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Case testCase = TestDataUtil.insertCase();

		Checklist_Item__c testChecklistItem = new Checklist_Item__c(
			Case__c = testCase.Id,
			Master_Checklist__c = testMasterChecklist.Id,
			Application__c = testCase.Application__c
		);
		insert testChecklistItem;

		Test.startTest();
			List<Checklist_Item__c> retrievedItems = checklistItemDA.getChecklistItemsByApplicationIdsAndMasterChecklistId(
				new List<Id>{testCase.Application__c}, testMasterChecklist.Id
			);
		Test.stopTest();

		System.assert(
			!retrievedItems.isEmpty(),
			'With the given Application Id and Master Checklist Id, a Checklist Item should have been returned.'
		);

		System.assertEquals(
			testChecklistItem.Id,
			retrievedItems[0].Id,
			'The retrieved checklist item should be the test checklist item that was inserted.'
		);
	}

	@isTest static void getChecklistItemsByCaseIds_givenACaseId_shouldRetrieveChecklistItem() {
		ChecklistItemDataAccessor checklistItemDA = new ChecklistItemDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test MC',
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Case testCase = TestDataUtil.insertCase();

		Checklist_Item__c testChecklistItem = new Checklist_Item__c(
			Case__c = testCase.Id,
			Master_Checklist__c = testMasterChecklist.Id,
			Application__c = testCase.Application__c
		);
		insert testChecklistItem;

		Test.startTest();
			List<Checklist_Item__c> retrievedItems = checklistItemDA.getChecklistItemsByCaseIds(
				new List<Id>{testCase.Id}
			);
		Test.stopTest();

		System.assert(
			!retrievedItems.isEmpty(),
			'With the given Case Id, a Checklist Item should have been returned.'
		);

		System.assertEquals(
			testChecklistItem.Id,
			retrievedItems[0].Id,
			'The retrieved checklist item should be the test checklist item that was inserted.'
		);
	}	

	@isTest static void getChecklistItemsByChecklistItemIds_givenAChecklistItemId_shouldRetrieveChecklistItem() {
		ChecklistItemDataAccessor checklistItemDA = new ChecklistItemDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test MC',
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Case testCase = TestDataUtil.insertCase();

		Checklist_Item__c testChecklistItem = new Checklist_Item__c(
			Case__c = testCase.Id,
			Master_Checklist__c = testMasterChecklist.Id,
			Application__c = testCase.Application__c
		);
		insert testChecklistItem;

		Test.startTest();
			List<Checklist_Item__c> retrievedItems = checklistItemDA.getChecklistItemsByChecklistItemIds(
				new Set<Id>{testChecklistItem.Id}
			);
		Test.stopTest();

		System.assert(
			!retrievedItems.isEmpty(),
			'With the given Checklist Item Id and Master Checklist Id, a Checklist Item should have been returned.'
		);

		System.assertEquals(
			testChecklistItem.Id,
			retrievedItems[0].Id,
			'The retrieved checklist item should be the test checklist item that was inserted.'
		);
	}
}