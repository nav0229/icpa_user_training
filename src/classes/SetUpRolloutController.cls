/*
	SetUpRolloutController.cls
	A controller that sets up Contacts to become Campaign Members
	-------------------------------------------------------------------
	Author                 Date        Version  Description
	-------------------------------------------------------------------
	Damien Phillippi       ??/??/2011  1.00     Creation
	Sathish Durairaj       ??/??/2011  2.00     Giving it an additional purpose
	Damien Phillippi       12/20/2011  2.01     Making it pass the XSRF issues
*/
public with sharing class SetUpRolloutController
{
	private Campaign camp;
	private List<Contact> campContacts;
	
	public static Id TITLEVI_RECORDTYPE = [SELECT Id, Name FROM RecordType WHERE Name = 'Title VI Contact' AND SObjectType = 'Contact'].Id;

	public SetUpRolloutController(ApexPages.StandardController stdController)
	{
		camp = (Campaign)stdController.getRecord();
	}

	public PageReference setUpRollout()
	{
		PageReference pageRef = null;
		boolean validationError = false;

		// Check that the campaign has a rollout state selected (legacy data issue)
		if (camp.OCR_Rollout_State__c != null)
		{

			// Determine the campaign status
			boolean statusInProgress = camp.Status.equalsIgnoreCase('In Progress');
			boolean statusRolloutSetup = camp.Status.equalsIgnoreCase('Rollout Set Up');

			if (statusInProgress || statusRolloutSetup)
			{
				// Get the contacts associated to this campaign's state(s)
				campContacts = getRolloutStateContacts();
	
				system.debug('statusRolloutSetup -------------------------->'+ statusRolloutSetup);
				// Check if the the user clicked on the setup rollout link again, after
				// the campaign's status was set to Rollout Setup and determine if any  
				// campaign members were removed
				if ( statusRolloutSetup ) {
					List<CampaignMember> currCampMembers = 
						[SELECT ContactId FROM CampaignMember WHERE CampaignId =: camp.Id];
					if (!currCampMembers.isEmpty()) {
						// The campaign is currently set to "Rollout Setup" and has campaign
						// member, but the link to run this logic was clicked again. We need
						// to verify if this action is valid
						validationError = hasSetupRolloutValidationError(currCampMembers);
					}
				} else {
					// Delete all the contacts in case the campaign status was changed 
					// manually back to campaign status "In Progress"
					deleteCampMembers();
				}
	
				if ( !validationError ) {
					// Create the campaign members based on the contacts found in the
					// rollout state(s) selected
					addMembers(campContacts);
	
					changeStatus('Rollout Set Up');
	
					pageRef = new PageReference('/' + camp.Id);
					
					system.debug('Inside Actual adding members ------'+ campContacts);
				}
			} else
			{
				// Cannot click on setup rollout unless the campaign status is set 
				// to "In Progress" or "Rollout Set Up" (special case)
				System.debug('The Campaign status is:-----> ' + camp.Status);
				logErrorMessage('The Rollout has already been setup.');
			}
		} else
		{
			// This issue will only occur with older legacy data as the state has been
			// made a required field on the campaign page layout
			logErrorMessage('This campaign doesn\'t have a rollout state selected. ' +
				'Please go back and associate this campaign to a state(s).');
		}
		return pageRef;
	}
	
	private void addMembers(List<Contact> campContacts)
	{
		List<CampaignMember> members = new List<CampaignMember>();
		for (Contact cont: campContacts)
		{
			CampaignMember member = new CampaignMember();
			member.CampaignId = camp.Id;
			member.ContactId = cont.Id;
			member.Status = CampaignHelper.SELECTED;
			members.add(member);
		}
		insert members;
	}
	
	private void deleteCampMembers()
	{
		delete [SELECT Id FROM CampaignMember WHERE CampaignId =: camp.Id];
	}
	
	public PageReference completeRollout()
	{
		PageReference pageRef = null;
		//Code to set the Rollout status to 'Completed'
		if (camp.Status == 'Completed'){
			System.debug('The Campaign status is:-----> ' + camp.Status);
			logErrorMessage('The Rollout is already completed.');
		} else
		{
			changeStatus('Completed');
			pageRef = new PageReference('/' + camp.Id);
		}
		
		
		return pageRef;
	}
	
	private void changeStatus(String newStatus)
	{
		camp.Status = newStatus;
		update camp;
	}

	/**
	 * Creates a list of contacts whose accounts are associated to the campaign's 
	 * rollout state(s)
	 */
	private List<Contact> getRolloutStateContacts() {
		String rolloutStates = camp.OCR_Rollout_State__c;
		//rolloutStates = rolloutStates.replaceAll(' ', '');

		List<String> rolloutStatesList = rolloutStates.split(';', 50);
		
		return [SELECT Id FROM Contact 
				WHERE Account.OCR_Title_VI_Status__c = 'Active' 
				AND Account.OCR_Reporting_State__c IN: rolloutStatesList 
				AND OCR_Title_VI_Primary_Contact__c = true 
				AND Account.Type = 'Donee'
				AND Contact.RecordTypeId = :TITLEVI_RECORDTYPE];
	}

	/**
	 * Performs all processing logic for when a user clicks on "Set Up Rollout" when
	 * the campaign's status is already set to "Rollout Set Up". If no contacts were 
	 * removed the function returns a validation error flag, otherwise it repopulates the
	 * contacts list with the removed contacts to re-add them to the campaign as members
	 */
	private boolean hasSetupRolloutValidationError(List<CampaignMember> currCampMembers) {
		boolean validationError = false;
		if ( currCampMembers.size() == campContacts.size() ) {
			logErrorMessage('The Rollout has already been setup.');
			validationError = true;
		} else {
			// The lists don't have the same number of contacts, re-add the 
			// missing members to the campaign
			Set<Id> contactIds = new Set<Id>();
			for ( CampaignMember curr : currCampMembers ) {
				contactIds.add(curr.ContactId);
			}

			// Get the contacts that are supposed to be assigned as members on the
			// campaign but were removed or added after the campaign was created
			String rolloutStates = camp.OCR_Rollout_State__c;
			//rolloutStates = rolloutStates.replaceAll(' ', '');
			List<String> rolloutStatesList = rolloutStates.split(';', 50);
			campContacts = 
				[SELECT Id FROM Contact WHERE Account.OCR_Title_VI_Status__c = 'Active' 
				 AND Account.OCR_Reporting_State__c IN: rolloutStatesList 
				 AND OCR_Title_VI_Primary_Contact__c = true
				 AND Id NOT IN: contactIds
				 AND Account.Type = 'Donee'
				 AND Contact.RecordTypeId = :TITLEVI_RECORDTYPE];	
				 			
		}
		return validationError;
	}

	/**
	 * Logs an error message on the visual force page
	 */
	private void logErrorMessage(String errMsg) {
		ApexPages.Message myMsg = 
			new ApexPages.Message(ApexPages.Severity.ERROR, errMsg);
		ApexPages.addMessage(myMsg);
	}

}