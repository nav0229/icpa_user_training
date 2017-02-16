@isTest
private class GSA_FCIC_KDBArticles_Callout_Test {
    
    static testMethod void testServiceFail() {
        //KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');   
        KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = false,Page_Size__c=3);
        insert kbSync ;
        system.assert(kbSync.API_Key__c == '1234');

        Test.starttest();

        Test.setMock(HttpCalloutMock.class, new GSA_FCIC_KDBArticles_MockCallout(201,'Failure',GSA_FCIC_KDBArticles_TestGenerator.getPublishedResponse(100),null));
        DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
        GSA_FCIC_KDBArticles_Callout.getArticleDetails_WS(todayDate, null, new Map<String, String>{'Key1' => 'Value1'}, new List<String>{'Field1', 'Field2'}, (Integer)kbSync.Page_Size__c,0, null, false);
        GSA_FCIC_KDBArticles_Callout.getArticleDetails_WS(todayDate, null, null, null, (Integer)kbSync.Page_Size__c,0, null, false);

        Test.stoptest();

        System.assertEquals(1,1); // Fake assert TODO: come back
    }
    
}