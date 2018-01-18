/*-------------------------------------------------------------------------------------------------*
  Apex trigger - Communications__c custom object
  IMT Communications trigger to create/update the event on the public calendar.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/12/2013    1.0       Initial version.
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
trigger IMTCommunicationsTrigger on Communications__c (after insert, after update) {
    
    // insert a new record
    if(Trigger.isAfter && Trigger.isInsert) {
        IMTCommunicationsHelper.onAfterInsert(Trigger.New);
    }
    
    //update the record
    if(Trigger.isAfter && Trigger.isUpdate) {
        IMTCommunicationsHelper.onAfterUpdate(Trigger.New, Trigger.oldMap, Trigger.newMap);
    }    
}