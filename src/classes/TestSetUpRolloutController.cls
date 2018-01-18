/*
	TestSetUpRolloutController.cls
	Tests the SetUpRolloutController.cls
	-------------------------------------------------------------------
	Author                 Date        Version  Description
	-------------------------------------------------------------------
	Unknown                ??/??/2011  1.0.0    Creation
	Damien Phillippi       01/13/2012  1.1.0    Adding additional Coverage
*/
@isTest
private class TestSetUpRolloutController
{
	static testMethod void testSetUpRolloutCampaignInProgress()
	{
		
		//Create an account with Title VI Status in Ohio
		Account acc = new Account();
		acc.Name = 'Test Acc';
		acc.OCR_Reporting_State__c = 'OH';
		acc.OCR_Title_VI_Status__c = 'Active';
		acc.Type = 'Donee';
		insert acc;

		//Create an associated Contact for the Account
		Contact cont = new Contact();
		cont.LastName = 'LastName';
		cont.FirstName = 'FirstName';
		cont.Phone = '2222222222';
		cont.AccountId = acc.Id;
		cont.OCR_Contact_Via__c = 'E-Mail';
		cont.Email = 'tester@test.com';
		cont.RecordTypeId = [SELECT Id, Name FROM RecordType WHERE Name = 'Title VI Contact' AND SObjectType = 'Contact'].Id;
		insert cont;

		//Create another associated Contact for the Account
		Contact cont2 = new Contact();
		cont2.LastName = 'LastName2';
		cont2.FirstName = 'FirstName2';
		cont2.Phone = '2222222233';
		cont2.AccountId = acc.Id;
		cont2.OCR_Contact_Via__c = 'E-Mail';
		cont2.Email = 'tester2@test2.com';
		cont.RecordTypeId = [SELECT Id, Name FROM RecordType WHERE Name = 'Title VI Contact' AND SObjectType = 'Contact'].Id;
		insert cont2;

		//Create a campaign within Ohio
		List<Campaign> camps = new List<Campaign>();
		Campaign camp = new Campaign();
		camp.OCR_Rollout_State__c = 'OH';
		camp.Name = 'Test Camp';
		camp.Status = 'In Progress';
		camps.add(camp);
		
		//Create a campaign without a state
		Campaign campWithoutState = new Campaign();
		campWithoutState.Name = 'Test Camp2';
		campWithoutState.Status = 'In Progress';
		camps.add(campWithoutState);
		
		insert camps;

		/* 
		 * @TEST SUITE 1: Setup and complete the rollout on a campaign 
		 */
		//If the user is navigated to this page, it would add the contacts within the similar state
		//to the campaign and take them back to the Campaign
		SetUpRolloutController control = new SetUpRolloutcontroller(new ApexPages.Standardcontroller(camp));
		control.setUpRollout();
		
		//Make sure that the Contact got added to the Campaign as a Member
		System.assert([SELECT Id FROM CampaignMember WHERE ContactId =: cont.Id].size() > 0);
		System.assert(camp.Status == 'Rollout Set Up');

		// Complete the rollout
		control.completeRollout();
		System.assert(camp.Status == 'Completed');
		control.setUpRollout();
		control.completeRollout();
		/*
		camp.Status = 'Rollout Set Up';
		update camp;
		delete [SELECT Id FROM CampaignMember WHERE ContactId =: cont.Id];
		control.setUpRollout();
		control.completeRollout();
		*/
		control = new SetUpRolloutcontroller(new ApexPages.Standardcontroller(campWithoutState));
		control.setUpRollout();
		control.completeRollout();


		/* 
		 * @TEST SUITE 2: Setup the rollout, then remove campaign members and 
		 * verify that the rollout is setup once again.
		 */

		/** SUITE 2: test 1 - click on set up rollout after it was first clicked **/
		// make the campaign's status appear to be as if the rollout was clicked
		camp.Status = 'Rollout Set Up';
		update camp;
		camp = [SELECT Status, OCR_Rollout_State__c FROM Campaign WHERE Id =: camp.Id];

		// Set up the rollout on this campaign, first without removing the contacts
		control = new SetUpRolloutcontroller(new ApexPages.Standardcontroller(camp));
		control.setUpRollout();

		// There was an error, verify the campaign status remains the same
		System.assert(camp.Status == 'Rollout Set Up');


		/** SUITE 2: test 2 - delete all campaign members **/
		// second test, delete all the contacts serving as members on this campaign
		delete [SELECT Id FROM CampaignMember WHERE CampaignId =: camp.Id];

		// Verify that the campaign no longer has contacts
		System.assert([SELECT Id FROM CampaignMember WHERE CampaignId =: camp.Id].isEmpty());
		
		// Simulate the user clicking on Setup Rollout after all campaign member were removed
		control.setUpRollout(); 

		// Verify that the campaign has members once again
		System.assert([SELECT Id FROM CampaignMember WHERE ContactId =: cont.Id].size() > 0);


		/** SUITE 2: test 3 - delete 1 campaign member **/
		// The list of current campaign members, prior to removing one
		List<CampaignMember> curr = [SELECT Id FROM CampaignMember WHERE CampaignId =: camp.Id];

		// third test, delete one of the two contacts serving as members on this campaign
		delete [SELECT Id FROM CampaignMember WHERE CampaignId =: camp.Id LIMIT 1];

		// Verify that the campaign has one less member
		List<CampaignMember> afterDelete = [SELECT Id FROM CampaignMember WHERE CampaignId =: camp.Id];
		System.assert(curr.size()-1 == afterDelete.size());

		// Simulate the user clicking on Setup Rollout after a campaign member was removed
		control.setUpRollout(); 
		control.setUpRollout();

		// Verify that the campaign has members once again
		System.assert([SELECT Id FROM CampaignMember WHERE ContactId =: cont.Id].size() > 0);
	}

}