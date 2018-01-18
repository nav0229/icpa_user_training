/*-------------------------------------------------------------------------------
  TestChatterFeedItemTrigger.cls
  Class for testing Chatter Feed Item trigger on ConnectApi.FeedItem object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               03/25/2014   1.0       Creation
  Rajakumar               04/30/2014   1.1       Task #00012362- email notification
  RajaKumar               08/22/2016   1.2       EBC Case# 26931 chatter feed file types prevention
  Rajakumar               05/09/2017   1.3       CDT Case# 31205- delete the collaborator access when chatter feed is deleted.
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */
//System.UnsupportedOperationException: ConnectApi methods are not supported in data siloed tests. 
//Please use @IsTest(SeeAllData=true).
@isTest(seeAllData=true) 
private class TestChatterFeedItemTrigger {
    @IsTest
    static void testCIAtMentionSharing() {
        // Build a simple feed item
        Map<Id, Group> grpMap = new Map<Id, Group>([Select Id from Group Where DeveloperName Like 'Critical_Items%']);
        List<GroupMember> grpuserslist = new List<GroupMember>();
        List<Critical_Issues__c> citemsList = new List<Critical_Issues__c>();
        Map<Id, Id> grpuserMap = new Map<Id, Id>();
        grpuserslist = [SELECT UserorGroupId, GroupId FROM GroupMember WHERE GroupId IN :grpMap.keySet()];
        
        for(GroupMember g : grpuserslist) {
            grpuserMap.put(g.UserorGroupId, g.GroupId);
        }
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND Id != :UserInfo.getUserId()
                    AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'GSA Standard Platform User') AND Id NOT IN :grpuserMap.keySet() LIMIT 2]; 
        
        for (Integer i=0;i<2;i++) {
            citemsList.add(new Critical_Issues__c(Organization__c = 'OCIO', 
                                        Related_Organization__c='Region 1', 
                                        Critical_Item_Status__c='New', User__c=users[0].Id,
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
        mentionSegment.Id = users[1].Id;
        messageInput.messageSegments.add(mentionSegment);
        
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = messageInput;
        
        ConnectApi.FeedItem feedItemReply = ConnectApi.ChatterFeeds.postFeedItem(null, 
                                                ConnectApi.FeedType.Record, citemsList[0].Id, input, null);
        
        List<Critical_Issues__Share> pocupdshares = [SELECT Id FROM Critical_Issues__Share WHERE 
                                                        ParentId = :citemsList[0].Id AND UserOrGroupId = :users[1].Id 
                                                        AND RowCause = 'Chatter__c'];
        // test to ensure that one sharing entry is inserted.
        Test.startTest();
        System.assertEquals(1, pocupdshares.size());
        Test.stopTest();
    }
    // EBC case# 26931 - v1.2 - BEGIN
    @isTest static void validateEBCFilePrevention() {
        List<User> stdUsers = [SELECT Id FROM User WHERE IsActive = true and UserType='Standard' LIMIT 2];
        // prepare the EBC record for insert
        Executive_Business_Case__c ebc = new Executive_Business_Case__c();
        ebc.Name = 'PRJ TSTZSDGF 123456';
        ebc.Project_Start_Date__c = System.today();
        ebc.Portfolio__c = 'FAS';
        ebc.Request_Type__c = 'New Investment';
        ebc.Requested_Amount_1st_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_2nd_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_3rd_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_4th_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_5th_Fiscal_Year__c = 0.00;
        ebc.Service_or_Staff_Office_SSO__c = 'A - Office of the Administrator';
        ebc.Executive_Sponsor_Delegate__c = stdUsers[0].Id;
        ebc.Abstract__c = 'TestRecord...';
        ebc.Fiscal_Year__c = '2019';
        ebc.Project_End_Date__c = System.today();
        ebc.Program_Business_Line__c = 'A - Office of the Administrator';
        // insert new EBC record
        insert ebc;
        // prepare the chatter feed with .txt attachment
        // prepare the message body input
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        // prepare the text segment input
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = 'Hey there ';
        messageInput.messageSegments.add(textSegment);
        // prepare the mentionsegment input
        ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
        mentionSegment.Id = stdUsers[1].Id;
        messageInput.messageSegments.add(mentionSegment);
        
        // prepare the message input
        ConnectApi.NewFileAttachmentInput newattachinput = new ConnectApi.NewFileAttachmentInput();
        newattachinput.title='My Title';
        newattachinput.description='sample file';
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = messageInput;
        input.attachment = newattachinput;
        
        // prepare the attachment input
        String text = 'These are the contents of the new file.';
        Blob myBlob = Blob.valueOf(text);
        ConnectApi.BinaryInput binInput = new ConnectApi.BinaryInput(myBlob, 'text/plain', 'My Title');
        // insert the feed with attachment
        try {
            ConnectApi.FeedItem feedItemReply = ConnectApi.ChatterFeeds.postFeedItem(null, 
                                                ConnectApi.FeedType.Record, ebc.Id, input, binInput);
        }
        catch(ConnectApi.ConnectApiException e) {
            System.assertEquals('You must attach the files of following types word, excel and pdf', e.getMessage());
        }
    }
    // EBC case# 26931 - v1.2 - END
    // CDT case#27693
    static testmethod void cdt_preventdelete(){
        //Create CDT date
        Controlled_Document__c cdt = new Controlled_Document__c();
        cdt.Stage__c='Drafting';
        cdt.Correspondence_Type__c='Forms';
        cdt.Originating_Office__c='AK - Office of Civil Rights';
        cdt.Reason_File_Deletion__c ='Testing for deletion';
        insert cdt;
        //Create a contentpost
        Blob body=[Select Name, ContentType, Body From StaticResource Limit 1].body;
        FeedItem post = new FeedItem();
        post.ParentId = cdt.id;
        post.Body ='CDT Test';
        post.ContentData = body;
        post.ContentFileName = 'sample.png';
        insert post;
        try{
            delete post;
            Controlled_Document__c Cd = [Select ID,Reason_File_Deletion__c from Controlled_Document__c where id = :cdt.id]; 
            System.assertEquals(null, cd.Reason_File_Deletion__c);
        }
        catch(Exception e){
              Boolean expectedExceptionThrown =  e.getMessage().contains('you cannot delete this attachment') ? true : false;
			 // System.AssertEquals(expectedExceptionThrown, true);
			
        }
        
        ContentDocument cdoc = [select id,title from ContentDocument where title='sample'];
        try{
            delete cdoc;
        }
        catch(Exception e){
              Boolean expectedExceptionThrown =  e.getMessage().contains('you cannot delete this attachment') ? true : false;
			
        }
        system.debug('**'+cdoc);
    }
    // CDT Case# 31205 - BEGIN
    @isTest static void testFeedDelete() {
        Set<Id> userIds = new Set<Id>();
        for(PermissionSetAssignment pa : [SELECT Id, AssigneeId FROM PermissionSetAssignment WHERE 
                                          PermissionSet.Name Like 'Controlled_Document%' LIMIT 200]) {
                                              userIds.add(pa.AssigneeId);
                                          }
        Map<Id, User> usersMap = new Map<Id, User>([SELECT Id FROM User WHERE Id IN :userIds 
                                                    AND IsActive=true AND UserType='Standard' LIMIT 5]);  
        List<User> users = usersMap.values();
        Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
        controlDoc.Reason_File_Deletion__c = 'testing';
        insert controlDoc;
        Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', users[0].Id);
        insert step;
        FeedItem post = ControlledDocumentTestUtility.createFeedItem(controlDoc.id);
        insert post; 
        List<FeedItem> feedItemExt = [SELECT Id, RelatedRecordId FROM FeedItem WHERE Id = :post.Id];
        List<ContentVersion> cvrExt = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :feedItemExt.get(0).RelatedRecordId];
        Set<Id> cdocIds = new Set<Id>();
        for(ContentVersion cvr: cvrExt) {
            cdocIds.add(cvr.ContentDocumentId);
        }
        List<ContentDocumentLink> cdlExt = [SELECT Id, LinkedEntityId, ShareType FROM ContentDocumentLink 
                                            WHERE ContentDocumentId IN :cdocIds];
		System.assertEquals(1, feedItemExt.size());
		System.assertEquals(1, cvrExt.size());
		System.assertEquals(true, cdlExt.size()>0);        
		//ContentVersion contentVer = ControlledDocumentTestUtility.getContentVersion(post.RelatedRecordId);
		//List<ContentDocumentLink> existingLinks = ControlledDocumentTestUtility.getLinkForUserDocument(UserInfo.getUserId(), contentVer.ContentDocumentId);
        Test.startTest();
        delete post;
        Test.stopTest();
        Integer count=0;
        for(ContentDocumentLink cdl: [SELECT Id, LinkedEntityId, ShareType FROM ContentDocumentLink 
                                      WHERE ContentDocumentId IN :cdocIds]) {
                                          if(cdl.ShareType == 'C') {
                                          	count = count + 1;    
                                          }    
                                      }                                  
        System.assertEquals(0, count);
    }
    // CDT Case# 31205 - END
}