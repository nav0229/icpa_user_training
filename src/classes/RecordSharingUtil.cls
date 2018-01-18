/*------------------------------------------------------------------------------------------------
  RecordSharingUtil for Sharing the records, deleting the sharing and displaying the records using
  RecordId and RowCause.
  
  This Utility also calls for GSAUtility to get the Object API name based on the RecordId
  ------------------------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  ------------------------------------------------------------------------------------------------
  Raja Nangunoori      03/25/2014      1.0     To Share, Delete and Retrive Sharing.
  ------------------------------------------------------------------------------------------------
  
  ------------------------------------------------------------------------------------------------*/

public class RecordSharingUtil {
    
  /** 
  * Class for RecordId, UserId, Access Level and RowCause for Sharing
  */
    public class RecordSharingDefiniation {
        public String recordId {get; set;}
        public String userId {get; set;}
        public String accessLevel {get; set;}
        public String rowCause {get; set;}
        public Boolean isGroup {get;set;} 
        public String groupId {get; set;}
        
         public recordSharingDefiniation (String recordId, String userId, String accessLevel, String rowCause) {
            this.recordId = recordId;
            this.userId = userId;
            this.accessLevel = accessLevel;
            this.rowCause = rowCause;
            this.isGroup = false;
        }
        public recordSharingDefiniation (String recordId, String groupId, String accessLevel, String rowCause, Boolean isGroup) {
            this.recordId = recordId;
            this.userId = userId;
            this.accessLevel = accessLevel;
            this.rowCause = rowCause;
            this.groupId = groupId;
            //Note - Forcing this constructor to work for only group
            this.isGroup = true;
        }
    }
    
     /**
     * Method to get the Object API Name using RecordID     
     */
    public static String getSharingObj(String recordId) {
        //Calling the Object API name method
        String obj = GSAUtility.getApiNameByRecordId(recordId);
        system.debug('Object API Name ' + obj);     
        //Condition to check if Object is a Standard or Custom Object
        //If Standard Object Append With "Share"
        if(!obj.endsWith('__c') && !obj.endsWith('__C')){
                   obj = obj+'Share';
                } else {
        //If Custom Object append with "__Share"
                 obj = obj.replace('__c', '__Share');
                 obj = obj.replace('__C', '__Share');                 
                }
                system.debug('Object Share ' + obj);
                
                try {
         //Returning the Shared Name of the Object
                        return obj;
                    } 
                catch(DMLException e) {                                   
                        return e.getMessage();
                   }
    }
    
    /**
    *Method to Share record using RecordId, UserId, AccessLevel and RowCause
    */
    public static void share(List<RecordSharingDefiniation> sharingFields){
        String recId;
        Set <Id> uId = new Set<Id>();
        Set <Id> gId = new Set<Id>();
    //Parsing the recordId from the values passed in the method
        for(RecordSharingDefiniation recordId: sharingFields) {
            recId = recordId.recordId;
            uId.add(recordId.userId);
            gId.add(recordId.groupId);
        }
        
        Map<String,User> userMap = new Map<String,User>();
        for(User u : [SELECT Id, isActive FROM User WHERE Id IN: uId]){
        	userMap.put(u.Id, u);
        }
        system.debug('Map ' + userMap);
        //By using the recordId get the Object API name from getSharingObj method
            String objShare = getSharingObj(recId);     
            Schema.SObjectType sharingObj = Schema.getGlobalDescribe().get(objShare);
        //Creating SOBject list to insert sharing list           
            List<SObject> lstSObj = new List<SObject>();
        //Assigning the respective values to sharing object to insert                
                for(RecordSharingDefiniation sF: sharingFields) {
                    SObject shareObj =  sharingObj.newSObject();
                    //String isActive = userMap.get();
                    System.debug('SF UserId ' + sF.userId);   
                    if(sF.isGroup == true){
                    	shareObj.put('ParentId', sF.recordId);                                       
                        shareObj.put('UserOrGroupId', sF.groupId);                    
                        shareObj.put('AccessLevel', sF.accessLevel);
                        shareObj.put('RowCause', sF.rowCause); 
                        lstSObj.add(shareObj);
                    }               
                    if(sF.userId != null) {
                    	Boolean uActive = userMap.get(sF.userId).IsActive;
                    	if(uActive){
                        shareObj.put('ParentId', sF.recordId);                                       
                        shareObj.put('UserOrGroupId', sF.userId);                    
                        shareObj.put('AccessLevel', sF.accessLevel);
                        shareObj.put('RowCause', sF.rowCause);                    
                            //Adding to the list
                        lstSObj.add(shareObj);  
                    	}              
                    }  
                }
                //Checking if the list is not empty then insert
                if(!lstSObj.isEmpty()){
                //Insert sharing list
                    insert lstSObj;
                    //Database.SaveResult[] jobShareInsertResult = Database.insert(lstSObj,false);
                }
    }
    /**
    *Method to remove or revoke sharing for the users
    */
    public static void unshare(List<RecordSharingDefiniation> sharingFields){
        String recId;
        //Parsing the recordId from the values passed in the method
            for(RecordSharingDefiniation recordId: sharingFields) {
                recId = recordId.recordId;
            }
        //Creating a new list for RecordIds
        List<String> listRecId = new List<String>();        
        String parentId;        
        String objShare = getSharingObj(recId);
        //system.debug(objShare);
        //Parsing the values for RecordId and adding it to the list
            for(RecordSharingDefiniation sF: sharingFields) {
                parentId = sF.recordId;                             
                listRecId.add(parentId);                                
            }               
     //Getting the list of users that are shared
    List<sObject> sharesToDelete = Database.query('SELECT Id, ParentId, UserOrGroupId, RowCause, AccessLevel FROM '+ objShare+' WHERE ParentId IN :listRecId LIMIT 10');
    List<SObject> lstSObj = new List<SObject>();
        //Checking if the query list is empty
            if(!sharesToDelete.isEmpty()){
                //Looping through the queried list
                for(SObject del :sharesToDelete) {
                    //Looping through the list of values that are passed in the method                  
                    for(RecordSharingDefiniation sField: sharingFields) {
                        //Compare User and RowCause to remove or revoke correct user                        
                        if(sField.rowCause == del.get('RowCause') && sField.userId == del.get('UserOrGroupId')) {
                            //Adding to the list
                            lstSObj.add(del);                            
                        }
                    }
                }
                
                    try {
                        //Removing or revoking list of user                        
                        delete lstSObj;
                    } 
                      catch(DMLException e) {
                        System.debug(LoggingLevel.INFO,'Error while deleting the apex sharing entry :' +e.getMessage());    
                    }
                                
            }
            
    }
    /**
    * Method to get all the user who has access to a record
    */
    public static List<SObject> getAllUsers(String recordId){       
        String objShare = getSharingObj(recordId);       
        List<sObject> listUsers = Database.query('SELECT Id, UserOrGroupId FROM '+objShare+' WHERE ParentId = :recordId');
        if(!listUsers.isEmpty()){
            return listUsers;
        } 
            return null;
        
    }
    /**
    * Method to get all the users with the passed row cause
    */
    public static List<SObject> getUsersByRowCause(String recordId, String rowCause) {
        String objShare = getSharingObj(recordId);              
        List<sObject> listUsersByRC = Database.query('SELECT Id, UserOrGroupId FROM '+objShare+' WHERE ParentId = :recordId AND RowCause = :rowCause');
        if(!listUsersByRC.isEmpty()){
            return listUsersByRC;
        } else {
            return null;
        }
        
    }
    
}