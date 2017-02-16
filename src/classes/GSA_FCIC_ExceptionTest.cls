@isTest
private class GSA_FCIC_ExceptionTest {
	
	static testMethod void createGeneralException() {
		try{
			throw new GSA_FCIC_Exception('Test exception has been thrown');
		} catch(GSA_FCIC_Exception e) {
			e.createExceptionRecord();
		}

		List<Exception__c> exceptions = [Select Id, Description__c, Exception_Type__c from Exception__c];

		system.assertEquals(exceptions.size(),1);
		Exception__c ex = exceptions[0];

		system.assertEquals(ex.Description__c,'Test exception has been thrown');
		system.assertEquals(ex.Exception_Type__c,'GSA_FCIC_Exception');

	}
	
	static testMethod void logGeneralException() {
		try{
			throw new GSA_FCIC_Exception('Test exception has been thrown');
		} catch(GSA_FCIC_Exception e) {
			e.createExceptionRecord(true, false);
		}

		List<Exception__c> exceptions = [Select Id, Description__c, Exception_Type__c from Exception__c];

		system.assertEquals(exceptions.size(),0);
	}

	static testMethod void createKBArticleException() {
		KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3);
        insert kbSync ;

		try{
			throw new GSA_FCIC_KBArticles_Exception('Test exception has been thrown');
		} catch(GSA_FCIC_KBArticles_Exception e) {
			e.createExceptionRecord();
		}

		List<Exception__c> exceptions = [Select Id, Description__c, Exception_Type__c from Exception__c];

		system.assertEquals(exceptions.size(),1);
		Exception__c ex = exceptions[0];

		system.assertEquals(ex.Description__c,'Test exception has been thrown');
		system.assertEquals(ex.Exception_Type__c,'GSA_FCIC_KBArticles_Exception');

	}
	
	static testMethod void logKBArticleException() {
		KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3);
        insert kbSync ;
		
		try{
			throw new GSA_FCIC_KBArticles_Exception('Test exception has been thrown');
		} catch(GSA_FCIC_KBArticles_Exception e) {
			e.createExceptionRecord(true, false);
		}

		List<Exception__c> exceptions = [Select Id, Description__c, Exception_Type__c from Exception__c];

		system.assertEquals(exceptions.size(),0);
	}


	
}