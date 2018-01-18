/* ----------------------------------------------------------------------------------
   Calculate the roll up summary field on Event Approval record when users 
   insert/update/delete Attendee record 
   Apex sharing - insert/update
-------------------------------------------------------------------------------------
    Author        | Date     | Version | Descripton
-------------------------------------------------------------------------------------
    Rajakumar       12/13/12   1.0       Initial Draft
    Rajakumar       05/06/14   2.0       Updated for apex sharing
    Rajakumar       08/19/14   3.0       Undo the changes made in 2.0
-------------------------------------------------------------------------------------    
*/
trigger AttendeeRollUp on Attendee__c (after delete, after insert, after update) {
 
  //When adding new attendees or updating existing attendees
  if (Trigger.isInsert || Trigger.isUpdate) {
    AttendeeRollUpHelper.onAfterUpsertorDelete(Trigger.new);
    /* -- Ver 3.0 -- Undo the changes made in 2.0 -- BEGIN --
    // -- Ver 2.0 -- Added for the apex Record Sharing -- BEGIN -- //
    if(Trigger.isInsert && Trigger.isAfter) {
        AttendeeRollUpHelper.recordInsertSharing(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        AttendeeRollUpHelper.recordUpdateSharing(Trigger.new, Trigger.oldMap);
    }
    // -- Ver 2.0 -- Added for the apex Record Sharing -- END -- // 
       -- Ver 3.0 -- Undo the changes made in 2.0 -- END -- */
  }
  
  //When deleting attendees
  if (Trigger.isDelete || Trigger.isUpdate) {
    AttendeeRollUpHelper.onAfterUpsertorDelete(Trigger.old);
  }
}