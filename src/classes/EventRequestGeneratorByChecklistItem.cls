/****************************************************************
 Name:  EventRequestGeneratorByChecklistItem
============================================================
Author: Lenny
Purpose: JIRA#1596/1602                                                                                                            
============================================================

****************************************************************/
public with sharing class EventRequestGeneratorByChecklistItem implements EventRequestGenByChecklistItemInterface {

    @TestVisible private static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();
    @TestVisible private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();
    @TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

    private final Map<String, String> CODE_TO_STAGE_MAP = new Map<String,String>{
        MasterChecklistDataAccessor.LOAN_HISTORY_CODE => EventRequestDataAccessor.STAGE_ORDER_LOAN_HISTORY,
        MasterChecklistDataAccessor.FLOOD_MAPPING_CODE => EventRequestDataAccessor.STAGE_ORDER_FLOOD_MAPPING,
        MasterChecklistDataAccessor.LOSS_VERIFICATION_CODE => EventRequestDataAccessor.STAGE_ORDER_LV_INSPECTION
    };
    
    public void generateEventRequestsForChecklistItems(List<Checklist_Item__c> checklistItems){
        Set<Id> masterChecklistIds = new Set<Id>();
        Set<Id> applicationIds = new Set<Id>();
        for(Checklist_Item__c item : checklistItems) {
            if(!masterChecklistIds.contains(item.Master_Checklist__c)){
                masterChecklistIds.add(item.Master_Checklist__c);
            }
            if(!applicationIds.contains(item.Application__c)){
                applicationIds.add(item.Application__c);
            }
        }
        Map<Id, Master_Checklist__c> masterChecklistMapById = masterChecklistDA.getMasterChecklistsMapById(new List<Id>(masterChecklistIds));
        Map<Id, Application__c> applicationMapById = applicationDA.getApplicationsMapById(new List<Id>(applicationIds));

        List<Event_Request__c> newEventRequests = new List<Event_Request__c>();
        for(Checklist_Item__c item : checklistItems) {
            String checklistCode = masterChecklistMapById.get(item.Master_Checklist__c).Checklist_Code__c;
            if(CODE_TO_STAGE_MAP.containsKey(checklistCode)){
                newEventRequests.add(
                    new Event_Request__c(
                        Name = applicationMapById.get(item.Application__c).Name + '-' + CODE_TO_STAGE_MAP.get(checklistCode),
                        Application_Number__c = applicationMapById.get(item.Application__c).Name,
                        Stage__c = CODE_TO_STAGE_MAP.get(checklistCode)
                    )
                );
            }
        }

        try{
            if(!newEventRequests.isEmpty()){
                eventRequestDA.insertEventRequests(newEventRequests);
            }
        }
        catch (DmlException e){
            System.debug(e);
            throw new EventRequestGeneratorByChecklistItemException('Error occured creating Event Requests.', e);
        }

    }

    public class EventRequestGeneratorByChecklistItemException extends Exception {}
}