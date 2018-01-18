/*
  RequestTrackerHelper.cls
  This Helper class is executed when a request tracker object is created/updated. 
  For CS Work Request: 
     create & update - It will share the record with the assignee
  For Blog request:
     create - it will share the record with the requestor supervisor, share the record with the original owner
     after update - it will share the record with the assignee and requestor supervisor
     before update - it will change the record owner to blog queue 'request tracker blog'
  
  -------------------------------------------------------------------
  Author            Date        Version  Description
  -------------------------------------------------------------------
  Rajakumar/Naseem  05/01/2012  1.0      Created.
  Rajakumar/Naseem  05/17/2012  1.1      Updated to share a record with Requestor Supervisor and Owner. 
                                         Change the owner to blog queue
  Srinivas          01/30/2013  1.2      Update to create records on Record type Complaint Tracker for users exits in public gruop Request_Tracker_Complaint_Tracker_User                                         
  Rajakumar         01/23/2015  1.3      Commented the code for Communication Job Log and Blog Request
*/
public class RequestTrackerHelper
{
   //////////// BEGIN !!!!! Only users exists in Request_Tracker_Complaint_Tracker_User group can create Records on Record type Complaint Tracker ///////////
   public static void onBeforeInsert(List<Request_Tracker__c> triggerNew){
           RecordType compRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE Name = 'Complaint Tracker' AND SObjectType = 'Request_Tracker__c' LIMIT 1];
           Group CTpublicGroupId = [Select Id from Group Where DeveloperName = 'Request_Tracker_Complaint_Tracker_User' LIMIT 1];       
           Set<String> lstUsers = new Set<String>();           
           for(GroupMember CTuserlist :[Select GroupId, UserorGroupId from GroupMember Where GroupId = :CTpublicGroupId.Id]){
              lstUsers.add(CTuserlist.UserorGroupId);
           }           
           
           for(Request_Tracker__c req:triggerNew){
             if(req.RecordTypeId == compRecordType.Id && !(lstUsers.contains(req.OwnerId))){
                req.addError('You are not authorized to create  Complaint Tracker record using this application, but  you can send email to complaints@gsa.gov to submit a complaint');
             }
           }
   }
  
  //////////// END !!!!!/////////
  // method will be invoked for changing the record owner (to blog queue) before updating the record
  public static void onBeforeUpdate(List<Request_Tracker__c> triggerNew, Map<Id, Request_Tracker__c> triggerOldMap)
  {
    /*
    Id blogrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Blog_Request' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
    */
    Id EPRrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'EvidencePreservationRequests' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
    Id EPRpublicGroupId = [Select Id from Group Where DeveloperName = 'Request_Tracker_EPR_ServerServices'].Id;
    List<GroupMember> userlist = [Select GroupId, UserorGroupId from GroupMember Where GroupId = :EPRpublicGroupId AND
                                  UserOrGroupId = :UserInfo.getUserId()];
    
    //RecordType user_type = [Select Name from RecordType where SObjectType='Contact' AND Id='01230000001Ir70' LIMIT 1];
    /*
    String queueName='Request Tracker Blog';

    Id reqId = [SELECT Id FROM Group WHERE Type='Queue' AND Name=:queueName].Id;
    */
    for(Request_Tracker__c RTrecord:triggerNew)
    { 
      // if the record type is CS Work Request and assignee field is not null
      /*
      if(RTrecord.RecordTypeId == blogrecTypeId && RTrecord.Status__c == 'Pending Final Review')
      {
        RTrecord.OwnerId = reqId;
      }
      */
      //if(RTrecord.RecordTypeId == EPRrecTypeId) {
      //    RTrecord.User_Type_Text__c = String.valueOf(user_type.Name);
      //}    
      //for validating the EPR group and recordtype
      if(!userlist.isEmpty() && RTrecord.RecordTypeId == EPRrecTypeId) {
         Request_Tracker__c oldrecord = triggerOldMap.get(RTrecord.Id);
         if(RTrecord.Requestor_ID__c != oldrecord.Requestor_ID__c || 
            RTrecord.Requestor__c != oldrecord.Requestor__c ||
            RTrecord.Legacy_Requestor__c != oldrecord.Legacy_Requestor__c || 
            RTrecord.Requestor_Original_Date__c != oldrecord.Requestor_Original_Date__c||
            RTrecord.OCIO_CSWR_JobType__c != oldrecord.OCIO_CSWR_JobType__c || 
            RTrecord.Status__c != oldrecord.Status__c||
            RTrecord.FOIA__c != oldrecord.FOIA__c || 
            RTrecord.Non_GSA__c != oldrecord.Non_GSA__c||
            RTrecord.Username__c != oldrecord.Username__c || 
            RTrecord.Legacy_Username__c != oldrecord.Legacy_Username__c||
            RTrecord.First_Name__c != oldrecord.First_Name__c || 
            RTrecord.Last_Name__c != oldrecord.Last_Name__c||
            RTrecord.Journaling_Started_Date__c != oldrecord.Journaling_Started_Date__c || 
            RTrecord.Assignee__c != oldrecord.Assignee__c||
            RTrecord.Date_Assigned__c != oldrecord.Date_Assigned__c || 
            RTrecord.Legacy_Assignee__c != oldrecord.Legacy_Assignee__c||
            RTrecord.Copy_Status__c != oldrecord.Copy_Status__c || 
            RTrecord.Additional_Comments__c != oldrecord.Additional_Comments__c||
            RTrecord.Litigation_Status__c != oldrecord.Litigation_Status__c || 
            RTrecord.Date_Litigation_Lifted__c != oldrecord.Date_Litigation_Lifted__c||
            RTrecord.Date_Release_to_Court__c != oldrecord.Date_Release_to_Court__c || 
            RTrecord.OCIO_CSWR_EstHors__c != oldrecord.OCIO_CSWR_EstHors__c||
            RTrecord.Date_Completed__c != oldrecord.Date_Completed__c || 
            RTrecord.Number_of_CD_s__c != oldrecord.Number_of_CD_s__c||
            RTrecord.Number_of_DVD_s__c != oldrecord.Number_of_DVD_s__c || 
            RTrecord.Number_of_Flash_Drive_s__c != oldrecord.Number_of_Flash_Drive_s__c){
                  RTrecord.addError('You are only allow to update the Date Archive Completed and Data Location/Path');
         }         
      }   
    }
  }   
  
  // this method is only created for the test coverage purpose, the system admin running user to be 
  // added to the respective group for code coverage
  @future
  public static void createGroupMembers(Set<Id> groupIds) {
    List<GroupMember> newGroupMembers = new List<GroupMember>();
    for (Id grpId : groupIds) {
        newGroupMembers.add(new GroupMember(GroupId=grpId, UserOrGroupId=UserInfo.getUserId()));
    }
    if (Test.isRunningTest()) {
     // start new context via system.runAs() for the same user for test code only
      System.runAs(new User(Id = Userinfo.getUserId())) {
        insert newGroupMembers;
      }
    } else {
      // in non-test code insert normally
      insert newGroupMembers;
    }
  }   
     
     /*                  
  // method will be invoked when user insert a new request tracker record
  public static void onAfterInsert(List<Request_Tracker__c> triggerNew)
  { 
    Id cswrkrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CS_Work_Request' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
    Id blogrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Blog_Request' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
    
    // Create a new list of sharing objects for Request Tracker
    List<Request_Tracker__Share> rtShrs = new List<Request_Tracker__Share>();
    // Create a new list of records for followers
    List<EntitySubscription> entSubs = new List<EntitySubscription>();

    // Declare variables for assignee sharing 
    Request_Tracker__Share assigneeShr, supervisorShr,requesterShr;
    // Declare variables for record's followers
    EntitySubscription follow;
    
    for(Request_Tracker__c RTrecord:triggerNew)
    { 
      // if the record type is CS Work Request and assignee field is not null
      if(RTrecord.RecordTypeId == cswrkrecTypeId && RTrecord.Assignee__c!=NULL)
      { 
        //Adding user to record's followers.
           follow=new EntitySubscription(parentId = RTrecord.Id,subscriberId = RTrecord.Assignee__c);
           entSubs.add(follow);
        // Instantiate the sharing objects
           assigneeShr = new Request_Tracker__Share();
        // Set the ID of record being shared
           assigneeShr.ParentID = RTrecord.Id;
        // Set the ID of user or group being granted access.
           assigneeShr.UserOrGroupId = RTrecord.Assignee__c;
        // Set the access level
           assigneeShr.AccessLevel='Edit';
        // Set the Apex sharing reason for assignee
           assigneeShr.RowCause=Schema.Request_Tracker__Share.RowCause.Share_with_Assignee__c;
        // Add objects to list for insert
           rtShrs.add(assigneeShr);
      }
      // if the record type is Blog Request and requester supervisor field is not null
      if(RTrecord.RecordTypeId == blogrecTypeId && RTrecord.OCIO_Blog_RequesterSupervisor__c != NULL)
      {
        //Adding user to record's followers.
        follow=new EntitySubscription(parentId = RTrecord.Id,subscriberId = RTrecord.OCIO_Blog_RequesterSupervisor__c);
        entSubs.add(follow);
        // logic for supervisor sharing in blog request
        supervisorShr = new Request_Tracker__Share();
        supervisorShr.ParentID = RTrecord.Id;
        supervisorShr.UserOrGroupId = RTrecord.OCIO_Blog_RequesterSupervisor__c;
        supervisorShr.AccessLevel='Edit';
        supervisorShr.RowCause=Schema.Request_Tracker__Share.RowCause.Share_with_Requester_Supervisor__c;
        rtShrs.add(supervisorShr);
      }
      // if the record type is Blog Request and requester (or initial owner) field is not null
      if(RTrecord.RecordTypeId == blogrecTypeId && RTrecord.OwnerId != NULL)
      {
        // logic for requester sharing in blog request
        requesterShr = new Request_Tracker__Share();
        requesterShr.ParentID = RTrecord.Id;
        requesterShr.UserOrGroupId = RTrecord.OwnerId;
        requesterShr.AccessLevel='Edit';
        requesterShr.RowCause=Schema.Request_Tracker__Share.RowCause.Share_with_Original_Owner__c;
        rtShrs.add(requesterShr);
      }
    }
    // Insert sharing records 
    try
    {
      if(!rtShrs.isEmpty())
      {
        insert rtShrs;
        System.debug('inserted');
      }    
      if(!entSubs.isEmpty())
      {
        insert entSubs;
        System.debug('chatter follower completed');
      } 
    }
    catch(Exception e)
    {
      System.debug(LoggingLevel.INFO,'error while sharing/inserting record with assignee\n'+e.getMessage());
    }
  }
  
  // method will be invoked when user update the existing request tracker record with different assignee.
  public static void onAfterUpdate(List<Request_Tracker__c> triggerNew, Map<Id, Request_Tracker__c> triggerOldMap)
  {
    Id cswrkrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CS_Work_Request' 
                          AND SObjectType = 'Request_Tracker__c'].Id;
    Id blogrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Blog_Request' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
    // Create a new list of sharing objects for Request Tracker
    List<Request_Tracker__Share> rtShrs = new List<Request_Tracker__Share>();
    // Create a new list of records for followers
    List<EntitySubscription> entSubs = new List<EntitySubscription>();

    // Declare variables for assignee sharing 
    Request_Tracker__Share assigneeShr,supervisorShr;
    // Declare variables for record's followers
    EntitySubscription follow;
    // List for deleting the existing assignees
    List<Id> oldIds = new List<Id>();
    // List for deleting the existing supervisors
    List<Id> oldsuperIds = new List<Id>();
    for(Request_Tracker__c RTrecord:triggerNew)
    { 
      //if the record type is CS Work Request or Blog Request and assignee is changed
      if((RTrecord.RecordTypeId == cswrkrecTypeId || RTrecord.RecordTypeId == blogrecTypeId) && RTrecord.Assignee__c != NULL)
      {
        //if the record assignee was changed or removed.
        if(RTrecord.Assignee__c!=triggerOldMap.get(RTrecord.Id).Assignee__c)
        {
          if(triggerOldMap.get(RTrecord.Id).Assignee__c!=NULL)
          {
            oldIds.add(RTrecord.Id);
            System.debug('>>>Found something');
          }
        }  
        //Adding user to record's followers.
        follow=new EntitySubscription(parentId = RTrecord.Id,subscriberId = RTrecord.Assignee__c);
        entSubs.add(follow);
        assigneeShr = new Request_Tracker__Share();
        assigneeShr.ParentID = RTrecord.Id;
        assigneeShr.UserOrGroupId = RTrecord.Assignee__c;
        assigneeShr.AccessLevel='Edit';
        assigneeShr.RowCause=Schema.Request_Tracker__Share.RowCause.Share_with_Assignee__c;
        rtShrs.add(assigneeShr);
      }
      // if the recordtype is blog request and requestor supervisor field is changed/updated.
      if(RTrecord.RecordTypeId == blogrecTypeId && RTrecord.OCIO_Blog_RequesterSupervisor__c != NULL)
      {
        if(RTrecord.OCIO_Blog_RequesterSupervisor__c != triggerOldMap.get(RTrecord.Id).OCIO_Blog_RequesterSupervisor__c)
        {
          if(triggerOldMap.get(RTrecord.Id).OCIO_Blog_RequesterSupervisor__c!=NULL)
          {
            oldsuperIds.add(RTrecord.Id);
            System.debug('>>>Found something');
          }
        }
          //Adding user to record's followers.
          follow=new EntitySubscription(parentId = RTrecord.Id,subscriberId = RTrecord.OCIO_Blog_RequesterSupervisor__c);
          entSubs.add(follow);
          // logic for supervisor sharing in blog request
          supervisorShr = new Request_Tracker__Share();
          supervisorShr.ParentID = RTrecord.Id;
          supervisorShr.UserOrGroupId = RTrecord.OCIO_Blog_RequesterSupervisor__c;
          supervisorShr.AccessLevel='Edit';
          supervisorShr.RowCause=Schema.Request_Tracker__Share.RowCause.Share_with_Requester_Supervisor__c;
          rtShrs.add(supervisorShr);
     }      
    }
    
      
    // Delete the existing sharing records and Insert new sharing records (with updated assignee/requester supervisor)
    try
    {
      if(!oldIds.isEmpty())
      {
         List<Request_Tracker__Share> oldRTShrs = [SELECT Id FROM Request_Tracker__Share 
            WHERE RowCause = 'Share_with_Assignee__c' AND ParentId IN :oldIds]; 
         System.debug('old assignee RT shares:' +oldRTShrs);
         if(!oldRTShrs.isEmpty())
           delete oldRTShrs;
      }
      if(!oldsuperIds.isEmpty())
      {
         List<Request_Tracker__Share> oldsuperRTShrs = [SELECT Id FROM Request_Tracker__Share 
            WHERE RowCause = 'Share_with_Requester_Supervisor__c' AND ParentId IN :oldsuperIds]; 
         System.debug('old supervisor RT shares:' +oldsuperRTShrs);
         if(!oldsuperRTShrs.isEmpty())
           delete oldsuperRTShrs;
      }
      if(!rtShrs.isEmpty())
        insert rtShrs;
      if(!entSubs.isEmpty())
        insert entSubs;
    }
    catch(DmlException e)
    {
      System.debug(LoggingLevel.INFO,'error while sharing/updating record with assignee\n'+e.getMessage());
    }  
  }
  */
}