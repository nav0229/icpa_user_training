public class CampaignHelper
{
	public static String SELECTED = 'Selected';
	public static String FIRST_LETTER_SENT = 'First Letter Sent';
	public static String SECOND_LETTER_SENT = 'Second Letter Sent';
	public static String THIRD_LETTER_SENT = 'Third Letter Sent';
	public static String NO_ACTIVITY = 'No Activity';
	public static String DRAFT = 'Draft';
	public static String SUBMITTED = 'Submitted';
	private static String INVITED = 'Invited';
	private static String SPEAKER = 'Speaker';
	private static String WILL_ATTEND = 'Will Attend';
	private static String ATTENDED = 'Attended';
	
	public static Id TITLE_VI_ROLLOUT_ID = [SELECT Id FROM RecordType WHERE DeveloperName = 'Title_VI_Rollout' AND SObjectType = 'Campaign'].Id;
	
	public static void setUpStatuses(List<Campaign> camps)
	{
		List<CampaignMemberStatus> memberStatuses = new List<CampaignMemberStatus>();
		Map<Id, List<CampaignMemberStatus>> oldStatuses = new Map<Id, List<CampaignMemberStatus>>();
		for (CampaignMemberStatus status: [SELECT SortOrder, Label, CampaignId, IsDefault, HasResponded FROM CampaignMemberStatus WHERE CampaignId IN: camps])
		{
			if (oldStatuses.get(status.CampaignId) == null)
				oldStatuses.put(status.CampaignId, new List<CampaignMemberStatus>());
			
			oldStatuses.get(status.CampaignId).add(status);
		}
		
		for (Campaign camp: camps)
		{
			if (camp.RecordTypeId == TITLE_VI_ROLLOUT_ID)
			{
				//List<CampaignMemberStatus> currAssoc = oldStatuses.get(camp.Id);
				//memberStatuses.add(new CampaignMemberStatus(sortOrder = 1, label = SELECTED, CampaignId = camp.Id, IsDefault = true, Id = currAssoc[0].Id));
				//memberStatuses.add(new CampaignMemberStatus(sortOrder = 2, label = FIRST_LETTER_SENT, campaignId = camp.id, Id = currAssoc[1].Id));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 3, label = SELECTED, CampaignId = camp.Id, IsDefault = true));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 4, label = FIRST_LETTER_SENT, campaignId = camp.id));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 5, label = SECOND_LETTER_SENT, campaignId = camp.id));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 6, label = THIRD_LETTER_SENT, campaignId = camp.id));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 7, label = NO_ACTIVITY, campaignId = camp.id));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 8, label = DRAFT, campaignId = camp.id));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 9, label = SUBMITTED, campaignId = camp.id, HasResponded = true));
			}
			
			if (camp.Real_Property_Campaign__c)
			{
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 3, label = INVITED, CampaignId = camp.Id, IsDefault = true));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 4, label = SPEAKER, CampaignId = camp.Id, IsDefault = false));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 5, label = WILL_ATTEND, CampaignId = camp.Id, IsDefault = false));
				memberStatuses.add(new CampaignMemberStatus(sortOrder = 6, label = ATTENDED, CampaignId = camp.Id, IsDefault = false));
			}
		}
		
		upsert memberStatuses;
	}

	public static void setCampaignActiveTitleVI(List<Campaign> camps)
	{
		for (Campaign camp: camps)
			if (camp.RecordTypeId == TITLE_VI_ROLLOUT_ID)
				camp.IsActive = true;
	}
	
	static testMethod void testCampaignHelper()
	{
		List<Campaign> newCamps = new List<Campaign>();
		Campaign camp = new Campaign();
		camp.Name = 'Test Camp';
		camp.RecordTypeId = TITLE_VI_ROLLOUT_ID;
		newCamps.add(camp);
		
		Campaign camp2 = new Campaign();
		camp2.Name = 'Test camp 2';
		camp2.Real_Property_Campaign__c = true;
		camp2.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Campaign' AND DeveloperName = 'General_Campaign'].Id;
		newCamps.add(camp2);
		insert newCamps;
		
		System.assert([SELECT Id FROM CampaignMemberStatus WHERE CampaignId =: camp.Id].size() > 0, 'No CampaignMemberStatus inserted.');
	}
}