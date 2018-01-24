public with sharing class ApplicationApprovalSubmitter implements ApplicationApprovalSubmitterInterface {

	private final String APPROVAL_PROCESS_TEAM_LEAD_REVIEW = 'Application_Approval_Team_Lead_Review';

	public ApplicationApprovalSubmitter(){}

	public void submitSystemRecommendedApplicationsForApproval(List<Application__c> applications, Map<Id,Application__c> oldApplicationsMap){
		List<Application__c> applicationsToSubmit = new List<Application__c>();

		for(Application__c application : applications){
			if(application.Status__c == ApplicationDataAccessor.STATUS_SYSTEM_RECOMMENDED 
				&& application.Status__c != oldApplicationsMap.get(application.Id).Status__c
				&& !Approval.isLocked(application.Id)
			){
				applicationsToSubmit.add(application);
			}
		}

		if(!applicationsToSubmit.isEmpty()){
			submitApplicationsForTeamLeadReview(applicationsToSubmit);
		}
	}

	private void submitApplicationsForTeamLeadReview(List<Application__c> applicationsToSubmit){
		List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();

		for(Application__c application : applicationsToSubmit){
			Approval.ProcessSubmitRequest newRequest = new Approval.ProcessSubmitRequest();
			newRequest.setObjectId(application.Id);
			newRequest.setSubmitterId(UserInfo.getUserId());
			newRequest.setProcessDefinitionNameOrId(APPROVAL_PROCESS_TEAM_LEAD_REVIEW);
			newRequest.setSkipEntryCriteria(false);
			newRequest.setComments('Submitting for Team Lead\'s Approval');

			approvalRequests.add(newRequest);
		}

		if(!approvalRequests.isEmpty()){
			System.debug('Submitting approval request for Applications:'+applicationsToSubmit);
			try {
				Approval.process(approvalRequests);
			} catch(Exception e) {
				System.debug('Error occurred while attempting to submit Applications for Approval');
			}
		}
	}
}