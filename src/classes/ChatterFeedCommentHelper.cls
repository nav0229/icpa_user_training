/*-------------------------------------------------------------------------------
  ChatterFeedCommentHelper.cls
  Helper Class for Chatter Feed Comment trigger on FeedComment object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               04/01/2014   1.0       Creation
  Rajakumar               04/30/2014   1.1       Task #00012362- email notification
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */

public class ChatterFeedCommentHelper {
    
    public static void recordSharing(List<FeedComment> newfeedcomments) {
        String citemKeyPrefix;
        String parentId;
        //String feeditemId;
        Boolean isNewUser = false;
        Critical_Issues__Share chatterShr;
        List<Critical_Issues__Share> chattershrList = new List<Critical_Issues__Share>();
        
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        
        citemKeyPrefix = Critical_Issues__c.sObjectType.getDescribe().getKeyPrefix();
                
        for(FeedComment comment: newfeedcomments) {
            parentId = comment.parentId;
            String communityId = null;
            String feeditemId = comment.FeedItemId;
            String commentId = comment.Id;
            // chatter @ mention record sharing for Critical Items application
            if(parentId.startsWith(citemKeyPrefix) ) { // comment.CommentType == 'TextComment' )
                ConnectApi.Comment com = ConnectApi.ChatterFeeds.getComment(communityId, commentId);
                List<ConnectApi.MessageSegment> messageSegments = com.body.messageSegments;
                for (ConnectApi.MessageSegment messageSegment : messageSegments) {
                    if (messageSegment instanceof ConnectApi.MentionSegment) {
                        ConnectApi.MentionSegment mentionSegment = (ConnectApi.MentionSegment) messageSegment;
                        ConnectApi.Actor actor = (ConnectApi.Actor) mentionSegment.record;
                        //System.debug('Actor Name ' + actor.name +'Type : '+actor.type);
                        if(actor.type == 'User') {
                            ConnectApi.User usr = (ConnectApi.User) mentionSegment.record;
                            //System.debug('USER TYPE; '+usr.UserType);
                            if(usr.UserType == ConnectApi.UserType.Internal) {
                                if(!mentionSegment.accessible) {
                                    chatterShr = new Critical_Issues__Share();
                                    chatterShr.ParentID = comment.parentId;
                                    chatterShr.UserOrGroupId = mentionSegment.record.id;
                                    chatterShr.AccessLevel='Read';
                                    chatterShr.RowCause=Schema.Critical_Issues__Share.RowCause.Chatter__c;
                                    chattershrList.add(chatterShr);
                                    // Another chatter post
                                    ConnectApi.MentionSegmentInput mentionSegment2 = new ConnectApi.MentionSegmentInput();
                                    mentionSegment2.Id = mentionSegment.record.id;
                                    messageInput.messageSegments.add(mentionSegment2);
                                    isNewUser = true;       
                                }
                            }
                        }
                    }            
                }                  
            }
            //System.debug('Comment body'+comment.commentBody);
        } 
        try {
            if(!chattershrList.isEmpty())
                insert chattershrList;
        }
        catch(DMLException e) {
            System.debug(LoggingLevel.INFO,'Error while inserting the Chatter apex sharing entry for Critical Items :'+e.getMessage());    
        }
        
        try {
            if(isNewUser) {
                ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
                textSegment.text = 'Have a look at the record chatter feed and comments.';
                messageInput.messageSegments.add(textSegment);
                ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
                input.body = messageInput;
                //CriticalItemChatterFeedRecursionCheck.setAlreadyInserted();
                ConnectApi.FeedItem feedItemReply = ConnectApi.ChatterFeeds.postFeedItem(null, 
                     ConnectApi.FeedType.Record, parentId, input, null);
            }
        }
        catch(ConnectApi.RateLimitException e) {
            System.debug(LoggingLevel.INFO,'ConnectApi RateLimitException while inserting the apex Chatter feed for Critical Items FeedComment :');    
        }    
    }
    
    public static void blockChatterFeedCommentAttachment(List<FeedComment> lstFI){
     String parentId;
     String apiName;
     String type;
     String objAPI;     
      for(FeedComment fi : lstFI){
          parentId = fi.ParentId;          
          type = fi.CommentType;    
          system.debug('ParentId ' + fi.parentId);
          apiName =  GSAUtility.getApiNameByRecordId(parentId);  
          system.debug('API Name ' + apiName);
          CCA_Disabled_Objects__c cca = CCA_Disabled_Objects__c.getValues(apiName);          
          if(cca != null){
              objAPI = cca.Name;
          //system.debug('objAPI ' + objAPI);
          //system.debug('Parent Id ' + parentId + 'FeedItem Id ' + fi.FeedItemId); 
          if(fi.CommentType == 'ContentComment' && apiName == objAPI){
                   fi.addError('Files cannot be uploaded to comments.  Please upload new version to original document.');
                   }
              }
           
           break;  
      
    }
                          
      }
}