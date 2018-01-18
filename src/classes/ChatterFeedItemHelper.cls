/*-------------------------------------------------------------------------------
  ChatterFeedItemHelper.cls
  Helper Class for Chatter Feed Item trigger on FeedItem object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               03/25/2014   1.0       Creation
  Rajakumar               04/30/2014   1.1       Task #00012362- email notification
  Rajakumar               08/22/2016   1.2       case# 26931- EBC chatter feed file types prevention added for before insert
  Ramesh Dugar			  4/3/2017     1.3       case#27693 - Prevent user from deleting Documents from CDT records
  Raja Kumar P            05/09/2017   1.4       case# 31205 - chatter feed deletion must delete the collaborators access.
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */

public class ChatterFeedItemHelper {
    
    public static void recordSharing(List<FeedItem> newfeeds) {
        String citemKeyPrefix;
        String parentId; 
        Boolean isNewUser = false;     
        Critical_Issues__Share chatterShr;
        List<Critical_Issues__Share> chattershrList = new List<Critical_Issues__Share>();
        
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        
        citemKeyPrefix = Critical_Issues__c.sObjectType.getDescribe().getKeyPrefix();
                
        for(FeedItem feed: newfeeds) {
            parentId = feed.parentId;
            String communityId = null;
            String feeditemId = feed.Id;
            // chatter @ mention record sharing for Critical Items application
            if(parentId.startsWith(citemKeyPrefix)) { // feed.type == 'TextPost'  
                ConnectApi.FeedItem feedItem = ConnectApi.ChatterFeeds.getFeedItem(communityId, feedItemId);
                List<ConnectApi.MessageSegment> messageSegments = feedItem.body.messageSegments;
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
                                    chatterShr.ParentID = feed.parentId;
                                    chatterShr.UserOrGroupId = mentionSegment.record.id;
                                    chatterShr.AccessLevel='Read';
                                    chatterShr.RowCause=Schema.Critical_Issues__Share.RowCause.Chatter__c;
                                    chattershrList.add(chatterShr);
                                    // for additional chatter post
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
        }
        
        try {
            if(!chattershrList.isEmpty()) {
                insert chattershrList;
            }    
        }
        catch(DMLException e) {
            System.debug(LoggingLevel.INFO,'Error while inserting the Chatter apex sharing entry for Critical Items :'+e.getMessage());    
        }
        
        try {
            if(isNewUser) {
                    ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
                    textSegment.text = 'Have a look at the record chatter post.';
                    messageInput.messageSegments.add(textSegment);
                    ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
                    input.body = messageInput;
                    CriticalItemChatterFeedRecursionCheck.setAlreadyInserted();
                    ConnectApi.FeedItem feedItemReply = ConnectApi.ChatterFeeds.postFeedItem(null, 
                                                    ConnectApi.FeedType.Record, parentId, input, null);
            }
        }
        catch(ConnectApi.RateLimitException e) {
            System.debug(LoggingLevel.INFO,'ConnectApi RateLimitException while inserting the apex Chatter feed for Critical Items :');    
        }   
    }
    
    // for EBC case# 26931 - v1.2 - BEGIN 
    public static void preventFewAttachmentTypes(List<FeedItem> records) {
        Map<String, String> contentTypesMap = getContentTypes('Executive_Business_Case__c');            
        for(FeedItem fitem: records) {
            if(fitem.Type == 'ContentPost' && fitem.parentId.getSObjectType().getDescribe().getName() == 'Executive_Business_Case__c' &&
                    !contentTypesMap.containsKey(fitem.ContentType)) {
                    fitem.addError('You must attach the files of following types word, excel and pdf');
            }            
        }    
    }
    
    public static Map<String, String> getContentTypes(String parentObject) {
        Map<String, String> contentsMap = new Map<String, String>();
        if(parentObject == 'Executive_Business_Case__c') {
            List<String> fileTypes = new List<String>{'application/vnd.ms-excel.addin.macroEnabled.12',
                                                'application/vnd.ms-excel.sheet.binary.macroEnabled.12',
                                                'application/vnd.ms-excel.sheet.macroEnabled.12',
                                                'application/vnd.ms-excel.template.macroEnabled.12',
                                                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                                'application/vnd.openxmlformats-officedocument.spreadsheetml.template',
                                                'application/vnd.ms-excel', 
                                                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                                'application/vnd.openxmlformats-officedocument.wordprocessingml.template',
                                                'application/vnd.ms-word.document.macroEnabled.12',
                                                'application/vnd.ms-word.template.macroEnabled.12',
                                                'application/msword',                                                
                                                'application/pdf'};
            for(String type : fileTypes) {
                contentsMap.put(type,type);            
            }
        }
        return contentsMap;
    }
    // for EBC case# 26931 - v1.2 - END
    // For CDT case#29763
    public static void preventfeedItemDelete(List<FeedItem> cdtfeed){
        Set<ID> controlDocumentID = new Set<ID>();
        Map<Id,String> cdIdMap = new Map<Id, String>();
       
        
        for(FeedItem f :cdtfeed) {
           if(f.Type == 'ContentPost' && f.parentId.getSObjectType().getDescribe().getName() == 'Controlled_Document__c') {
               // f.addError('you cannot delete this attachment. Please contact your administrator for assistance.',FALSE);
               ControlDocumentID.add(f.parentId);
               
            } 
        }
        
        List<Controlled_Document__c> conDoc = [SELECT Id,Reason_File_Deletion__c FROM Controlled_Document__c where ID IN:ControlDocumentID];
        for(Controlled_Document__c cd : conDoc) {
             cdIdMap.put(cd.Id,cd.Reason_File_Deletion__c);
         }
        
        Id controlDocID;
        string reasonForDeletion;
        Set<Id> controlledDocuemntID = new Set<ID>(); 
        List<CDT_Deletion_Log__c> logList = new List<CDT_Deletion_Log__c>();
        for(FeedItem item : cdtfeed) {
            if(item.Type == 'ContentPost' && item.parentId.getSObjectType().getDescribe().getName() == 'Controlled_Document__c'){
                //controlDocId = item.parentId;
                reasonForDeletion = cdIdMap.get(item.parentId);
                controlledDocuemntID.add(item.parentId);
                if(String.isBlank(reasonForDeletion))
                       item.addError('You cannot delete this attachment. Please Enter the reason for deletion.',FALSE);
                    else {
                           CDT_Deletion_Log__c log = new CDT_Deletion_Log__c();
                        	log.Contolled_Document__c = item.parentId;
                            log.File_Name__c= item.Title;
                            log.DeletionDate__c = Date.Today();
                            log.Reason__c = reasonForDeletion;
                            log.User_Name__c = UserInfo.getName();
                            logList.add(log);
                       	  
                    }
                 
            }   
        }
            
        Insert(logList);
        List<Controlled_Document__c> Cdlist = [Select ID,Reason_File_Deletion__c from Controlled_Document__c where id in :controlledDocuemntID];
        for(Controlled_Document__c record : cdlist){
            record.Reason_File_Deletion__c ='';
        }
        Update(Cdlist);
	        
     }
    //End of CDT Case#29763
    // 
    // for case# 31205 - BEGIN
    public static void deleteContentDocumentLinks(List<FeedItem> triggerOld, Map<Id, FeedItem> triggerOldMap) {
        Set<Id> cdocIds = new Set<Id>();
        List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();  
        Set<Id> relatedRecordIds = new Set<Id>();
        for(FeedItem fitem: triggerOld) {    
            // Identify the controlled document contentpost records        
            if(fitem.type == 'ContentPost' && fitem.parentId.getSObjectType().getDescribe().getName() == 'Controlled_Document__c') {
                //System.debug('ContentVersion' +fitem.relatedrecordId);
                if(fitem.RelatedRecordId != null)
                    relatedRecordIds.add(fitem.RelatedRecordId);
            }
        }
        if(!relatedRecordIds.isEmpty()) {
            // Identify the ContentDocument Ids by using ContentVersion Ids
            for(ContentVersion cv : [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :relatedrecordIds]) {
                cdocIds.add(cv.ContentDocumentId);
            }    
            //System.debug('ContentVersion list size : '+cdocIds.size());
            // Identify the content document link records to remove the collaborators access for the deleted feeds/posts.
            for(ContentDocument cd : [SELECT Id, (SELECT Id FROM ContentDocumentLinks WHERE ShareType = 'C') FROM ContentDocument WHERE Id IN :cdocIds]) {
                for(ContentDocumentLink cdl : cd.ContentDocumentLinks) {
                    cdlList.add(cdl);
                }
            }            
            System.debug('CDL size :' +cdlList.size());
            try {
                if(!cdlList.isEmpty())
                    delete cdlList;
            }
            catch(DMLException e) {
                System.debug(LoggingLevel.INFO,'ChatterFeedItemTrigger - After Delete error '+e.getMessage());    
            }   
        }    
    }
    // for case# 31205 - END
}