@isTest
private class CDTPreventAttachmentDeleteHelperTest {
   
    static testmethod void deleteattachment(){
       
		FeedItem post;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(2);
		User testUser1 = exsitingStandardUsers.get(0);
		User testUser2 = exsitingStandardUsers.get(1);
		system.runAs(testUser1){
		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
        controlDoc.Reason_File_Deletion__c = 'Deletiong for Testing';
		insert controlDoc;
       
		insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser2.Id);
        ControlledDocumentTestUtility.insertCollaborationTriggerControl(true);
					
       	ContentVersion testContentInsert =new ContentVersion(); 
        testContentInsert.ContentURL = '<a target="_blank" href="http://www.google.com/" rel="nofollow">http://www.google.com/</a>'; 
        testContentInsert.Title ='Google.com'; 
        insert testContentInsert; 
        
        ContentVersion testContent = [SELECT ContentDocumentId FROM ContentVersion where Id = :testContentInsert.Id];
        
        ContentDocument contentDoc = [select id from contentDocument where id=:testContent.ContentDocumentId];
        ContentDocumentLink contentlink=new ContentDocumentLink();
            contentlink.LinkedEntityId=controlDoc.id;
            contentlink.contentdocumentid=contentDoc.Id;
            contentlink.ShareType = 'V';
        insert contentlink;
        
        Test.startTest(); 
            try{
                delete contentDoc;
             	Controlled_Document__c Cd = [Select ID,Reason_File_Deletion__c from Controlled_Document__c where id = :controlDoc.id]; 
                System.assertEquals(null, cd.Reason_File_Deletion__c);
               }
            catch(Exception e){ 
                Boolean expectedExceptionThrown =  e.getMessage().contains('you cannot delete this attachment') ? true : false;
				System.AssertEquals(expectedExceptionThrown, true);
                
            }	
        Test.stopTest(); 
        }
    }
}