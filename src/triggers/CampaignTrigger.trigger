trigger CampaignTrigger on Campaign (after insert, before insert)
{
	if (Trigger.isAfter && Trigger.isInsert)
		CampaignHelper.setUpStatuses(Trigger.new);
	if (Trigger.isBefore && Trigger.isInsert)
		CampaignHelper.setCampaignActiveTitleVI(Trigger.new);
}