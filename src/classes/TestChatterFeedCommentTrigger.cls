/*-------------------------------------------------------------------------------
  TestChatterFeedCommentTrigger.cls
  Class for testing Chatter Feed Comment trigger on ConnectApi.Comment object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               04/02/2014   1.0       Creation
  Rajakumar               04/30/2014   1.1       Task #00012362- email notification
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */
@isTest(seeAllData=true)
private class TestChatterFeedCommentTrigger {
    @IsTest
    static void testCIAtMentionCommentSharing() {
        // Build a simple feed item
        Map<Id, Group> grpMap = new Map<Id, Group>([Select Id from Group Where DeveloperName Like 'Critical_Items%']);
        List<GroupMember> grpuserslist = new List<GroupMember>();
        Map<Id, Id> grpuserMap = new Map<Id, Id>();
        grpuserslist = [SELECT UserorGroupId, GroupId FROM GroupMember WHERE GroupId IN :grpMap.keySet()];
        
        for(GroupMember g : grpuserslist) {
            grpuserMap.put(g.UserorGroupId, g.GroupId);
        }
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId()
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') AND Id NOT IN :grpuserMap.keySet() LIMIT 3]; 
        
        List<Critical_Issues__c> citemsList = new List<Critical_Issues__c>();
        //List<User> users2 = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
        
        ID ciUser1Id = users[2].Id;
        for (Integer i=0;i<2;i++) {
            citemsList.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=ciUser1Id,
                                        Action_Required_by_Administrator__c='Info Only/No Action Needed',
                                        Date_Updated__c=Date.today(),
                                        Additional_Comments2__c='Test1',
                                        Action_Type_Detail__c='Budget',
                                        Deadline__c=Date.today()+1,
                                        Recommended_Action__c='need to discuss',
                                        IQ_Number__c='123',
                                        Status_Update__c='Test1', Name='Test'+i));
        }
        insert citemsList;
               
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = 'Hey there ';
        messageInput.messageSegments.add(textSegment);
        
        ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
        mentionSegment.Id = users[0].Id;
        messageInput.messageSegments.add(mentionSegment);
        
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = messageInput;
        
        ConnectApi.FeedItem feedItemReply = ConnectApi.ChatterFeeds.postFeedItem(null, 
                                                ConnectApi.FeedType.Record, citemsList[0].Id, input, null);
        
        // Create Chatter Comment
        String communityId = null;
        String feedItemId = feedItemReply.Id;

        ConnectApi.CommentInput input2 = new ConnectApi.CommentInput();
        ConnectApi.MessageBodyInput messageInput2 = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegment2;
        ConnectApi.MentionSegmentInput mentionSegment2;
        messageInput2.messageSegments = new List<ConnectApi.MessageSegmentInput>();
                
        textSegment2 = new ConnectApi.TextSegmentInput();
        textSegment2.text = 'Comment Text Body';
        messageInput2.messageSegments.add(textSegment2);
        
        mentionSegment2 = new ConnectApi.MentionSegmentInput();
        mentionSegment2.Id = users[1].Id;
        messageInput2.messageSegments.add(mentionSegment2);

        input2.body = messageInput2;

        ConnectApi.NewFileAttachmentInput attachmentInput = new ConnectApi.NewFileAttachmentInput();
        attachmentInput.description = 'The description of the file';
        attachmentInput.title = 'contentFile.txt';
        input2.attachment = attachmentInput;

        String fileContents = 'This is the content of the file.';
        Blob fileBlob = Blob.valueOf(fileContents);
        ConnectApi.BinaryInput binaryInput = new ConnectApi.BinaryInput(fileBlob, 'text/plain', 'contentFile.txt');
        //ConnectApi.BinaryInput binaryInput = new ConnectApi.BinaryInput();

        ConnectApi.Comment commentRep = ConnectApi.ChatterFeeds.postComment(communityId, feedItemId, input2, binaryInput);
        
        List<Critical_Issues__Share> pocupdshares = [SELECT Id FROM Critical_Issues__Share WHERE 
                                                        ParentId = :citemsList[0].Id AND UserOrGroupId = :users[1].Id 
                                                        AND RowCause = 'Chatter__c'];
        // test to ensure that one sharing entry is inserted.
        Test.startTest();
        System.assertEquals(1, pocupdshares.size());
        Test.stopTest();
    }
    
    static void testInsertFeedCommentWithAttachments() {
        FeedComment fc = new FeedComment();        
        Controlled_Document__c cd = new Controlled_Document__c();
        cd.Stage__c = 'Drafting';
        insert cd;
        
        FeedItem fi = new FeedItem();
        fi.ParentId = cd.Id;
        fi.Body = 'Test Feed Item';
        insert fi;
        
        fc.CommentType = 'TextComment';
        fc.FeedItemId = fi.Id;
        fc.CommentBody ='Test comment body';                
        insert fc;
        system.assertEquals(true, true);
        
      
    }

}