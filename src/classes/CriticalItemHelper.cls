/*-------------------------------------------------------------------------------
  CriticalItemHelper.cls
  Helper Class for Critical Item trigger on Critical_Issues__c object
  -------------------------------------------------------------------------------
  Author                 |Date       | Version | Description
  -------------------------------------------------------------------------------
  Rajakumar               04/04/2014   1.0       Creation
  -------------------------------------------------------------------------------
  ------------------------------------------------------------------------------- */
public class CriticalItemHelper {
    
    //After Insert
    public static void onAfterInsert(List<Critical_Issues__c> triggerNew) {
        // Declarations
        Critical_Issues__Share pocShr;
        List<Critical_Issues__Share> pocshrList = new List<Critical_Issues__Share>();
        Set<Id> userIds = new Set<Id>();
        // set of POC users
        for(Critical_Issues__c citem: triggerNew) {
            userIds.add(citem.User__c);
        }
        // map of the extracting POC user details
        Map<Id, User> usersMap = new Map<Id, User>([SELECT Id, UserType FROM User WHERE Id IN :userIds]);
        // Process the records
        for(Critical_Issues__c citem: triggerNew) {
            if(usersMap.get(citem.User__c).UserType == 'Standard') {
                pocShr = new Critical_Issues__Share();
                pocShr.ParentID = citem.Id;
                pocShr.UserOrGroupId = citem.User__c;
                pocShr.AccessLevel = 'Read';
                pocShr.RowCause = Schema.Critical_Issues__Share.RowCause.POC__c;
                pocshrList.add(pocShr);
            }
            //userids.add(citem.User__c);
        }
        // INSERT the new POC apex record sharing entries
        try {
            insert pocshrList;
        }
        catch(DMLException e) {
            System.debug(LoggingLevel.INFO,'Error while inserting the POC apex sharing entry for Critical Items :'+e.getMessage());    
        }        
    }
    
    // After Update
    public static void onAfterUpdate(List<Critical_Issues__c> triggerNew, Map<Id, Critical_Issues__c> triggerOldMap, Map<Id, Critical_Issues__c> triggerNewMap) {
        // Declarations
        Critical_Issues__Share pocShr; 
        List<Critical_Issues__Share> oldpocshrList = new List<Critical_Issues__Share>(); 
        List<Critical_Issues__Share> newpocshrList = new List<Critical_Issues__Share>(); 
        Set<Id> oldpocRecIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();
        // set of POC users
        for(Critical_Issues__c citem: triggerNew) {
            if(citem.User__c != triggerOldMap.get(citem.Id).User__c)
                userIds.add(citem.User__c);
        }
        // map of the extracting POC user details
        Map<Id, User> usersMap = new Map<Id, User>([SELECT Id, UserType FROM User WHERE Id IN :userIds]);
        
        for(Critical_Issues__c citem: triggerNew) {
            if(citem.User__c != triggerOldMap.get(citem.Id).User__c ) {
                oldpocRecIds.add(citem.Id);
                if(usersMap.get(citem.User__c).UserType == 'Standard') {
                    pocShr = new Critical_Issues__Share();
                    pocShr.ParentID = citem.Id;
                    pocShr.UserOrGroupId = citem.User__c;
                    pocShr.AccessLevel = 'Read';
                    pocShr.RowCause = Schema.Critical_Issues__Share.RowCause.POC__c;
                    newpocshrList.add(pocShr);
                }
            }   
        }
        // FETCH the old apex sharing entries from the salesforce share object
        if(!oldpocRecIds.isEmpty()) {
            oldpocshrList = [SELECT Id FROM Critical_Issues__Share WHERE RowCause = 'POC__c' AND ParentId IN :oldpocRecIds]; 
        }
        // DELETE the old POC apex record sharing entries
        try {
            delete oldpocshrList;
        }
        catch(DMLException e) {
            System.debug(LoggingLevel.INFO,'Error while deleting the POC apex sharing entry for Critical Items :' +e.getMessage());    
        } 
        // INSERT the new POC apex record sharing entries
        try {
            insert newpocshrList;
        }        
        catch(DMLException e) {
            System.debug(LoggingLevel.INFO,'Error while updating the POC apex sharing entry for Critical Items :' +e.getMessage());    
        }
    }
    
    // Before Insert
    public static void onBeforeInsert(List<Critical_Issues__c> triggerNew) {
        
        Boolean followUp = false, monitor = false, delReview = false, rcReview = false, blReview = false, raReview = false; 
        Boolean comReview = false, comAppr = false, ssoReview = false, frontoffReview = false, chiefReview = false;
        Boolean dAdmReview = false, admReview = false, admAppr = false, completed = false, cancelled = false; 
        Boolean isExecSec = false;
        
        Map<Id, Group> grpMap = new Map<Id, Group>([Select Id, DeveloperName from Group Where DeveloperName Like 'Critical_Items_%']);                
        /*
        List<GroupMember> usergrplist = [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId IN :grpmap.keySet() AND
                                  UserOrGroupId = :UserInfo.getUserId()];
        */
        for(GroupMember gm: [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId IN :grpmap.keySet() AND
                                  UserOrGroupId = :UserInfo.getUserId()]) {
            if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Delegate_Users') {
                followup     = true;
                delReview    = true;                  
            }     
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_RA_Users') {
                followup    = true;
                monitor     = true;
                raReview    = true;                
            }    
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_RC_Users') {
                followup    = true;
                monitor     = true;
                rcReview    = true;
            }    
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_ExecSec_Users' || 
                    grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_AuditGroup_Users') {
                //followup    = true;
                isExecSec    = true;
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_BusLineExec_Users') {
                followup    = true;
                monitor     = true;
                blReview    = true;                
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_HSO_Users') {
                followup    = true;
                monitor     = true;
                ssoReview   = true;                
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Front_Office_Users') {
                followup    = true;
                monitor     = true;
                frontoffReview = true; 
                admReview   = true;
                admAppr     = true;              
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Commissioner_Users') {
                followup    = true;
                monitor     = true;
                comReview   = true;
                comAppr     = true;                
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Administrator_Users') {
                followup    = true;
                monitor     = true;
                admReview   = true;
                admAppr     = true;
                //dAdmReview  = true;
                //chiefReview = true;
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_ChiefofStaff_Users') {
                followup    = true;
                monitor     = true;
                chiefReview = true;
                admReview   = true;
                admAppr     = true;
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_DeputyAdmin_Users') {
                followup    = true;
                monitor     = true;
                dAdmReview  = true;
                admReview   = true;
                admAppr     = true;
            }
            else     
                continue;
        } 
        
        for(Critical_Issues__c citem: triggerNew) {
            if( citem.Critical_Item_Status__c == 'Monitor' && !monitor ) {
                citem.addError('You are not authorized to set the status to Monitor');
            }
            else if( citem.Critical_Item_Status__c == 'Follow-up' && !followup ) {
                citem.addError('You are not authorized to set the status to Follow-Up');
            }
            else if( citem.Critical_Item_Status__c == 'Delegate Reviewed' && !delReview ) {
                citem.addError('You are not authorized to set the status to Delegate Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'RC Reviewed' && !rcReview ) {
                citem.addError('You are not authorized to set the status to RC Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Business Line Reviewed' && !blReview ) {
                citem.addError('You are not authorized to set the status to Business Line Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'RA Reviewed' && !raReview ) {
                citem.addError('You are not authorized to set the status to RA Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Commissioner Reviewed' && !comReview ) {
                citem.addError('You are not authorized to set the status to Commissioner Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Commissioner Approved' && !comAppr ) {
                citem.addError('You are not authorized to set the status to Commissioner Approved');
            }
            else if( citem.Critical_Item_Status__c == 'Staff Office Reviewed' && !ssoReview ) {
                citem.addError('You are not authorized to set the status to Staff Office Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Front Office Reviewed' && !frontoffReview ) {
                citem.addError('You are not authorized to set the status to Front Office Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Chief of Staff Reviewed' && !chiefReview ) {
                citem.addError('You are not authorized to set the status to Chief of Staff Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Deputy Administrator Reviewed' && !dAdmReview ) {
                citem.addError('You are not authorized to set the status to Deputy Administrator Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Administrator Reviewed' && !admReview ) {
                citem.addError('You are not authorized to set the status to Administrator Reviewed');
            }
            else if( citem.Critical_Item_Status__c == 'Administrator Approved' && !admAppr ) {
                citem.addError('You are not authorized to set the status to Administrator Approved');
            }
            else if (citem.Action_Required_by_Administrator__c != 'Ready For Signature/Approval' &&
                citem.Action_Required_by_Administrator__c != 'Action/Decision Required' && isExecSec ) {
                citem.addError('You are only authorized to set the Action Type as Ready For Signature/Approval OR Action/Decision Required');
            }     
            else
                continue;   
        }
    }
    
    public static void onBeforeUpdate(List<Critical_Issues__c> triggerNew, Map<Id, Critical_Issues__c> triggerOldMap) {
        
        Boolean followUp = false, monitor = false, delReview = false, rcReview = false, blReview = false, raReview = false; 
        Boolean comReview = false, comAppr = false, ssoReview = false, frontoffReview = false, chiefReview = false;
        Boolean dAdmReview = false, admReview = false, admAppr = false, completed = false, cancelled = false; 
        Boolean isExecSec = false;
        
        Map<Id, Group> grpMap = new Map<Id, Group>([Select Id, DeveloperName from Group Where DeveloperName Like 'Critical_Items_%']);
        /*
        List<GroupMember> usergrplist = [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId IN :grpmap.keySet() AND
                                  UserOrGroupId = :UserInfo.getUserId()];
        */
        for(GroupMember gm: [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId IN :grpmap.keySet() AND
                                  UserOrGroupId = :UserInfo.getUserId()]) {
            if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Delegate_Users') {
                followup     = true;
                delReview    = true;                  
            }    
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_RA_Users') {
                followup    = true;
                monitor     = true;
                raReview    = true;                
            }    
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_RC_Users') {
                followup    = true;
                monitor     = true;
                rcReview    = true;
            }    
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_ExecSec_Users' ||
                    grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_AuditGroup_Users') {
                //followup    = true;
                isExecSec    = true;
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_BusLineExec_Users') {
                followup    = true;
                monitor     = true;
                blReview    = true;                
            }
            if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_HSO_Users') {
                followup    = true;
                monitor     = true;
                ssoReview   = true;                
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Front_Office_Users') {
                followup    = true;
                monitor     = true;
                frontoffReview = true; 
                admReview   = true;
                admAppr     = true;              
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Commissioner_Users') {
                followup    = true;
                monitor     = true;
                comReview   = true;
                comAppr     = true;                
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_Administrator_Users') {
                followup    = true;
                monitor     = true;
                admReview   = true;
                admAppr     = true;
                //dAdmReview  = true;
                //chiefReview = true;
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_ChiefofStaff_Users') {
                followup    = true;
                monitor     = true;
                chiefReview = true;
                admReview   = true;
                admAppr     = true;
            }
            else if(grpmap.get(gm.GroupId).DeveloperName == 'Critical_Items_DeputyAdmin_Users') {
                followup    = true;
                monitor     = true;
                dAdmReview  = true;
                admReview   = true;
                admAppr     = true;
            }
            else 
                continue;
        } 
        
        for(Critical_Issues__c citem: triggerNew) {
            if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Monitor' && !monitor ) {
                citem.addError('You are not authorized to change the status to Monitor');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Follow-up' && !followup ) {
                citem.addError('You are not authorized to change the status to Follow-Up');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Delegate Reviewed' && !delReview ) {
                citem.addError('You are not authorized to change the status to Delegate Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'RC Reviewed' && !rcReview ) {
                citem.addError('You are not authorized to change the status to RC Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Business Line Reviewed' && !blReview ) {
                citem.addError('You are not authorized to change the status to Business Line Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'RA Reviewed' && !raReview ) {
                citem.addError('You are not authorized to change the status to RA Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Commissioner Reviewed' && !comReview ) {
                citem.addError('You are not authorized to change the status to Commissioner Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Commissioner Approved' && !comAppr ) {
                citem.addError('You are not authorized to change the status to Commissioner Approved');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Staff Office Reviewed' && !ssoReview ) {
                citem.addError('You are not authorized to change the status to Staff Office Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Front Office Reviewed' && !frontoffReview ) {
                citem.addError('You are not authorized to change the status to Front Office Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Chief of Staff Reviewed' && !chiefReview ) {
                citem.addError('You are not authorized to change the status to Chief of Staff Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Deputy Administrator Reviewed' && !dAdmReview ) {
                citem.addError('You are not authorized to change the status to Deputy Administrator Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Administrator Reviewed' && !admReview ) {
                citem.addError('You are not authorized to change the status to Administrator Reviewed');
            }
            else if( citem.Critical_Item_Status__c != triggerOldMap.get(citem.Id).Critical_Item_Status__c && 
                citem.Critical_Item_Status__c == 'Administrator Approved' && !admAppr ) {
                citem.addError('You are not authorized to change the status to Administrator Approved');
            }
            else if (citem.Action_Required_by_Administrator__c != triggerOldMap.get(citem.Id).Action_Required_by_Administrator__c &&
                citem.Action_Required_by_Administrator__c != 'Ready For Signature/Approval' &&
                citem.Action_Required_by_Administrator__c != 'Action/Decision Required' && isExecSec ) {
                citem.addError('You are only authorized to change the Action Type to Ready For Signature/Approval OR Action/Decision Required');
            }
            else 
                continue;   
        }
    }
}