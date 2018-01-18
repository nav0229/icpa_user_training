/*-------------------------------------------------------------------------------------------------*
  Apex class 
  Creates an event on IMT Calendar for Leasing record
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/30/2013    1.0       Initial version.
  Rajakumar          06/25/2014    1.1       Remove the validation error when the user is in CO and Regional user groups
  Rajakumar          09/09/2015    1.2       O&M Case# 20041 - remove the required field conditions
  Rajakumar          04/19/2016    1.3       Update the prospectus validation and owner changes validation- case# 24343
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
public class IMTLeasingHelper {
    
    public static void onAfterInsert(List<Leasing__c> triggerNew) {
         
         List<EventUtil.EventFieldDefinition> eventFields = new list<EventUtil.EventFieldDefinition> {
         new EventUtil.EventFieldDefinition('Proposed_Lease_Award_Date__c', 'Proposed_Lease_Award_Date__c', 'Lease Award'), 
         new EventUtil.EventFieldDefinition('Anticipated_Solicitation_Notification_Re__c', 'Anticipated_Solicitation_Notification_Re__c', 'Lease Solicitation')
         };
         List<EventUtil.EventFieldDefinition> eventFieldLease = new list<EventUtil.EventFieldDefinition> {
         new EventUtil.EventFieldDefinition('Proposed_Lease_Award_Date__c', 'Proposed_Lease_Award_Date__c', 'Lease Award') 
         };
         List<EventUtil.EventFieldDefinition> eventFieldSolicit = new list<EventUtil.EventFieldDefinition> {
         new EventUtil.EventFieldDefinition('Anticipated_Solicitation_Notification_Re__c', 'Anticipated_Solicitation_Notification_Re__c', 'Lease Solicitation') 
         };
         
         List<Leasing__c> newrecords = new List<Leasing__c>();
         List<Leasing__c> newLeaseRecords = new List<Leasing__c>();
         List<Leasing__c> newSolicitRecords = new List<Leasing__c>();
         for(Leasing__c lease: triggerNew) {
             if(lease.Proposed_Lease_Award_Date__c != null && lease.Anticipated_Solicitation_Notification_Re__c != null) {
                 newrecords.add(lease);
             } else if (lease.Proposed_Lease_Award_Date__c != null && lease.Anticipated_Solicitation_Notification_Re__c == null) {
                 newLeaseRecords.add(lease);
             } else if (lease.Proposed_Lease_Award_Date__c == null && lease.Anticipated_Solicitation_Notification_Re__c != null) {
                 newSolicitRecords.add(lease);
             } else {
                 //nothing
             }
         }
         
         if(!newrecords.isEmpty()) {
             EventUtil.onAfterInsert(newrecords, eventFields, 'IMTCalendar', null);
         }
         if(!newLeaseRecords.isEmpty()) {
             EventUtil.onAfterInsert(newLeaseRecords, eventFieldLease, 'IMTCalendar', null);
         }
         if(!newSolicitRecords.isEmpty()) {
             EventUtil.onAfterInsert(newSolicitRecords, eventFieldSolicit, 'IMTCalendar', null);
         }               
    }
    
    public static void onAfterUpdate(List<Leasing__c> triggerNew, Map<Id, Leasing__c> triggerOldMap, Map<Id, Leasing__c> triggerNewMap) {
         
         // declarations
         PublicCalendarList__c imtCal;
         String imtCalId;
         Set<Id> updatedRecordIds = new Set<Id>();
         Set<Id> leaseUpdateRecordIds = new Set<Id>();
         Set<Id> solicitUpdateRecordIds = new Set<Id>();
         Set<Id> delshrRecordIds = new Set<Id>();
         Set<Id> leasedelShrRecordIds = new Set<Id>();
         Set<Id> solicitdelShrRecordIds = new Set<Id>();
         List<Event> leaseorSolicitNewRecords = new List<Event>();
         List<Event> solicitdelShrEventLst = new List<Event>();
         List<Event> leasedelShrEventLst = new List<Event>();
         List<Event> leaseUpdateShrEventLst = new List<Event>();
         List<Event> solicitUpdateShrEventLst = new List<Event>();
         
         // some prepopulated configuration data for parameters
         List<EventUtil.EventFieldDefinition> eventFields = new list<EventUtil.EventFieldDefinition> {
         new EventUtil.EventFieldDefinition('Proposed_Lease_Award_Date__c', 'Proposed_Lease_Award_Date__c', 'Lease Award'), 
         new EventUtil.EventFieldDefinition('Anticipated_Solicitation_Notification_Re__c', 'Anticipated_Solicitation_Notification_Re__c', 'Lease Solicitation')
         };
         //access the public calendar by the custom settings..
         imtCal = PublicCalendarList__c.getValues('IMTCalendar');
         imtCalId = imtCal.CalendarID__c; 
         
         //Set<Id> solicitNewRecordIds = new Set<Id>();
         for(Leasing__c req: triggerNew) {
             // when both date fields are not null, both of them are changed from dateA to dateB
             Boolean matchfound = false;
             if((req.Proposed_Lease_Award_Date__c != null && 
                 triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c != null &&
                 req.Proposed_Lease_Award_Date__c != triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c && 
                 req.Anticipated_Solicitation_Notification_Re__c != null &&
                 triggerOldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c != null &&
                 req.Anticipated_Solicitation_Notification_Re__c != triggerOldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c) ) {
                 updatedRecordIds.add(req.Id); 
                 matchfound = true;                
             }
             // when both date fields are not null and both are changed from DateA to null
             else if(req.Proposed_Lease_Award_Date__c == null && 
                 req.Proposed_Lease_Award_Date__c != triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c &&
                 req.Anticipated_Solicitation_Notification_Re__c == null && 
                 req.Anticipated_Solicitation_Notification_Re__c != triggerOldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c) {
                 delshrRecordIds.add(req.Id);
                 matchfound = true;
             }
             else {
             }
             // when the lease date is null, changed from null to date
             if( matchfound == false && (req.Proposed_Lease_Award_Date__c != null && 
                 triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c == null)) {
                 leaseorSolicitNewRecords.add(new Event(WhatId = req.Id, OwnerId = imtCalId, Subject = 'Lease Award',
                         StartDateTime = Datetime.newInstance((Date)req.Proposed_Lease_Award_Date__c,Time.newInstance(0, 0, 0, 0)),
                         EndDateTime = Datetime.newInstance((Date)req.Proposed_Lease_Award_Date__c,Time.newInstance(23, 59, 59, 0)) ));
             }    
             // when the lease date is not null, changed from dateA to dateB
             else if(matchfound == false && (req.Proposed_Lease_Award_Date__c != null 
                     && triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c != null &&
                     triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c != req.Proposed_Lease_Award_Date__c)) {
                 leaseUpdateRecordIds.add(req.Id);
             }    
             // when the lease date is not null, changed from dateA to null
             else if(matchfound == false && (req.Proposed_Lease_Award_Date__c == null 
                     && triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c != null &&
                     triggeroldMap.get(req.Id).Proposed_Lease_Award_Date__c != req.Proposed_Lease_Award_Date__c)) {
                 leasedelShrRecordIds.add(req.Id);
             }
             else {
                 // nothing
             }
             
             // when the solicit date is null, changed from null to date
             if(matchfound == false && (req.Anticipated_Solicitation_Notification_Re__c != null && 
                 triggeroldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c == null)) {
                 leaseorSolicitNewRecords.add(new Event(WhatId = req.Id, OwnerId = imtCalId, Subject = 'Lease Solicitation',
                         StartDateTime = Datetime.newInstance((Date)req.Anticipated_Solicitation_Notification_Re__c,Time.newInstance(0, 0, 0, 0)),
                         EndDateTime = Datetime.newInstance((Date)req.Anticipated_Solicitation_Notification_Re__c,Time.newInstance(23, 59, 59, 0)) ));
             }    
             // when the solicit date is not null, changed from dateA to dateB
             else if(matchfound == false && (req.Anticipated_Solicitation_Notification_Re__c != null && 
                 triggeroldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c != null &&
                 triggeroldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c != req.Anticipated_Solicitation_Notification_Re__c)) {
                 solicitUpdateRecordIds.add(req.Id);
             }    
             // when the solicit date is not null, changed from dateA to null
             else if(matchfound == false && (req.Anticipated_Solicitation_Notification_Re__c == null && 
                 triggeroldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c != null &&
                 triggeroldMap.get(req.Id).Anticipated_Solicitation_Notification_Re__c != req.Anticipated_Solicitation_Notification_Re__c)) {
                 solicitdelShrRecordIds.add(req.Id);
             }
             else {
                 // nothing
             }
             
         }
         // insert the new event records for the respective leasing records
         if(!leaseorSolicitNewRecords.isEmpty()) {
             try {
                 insert leaseorSolicitNewRecords;
             }
             catch(DMLException e) {
                 System.debug(LoggingLevel.INFO,'Error in Inserting the IMT Leasing Calendar Event records :' +e.getMessage());    
             }
         }
         // for fetching the list of eligible event records for deletion        
         if(!solicitdelShrRecordIds.isEmpty()) {
             solicitdelShrEventLst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime 
                     FROM Event WHERE WhatId IN :solicitdelShrRecordIds AND Subject = 'Lease Solicitation' AND OwnerId = :imtCalId];                          
         }
         if(!leasedelShrRecordIds.isEmpty()) {
             leasedelShrEventLst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime 
                     FROM Event WHERE WhatId IN :leasedelShrRecordIds AND Subject = 'Lease Award' AND OwnerId = :imtCalId];
         }
         // for fetching the list of event records for update operation
         if(!leaseUpdateRecordIds.isEmpty()) {
             leaseUpdateShrEventLst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime 
                     FROM Event WHERE WhatId IN :leaseUpdateRecordIds AND Subject = 'Lease Award' AND OwnerId = :imtCalId];    
         }
         if(!leaseUpdateShrEventLst.isEmpty()) {
             for(Event evt: leaseUpdateShrEventLst) {
                 evt.StartDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get('Proposed_Lease_Award_Date__c'),Time.newInstance(0, 0, 0, 0));
                 evt.EndDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get('Proposed_Lease_Award_Date__c'),Time.newInstance(23, 59, 59, 0));
             }
         }
         if(!solicitUpdateRecordIds.isEmpty()) {
             solicitUpdateShrEventLst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime 
                     FROM Event WHERE WhatId IN :solicitUpdateRecordIds AND Subject = 'Lease Solicitation' AND OwnerId = :imtCalId];    
         }
         if(!solicitUpdateShrEventLst.isEmpty()) {
             for(Event evt: solicitUpdateShrEventLst) {
                 evt.StartDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get('Anticipated_Solicitation_Notification_Re__c'),Time.newInstance(0, 0, 0, 0));
                 evt.EndDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get('Anticipated_Solicitation_Notification_Re__c'),Time.newInstance(23, 59, 59, 0));
             }
         }
         // merge the 2 extracted/manipulated lists into one list and perform one DML operation
         if(!solicitUpdateShrEventLst.isEmpty() || !leaseUpdateShrEventLst.isEmpty()) {
             leaseUpdateShrEventLst.addAll(solicitUpdateShrEventLst);
             try {
                 update leaseUpdateShrEventLst;
             }
             catch(DMLException e) {
                 System.debug(LoggingLevel.INFO,'Error in update the IMT Leasing Calendar Event records :' +e.getMessage());    
             }    
         }
         // delete them together in one DML operation
         if(!leasedelShrEventLst.isEmpty() || !solicitdelShrEventLst.isEmpty()) {
             // merge all extracted event records into one list
             leasedelShrEventLst.addAll(solicitdelShrEventLst);
             try {
                 delete leasedelShrEventLst;
             }
             catch(DMLException e) {
                 System.debug(LoggingLevel.INFO,'Error in deleting the IMT Leasing Calendar Event records :' +e.getMessage());    
             }
         }
         
         // for the existing behavior of leasing   
         if(!updatedRecordIds.isEmpty() || !delshrRecordIds.isEmpty())
            EventUtil.onAfterUpdate(triggerNew, updatedRecordIds, triggerNewMap, delshrRecordIds, eventFields, 'IMTCalendar', ' ');
    }
    
    public static void onBeforeUpdate(List<Leasing__c> triggerNew, Map<Id, Leasing__c> triggerOldMap) {
        /* commented for case# 24343
        Id usrGrpId; 
        List<GroupMember> usrlist = new List<GroupMember>();
        usrGrpId = [Select Id from Group Where DeveloperName = 'IMT_Leasing_Regional_Users'].Id;
        usrlist = [Select GroupId, UserorGroupId from GroupMember Where GroupId = :usrGrpId AND
                                  UserOrGroupId = :UserInfo.getUserId()];
        // O&M Case # 13672
        Id coUsrGrpId;
        List<GroupMember> coUsrList = new List<GroupMember>();
        coUsrGrpId = [Select Id from Group Where DeveloperName = 'IMT_Leasing_CO_Users'].Id;
        coUsrList = [Select GroupId, UserorGroupId from GroupMember Where GroupId = :coUsrGrpId AND
                                  UserOrGroupId = :UserInfo.getUserId()];
        //
        */
        Id coSuperUsrGrpId, coEditorGrpId;
        List<GroupMember> coSuperUsrList = new List<GroupMember>();
        List<GroupMember> coEditorList = new List<GroupMember>();
        List<User> admuser = new List<User>();
        admuser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() AND Profile.Name = 'GSA System Administrator'];
        coEditorGrpId = [SELECT Id FROM Group WHERE DeveloperName = 'IMT_Leasing_CO_Editors'].Id;
        coSuperUsrGrpId = [SELECT Id FROM Group WHERE DeveloperName = 'IMT_Leasing_CO_Superusers'].Id;
        coSuperUsrList = [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId = :coSuperUsrGrpId AND
                                  UserOrGroupId = :UserInfo.getUserId()];
        coEditorList = [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId = :coEditorGrpId AND
                                  UserOrGroupId = :UserInfo.getUserId()];        
        for(Leasing__c req: triggerNew) {
            // if the running user is not system admin user
            if(admUser.isEmpty()) {
                // if the prospectus number is changed and the running user is not in 'CO Editor group' or 'CO Superuser group'.
                if((req.Prospectus_Number__c != triggerOldMap.get(req.Id).Prospectus_Number__c) && 
                    coSuperUsrList.isEmpty() && coEditorList.isEmpty() ) {
                    //&& (coUsrList.isEmpty()))  // O&M Case # 13672
                    req.addError('You do not have permissions to update the Prospectus Number field as a Leasing Regional User');   
                }
                // if the ownerid is changes and the running user is not in 'CO Superuser group'
                if((req.OwnerId != triggerOldMap.get(req.Id).OwnerId) && coSuperUsrList.isEmpty()) {
                    req.addError('You do not have permissions to change the Owner field');
                }
            }
        }        
    }
    
    
}