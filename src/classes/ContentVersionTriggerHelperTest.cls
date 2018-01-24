@isTest
private class ContentVersionTriggerHelperTest
{
	@isTest
	static void beforeUpdate_givenAnyData_shouldCallHandleDocumentLinks(){
		List<ContentVersion> newContentVersions = new List<ContentVersion>();
		Map<Id,ContentVersion> oldContentVersionsMap = new Map<Id,ContentVersion>();

		ContentDocumentLinkerMock linkerMock = new ContentDocumentLinkerMock();
		ContentVersionTriggerHelper.contentDocumentLinker = linkerMock;
		ContentVersionTriggerHelper testController = new ContentVersionTriggerHelper();

		Test.startTest();
			testController.beforeUpdate(newContentVersions, oldContentVersionsMap);
		Test.stopTest();

		System.assertEquals(1, linkerMock.handleDocumentLinksCallCount);
	}

	public class ContentDocumentLinkerMock implements ContentDocumentLinkerInterface {
		public Integer handleDocumentLinksCallCount { get; private set; }

		public ContentDocumentLinkerMock(){
			handleDocumentLinksCallCount = 0;
		}

		public void handleDocumentLinks(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap){
			handleDocumentLinksCallCount++;
		}
	}

	@isTest
	static void AfterInsert_givenListOfContentVersion_shouldCallUpdateSignedDocumentChecklistItemStatus(){
		List<ContentVersion> newContentVersions = new List<ContentVersion>();
		ContentVersionTriggerHelper testController = new ContentVersionTriggerHelper();

		Test.startTest();
			testController.afterInsert(newContentVersions);
		Test.stopTest();
	}
}