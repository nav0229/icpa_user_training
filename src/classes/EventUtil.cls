/*------------------------------------------------------------------------------------------------
  EventUtil for creating the event records on the Shared calendar for respective object records
  
  ------------------------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  ------------------------------------------------------------------------------------------------
  Rajakumar              08/12/2013  1.0       Initial version
  ------------------------------------------------------------------------------------------------
  
  ------------------------------------------------------------------------------------------------*/
public class EventUtil {
    
    // class for date and subject fields to drive the event record
    public class EventFieldDefinition {
        public String startDtField {get;set;}
        public String endDtField {get;set;}
        public String eventSubject {get;set;}
         
        public eventfieldDefinition (String startDtField, String endDtField, String eventSubject) {
            this.startDtField = startDtField;
            this.endDtField = endDtField;
            this.eventSubject = eventSubject;
        }
    }
    
    // Insert the new record
    public static void onAfterInsert(List<sObject> records, List<EventFieldDefinition> eventFields, String calendarName, String subjectAppendField) {
         
         // records --> list of new records -- Trigger.New or Custom List based on the selection criteria 
         // eventFields --> Wrapper class {'Start_Date__c','End_Date__c','Sample Comms Event'}
         // calendarName --> Name of the Calendar as per the record entry in Custom Settings i.e.PublicCalendarList__c        
         // subjectAppendField --> dynamic subject for each event 
         //             Ex...Communications-Region1 i.e. Communications (i.e. object name) and Region1 (i.e.Region__SSO__c field value)
         
         List<Event> shrEventLst = new List<Event>();
         Map<String,String> keyPrefixMap = new Map<String,String>();
         
         String objectTypeKey, objectTypeName, imtCalId;
         PublicCalendarList__c imtCal;
         
         Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
         for(String sObj : gd.keySet()){
             Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
             keyPrefixMap.put(r.getKeyPrefix(), r.getName());
         }
         objectTypeKey = records[0].Id;
         objectTypeName = keyPrefixMap.get(objectTypeKey.subString(0,3));
         Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectTypeName.toLowerCase()).getDescribe().Fields.getMap();      
         Set<String> selectedFields = new Set<String>();
         for(EventFieldDefinition e: eventFields) {
             selectedFields.add(e.startDtField);
             selectedFields.add(e.endDtField);
         }
         if(!String.isBlank(subjectAppendField))
             selectedFields.add(subjectAppendField);
         
         Boolean fieldsFound = true;
         for(String s: selectedFields) {
             if(fieldMap.get(s)==null)
                 fieldsFound = false;
         }        
             
         //access the public calendar by the custom settings..
         imtCal = PublicCalendarList__c.getValues(calendarName);
         imtCalId = imtCal.CalendarID__c;
         if(fieldsFound) {
         for(sObject req: records) {
             for(EventFieldDefinition e: eventFields) {
                 Event newEvent = new Event();
                 if(!String.isBlank(subjectAppendField)) 
                     //newEvent.Subject = objectTypeName.removeEnd('__c') + '-' + req.get(subjectAppendField);
                     newEvent.Subject = e.eventSubject + '-' + req.get(subjectAppendField);
                 else
                     newEvent.Subject = e.eventSubject;
                 newEvent.WhatId= req.Id;
                 newEvent.OwnerId = imtCalId;
                 newEvent.StartDateTime = Datetime.newInstance((Date)req.get(e.startDtField),Time.newInstance(0, 0, 0, 0));
                 newEvent.EndDateTime = Datetime.newInstance((Date)req.get(e.endDtField),Time.newInstance(23, 59, 59, 0));
                 shrEventLst.add(newEvent);
              }   
         }
         }
         else
             records[0].addError('Please check the field names in EventFieldDefinitions of the Apex Trigger/Helper class');
         try {
             if(!shrEventLst.isEmpty()) {
                 insert shrEventLst;
             }
         }
         catch(Exception e) {
             System.debug(LoggingLevel.INFO,'Error while inserting a new shared event for the record \n'+e.getMessage());
         }
    }
    
    // Update the existing record
    public static void onAfterUpdate(List<sObject> allNewRecords, Set<Id> updatedRecordIds, Map<Id,sObject> triggerNewMap, Set<Id> delShrRecordIds, 
                            List<EventFieldDefinition> eventFields, String calendarName, String subjectAppendField) {
         // records - Trigger.New
         // updatedRecordIds --> list of updated record Ids i.e. Trigger.New or Custom List based on the selection criteria 
         // triggerNewMap --> map of new record values i.e. Trigger.newMap
         // delShrRecordIds --> list of object record ids which are no longer require the event records
         // eventFields --> Wrapper class {'Start_Date__c','End_Date__c','Sample Event-Award'}
         // calendarName --> Name of the Calendar as per the record entry in Custom Settings i.e.PublicCalendarList__c        
         // subjectAppendField --> dynamic subject for each event 
         //             Ex...Communications-Region1 i.e. Communications (i.e. object name) and Region1 (i.e.Region__SSO__c field value)
                  
         List<Event> delShrEventLst = new List<Event>();
         List<Event> oldShrEventLst = new List<Event>();
         List<Event> newShrEventLst = new List<Event>();
         Map<String,String> keyPrefixMap = new Map<String,String>();
         Map<Id, Id> resultmap = new Map<Id, Id>();
         
         String objectTypeKey, objectTypeName, imtCalId;
         PublicCalendarList__c imtCal;
         
         Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
         for(String sObj : gd.keySet()){
             Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
             keyPrefixMap.put(r.getKeyPrefix(), r.getName());
         }
         objectTypeKey = allNewRecords[0].Id;
         objectTypeName = keyPrefixMap.get(objectTypeKey.subString(0,3));
         Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectTypeName.toLowerCase()).getDescribe().Fields.getMap();      
         Set<String> selectedFields = new Set<String>();
         for(EventFieldDefinition e: eventFields) {
             selectedFields.add(e.startDtField);
             selectedFields.add(e.endDtField);
         }
         if(!String.isBlank(subjectAppendField))
             selectedFields.add(subjectAppendField);
         
         Boolean fieldsFound = true;
         for(String s: selectedFields) {
             if(fieldMap.get(s)==null)
                 fieldsFound = false;
         }
                 
         //access the public calendar by the custom settings..
         imtCal = PublicCalendarList__c.getValues(calendarName);
         imtCalId = imtCal.CalendarID__c;
         
         
         try {
             // extract the old shared calendar events tied to respective comms records - delete
             if(!delShrRecordIds.isEmpty()){    
                 delShrEventLst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event WHERE WhatId IN :delShrRecordIds AND OwnerId = :imtCalId];
                 // Check whether there are shared calendar events for the comms records 
                 if(!delShrEventLst.isEmpty()) {
                     delete delShrEventLst; // delete them in the shared calendar 
                }
             }
         }    
         catch(Exception e) {
             System.debug(LoggingLevel.INFO,'Error while delete the shared calendar event for the record \n'+e.getMessage());
         }
         
                  
         try {
             //extract the old shared calendar events tied to respective comms records
             if(!updatedRecordIds.isEmpty()){    
                 if(fieldsFound) {
                 oldShrEventLst = [Select Id, Subject, WhatId, OwnerId, StartDateTime, EndDateTime FROM Event WHERE WhatId IN :updatedRecordIds AND OwnerId = :imtCalId];
                 //check whether there are shared calendar events for the comms records
                 if(!oldShrEventLst.isEmpty()) {
                     for(Event evt: oldShrEventLst) {
                         if(eventFields.size() == 1) {
                                 evt.StartDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get(eventFields[0].startDtField),Time.newInstance(0, 0, 0, 0));
                                 evt.EndDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get(eventFields[0].endDtField),Time.newInstance(23, 59, 59, 0));
                                 if(!String.isBlank(subjectAppendField))
                                     evt.Subject = eventfields[0].eventSubject + '-' + triggerNewMap.get(evt.WhatId).get(subjectAppendField);
                                 resultmap.put((Id)triggerNewMap.get(evt.WhatId).get('Id'),(Id)triggerNewMap.get(evt.WhatId).get('Id'));
                         }
                         if(eventFields.size() > 1) {
                             for(EventFieldDefinition e: eventFields) {
                                 if(evt.Subject == e.eventSubject) {
                                     evt.StartDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get(e.startDtField),Time.newInstance(0, 0, 0, 0));
                                     evt.EndDateTime = Datetime.newInstance((Date)triggerNewMap.get(evt.WhatId).get(e.endDtField),Time.newInstance(23, 59, 59, 0));
                                     if(!String.isBlank(subjectAppendField))
                                         evt.Subject = e.eventSubject + '-' + triggerNewMap.get(evt.WhatId).get(subjectAppendField);
                                     resultmap.put((Id)triggerNewMap.get(evt.WhatId).get('Id'),(Id)triggerNewMap.get(evt.WhatId).get('Id'));
                                 }
                             }    
                          }
                      }       
                      update oldShrEventLst; // update those shared calendar events
                } 
                // check whether there are no shared calendar events for some or all comms records
                if(oldShrEventLst.size() != updatedRecordIds.size()) {
                     for(Id recId: updatedRecordIds){
                         if(!resultmap.containsKey(recId)) {
                             //System.debug('not found');
                             for(EventFieldDefinition e: eventFields) {
                                 Event newShrEvent = new Event();
                                 if(!String.isBlank(subjectAppendField)) 
                                     //newShrEvent.Subject = objectTypeName.removeEnd('__c') + '-' + triggerNewMap.get(recId).get(subjectAppendField);
                                     newShrEvent.Subject = e.eventSubject + '-' + triggerNewMap.get(recId).get(subjectAppendField);
                                 
                                 else
                                     newShrEvent.Subject = e.eventSubject;
                                 newShrEvent.WhatId= recId;
                                 newShrEvent.OwnerId = imtCalId;
                                 newShrEvent.StartDateTime = Datetime.newInstance((Date)triggerNewMap.get(recId).get(e.startDtField),Time.newInstance(0, 0, 0, 0));
                                 newShrEvent.EndDateTime = Datetime.newInstance((Date)triggerNewMap.get(recId).get(e.endDtField),Time.newInstance(23, 59, 59, 0));
                                 newShrEventLst.add(newShrEvent);
                              } 
                             
                         }
                     }
                     if(!newShrEventLst.isEmpty()) {
                         insert newShrEventLst;    //insert the new events for the comms records which dont have existing shared calendar events 
                     }         
                }
             } 
             else 
             allNewRecords[0].addError('Please check the field names in EventFieldDefinitions of the Apex Trigger/Helper class');
             }
         }
         catch(Exception e) {
             System.debug(LoggingLevel.INFO,'Error while updating the Shared calendar event for the record \n'+e.getMessage());
         }
         
             
    }
}