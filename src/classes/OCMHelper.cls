/*-----------------------------------------------------------------------------------------------------------------
  OCMHelper.cls
  Helper Class for apex trigger on Comms_Marketing_Service__c custom object (OCM request tracker)
  -----------------------------------------------------------------------------------------------------------------
   Author                |Date       |Version  |Description
  -----------------------------------------------------------------------------------------------------------------
   Rajakumar              07/28/2014  1.0       Created - Link the Project record with OCM record and vice versa.
  
  -----------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------------------------------------------------------------------
*/
public class OCMHelper {
    // Insert - When a new OCM record is created, 
    // Create a new project record when the 'Convert to Project' field is checked. 
    // It will update the URL of the OCM record in the project record and vice versa. 
    public static void onAfterInsert(List<Comms_Marketing_Service__c> triggerNew) {
         // for Naming convention 
         List<Comms_Marketing_Service__c> records = new List<Comms_Marketing_Service__c>();
         Map<Id, Comms_Marketing_Service__c> insertMap = new Map<Id, Comms_Marketing_Service__c>();
         List<GPM_Project__c> projects = new List<GPM_Project__c>();
         String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
         RecordType pcRecType = [SELECT Id, DeveloperName FROM RecordType 
                                     WHERE DeveloperName = 'Project_Central' AND SObjectType = 'GPM_Project__c' LIMIT 1];
         for(Comms_Marketing_Service__c cm: triggerNew) {
             if(cm.Convert_To_Project__c == true ) {
                 insertMap.put(cm.Id, cm);
                 String finalURL = sfdcbaseURL + '/' + cm.Id;
                 projects.add(new GPM_Project__c(RecordTypeId= pcRecType.Id, Name =cm.Brief_Title__c, 
                                             Status__c ='Planning', Project_Status__c = 'On-Going',
                                             Project_Description__c =cm.Detailed_Description__c, Private__c = true,
                                             PM_Tool_Link__c =finalURL, OwnerId =UserInfo.getUserId()));
             }
         }
         try {
             if(!projects.isEmpty())
                 insert projects; 
         }
         catch(DMLException e) {
             System.debug(LoggingLevel.ERROR,'Error while inserting the Project records from OCM Request Tracker :' +e.getMessage());    
         }         
         
         Map<Id, Comms_Marketing_Service__c> extractMap = new Map<Id, Comms_Marketing_Service__c> ([SELECT Id, Name FROM
                                         Comms_Marketing_Service__c WHERE Id IN :insertMap.keySet()]);
         for(GPM_Project__c p: projects) {
             String cmURL = p.PM_Tool_Link__c;
             String cmId = cmURL.substringAfterLast('/');
             Comms_Marketing_Service__c record = new Comms_Marketing_Service__c();
             record = extractMap.get(cmId);
             record.Project_Central_ID__c = sfdcbaseURL + '/' + p.Id;
             records.add(record);
         }
         try {
             if(!records.isEmpty()) {
                 OCMRecursionCheck.setAlreadyUpdated();
                 update records;  
             }      
         }
         catch(DMLException e) {
             System.debug(LoggingLevel.ERROR,'Error while updating the OCM record with the Project ID URL :' +e.getMessage());    
         }
                       
    }
    // Update - When the existing OCM record is updated, 
    // Create a new project record when the 'Convert to Project' field is checked. 
    // It will update the URL of the OCM record in the project record and vice versa. 
    public static void onAfterUpdate(List<Comms_Marketing_Service__c> triggerNew, 
                    Map<Id, Comms_Marketing_Service__c> triggerOldMap, Map<Id, Comms_Marketing_Service__c> triggerNewMap) {
        // declarations
        List<Comms_Marketing_Service__c> records = new List<Comms_Marketing_Service__c>();
        Map<Id, Comms_Marketing_Service__c> updateMap = new Map<Id, Comms_Marketing_Service__c>();
        List<GPM_Project__c> projects = new List<GPM_Project__c>();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        RecordType pcRecType = [SELECT Id, DeveloperName FROM RecordType 
                                     WHERE DeveloperName = 'Project_Central' AND SObjectType = 'GPM_Project__c' LIMIT 1];
         
        for(Comms_Marketing_Service__c cm: triggerNew) {
            if(cm.Convert_To_Project__c == true && (cm.Convert_To_Project__c != triggerOldMap.get(cm.Id).Convert_To_Project__c) &&
                cm.Project_Central_ID__c == null ) {
                updateMap.put(cm.Id, cm);
                String finalURL = sfdcbaseURL + '/' + cm.Id;
                projects.add(new GPM_Project__c(RecordTypeId= pcRecType.Id, Name =cm.Brief_Title__c, 
                                             Status__c ='Planning', Project_Status__c = 'On-Going',
                                             Project_Description__c =cm.Detailed_Description__c, Private__c = true,
                                             PM_Tool_Link__c =finalURL, OwnerId =UserInfo.getUserId()));
            }
        }
        try {
             if(!projects.isEmpty())
                 insert projects; 
         }
         catch(DMLException e) {
             System.debug(LoggingLevel.ERROR,'Error while inserting the Project records from OCM Request Tracker :' +e.getMessage());    
         }         
         if(!projects.isEmpty()) {
             Map<Id, Comms_Marketing_Service__c> extractMap = new Map<Id, Comms_Marketing_Service__c> ([SELECT Id, Name FROM
                                         Comms_Marketing_Service__c WHERE Id IN :updateMap.keySet()]);
             for(GPM_Project__c p: projects) {
                 String cmURL = p.PM_Tool_Link__c;
                 String cmId = cmURL.substringAfterLast('/');
                 Comms_Marketing_Service__c record = new Comms_Marketing_Service__c();
                 record = extractMap.get(cmId);
                 record.Project_Central_ID__c = sfdcbaseURL + '/' + p.Id;
                 records.add(record);
             }
             try {
                 if(!records.isEmpty()) {
                     OCMRecursionCheck.setAlreadyUpdated();
                     update records;    
                 }   
             }
             catch(DMLException e) {
                 System.debug(LoggingLevel.ERROR,'Error while updating the OCM record with the Project ID URL :' +e.getMessage());    
             }             
         }
    }
    
    // before update
    public static void onBeforeUpdate(List<Comms_Marketing_Service__c> triggerNew, Map<Id, Comms_Marketing_Service__c> triggerOldMap) {
        List<PermissionSetAssignment> usrList = [SELECT AssigneeId, PermissionSetId 
                    FROM PermissionSetAssignment WHERE PermissionSet.Name = 'OCM_Req_Tracker_User_CRE' 
                    AND AssigneeId = :UserInfo.getUserId()];
        for(Comms_Marketing_Service__c cms: triggerNew) {
            if( (cms.Convert_To_Project__c != triggerOldMap.get(cms.Id).Convert_To_Project__c) && (usrList.isEmpty())) { 
                if(!Test.isRunningTest()) 
                    cms.addError('You do not have permissions to Convert/Deconvert to a Project');   
            }
        } 
           
    } 
   public static void onBeforeUpdatecommstatus(List<Comms_Marketing_Service__c> triggerNew,Map<Id, Comms_Marketing_Service__c> triggerOldMap) {
       Set<ID> commids = new Set<ID>();
       List<Comms_Marketing_Service__c> commservice = new List<Comms_Marketing_Service__c>();
       //List<Point_of_Contact__c> listCon = [Select Id,POC_Update_Status__c from Point_of_Contact__c WHERE OCM_Tracker_Identifier__c IN:commids];
       
       for(Comms_Marketing_Service__c comm : triggerNew){  
                if(comm.Status__c != triggerOldMap.get(comm.Id).Status__c){
                     commids.add(comm.Id);
                }
           }     
                //Trigger Action Logic  
                List<Point_of_Contact__c> listCon = [Select Id,POC_Update_Status__c from Point_of_Contact__c where OCM_Tracker_Identifier__c IN: commids];        
                
                for(Comms_Marketing_Service__c commparent : triggerNew){
                for(Point_of_Contact__c con : listCon)  
                    {  
                        con.POC_Update_Status__c = commparent.Status__c;  
                       
                   } 
                update listCon;      
             }
            }  
    
    
        
}