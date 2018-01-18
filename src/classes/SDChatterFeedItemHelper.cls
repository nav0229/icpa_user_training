public with sharing class SDChatterFeedItemHelper {

	public static void dontAllowChatterFeedUploadsOnSDRelatedObjects(List<FeedItem> newFeedItemList) {

		for(FeedItem item : newFeedItemList) {
			if(
					(
							(item.ParentId.getSObjectType().getDescribe().getName() == SDProjectConstants.OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD)
									|| (item.ParentId.getSObjectType().getDescribe().getName() == SDProjectConstants.OBJECTAPINAME_AGENCY_PROTEST_CASE)
					)
							&& item.Type == 'ContentPost') {
				item.addError(SDProjectConstants.ERROR_MSG_CHATTER_FEED_ITEM_UPLOAD);
			}
		}

	}

}