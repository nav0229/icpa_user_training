/* ----------------------------------------------------------------------------------
   Calculate the roll up summary field on Attendee record when users 
   insert/update/delete Attendee Expense record 
-------------------------------------------------------------------------------------
    Author        | Date     | Version | Descripton
-------------------------------------------------------------------------------------
    Rajakumar       12/13/12   1.0       Initial Draft
-------------------------------------------------------------------------------------    
*/
trigger AttendeeExpenseRollUp on Attendee_Expense__c (after delete, after insert, after update) {
 
  //When adding new attendee expenses or updating existing attendee expenses
  if (Trigger.isInsert || Trigger.isUpdate)
  {
    AttendeeExpenseRollUpHelper.onAfterUpsertorDelete(Trigger.new);
  }
  
  //When deleting attendee expenses
  if (Trigger.isDelete || Trigger.isUpdate)
  {
    AttendeeExpenseRollUpHelper.onAfterUpsertorDelete(Trigger.old);
  }
}