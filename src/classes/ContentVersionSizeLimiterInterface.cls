/****************************************************************
 Name: ContentVersionSizeLimiter
============================================================
Author: Kevin
Purpose: Interface for ContentVersionSizeLimiter
============================================================

****************************************************************/
public interface ContentVersionSizeLimiterInterface {

	void validateContentSizes(List<ContentVersion> versions);
}