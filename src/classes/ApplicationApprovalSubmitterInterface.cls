public interface ApplicationApprovalSubmitterInterface {
	void submitSystemRecommendedApplicationsForApproval(List<Application__c> applications, Map<Id,Application__c> oldApplicatonsMap);
}