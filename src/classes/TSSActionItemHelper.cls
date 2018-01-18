/*-------------------------------------------------------------------------------------------------*
  Apex class 
  Helper class for TSS_Action_Item__c object apex trigger
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/05/2014    1.0       Initial version.
  
 *-------------------------------------------------------------------------------------------------*
 
 *-------------------------------------------------------------------------------------------------*/
public class TSSActionItemHelper {
    // Before Inserting a new record
    public static void onBeforeInsert(List<TSS_Action_Item__c> triggerNew) {
        Id superUsrGrpId;
        List<GroupMember> usrlist = new List<GroupMember>();
        superUsrGrpId = [SELECT Id, DeveloperName FROM Group WHERE DeveloperName = 'TSS_Advanced_Users'].Id;
        usrlist = [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId = :superUsrGrpId AND UserorGroupId =:UserInfo.getUserId()];
        for(TSS_Action_Item__c ta: triggerNew) {
            if((ta.Status__c == 'Cancelled') && (usrlist.isEmpty())) {
                ta.addError('You do not have permissions to Cancel the Action Item, please contact the Super User');
            }        
        }
    }
    // Before updating the existing record
    public static void onBeforeUpdate(List<TSS_Action_Item__c> triggerNew, Map<Id, TSS_Action_Item__c> triggerOldMap) {
        Id superUsrGrpId;
        List<GroupMember> usrlist = new List<GroupMember>();
        superUsrGrpId = [SELECT Id, DeveloperName FROM Group WHERE DeveloperName = 'TSS_Advanced_Users'].Id;
        usrlist = [SELECT GroupId, UserorGroupId FROM GroupMember WHERE GroupId = :superUsrGrpId AND UserorGroupId =:UserInfo.getUserId()];
        for(TSS_Action_Item__c ta: triggerNew) {
            if((ta.Status__c == 'Cancelled') && (ta.Status__c != triggerOldMap.get(ta.Id).Status__c) && (usrlist.isEmpty())) {
                ta.addError('You do not have permissions to Cancel the Action Item, please contact the Super User');
            }
        }    
    }    
    
}