/*
	TitleVIReviewChildController
	In between page that checks to see if there are associated children, if not then creates one
	and then redirects.
	-------------------------------------------------------------------
	Author                 Date        Version  Description
	-------------------------------------------------------------------
	Damien Phillippi       11/22/2011  1.00     Creation
	Damien Phillippi       12/20/2011  1.01     Moving DML from an action method in order to prevent XSRF issues.
*/
public with sharing class TitleVIReviewChildController
{
	private Id parentId;
	public TitleVIReviewChildController()
	{
		parentId = ApexPages.currentPage().getParameters().get('id');
	}
	
	public PageReference redirect()
	{
		createReview();
		return new PageReference('/apex/TitleVIReview?id=' + parentId);
	}
	
	private void createReview()
	{
		if ([SELECT Id FROM OCIO_Title_VI_Review__c WHERE OCR_Title_VI_Submission__c =: parentId].size() == 0)
		{
			//Any additional fields that need populated would go here.
			OCIO_Title_VI_Review__c newReview = new OCIO_Title_VI_Review__c();
			newReview.OCR_Title_VI_Submission__c = parentId;
			insert newReview;
		}
	}	
}