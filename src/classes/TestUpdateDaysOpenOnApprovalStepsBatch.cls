/*-------------------------------------------------------------------------------------------------*
  TestUpdateDaysOpenOnApprovalStepsBatch
  Test class for the UpdateDaysOpenOnApprovalStepsBatch class.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Stefan Maurer      12/07/2014    1.0       Created
 *-------------------------------------------------------------------------------------------------*/
@isTest
private class TestUpdateDaysOpenOnApprovalStepsBatch {

	@isTest static void testBatchExecution() {
		Controlled_Document__c controlDoc;
		Approval_Step__c step;
		List<User> exsitingStandardUsers = ControlledDocumentTestUtility.getStandardUsers(1);
		User testUser1 = exsitingStandardUsers.get(0);
		
		System.runAs(testUser1) {
			controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			controlDoc.ExecSec_Start_Date__c = System.today();
			insert controlDoc;
			step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.id, '1', testUser1.Id);
			step.Approval_Status__c = ControlledDocumentConstants.INITIATED_STATUS_STRING;
			insert step;
		}

		Test.startTest();
		//System.schedule('ScheduleUpdateDaysOpenOnApprovalStepsBatch', '0 0 0 1 1 ? 2022', new ScheduleUpdateDaysOpenOnApprovalSteps());
		UpdateDaysOpenOnApprovalStepsBatch u = new UpdateDaysOpenOnApprovalStepsBatch();
		Database.executeBatch(u);
		Test.stopTest();

		controlDoc = ControlledDocumentTestUtility.getControlledDocument(controlDoc.id);
		System.assertEquals(UserInfo.getUserId(), controlDoc.LastModifiedById, 'If batch ran successfully, last modified user should be the same as the user that is running the test.');
	}

}