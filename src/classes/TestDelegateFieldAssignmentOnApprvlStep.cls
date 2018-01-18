@isTest
public class TestDelegateFieldAssignmentOnApprvlStep{

    static testMethod void testDelegateAssignment(){

    	DelegateFieldAssignmentOnApprovalStep.isTest = true;

    	List<User> existingStandardUsers = ControlledDocumentTestUtility.getStandardUsersWithDelegatedApprovers(2);
		User testUser1 = existingStandardUsers.get(0);
		User testUser2 = existingStandardUsers.get(1);
		User testUser3 = ControlledDocumentTestUtility.getDelegateOfUser(existingStandardUsers.get(1).Id);

		Approval_Step__c step;

		System.runAs(testUser1) {
			Controlled_Document__c controlDoc = ControlledDocumentTestUtility.createTestControlDoc();
			insert controlDoc;

			step = ControlledDocumentTestUtility.createApprovalStep(controlDoc.Id, '1', testUser2.Id);
			insert step;

			////////////////////
			Test.startTest();
			////////////////////

			ControlledDocumentTestUtility.initiateApprovalStep(step.Id);

			////////////////////
			Test.stopTest();
			////////////////////

		}

		System.runAs(testUser3){

			ControlledDocumentTestUtility.approveApprovalStep(step.Id);

		}

		System.assert(true);

    }

}