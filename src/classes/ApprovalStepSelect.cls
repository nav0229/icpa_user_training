/*-------------------------------------------------------------------------------------------------*
  ApprovalStepSelect
  -Wrapper class for use in the RelatedApprovalStepListController and the ApprovalStepSelect
   manger classes.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Stefan Maurer      09/30/2014    1.0       Created
 *-------------------------------------------------------------------------------------------------*/
 public with sharing class ApprovalStepSelect {
	public Approval_Step__c approvalStep {get; set;}
	public Boolean selected {get; set;}

	public ApprovalStepSelect(Approval_Step__c approvalStep) {
		this.approvalStep = approvalStep;
		selected = false;
	}

	public ApprovalStepSelect(ApprovalStepSelect step){
		this.approvalStep = step.approvalStep.clone(true, true);
		this.selected = step.selected;
	}

	public Boolean getIsLocked(){
		return approvalStep.Approval_Status__c == ControlledDocumentConstants.INITIATED_STATUS_STRING ||
		       approvalStep.Approval_Status__c == ControlledDocumentConstants.APPROVED_STATUS_STIRNG  ||
		       approvalStep.Approval_Status__c == ControlledDocumentConstants.APPROVED_WITH_COMMENTS_STATUS_STIRNG;
	}
}