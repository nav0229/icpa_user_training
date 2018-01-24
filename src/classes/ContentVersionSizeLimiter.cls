/****************************************************************
 Name: ContentVersionSizeLimiter
============================================================
Author: Kevin/Matt
Purpose: Enforce the file size limit for ContentVersions
============================================================

****************************************************************/
public with sharing class ContentVersionSizeLimiter implements ContentVersionSizeLimiterInterface {

	private final Integer fileSizeLimitBytes = 52428800; //50MB in bytes

	public ContentVersionSizeLimiter(){}

	public void validateContentSizes(List<ContentVersion> versions){
		for(ContentVersion version : versions){

			System.debug(versions);
			
			System.debug('Checking ContentVersion(Id:' + version.Id + ') File size: ' + version.ContentSize);

			if(version.ContentSize > this.fileSizeLimitBytes){
				System.debug('ContentVersion(Id:' + version.Id + ') having a File size of ' + version.ContentSize + ' exceeds the byte limit.');
				version.addError('Error: File Size Exceeds 50 MB Maximum');
			}
		}
	}
}