/*-------------------------------------------------------------------------------------------------*
  Apex trigger
  Task Trigger for reminder emails functionality
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/06/2013    1.0       Created - O&M Case # 00009464
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
trigger TaskTrigger on Task (before insert, before update) {
    
    if(Trigger.isBefore && Trigger.isInsert) {
        //insert validations
        TaskHelper.onBeforeInsert(Trigger.new);
    }           
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        //update validations and set the DMLOptions for email notifications 
        TaskHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
    }
    
}