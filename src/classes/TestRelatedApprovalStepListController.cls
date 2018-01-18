/*-------------------------------------------------------------------------------------------------*
  TestApprovalStepListController
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Stefan Maurer      10/31/2014    1.0       Created
 *-------------------------------------------------------------------------------------------------*/
@isTest
private class TestRelatedApprovalStepListController {
	
	@isTest static void testNoApprovalSteps() {
		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;

		Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);
		Test.stopTest();

		System.assertEquals(1, controller.manager.approvalStepSelects.size(), 'The approvalStepSelects list should only include the new row.');
		System.assertEquals(false, controller.editMode);
	}

	@isTest static void testWithExistingApprovalSteps() {
		List<Approval_Step__c> newApprovalSteps = new List<Approval_Step__c>();

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		Controlled_Document__c otherControlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert new List<Controlled_Document__c>{controlDoc, otherControlDoc};

		newApprovalSteps.add(ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', UserInfo.getUserId()));
		newApprovalSteps.add(ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '2', UserInfo.getUserId()));
		newApprovalSteps.add(ControlledDocumentTestUtility.createApprovalStep(otherControlDoc.id, '1', UserInfo.getUserId()));
		insert newApprovalSteps;

		Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);
		Test.stopTest();

		System.assertEquals(3, controller.manager.approvalStepSelects.size(), 'The approvalStepSelects list should only include the 2 inserted approval steps and the new row.');
		System.assertEquals(false, controller.editMode);
	}

	@isTest static void testEditMode(){
		List<Approval_Step__c> newApprovalSteps = new List<Approval_Step__c>();

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;
		insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', UserInfo.getUserId());
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);

		Test.startTest();
		controller.editMode();
		Test.stopTest();

		System.assertEquals(true, controller.editMode);
		System.assertEquals(1, controller.manager.ApprovalStepSelects.size(), 'Manager should have removed the last row, leaving only 1 approval step.');
	}

	@isTest static void testReadMode(){
		List<Approval_Step__c> newApprovalSteps = new List<Approval_Step__c>();

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;
		insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', UserInfo.getUserId());
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);
		controller.editMode();

		Test.startTest();
		controller.readMode();
		Test.stopTest();

		System.assertEquals(false, controller.editMode);
		System.assertEquals(2, controller.manager.ApprovalStepSelects.size(), 'Manager should have readded the last row, leaving 2 approval steps.');
	}

	@isTest static void testSaveTable(){
		List<Approval_Step__c> newApprovalSteps = new List<Approval_Step__c>();

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;
		insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', UserInfo.getUserId());
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);
		controller.editMode();

		Test.startTest();
		controller.saveTable();
		Test.stopTest();

		System.assertEquals(false, controller.editMode);
		System.assertEquals(2, controller.manager.ApprovalStepSelects.size(), 'Manager should have readded the last row, leaving 2 approval steps.');
	}

	@isTest static void testFailedSaveTable(){
		List<Approval_Step__c> newApprovalSteps = new List<Approval_Step__c>();

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;
		Approval_Step__c step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', UserInfo.getUserId());
		step.Office__c = null;
		insert step;
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);
		controller.editMode();

		Test.startTest();
		controller.saveTable();
		Test.stopTest();

		System.assertEquals(true, controller.editMode);
		System.assertEquals(1, controller.manager.ApprovalStepSelects.size(), 'Manager should have remained in edit mode, leaving only 1 row.');
	}

	@isTest static void testGetExternalReviewRoleName(){
		List<Approval_Step__c> newApprovalSteps = new List<Approval_Step__c>();

		Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
		insert controlDoc;
		insert ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', UserInfo.getUserId());
		ApexPages.StandardController sc = new ApexPages.StandardController(controlDoc);
		RelatedApprovalStepListController controller = new RelatedApprovalStepListController(sc);
		Test.setCurrentPage(Page.RelatedApprovalStepList);

		Test.startTest();
		controller.getEXTERNAL_REVIEW_ROLE_NAME();
		Test.stopTest();

		System.assertEquals(ControlledDocumentConstants.EXTERNAL_REVIEW_ROLE_NAME, controller.getEXTERNAL_REVIEW_ROLE_NAME());
	}
}