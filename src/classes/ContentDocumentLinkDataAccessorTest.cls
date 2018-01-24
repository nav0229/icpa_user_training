@isTest
private class ContentDocumentLinkDataAccessorTest {
	
	@isTest static void insertContentDocumentLinks_givenAContentDocumentLink_shouldInsertLink() {
		ContentDocumentLinkDataAccessor linkDA = new ContentDocumentLinkDataAccessor();

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

		ContentVersion testCV = new ContentVersion(
			ReasonForChange = 'Test Reason 0',
			PathOnClient = '/fake/path',
			VersionData = Blob.valueOf('Test Data')
		);
		insert testCV;

		testCV = [
			SELECT Id, ContentDocumentId
			FROM ContentVersion
			WHERE Id = :testCV.Id
		];

		ContentDocumentLink testDocumentLink = new ContentDocumentLink(
			ContentDocumentId = testCV.ContentDocumentId,
			LinkedEntityId = testChecklistItem.Id,
			ShareType = 'V'
		);

		Test.startTest();
			linkDA.insertContentDocumentLinks(new List<ContentDocumentLink>{testDocumentLink});
		Test.stopTest();

		System.assert(
			testDocumentLink.Id != null,
			'The constructed Content Document Link should have been inserted.'
		);
	}
	
	@isTest static void deleteContentDocumentLinks_givenAContentDocumentLink_shouldDeleteLink() {
		ContentDocumentLinkDataAccessor linkDA = new ContentDocumentLinkDataAccessor();

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

		ContentVersion testCV = new ContentVersion(
			ReasonForChange = 'Test Reason 1',
			PathOnClient = '/fake/path',
			VersionData = Blob.valueOf('Test Data')
		);
		insert testCV;

		testCV = [
			SELECT Id, ContentDocumentId
			FROM ContentVersion
			WHERE Id = :testCV.Id
		];

		ContentDocumentLink testDocumentLink = new ContentDocumentLink(
			ContentDocumentId = testCV.ContentDocumentId,
			LinkedEntityId = testChecklistItem.Id,
			ShareType = 'V'
		);
		insert testDocumentLink;

		Test.startTest();
			linkDA.deleteContentDocumentLinks(new List<ContentDocumentLink>{testDocumentLink});
		Test.stopTest();

		List<ContentDocumentLink> deletedResult = [
			SELECT Id
			FROM ContentDocumentLink
			WHERE Id =:testDocumentLink.Id
		];

		System.assert(
			deletedResult.isEmpty(),
			'ContentDocumentLink should have been deleted, but was not.'
		);
	}
	
	@isTest static void getContentDocumentLinksByDocIds_givenADocumentId_shouldRetrieveLink() {
		ContentDocumentLinkDataAccessor linkDA = new ContentDocumentLinkDataAccessor();

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

		ContentVersion testCV = new ContentVersion(
			ReasonForChange = 'Test Reason 2',
			PathOnClient = '/fake/path',
			VersionData = Blob.valueOf('Test Data')
		);
		insert testCV;

		testCV = [
			SELECT Id, ContentDocumentId
			FROM ContentVersion
			WHERE Id = :testCV.Id
		];

		ContentDocumentLink testDocumentLink = new ContentDocumentLink(
			ContentDocumentId = testCV.ContentDocumentId,
			LinkedEntityId = testChecklistItem.Id,
			ShareType = 'V'
		);
		insert testDocumentLink;

		Test.startTest();
			List<ContentDocumentLink> retrievedLinks = linkDA.getContentDocumentLinksByDocIds(new Set<Id>{testDocumentLink.ContentDocumentId});
		Test.stopTest();

		System.assert(
			!retrievedLinks.isEmpty(),
			'With the given ContentDocumentId, a ContentDocumentLink should have been retrieved.'
		);

		ContentDocumentLink relatedLink;
		for(ContentDocumentLink link : retrievedLinks){
			if(link.Id == testDocumentLink.Id){
				relatedLink = link;
			}
		}

		System.assert(
			relatedLink != null,
			'With the given ContentDocumentId, the inserted ContentDocumentLink should have been retrieved.'
		);
	}

	@isTest static void getContentDocumentLinksByLinkedEntityIds_givenALinkedEntityId_shouldRetrieveLink() {
		ContentDocumentLinkDataAccessor linkDA = new ContentDocumentLinkDataAccessor();

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

		ContentVersion testCV = new ContentVersion(
			ReasonForChange = 'Test Reason 3',
			PathOnClient = '/fake/path',
			VersionData = Blob.valueOf('Test Data')
		);
		insert testCV;

		testCV = [
			SELECT Id, ContentDocumentId
			FROM ContentVersion
			WHERE Id = :testCV.Id
		];

		ContentDocumentLink testDocumentLink = new ContentDocumentLink(
			ContentDocumentId = testCV.ContentDocumentId,
			LinkedEntityId = testChecklistItem.Id,
			ShareType = 'V'
		);
		insert testDocumentLink;

		Test.startTest();
			List<ContentDocumentLink> retrievedLinks = linkDA.getContentDocumentLinksByLinkedEntityIds(new Set<Id>{testDocumentLink.LinkedEntityId});
		Test.stopTest();

		System.assert(
			!retrievedLinks.isEmpty(),
			'With the given LinkedEntityId, a ContentDocumentLink should have been retrieved.'
		);

		System.assertEquals(
			testDocumentLink.Id,
			retrievedLinks[0].Id,
			'The retrieved ContentDocumentLink should be the inserted test ContentDocumentLink.'
		);
	}
}