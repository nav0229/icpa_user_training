@isTest
private class MasterChecklistDataAccessorTest {
	
	@isTest static void getMasterChecklistByChecklistCode_givenAChecklistCode_shouldRetrieveMasterChecklist() {
		MasterChecklistDataAccessor masterChecklistDA = new MasterChecklistDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test Master Checklist',
			Checklist_Code__c = MasterChecklistDataAccessor.CBR_CODE,
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Test.startTest();
			Master_Checklist__c retrievedChecklist = masterChecklistDA.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.CBR_CODE);
		Test.stopTest();

		System.assert(
			retrievedChecklist != null,
			'With the given Checklist Code, a Master Checklist should have been retrieved.'
		);

		System.assertEquals(
			testMasterChecklist.Id,
			retrievedChecklist.Id,
			'The retrieved Master Checklist should be the inserted test Master Checklist.'
		);
	}
	
	@isTest static void getMasterChecklistsByChecklistCodes_givenAChecklistCode_shouldRetrieveMasterChecklist() {
		MasterChecklistDataAccessor masterChecklistDA = new MasterChecklistDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test Master Checklist',
			Checklist_Code__c = MasterChecklistDataAccessor.CBR_CODE,
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Test.startTest();
			List<Master_Checklist__c> retrievedChecklists = masterChecklistDA.getMasterChecklistsByChecklistCodes(new List<String>{MasterChecklistDataAccessor.CBR_CODE});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedChecklists.size(),
			'With the given Checklist Code, one Master Checklist should have been retrieved.'
		);

		System.assertEquals(
			testMasterChecklist.Id,
			retrievedChecklists[0].Id,
			'The retrieved Master Checklist should be the inserted test Master Checklist.'
		);		
	}

	@isTest static void getMasterChecklistsMapById_givenAnMCId_shouldRetrieveMasterChecklistMap() {
		MasterChecklistDataAccessor masterChecklistDA = new MasterChecklistDataAccessor();

		Master_Checklist__c testMasterChecklist = new Master_Checklist__c(
			Name = 'Test Master Checklist',
			Checklist_Code__c = MasterChecklistDataAccessor.CBR_CODE,
			Checklist_Type__c = 'Interface'
		);
		insert testMasterChecklist;

		Test.startTest();
			Map<Id,Master_Checklist__c> retrievedChecklistsMap = masterChecklistDA.getMasterChecklistsMapById(new List<Id>{testMasterChecklist.Id});
		Test.stopTest();

		System.assertEquals(
			1,
			retrievedChecklistsMap.size(),
			'With the given Checklist Code, one Master Checklist should be in the map.'
		);

		System.assertEquals(
			testMasterChecklist.Id,
			retrievedChecklistsMap.get(testMasterChecklist.Id).Id,
			'The retrieved Master Checklist should be the inserted test Master Checklist.'
		);		
	}
	
}