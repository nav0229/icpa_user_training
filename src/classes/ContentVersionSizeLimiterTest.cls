@isTest
private class ContentVersionSizeLimiterTest
{
	@isTest
	static void validateContentSizes_givenVersionWithContentSizeGreaterThanLimit_shouldAddError(){
		ContentVersionSizeLimiter testLimiter = new ContentVersionSizeLimiter();

		MockSObjectBuilder contentVersionBuilder = new MockSObjectBuilder(ContentVersion.getSObjectType());
		contentVersionBuilder.setField('ContentSize', '52428801');
		ContentVersion testContentVersion = (ContentVersion)JSON.deserialize(contentVersionBuilder.getSerializedSObject(), ContentVersion.class);

		Test.startTest();
			testLimiter.validateContentSizes(new List<ContentVersion>{testContentVersion});
		Test.stopTest();

		System.assert(!ApexPages.getMessages().isEmpty());
	}

	@isTest
	static void validateContentSizes_givenVersionWithContentSizeEqualToLimit_shouldNotAddError(){
		ContentVersionSizeLimiter testLimiter = new ContentVersionSizeLimiter();

		MockSObjectBuilder contentVersionBuilder = new MockSObjectBuilder(ContentVersion.getSObjectType());
		contentVersionBuilder.setField('ContentSize', '52428800');
		ContentVersion testContentVersion = (ContentVersion)JSON.deserialize(contentVersionBuilder.getSerializedSObject(), ContentVersion.class);

		Test.startTest();
			testLimiter.validateContentSizes(new List<ContentVersion>{testContentVersion});
		Test.stopTest();

		System.assert(ApexPages.getMessages().isEmpty());
	}
}