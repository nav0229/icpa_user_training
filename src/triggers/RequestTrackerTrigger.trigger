/*
    RequestTrackerTrigger.trigger
    This trigger will provide the record sharing to assignee for CS work request and Blog request record types
    It will also provide the record sharing to requester supervisor for Blog requests.
    For CS Work Request: 
     create & update - It will share the record with the assignee
    For Blog request:
     create/insert - it will share the record with the requestor supervisor, it will share the record with original owner
     after update - it will share the record with the assignee and requestor supervisor
     before update - it will change the record owner to queue 'request tracker blog'
    -------------------------------------------------------------------
    Author            Date        Version  Description
    -------------------------------------------------------------------
    Rajakumar/Naseem  05/01/2012  1.0      Creation.
    Rajakumar/Naseem  05/17/2012  1.1      Updated to share a record with Requestor Supervisor and Owner. 
                                           Change the owner to blog queue 
    Srinivas          01/30/2013  1.2      Update to create records on Record type Complaint Tracker for users exits in public gruop Request_Tracker_Complaint_Tracker_User                                           
    Rajakumar         01/23/2015  1.3      Commented the code for Communication Job Log and Blog Request
*/
trigger RequestTrackerTrigger on Request_Tracker__c (before update, 
 // after insert, after update, 
                                                     before insert)
{
    /*
    if (Trigger.isInsert)
    {
       RequestTrackerHelper.onAfterInsert(Trigger.new);
    }
    */
    if(Trigger.isBefore && Trigger.isUpdate)
    {
       RequestTrackerHelper.onBeforeUpdate(Trigger.new,Trigger.oldMap);
    }   
    /*
    if (Trigger.isAfter && Trigger.isUpdate)
    { 
       RequestTrackerHelper.onAfterUpdate(Trigger.new,Trigger.oldMap);
    }
    */
    if (Trigger.isBefore && Trigger.isInsert){
        RequestTrackerHelper.onBeforeInsert(Trigger.new);
    }
}