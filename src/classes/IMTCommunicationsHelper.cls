/*-------------------------------------------------------------------------------------------------*
  Apex class 
  Creates an event on IMT Calendar for Comms record
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/16/2013    1.0       Initial version.
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
public class IMTCommunicationsHelper {
    
    public static void onAfterInsert(List<Communications__c> triggerNew) {
         List<EventUtil.EventFieldDefinition> eventFields = new list<EventUtil.EventFieldDefinition> {
         new EventUtil.EventFieldDefinition('start_date__c', 'End_Date__c', 'Communications')
         };
         List<Communications__c> records = new List<Communications__c>();                  
         for(Communications__c c: triggerNew) {
             if(c.Show_in_Shared_Calendar__c == true) {
                 records.add(c);
             }     
         }
         //System.debug('TOTAL INSERT RECORDS size: ' +records.size());
         if(!records.isEmpty())
            EventUtil.onAfterInsert(records, eventFields, 'IMTCalendar', 'Region_SSO__c');
    }
    
    public static void onAfterUpdate(List<Communications__c> triggerNew, Map<Id, Communications__c> triggerOldMap, Map<Id, Communications__c> triggerNewMap) {
         List<EventUtil.EventFieldDefinition> eventFields = new list<EventUtil.EventFieldDefinition> {
         new EventUtil.EventFieldDefinition('start_date__c', 'end_date__c', 'Communications')
         };
         List<Communications__c> updatedRecs = new List<Communications__c>();
         Set<Id> delshrRecordIds = new Set<Id>();
         Set<Id> updatedRecordIds = new Set<Id>();
         for(Communications__c req: triggerNew) {
             // list of the communication records which are not available in shared calendar
             if((req.Start_Date__c!=triggerOldMap.get(req.Id).Start_Date__c || 
                 req.End_Date__c!=triggerOldMap.get(req.Id).End_Date__c ||
                 req.Region_SSO__c!=triggerOldMap.get(req.Id).Region_SSO__c ||
                 req.Show_in_Shared_Calendar__c != triggerOldMap.get(req.Id).Show_in_Shared_Calendar__c) && req.Show_in_Shared_Calendar__c == true) {
                 updatedRecordIds.add(req.Id);
             }
             // list of the communication records which are already available in shared calendar
             if((req.Start_Date__c!=triggerOldMap.get(req.Id).Start_Date__c || 
                 req.End_Date__c!=triggerOldMap.get(req.Id).End_Date__c ||
                 req.Region_SSO__c!=triggerOldMap.get(req.Id).Region_SSO__c ||
                 req.Show_in_Shared_Calendar__c == triggerOldMap.get(req.Id).Show_in_Shared_Calendar__c) && req.Show_in_Shared_Calendar__c == true) {
                 updatedRecordIds.add(req.Id);
             }
             // list of the communication records which are already available in shared calendar but no longer required to show
             if((req.Start_Date__c!=triggerOldMap.get(req.Id).Start_Date__c || req.End_Date__c!=triggerOldMap.get(req.Id).End_Date__c ||
                 req.Show_in_Shared_Calendar__c != triggerOldMap.get(req.Id).Show_in_Shared_Calendar__c) && req.Show_in_Shared_Calendar__c == false) {
                 delshrRecordIds.add(req.Id);
             }
            
        }        
        if(!updatedRecordIds.isEmpty() || !delshrRecordIds.isEmpty())
            EventUtil.onAfterUpdate(triggerNew, updatedRecordids, triggerNewMap, delshrRecordIds, eventFields, 'IMTCalendar', 'Region_SSO__c');
    }
}