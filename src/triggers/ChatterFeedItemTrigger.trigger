/*-------------------------------------------------------------------------------
  ChatterFeedItemTrigger
  Chatter FeedItem Trigger on ConnectApi.FeedItem object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               03/25/2014   1.0       Creation
  Rajakumar               04/30/2014   1.1       Task #00012362 -chatter email notification
  Stefan Maurer           12/01/2014   1.2       Added call to chatter file colaborator
  Raja Kumar P            08/22/2016   1.3       case# 26931- EBC chatter feed file types prevention added for before insert
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */
trigger ChatterFeedItemTrigger on FeedItem (after insert, before insert) {
    if(Trigger.isAfter && Trigger.isInsert) {
        // Author: Christian Coleman
        // Other relevant file(s):
        //    1. ChatterFileCollaboratorTH.cls
        // This was commented out as the ability to send emails conditionally upon adding feed items or approval steps is no longer required.
        // The new business requirements are to never send a custom email unless from the batch job / button.
        //ChatterFileCollaboratorTH.sendEmails = false;
        ChatterFileCollaboratorTH.createCollaborators(trigger.new);
        if(!CriticalItemChatterFeedRecursionCheck.hasAlreadyInserted()){
            ChatterFeedItemHelper.recordSharing(Trigger.new);
        }
    }
    // case# 26931 v1.3 - BEGIN
    if(Trigger.isBefore && Trigger.isInsert) {
        ChatterFeedItemHelper.preventFewAttachmentTypes(Trigger.new);
        SDChatterFeedItemHelper.dontAllowChatterFeedUploadsOnSDRelatedObjects(trigger.new);
    }
    // case# 26931 v1.3 - END
}