public with sharing class RT_StatusTrackerController {

    public RT_StatusTrackerController(ApexPages.StandardController controller) {}

    @AuraEnabled    
    public static string TrackerUpdate(Id id){
       Request_Tracker__c requestTrackerlist = [select Status__c from Request_Tracker__c where id=:id];
       return requestTrackerlist.Status__c; 
    } 
}