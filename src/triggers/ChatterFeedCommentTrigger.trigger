/*-------------------------------------------------------------------------------
  ChatterFeedCommentTrigger
  Chatter FeedComment Trigger on FeedComment object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               04/01/2014   1.0       Creation
  Rajakumar               04/30/2014   1.1       Task #00012362- email notification
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */
trigger ChatterFeedCommentTrigger on FeedComment (after insert, before insert) {
    if(Trigger.isInsert && Trigger.isAfter) {
        ChatterFeedCommentHelper.recordSharing(Trigger.new);
        //ChatterFeedCommentHelper.blockChatterFeedCommentAttachment(trigger.new);
    }

    if(Trigger.isBefore && Trigger.isInsert) {
        ChatterFeedCommentHelper.blockChatterFeedCommentAttachment(trigger.new);
        SDChatterFeedCommentHelper.blockChatterFeedCommentAttachment(trigger.new);
    }
}