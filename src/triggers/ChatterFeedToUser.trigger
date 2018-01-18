trigger ChatterFeedToUser on User (before update, after insert, after update) {

    Set<Id> userIds = new Set<Id>();
	Set<Id> LMTuserIds = new Set<Id>();
	
    for (User curr: trigger.new)
    {
        if((curr.IsActive && Trigger.isInsert) || (curr.IsActive && !Trigger.oldMap.get(curr.Id).IsActive))
            userIds.add(curr.Id);
    }

    if(publicUserGroupHandler.disableGroupMemberRecalculation == false){
        //Bypass this functionality from 'PermissionSetUtilTest class to avoid SOQL LIMIT exception - Case 00022387
        if(!PublicGroupUserSyncHelper.isTestMethod){
            UserToChatterMessage.followUser(userIds); 
        }
    }

    if(Trigger.isBefore && Trigger.isUpdate){

        //publicUserGroupHandler.disableGroupMemberRecalculation = true;
        //Bypass this functionality from 'PermissionSetUtilTest class to avoid SOQL LIMIT exception - Case 00022387
        if(!PublicGroupUserSyncHelper.isTestMethod){
            SupplementaryAccessUserGranterUser.updateSupplementsForDelegates(trigger.old, trigger.new);
        }

    }

    //Following code responsible for Synchronizing Users Organization.
    //GROUP FORMAT  {MAJORORG}_PUBLIC_GROUP_GSASYSTEM
    //Taking only the users with Major_org__c is not blank
    if(Trigger.isInsert && publicUserGroupHandler.disableGroupMemberRecalculation == false) {
    //Bypass this functionality from 'PermissionSetUtilTest class to avoid SOQL LIMIT exception - Case 00022387
        if(!PublicGroupUserSyncHelper.isTestMethod){
            publicUserGroupHandler.insertGroupMembers(Trigger.newMap);
            publicUserGroupHandler.insertSupervisorGroupMembers(Trigger.newMap);
        }
        PermissionSetUtil.assignPermissionSetsToUsers(Trigger.newMap);
        
    }

    else if(Trigger.isUpdate && publicUserGroupHandler.disableGroupMemberRecalculation == false) {
        //Bypass this functionality from 'PermissionSetUtilTest class to avoid SOQL LIMIT exception - Case 00022387
        if(!PublicGroupUserSyncHelper.isTestMethod){
            publicUserGroupHandler.updateGroupMembers(Trigger.newMap,Trigger.oldMap);   
        }
        PermissionSetUtil.updatePermissionSetsToUsers(Trigger.newMap,Trigger.oldMap);
    
    }

    Map<Id,User> newUserMap = Trigger.newMap;
    List<String> serializedNewUsers = new List<String>();

    for(id userId : newUserMap.keySet()){

        User processUser = newUserMap.get(userId);
        String serializedNewUser = JSON.serialize(processUser);
        serializedNewUsers.add(serializedNewUser);

    }

    Map<Id,User> oldUserMap;
    if(Trigger.oldMap != NULL){
        oldUserMap = Trigger.oldMap;    
    } else{
        oldUserMap = new Map<Id,User>();
    }


    List<String> serializedOldUsers = new List<String>();
    //List<User> users = new List<User>();

    for(id userId : oldUserMap.keySet()){
        User processUser = oldUserMap.get(userId);
        //users.add(processUser);
        String serializedOldUser = JSON.serialize(processUser);
        serializedOldUsers.add(serializedOldUser);
    
    }

    /**
     * Salesforce doesn't allow 
     * @future methods to take list of objects as parameter.
     * So List of users are passed as serialized text to the 
     * @future method CRMUtil.CreateOrUpdateGsaContactFromUser(serializedUsers);
     * 
     */
    if(publicUserGroupHandler.disableGroupMemberRecalculation == false) {
        //Bypass this functionality from 'PermissionSetUtilTest class to avoid SOQL LIMIT exception - Case 00022387
        if(!PublicGroupUserSyncHelper.isTestMethod){
            CRMUtil.CreateOrUpdateGsaContactFromUser(serializedNewUsers,serializedOldUsers); 
        }
    }

    /*else if(Trigger.isDelete)
    {
        publicUserGroupHandler.deleteGroupMembers(Trigger.oldMap);
        publicUserGroupHandler.deleteSupervisorGroupMembers(Trigger.newMap);        
        //PermissionSetUtil.removePermissionSetsToUsers(Trigger.oldMap);
    }*/
    
    //LMT - Update the Org User License Object
    //Sample Code - if(System.IsBatch() == false && ){
    //if(Trigger.isAfter && System.isFuture() == false){
    if(Trigger.isAfter && publicUserGroupHandler.disableGroupMemberRecalculation == false){
    	for (User curr: trigger.new)
    		LMTuserIds.add(curr.Id);
     	UpdateUserLicenseUtil.UpdateUserLicense(LMTuserIds);
    }
	
}