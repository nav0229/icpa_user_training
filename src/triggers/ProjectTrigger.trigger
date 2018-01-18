/*-------------------------------------------------------------------------------------------------*
  Apex trigger for GPM_Project__c object 
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          02/17/2015    1.0       Initial version.
  Rajakumar          03/18/2015    1.1       Commented code- remove the executive summary section
 *-------------------------------------------------------------------------------------------------*
 
 *-------------------------------------------------------------------------------------------------*/
trigger ProjectTrigger on GPM_Project__c (
                                        //1.1 - before insert, before update, 
                                            after update) {
    /* 1.1 commented - begin
    if(Trigger.isInsert && Trigger.isBefore) {
        ProjectHelper.onBeforeInsert(Trigger.new);
    }
    //
    if(Trigger.isUpdate && Trigger.isBefore) {
        ProjectHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
     1.1 commented - end */
    //
    if(Trigger.isUpdate && Trigger.isAfter) {
        ProjectHelper.onAfterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
    }
}