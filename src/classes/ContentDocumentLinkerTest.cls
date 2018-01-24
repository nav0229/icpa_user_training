@isTest
private class ContentDocumentLinkerTest
{

	@isTest
	static void handledocumentLinks_givenNullListAndMap_shouldNotThrowError(){
		ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
		ContentDocumentLinker.applicationDA = mockDA;
		ContentDocumentLinkDataAccessorMock contentDocumentMockDA = new ContentDocumentLinkDataAccessorMock();
		ContentDocumentLinker.contentDocumentLinkDA = contentDocumentMockDA;
		ContentDocumentLinker linker = new ContentDocumentLinker();

		//List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap
		boolean didNotThrowException = true;
		Test.startTest();
			try {
				linker.handleDocumentLinks(null, null);
			}
			catch (Exception e) {
				didNotThrowException = false;
			}
		Test.stopTest();

		System.assert(didNotThrowException, 'Exception was thrown when a null list and map were provided.');
	}

	@isTest
	static void handledocumentLinks_givenEmptyListAndMap_shouldNotThrowError(){
		ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
		ContentDocumentLinker.applicationDA = mockDA;
		ContentDocumentLinkDataAccessorMock contentDocumentMockDA = new ContentDocumentLinkDataAccessorMock();
		ContentDocumentLinker.contentDocumentLinkDA = contentDocumentMockDA;
		ContentDocumentLinker linker = new ContentDocumentLinker();
		
		boolean didNotThrowException = true;
		Test.startTest();
			try {
				linker.handleDocumentLinks(new List<ContentVersion>(), new Map<Id,ContentVersion>());
			}
			catch (Exception e) {
				didNotThrowException = false;
			}
		Test.stopTest();

		System.assert(didNotThrowException, 'Exception was thrown when an empty list and map were provided.');
	}

	@isTest
	static void handledocumentLinks_givenValidListAndMap_shouldDeleteOldAppLinkAndCreateNew(){
		ApplicationDataAccessorMock mockDA = new ApplicationDataAccessorMock();
		ContentDocumentLinker.applicationDA = mockDA;
		ContentDocumentLinkDataAccessorMock contentDocumentMockDA = new ContentDocumentLinkDataAccessorMock();
		ContentDocumentLinker.contentDocumentLinkDA = contentDocumentMockDA;
		ContentDocumentLinker linker = new ContentDocumentLinker();

		MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
		applicationMockBuilder.setField('Name', '123456789');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c oldApp = (Application__c) applicationMockBuilder.build();

		applicationMockBuilder.setField('Name', '987654321');
		applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());

		Application__c newApp = (Application__c) applicationMockBuilder.build();

		mockDA.getApplicationsByApplicationNumberReturn.add(oldApp);
		mockDA.getApplicationsByApplicationNumberReturn.add(newApp);

		ContentVersion oldVersion = (ContentVersion)JSON.deserialize(
			'{"ContentVersion":' +
				'{"Title":"Test",'+ 
				'"Id":"12345",' +
				'"ContentDocumentId":"23456",'+
				'"New_Parent_Application_No__c":"' + oldApp.Name +'"}' +
			'}'
			, ContentVersion.class
		);

		ContentVersion newVersion = (ContentVersion)JSON.deserialize(
			'{"ContentVersion":' +
				'{"Title":"Test",'+ 
				'"Id":"12345",' +
				'"ContentDocumentId":"23456",'+
				'"New_Parent_Application_No__c":"' + newApp.Name +'"}' +
			'}'
			, ContentVersion.class
		);

		Map<Id,ContentVersion> oldMap = new Map<Id,ContentVersion>();
		oldMap.put(oldVersion.Id,oldVersion);

		Test.startTest();
			linker.handleDocumentLinks(new List<ContentVersion>{newVersion}, oldMap);
		Test.stopTest();

		
		
		System.assert(
			contentDocumentMockDA.getContentDocumentLinksByDocIdsCallCount > 0, 
			'getContentDocumentLinksByDocIds should have been called to retrieve ContentDocumentLinks.'
		);
		System.assert(
			contentDocumentMockDA.insertContentDocumentLinksCallCount > 0, 
			'insertContentDocumentLinks should have been called to insert new ContentDocumentLinks.'
		);
		System.assert(
			contentDocumentMockDA.deleteContentDocumentLinksCallCount > 0, 
			'deleteContentDocumentLinks should have been called to delete old ContentDocumentLinks.'
		);
	}
}