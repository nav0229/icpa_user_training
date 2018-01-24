@isTest
public with sharing class ContentVersionSizeLimiterMock implements ContentVersionSizeLimiterInterface {
	public Integer validateContentSizesCallCount {get; private set;}

	public ContentVersionSizeLimiterMock() {
		validateContentSizesCallCount = 0;
	}

	public void validateContentSizes(List<ContentVersion> versions){
		validateContentSizesCallCount++;
	}
}