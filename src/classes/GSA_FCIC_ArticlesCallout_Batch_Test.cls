@isTest
public class GSA_FCIC_ArticlesCallout_Batch_Test{

  static testMethod void GSA_FCIC_ArticlesCalloutBatchTest(){
	   
	GSA_FCIC_ArticlesCallout_Batch  gsaCall = new GSA_FCIC_ArticlesCallout_Batch(5);

		  
	KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', 
														Endpoint__c = 'http://api.data.gov/gsa/cmp/v1/usagov/', 
														API_Key__c= 'nhDDY3PIS2OJtiFyAva27CItXCUmIKupE3N1VLc2', 
														Create_Exception_Record__c= true,  
														Date_Delta__c = 3, 
														Email_Exception__c = true, 
														Page_Size__c=3);
	insert kbSync ;
	system.assert(kbSync.API_Key__c == 'nhDDY3PIS2OJtiFyAva27CItXCUmIKupE3N1VLc2');
	test.starttest();
	  Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(200,'Sucess',GSA_FCIC_KDBArticles_TestGenerator.getPublishedResponse(100),null));
	  ID batchprocessid = Database.executeBatch(gsaCall ,5);
	Test.stopTest();     
  }

  static testMethod void GSA_FCIC_ArticlesCalloutInitialBatchTest(){
   
	GSA_FCIC_ArticlesCallout_InitialBatch  gsaCall = new GSA_FCIC_ArticlesCallout_InitialBatch();

		
	KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', 
														Endpoint__c = 'http://api.data.gov/gsa/cmp/v1/usagov/',
														API_Key__c= 'nhDDY3PIS2OJtiFyAva27CItXCUmIKupE3N1VLc2', 
														Create_Exception_Record__c= true, 
														Date_Delta__c = 3, 
														Email_Exception__c = true, 
														Page_Size__c=3);
	insert kbSync ;
	system.assert(kbSync.API_Key__c == 'nhDDY3PIS2OJtiFyAva27CItXCUmIKupE3N1VLc2');
	test.starttest();
	  Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(200,'Sucess',GSA_FCIC_KDBArticles_TestGenerator.getPublishedResponse(100),null));
	  ID batchprocessid = Database.executeBatch(gsaCall ,5);
	Test.stopTest();   
  }

}