public class PermissionSetUtil
{ 
    public static void assignPermissionSetsToUsers(Map<Id,User> newUserMap)      
    { 
        List<PermissionSet> permissionSets = getPermissionSetList();
        Set<Id> profileIds = getChatterProfileIds();
        Set<Id> exclusionProfileIds = getExclusionProfileIds(); 
        List<User> listAllUsers = new List<User>();
        List<PermissionSetAssignment> psAssignments = new List<PermissionSetAssignment>();
        
        Set<Id> newAssigneeIds = new Set<Id>();  
        Set<Id> permissionSetIds = new Set<Id>();  
        List<PermissionSetAssignment> newPermissionAssignments = new List<PermissionSetAssignment>();
        
        for(Id userId :newUserMap.KeySet()) 
        {
            User user = newUserMap.get(userId);
            //  Don't break if Affiliation is empty
            if(user.Affiliation__c != null){
                if( user.IsActive && ! ( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds) ) && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT'))
            {
                for(PermissionSet permissionSet : permissionSets)
                { 
                    psAssignments.add( new PermissionSetAssignment(AssigneeId = user.Id,PermissionSetId = permissionSet.Id ) );                    
                    newAssigneeIds.add(user.Id);
                    permissionSetIds.add(permissionSet.Id);
                }
            }    
            }
            
        }
        
        List<PermissionSetAssignment> filteredAssignmentList = new List<PermissionSetAssignment>();
        List<PermissionSetAssignment> psAssignmentList = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where AssigneeId in :newAssigneeIds];
        
        if(psAssignmentList != null && psAssignmentList.size() > 0 && psAssignments != null && psAssignments.size() > 0)        
        {
            for(PermissionSetAssignment listPermission : psAssignmentList)
            {
                for(PermissionSetAssignment newAssignment :psAssignments)
                {
                    if(!( (listPermission.AssigneeId == newAssignment.AssigneeId)  && (listPermission.PermissionSetId  == newAssignment.PermissionSetId)) )
                    {
                        filteredAssignmentList.add(newAssignment);
                    }
                }
            }
        
            if(filteredAssignmentList != null && filteredAssignmentList.size() > 0)  
            {      
                insert filteredAssignmentList;
            }
        }
        /*
        if(psAssignments != null && psAssignments.size() > 0)  
        {      
            insert psAssignments;
        }
        */
    }        
        
    public static  void updatePermissionSetsToUsers(Map<Id,User> newUserMap,Map<Id,User> oldUserMap)    
    {
        Set<Id> exclusionProfileIds = getExclusionProfileIds();
        Set<Id> profileIds = getChatterProfileIds();
        List<PermissionSet> permissionSets = getPermissionSetList();
        
        Map<Id,PermissionSet> permissionSetsMap = new Map<Id,PermissionSet>();
        for(PermissionSet ps : permissionSets)
        {
            permissionSetsMap.put(ps.Id,ps);
            //system.debug(ps.Name);
        }
        
        
        List<PermissionSetAssignment> psNewAssignments = new List<PermissionSetAssignment>();
        List<PermissionSetAssignment> psDeleteAssignments = new List<PermissionSetAssignment>();
        
        
        Set<Id> newAssigneeIds = new Set<Id>();  
        Set<Id> permissionSetIds = new Set<Id>();  
        
        Set<Id> deleteAssigneeIds = new Set<Id>();  
        Set<Id> deletePermissionSetIds = new Set<Id>();  
        
        for(Id userId : newUserMap.KeySet())
        {
            User afterUpdateUser = newUserMap.get(userId);
            User beforeUpdateUser = oldUserMap.get(userId);
            
            if(isUserInProfile(beforeUpdateUser ,exclusionProfileIds) || !(afterUpdateUser.IsActive) ||
            (afterUpdateUser.Affiliation__c == null &&  beforeUpdateUser.Affiliation__c == null ) ||
            (afterUpdateUser.Affiliation__c != null &&  beforeUpdateUser.Affiliation__c != null && beforeUpdateUser.Affiliation__c.equalsIgnoreCase(afterUpdateUser.Affiliation__c))
            )
            {
                continue;
            }
                        
            if(!( profileIds.contains(afterUpdateUser.ProfileId) || isUserInProfile(afterUpdateUser,exclusionProfileIds)) && afterUpdateUser.Affiliation__c != null && afterUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') )
            {
                for(PermissionSet permissionSet : permissionSets)
                {
                    psNewAssignments.add(new PermissionSetAssignment(AssigneeId = afterUpdateUser.Id,PermissionSetId = permissionSet.Id ) ); 
                    newAssigneeIds.add(afterUpdateUser.Id);
                    permissionSetIds.add(permissionSet.Id);
                    //system.debug('afterUpdateUser.Id:'+afterUpdateUser.Id +':'+permissionSet.Id);
                    //system.debug(permissionSetsMap.get(permissionSet.Id).Name);
                }
            }
            else if(!( profileIds.contains(afterUpdateUser.ProfileId) || isUserInProfile(afterUpdateUser,exclusionProfileIds)) && (beforeUpdateUser.Affiliation__c == null || beforeUpdateUser.Affiliation__c.equalsIgnoreCase('')) )
            {
            }
            else if(!( profileIds.contains(afterUpdateUser.ProfileId) || isUserInProfile(afterUpdateUser,exclusionProfileIds)) && beforeUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') && (afterUpdateUser.Affiliation__c == null || ! afterUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') ) )
            {
                for(PermissionSet permissionSet : permissionSets)
                {
                    psDeleteAssignments.add(new PermissionSetAssignment(AssigneeId = afterUpdateUser.Id,PermissionSetId = permissionSet.Id ) );                     
                    deleteAssigneeIds.add(afterUpdateUser.Id);
                    deletePermissionSetIds.add(permissionSet.Id);
                }
            }
        }
        
        List<PermissionSetAssignment> filteredDeleteAssignmentList = new List<PermissionSetAssignment>();        
        List<PermissionSetAssignment> psDeleteAssignmentList = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where AssigneeId in :deleteAssigneeIds];
        
        if(psDeleteAssignmentList != null && psDeleteAssignmentList.size() > 0 && psDeleteAssignments != null && psDeleteAssignments.size() > 0)        
        {
            for(PermissionSetAssignment deleteListPermission : psDeleteAssignmentList)
            {
                for(PermissionSetAssignment deleteAssignment:psDeleteAssignments)
                {
                    if((deleteListPermission.AssigneeId == deleteAssignment.AssigneeId)  && (deleteListPermission.PermissionSetId  == deleteAssignment.PermissionSetId))
                    {
                        filteredDeleteAssignmentList.add(deleteListPermission );
                    }
                }
            }
        }
        if(filteredDeleteAssignmentList != null && filteredDeleteAssignmentList.size() > 0)  
        {      
            delete filteredDeleteAssignmentList;
        } 
        
        List<PermissionSetAssignment> filteredAssignmentList = new List<PermissionSetAssignment>();
        List<PermissionSetAssignment> psExistingList = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where AssigneeId in :newAssigneeIds];
        Map<string,PermissionSetAssignment> psExistingAssignmentMap = new Map<string,PermissionSetAssignment>();
        if(psExistingList != null && psExistingList.size() > 0)
        {
            string existingMapId = '';
            for(PermissionSetAssignment existingAssignment :psExistingList )
            {
                existingMapId = existingAssignment.PermissionSetId +':'+existingAssignment.AssigneeId;
                if(!psExistingAssignmentMap.containsKey(existingMapId))
                {
                    psExistingAssignmentMap.put(existingMapId,existingAssignment);
                }
            }
        }
        
        if(psExistingAssignmentMap != null && psExistingAssignmentMap.size() > 0 && psNewAssignments!= null && psNewAssignments.size() > 0)        
        {
            string newMapId = '';
            for(PermissionSetAssignment newAssignment :psNewAssignments)
            {
                newMapId = newAssignment.PermissionSetId +':'+newAssignment.AssigneeId;
                if(psExistingAssignmentMap.containsKey(newMapId)) 
                {
                    system.debug('psExistingAssignmentMap.containsKey(newMapId):'+newMapId);
                    continue;                      
                }
                system.debug(':'+newMapId);
                filteredAssignmentList.add(newAssignment);
           }
        }
        if(filteredAssignmentList != null && filteredAssignmentList.size() > 0)
        {
            insert filteredAssignmentList;
        }
    }
    
    //Gets chatter profile and also exclusion list
    public static Set<Id> getChatterProfileIds()
    {
        Set<Id> profileIds = new Set<Id>();
        //Getting exclusion UserLicense from Custom settings.
        List<String> exclusionUserLicense = getUserProvisioningUtilValuesByType('ExclusionUserLicense');
        List<Profile> profileList = [Select p.Id From Profile p where p.UserLicenseId IN (Select  u.Id From UserLicense u where u.Name IN :exclusionUserLicense)];
        for(Profile profile:profileList)
        {
            profileIds.add(profile.Id);
        }
        return profileIds;
    }
    
    public static Set<Id> getExclusionProfileIds()
    {
        Set<Id> profileIds = new Set<Id>();
        //Getting exclusion profile from Custom settings.
        List<String> exclusionProfiles = getUserProvisioningUtilValuesByType('ExclusionProfile');
        List<Profile> profileExclList = [Select p.Id,p.Name From Profile p where p.Name IN :exclusionProfiles];
        for(Profile profile1:profileExclList)
        {
            profileIds.add(profile1.Id);
        }
        
        return profileIds;
    }
    public static boolean isUserInProfile(User user,Set<Id> profileIds)
    {
        boolean result = false;
        for(Id profileId:profileIds)
        {
            if(profileId == user.ProfileId)
            {
                result = true;
                break;
            }
        }
        return result;
    }
    public static List<PermissionSet> getPermissionSetList()
    {
        //Getting Permissionset Name from Custom settings.
        List<String> psList = getUserProvisioningUtilValuesByType('UserDefaultPermissionSet');
        List<PermissionSet> permissionSets = [SELECT Id,IsOwnedByProfile,Label,Name,ProfileId FROM PermissionSet where Name in :psList];
        return permissionSets;
    }
    
    public static List<String> getUserProvisioningUtilValuesByType(String type)
    {
        List<String> values = new List<String>();
        if(PublicGroupUserSyncHelper.isTestMethod)
        {
            List<UserTestProvisioningUtil__c> userProvisioningValues = [select Name,api_name__c from UserTestProvisioningUtil__c where type__c = :type];
            for(UserTestProvisioningUtil__c value: userProvisioningValues )
            {
                values.add(value.api_name__c);
            }
        }
        else
        {
            List<UserProvisioningUtil__c> userProvisioningValues = [select Name,api_name__c from UserProvisioningUtil__c where type__c = :type];
            for(UserProvisioningUtil__c value: userProvisioningValues )
            {
                values.add(value.api_name__c);
            }
        }
        return values;
    }
}