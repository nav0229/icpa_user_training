public with sharing class SDChatterFeedCommentHelper {

	public static void blockChatterFeedCommentAttachment(List<FeedComment> newCommentList) {

		for(FeedComment comment : newCommentList) {
			if(
					(
							(comment.ParentId.getSObjectType().getDescribe().getName() == SDProjectConstants.OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD)
									|| (comment.ParentId.getSObjectType().getDescribe().getName() == SDProjectConstants.OBJECTAPINAME_AGENCY_PROTEST_CASE)
					)
							&& comment.CommentType == 'ContentComment') {
				comment.addError(SDProjectConstants.ERROR_MSG_CHATTER_FEED_ITEM_UPLOAD);
			}
		}

	}

}