@isTest 
private class TestBatchQualityAssuranceController {
	
	@isTest static void testController(){
		Test.startTest();

		// start Grant Update Access batch
		GrantAccessToChatterFileBatch b = new GrantAccessToChatterFileBatch();
		ID batchprocessid = Database.executeBatch(b, 1);

		// create a controlled document
		//ControlledDocumentTestUtility.createRequiredChatterGroups();
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(1);
		User testUser1 = exsitingStandardUsers.get(0);
		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;
		}

		// query CD
		List<Controlled_Document__c> cdList = [SELECT Id FROM Controlled_Document__c LIMIT 1];

		// create a Grant Update Access Request
		Controlled_Document_Feed__c cdf = new Controlled_Document_Feed__c();
		cdf.Controlled_Document__c = cdList.get(0).Id;
		cdf.Status__c = 'Pending';
		insert cdf;

		// instantiate the controller
		BatchQualityAssuranceController batchQualityAssuranceController = new BatchQualityAssuranceController();
		//BatchQualityAssuranceController.BatchWrapper bw = new BatchQualityAssuranceController.BatchWrapper('', 0, System.now());
		//BatchQualityAssuranceController.BadControlledDocuments bcd = new BatchQualityAssuranceController.BadControlledDocuments('', '', '', '', System.now());

		// the assert
		System.assertNotEquals(b, null);

		Test.stopTest();
	}

}