/**
 * SurveyFeedbackHelper.cls
 * @author  Justin Lyon
 * @date 6/29/2015
 *
 * Manage methods and logic for the SurveyFeedbackTrigger.trigger.
 */
public with sharing class SurveyFeedbackHelper {

	/**
	 * [setOwner Before insert, set Owner to related User by Contact.Contact_Federated_ID__c]
	 * @param newFeedbacks [Trigger.new]
	 */
	public static void setOwner(List<SurveyFeedback__c> newFeedbacks) {
		Set<Id> contactIds = new Set<Id>();
		for(SurveyFeedback__c sf : newFeedbacks) {
			contactIds.add(sf.Contact__c);
		}

		Map<String, Contact> fedIdToContact = new Map<String, Contact>();
		Map<String, User> fedIdToUser = new Map<String, User>();
		try {
			// Map Fed Id to Contact and Fed Id to User
			// Contact.Contact_Federated_ID__c
			for(Contact c : [SELECT Contact_Federated_ID__c FROM Contact WHERE Id IN :contactIds]) {
				if(c.Contact_Federated_ID__c != null) {
					fedIdToContact.put(c.Contact_Federated_ID__c, c);
				}
			}

			// User.FederationIdentifier
			for(User u : [SELECT FederationIdentifier, Id FROM User WHERE FederationIdentifier IN :fedIdToContact.keySet()]) {
				fedIdToUser.put(u.FederationIdentifier, u);
			}
		} catch(QueryException qe) {
			System.debug(qe.getMessage());
		}

		// If a user with matching Fed Id exists, Map Contact Id to User by Fed Id
		Map<Id, User> contactIdToUserMap = new Map<Id, User>();
		for(Contact c : fedIdToContact.values()) {
			if(fedIdToUser.containsKey(c.Contact_Federated_ID__c)) {
				contactIdToUserMap.put(c.Id, fedIdToUser.get(c.Contact_Federated_ID__c));
			}
		}

		// For each Contact with a Matching User by Fed Id, change Feedback's Owner.
		if(!contactIdToUserMap.isEmpty()) {
			for(SurveyFeedback__c sf : newFeedbacks) {
				if(contactIdToUserMap.containsKey(sf.Contact__c)) {
					sf.OwnerId = contactIdToUserMap.get(sf.Contact__c).Id;
				}
			}
		}
	}
}