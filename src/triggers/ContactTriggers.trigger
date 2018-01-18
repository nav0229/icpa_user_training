/*
	ContactTriggers.trigger
	This should call various Contact Trigger Helpers that deal with Contacts
	-------------------------------------------------------------------
	Author                 Date       Version  Description
	-------------------------------------------------------------------
	Damien Phillippi       12/20/2011  1.00    Creation
	Smitha Unnivelan       05/19/2014          Reference to ContactUniqueEmailTriggerHelper changed to CRMUtil
	Rajakumar P            08/17/2015  1.02    Updated to include the logic form OHRM Hiring Manager and Supervisor surveys reminders
	Justin Lyon - AS	   09/24/2015		   Add New Supervisor Survey support
												catchNewSupervisors()
*/
// BEGIN - COMMENTED in version 1.02
// trigger ContactTriggers on Contact (before insert, before update)
// END - COMMENTED in version 1.02
// BEGIN - INSERTED in version 1.02
trigger ContactTriggers on Contact (before insert, after insert, before update, after update)
// END - INSERTED in version 1.02
{
	if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
	{
		//ContactUniqueEmailTriggerHelper.validateUniqueEmails(Trigger.new, Trigger.oldMap);
		CRMUtil.validateUniqueEmails(Trigger.new, Trigger.oldMap);
	}
	// BEGIN - INSERTED in version 1.02
	if(Trigger.isAfter && Trigger.isUpdate) {
		ContactHelper.onAfterUpdate(Trigger.new, Trigger.oldMap);
	}
	// END - INSERTED in version 1.02

	// Developed by Acumen Solutions
	if(Trigger.isAfter) {
		if(Trigger.isUpdate) {
			ContactHelper.catchNewSupervisors(Trigger.new, Trigger.oldMap);
		} else if(Trigger.isInsert) {
			ContactHelper.catchNewSupervisors(Trigger.new, null);
		}
	}
}