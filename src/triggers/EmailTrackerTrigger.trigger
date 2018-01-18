/*-------------------------------------------------------------------------------------------------*
  Apex trigger - EmailTracker__c custom object
  Contact Manager VOE surveys
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/14/2015    1.0       Initial version.
  Justin Lyon        09/24/2015              Add New Supervisor Survey support
                                              deleteNewSupervisorEmailTrackerReminders()
                                              createNewSupervisorReminderTrackers()
  GaneshKumar Mandava    08/24/2017           Removed code which creates reminder records.

 *-------------------------------------------------------------------------------------------------*
 *-------------------------------------------------------------------------------------------------*/
trigger EmailTrackerTrigger on EmailTracker__c (before insert, after update, before update, after insert) {
    // begin
    /* before insert -
        FOR EACH record, find related User by ToContact.FederatedID.
        THEN Set the Owner to the User.
    */
    if(Trigger.isBefore && Trigger.isInsert) {
        EmailTrackerHelper.onBeforeInsert(Trigger.new);
    }

    
}