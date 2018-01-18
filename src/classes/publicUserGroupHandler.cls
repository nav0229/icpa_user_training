public class publicUserGroupHandler
{

    public static boolean disableGroupMemberRecalculation = false;

    public static void insertSupervisorGroupMembers(Map<Id,User> newUserMap)    
    {
        Set<Id> profileIds = getChatterProfileIds();
        List<GroupMember> listGroupMembersToInsert= new list<GroupMember>();
        Group superGroup = [SELECT Id,DeveloperName FROM Group WHERE Group.DeveloperName = 'Supervisor_PUBLIC_GROUP_GSASYSTEM' Limit 1];
        
        Set<Id> exclusionProfileIds = getExclusionProfileIds();
        
        for(Id userId :newUserMap.KeySet()) 
        {
            User user = newUserMap.get(userId);
            if(!( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds)) && user.Affiliation__c != null && !user.Affiliation__c.equalsIgnoreCase('') && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT') && ( user.Supervisory_Status__c == 2 || user.Supervisory_Status__c ==4 || user.Supervisory_Status__c ==5) )
            {
                GroupMember newGroupMember = new GroupMember();
                newGroupMember.GroupId = superGroup.Id;
                newGroupMember.UserOrGroupId = user.Id;
                listGroupMembersToInsert.add(newGroupMember);
            }
        }        
        //Adding all the users to the group.
        if(listGroupMembersToInsert != null && listGroupMembersToInsert.size() > 0)  
        {      
            insert listGroupMembersToInsert;
        }
    }
    
    public static void deleteSupervisorGroupMembers(Map<Id,User> deletedUserMap)    
    {
        Set<Id> profileIds = getChatterProfileIds();
        List<GroupMember> listGroupMembersToInsert= new list<GroupMember>();
        Group superGroup = [SELECT Id,DeveloperName FROM Group WHERE Group.DeveloperName = 'Supervisor_PUBLIC_GROUP_GSASYSTEM' Limit 1];
        
        Set<Id> exclusionProfileIds = getExclusionProfileIds();
        
        List<GroupMember> preGroupMember = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :superGroup.Id];
        for(Id userId :deletedUserMap.KeySet()) 
        {
            User user = deletedUserMap.get(userId);
            if(  ! ( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds))  && user.Affiliation__c != null && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT') &&  ( (user.Supervisory_Status__c == 2) || (user.Supervisory_Status__c ==4) || (user.Supervisory_Status__c ==5))
            )
            {
                for(GroupMember listGroup:preGroupMember) 
                {
                    if(listGroup.UserOrGroupId == user.Id && listGroup.GroupId == superGroup.Id)
                        listGroupMembersToInsert.add(listGroup);
                }
            }
        }        
        //Adding all the users to the group.
        if(listGroupMembersToInsert != null && listGroupMembersToInsert.size() > 0)  
        {      
            delete listGroupMembersToInsert;
        }
    }

    public static void insertGroupMembers(Map<Id,User> newUserMap)    
    {
        List<String> listGroupName = new List<String>();
        Set<Id> profileIds = getChatterProfileIds();
        Set<Id> exclusionProfileIds = getExclusionProfileIds();
        
        for(Id userId :newUserMap.KeySet()) 
        {
            User user = newUserMap.get(userId);
            if( ! ( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds) ) && user.MAJOR_ORG__c != null && !user.MAJOR_ORG__c.equalsIgnoreCase('') && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT'))
                listGroupName.add((user.MAJOR_ORG__c).toUpperCase()+'_PUBLIC_GROUP_GSASYSTEM');
        }
        //Added to take care of All employees
        listGroupName.add('GSA_Employees');
        //Added to take care of CONTRACTOR
        listGroupName.add('I_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM');
        
        List<Group> groups = [SELECT Id,DeveloperName FROM Group WHERE Group.DeveloperName IN :listGroupName];
        Map<String,Group> groupMap = new Map<String,Group>();
        
        if(groups != null && groups.size() > 0)
        {
            for(Group group1 : groups)
            {
                groupMap.put(group1.DeveloperName.toUpperCase(),group1);
            }
        }
        
        List<GroupMember> listGroupMembersToInsert= new list<GroupMember>();
        
        //All employees group        
        List<GroupMember> employeeGroupMembersToInsert = new list<GroupMember>();
        // added for case# 22001 - BEGIN
        List<String> empGrpMembersToInsert = new List<String>();
        List<String> listGrpMembersToInsert = new List<String>();
        // added for case# 22001 - END
        for(Id userId :newUserMap.KeySet()) 
        {
            User user = newUserMap.get(userId);
            if(! ( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds)))
            {
                if(user.MAJOR_ORG__c != null && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT') && groupMap.containsKey(user.MAJOR_ORG__c.toUpperCase()+'_PUBLIC_GROUP_GSASYSTEM')
                )
                {
                    Group group1 = groupMap.get(user.MAJOR_ORG__c.toUpperCase()+'_PUBLIC_GROUP_GSASYSTEM');
                    GroupMember newGroupMember = new GroupMember();
                    newGroupMember.GroupId = group1.Id;
                    newGroupMember.UserOrGroupId = user.Id;
                    listGroupMembersToInsert.add(newGroupMember);
                    // case# 22001 - added - BEGIN
                    GrpMemberHelper gh = new GrpMemberHelper(group1.Id, user.Id);
                    listGrpMembersToInsert.add(JSON.serialize(gh));
                    // case# 22001 - added - END
                }
                if(user.Affiliation__c!= null && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT'))
                {
                    //Adding all the employees to GSA Employee group.
                    Group employeeGroup = groupMap.get('GSA_Employees'.toUpperCase());
                    GroupMember employeeGroupMember = new GroupMember();
                    employeeGroupMember.GroupId = employeeGroup.Id;
                    employeeGroupMember.UserOrGroupId = user.Id;
                    employeeGroupMembersToInsert.add(employeeGroupMember);
                    // case# 22001 - added - BEGIN
                    GrpMemberHelper ge = new GrpMemberHelper(employeeGroup.Id, user.Id);
                    empGrpMembersToInsert.add(JSON.serialize(ge));
                    // case# 22001 - added - END
                }
                //Adding contractors also to I_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM
                if(user.MAJOR_ORG__c != null && user.MAJOR_ORG__c.equalsIgnoreCase('I')  && user.Affiliation__c!= null && user.Affiliation__c.equalsIgnoreCase('CONTRACTOR') && groupMap.containsKey(user.MAJOR_ORG__c.toUpperCase()+'_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM')
                ) 
                {
                    Group group1 = groupMap.get(user.MAJOR_ORG__c.toUpperCase()+'_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM');
                    GroupMember newGroupMember = new GroupMember();
                    newGroupMember.GroupId = group1.Id;
                    newGroupMember.UserOrGroupId = user.Id;
                    listGroupMembersToInsert.add(newGroupMember);
                    // case# 22001 - added - BEGIN
                    GrpMemberHelper gc = new GrpMemberHelper(group1.Id, user.Id);
                    listGrpMembersToInsert.add(JSON.serialize(gc));
                    // case# 22001 - added - END
                }
            }        
        }
        //Adding all the users to the group.
        if(listGroupMembersToInsert != null && listGroupMembersToInsert.size() > 0)  
        {      
            // case# 22001 - commented - BEGIN
            //insert listGroupMembersToInsert;
            // case# 22001 - commented - END
            // case# 22001 - added - BEGIN
            createGroupMembers(listGrpMembersToInsert);
            //case# 22001 - added - END
        }
        if(employeeGroupMembersToInsert != null && employeeGroupMembersToInsert.size() > 0)  
        {      
            // case# 22001 - commented - BEGIN
            //insert employeeGroupMembersToInsert;
            // case# 22001 - commented - END
            // case# 22001 - added - BEGIN
            createGroupMembers(empGrpMembersToInsert);
            //case# 22001 - added - END
        }

    }        
    
    public static  void updateGroupMembers(Map<Id,User> newUserMap,Map<Id,User> oldUserMap)    
    {
        Map<Id,User> newUpdatedUserMap = new Map<Id,User>();
        Map<Id,User> deleteUpdatedUserMap = new Map<Id,User>();       
        
        //Supervisor Group members
        Map<Id,User> newUpdatedSuperUserMap = new Map<Id,User>();
        Map<Id,User> deleteUpdatedSuperUserMap = new Map<Id,User>();
        
        Set<Id> exclusionProfileIds = getExclusionProfileIds();
        Set<Id> profileIds = getChatterProfileIds();
        
        Set<Decimal > supervisoryStatus = new Set<Decimal>{2,4,5};
        
        for(Id userId : newUserMap.KeySet())
        {
            User afterUpdateUser = newUserMap.get(userId);
            User beforeUpdateUser = oldUserMap.get(userId);
            /*if(isUserInProfile(beforeUpdateUser ,exclusionProfileIds))
            {
                continue;
            }
            */
            if(!exclusionProfileIds.contains(beforeUpdateUser.ProfileId))
            {
                //if(!( profileIds.contains(afterUpdateUser.ProfileId) || isUserInProfile(afterUpdateUser,exclusionProfileIds)) && afterUpdateUser.Affiliation__c != null && (beforeUpdateUser.Affiliation__c == null ||!beforeUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT'))   && afterUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') )
                //if(!(profileIds.contains(afterUpdateUser.ProfileId) || isUserInProfile(afterUpdateUser,exclusionProfileIds)) && afterUpdateUser.Affiliation__c != null && afterUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') && afterUpdateUser.Supervisory_Status__c != null)
                if(!(profileIds.contains(afterUpdateUser.ProfileId) || isUserInProfile(afterUpdateUser,exclusionProfileIds)))
                {
                    if( afterUpdateUser.Affiliation__c != null && afterUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') )
                    {
                        //Government
                        if(beforeUpdateUser.Affiliation__c != null && !beforeUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT'))
                        {
                            deleteUpdatedUserMap.put(userId,beforeUpdateUser);
                            newUpdatedUserMap.put(userId,afterUpdateUser);
                        }
                        else if( beforeUpdateUser.Affiliation__c == null || (beforeUpdateUser.Affiliation__c != null && !beforeUpdateUser.Affiliation__c.equalsIgnoreCase('')) )
                        {
                            newUpdatedUserMap.put(userId,afterUpdateUser);
                        }
                        
                        

                        //Supervisor add or delete
                        if( supervisoryStatus.contains(beforeUpdateUser.Supervisory_Status__c) && !supervisoryStatus.contains(afterUpdateUser.Supervisory_Status__c)) 
                        {
                            deleteUpdatedSuperUserMap.put(userId,beforeUpdateUser);
                        }
                        else if(supervisoryStatus.contains(afterUpdateUser.Supervisory_Status__c)) 
                        {
                            newUpdatedSuperUserMap.put(userId,afterUpdateUser);
                        }                 
                                      
                        //Section deals with MAJOR ORG      
                        if(beforeUpdateUser.MAJOR_ORG__c != null && !beforeUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('')  && (afterUpdateUser.MAJOR_ORG__c == null || afterUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('')) )
                        {
                            deleteUpdatedUserMap.put(userId,beforeUpdateUser);
                        }
                        else if(afterUpdateUser.MAJOR_ORG__c != null && !afterUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('') && (beforeUpdateUser.MAJOR_ORG__c == null || beforeUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('')) )
                        {
                            newUpdatedUserMap.put(userId,afterUpdateUser); 
                        }
                        else if(afterUpdateUser.MAJOR_ORG__c != null && !afterUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('') && beforeUpdateUser.MAJOR_ORG__c != null && !beforeUpdateUser.MAJOR_ORG__c.equalsIgnoreCase(''))
                        {
                            if(!afterUpdateUser.MAJOR_ORG__c.equalsIgnoreCase(beforeUpdateUser.MAJOR_ORG__c))
                            {
                                deleteUpdatedUserMap.put(userId,beforeUpdateUser);
                            }
                            newUpdatedUserMap.put(userId,afterUpdateUser); 
                        }
                    }
                    else       
                    {
                        //Goverment delete
                        if ( beforeUpdateUser.Affiliation__c != null && beforeUpdateUser.Affiliation__c.equalsIgnoreCase('GOVERNMENT') )
                        {
                            deleteUpdatedUserMap.put(userId,beforeUpdateUser);
                        }
  
                         //Supervisor delete
                        if( supervisoryStatus.contains(beforeUpdateUser.Supervisory_Status__c)) 
                        {
                            deleteUpdatedSuperUserMap.put(userId,beforeUpdateUser);
                        }
                        
                        if(afterUpdateUser.Affiliation__c != null && afterUpdateUser.Affiliation__c.equalsIgnoreCase('CONTRACTOR'))
                        {
                            if(afterUpdateUser.MAJOR_ORG__c != null && afterUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('I') || (beforeUpdateUser.MAJOR_ORG__c == null || (beforeUpdateUser.MAJOR_ORG__c != null && !beforeUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('I'))))
                            {
                                newUpdatedUserMap.put(userId,afterUpdateUser); 
                            }
                            else if(beforeUpdateUser.MAJOR_ORG__c != null && beforeUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('I'))
                            {
                                deleteUpdatedUserMap.put(userId,beforeUpdateUser);
                            }
                        }   
                        if(( afterUpdateUser.Affiliation__c == null || afterUpdateUser.Affiliation__c != null && !afterUpdateUser.Affiliation__c.equalsIgnoreCase('CONTRACTOR')) && beforeUpdateUser.Affiliation__c != null && beforeUpdateUser.Affiliation__c.equalsIgnoreCase('CONTRACTOR'))
                        {
                            //MAJOR ORG Deletion
                            if(beforeUpdateUser.MAJOR_ORG__c != null && (beforeUpdateUser.MAJOR_ORG__c.equalsIgnoreCase('I')))
                            {
                                deleteUpdatedUserMap.put(userId,beforeUpdateUser);
                            }       
                        }
                   }                  
                }
            }
        }
        if(deleteUpdatedUserMap != null && deleteUpdatedUserMap.size() > 0)
        {       
            deleteGroupMembers(deleteUpdatedUserMap);          
        }        
        if(newUpdatedUserMap != null && newUpdatedUserMap.size() > 0)
        {
            insertGroupMembers(newUpdatedUserMap);
        }
        
        
        //For supervisory groupmembers.    
        if(deleteUpdatedSuperUserMap != null && deleteUpdatedSuperUserMap.size() > 0)
        {
            deleteSupervisorGroupMembers(deleteUpdatedSuperUserMap);         
        }
        if(newUpdatedSuperUserMap != null && newUpdatedSuperUserMap.size() > 0)
        {
            insertSupervisorGroupMembers(newUpdatedSuperUserMap);
        }
    }
    
    public static void deleteGroupMembers(Map<Id,User> deletedUserMap)        
    {
        List<String> listGroupName = new List<String>();
        Set<Id> profileIds = getChatterProfileIds();
        Set<Id> exclusionProfileIds = getExclusionProfileIds();
        for(Id userId :deletedUserMap.KeySet()) 
        {
            User user = deletedUserMap.get(userId);
            if(! ( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds) ) && user.MAJOR_ORG__c != null && !user.MAJOR_ORG__c.equalsIgnoreCase('') && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT'))
                listGroupName.add(user.MAJOR_ORG__c.toUpperCase()+'_PUBLIC_GROUP_GSASYSTEM');
        }
         //Added to take care of All employees
        listGroupName.add('GSA_Employees');
        //Added to take care of CONTRACTOR
        listGroupName.add('I_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM');
        
        
        List<Group> groups = [SELECT Id,DeveloperName FROM Group WHERE Group.DeveloperName IN :listGroupName];
        Map<String,Group> groupMap = new Map<String,Group>();
        Set<Id> groupIds = new Set<Id>();
        
        if(groups != null && groups.size() > 0)
        {
            for(Group group1 : groups)
            {
                groupMap.put(group1.DeveloperName.toUpperCase(),group1);
                groupIds.add(group1.Id);
            }
        }
        //List<GroupMember> preGroupMember = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE GroupId = :groupIds];
        List<GroupMember> preGroupMember = [SELECT GroupId,Id,SystemModstamp,UserOrGroupId FROM GroupMember WHERE UserOrGroupId = :deletedUserMap.KeySet()];
        List<GroupMember> listGroupMembersToDelete = new list<GroupMember>();
        List<GroupMember> employeeGroupMembersToDelete = new list<GroupMember>();        
        
        for(Id userId :deletedUserMap.KeySet()) 
        {
            User user = deletedUserMap.get(userId);
            if( ! ( profileIds.contains(user.ProfileId) || isUserInProfile(user,exclusionProfileIds) ) )
            {
            
                if( user.MAJOR_ORG__c != null && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT') && groupMap.containsKey(user.MAJOR_ORG__c.toUpperCase()+'_PUBLIC_GROUP_GSASYSTEM') )
                {
                    Group group1 = groupMap.get(user.MAJOR_ORG__c.toUpperCase()+'_PUBLIC_GROUP_GSASYSTEM');
                    for(GroupMember listGroup:preGroupMember)
                    {
                        if(listGroup.UserOrGroupId == user.Id && listGroup.GroupId == group1.Id)
                            listGroupMembersToDelete.add(listGroup);
                    }
                }
                if( user.Affiliation__c != null && user.Affiliation__c.equalsIgnoreCase('GOVERNMENT') )                
                {
                    Group newEmployeeGroup = groupMap.get('GSA_Employees'.toUpperCase());
                    for(GroupMember listGroup:preGroupMember)
                    {
                        if(listGroup.UserOrGroupId == user.Id && listGroup.GroupId == newEmployeeGroup.Id)
                            employeeGroupMembersToDelete.add(listGroup);
                    }                
                }
                if( user.MAJOR_ORG__c != null && user.Affiliation__c.equalsIgnoreCase('CONTRACTOR') && groupMap.containsKey(user.MAJOR_ORG__c.toUpperCase()+'_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM') )
                {
                    Group group1 = groupMap.get(user.MAJOR_ORG__c.toUpperCase()+'_CONTRACTOR_PUBLIC_GROUP_GSASYSTEM');
                    for(GroupMember listGroup:preGroupMember)
                    {
                        if(listGroup.UserOrGroupId == user.Id && listGroup.GroupId == group1.Id)
                            listGroupMembersToDelete.add(listGroup);
                    }
                }
            }
        }        
        //Adding all the users to the group.
        if(listGroupMembersToDelete != null && listGroupMembersToDelete.size() > 0)  
        {      
            delete listGroupMembersToDelete;
        }
        if(employeeGroupMembersToDelete != null && employeeGroupMembersToDelete.size() > 0)  
        {   
            delete employeeGroupMembersToDelete;            
        }        
        
    }
 /*   
    //Gets chatter profile and also exclusion list
    public static Set<Id> getChatterProfileIds()
    {
        Set<Id> profileIds = new Set<Id>();
        List<Profile> profileList = [Select p.Id From Profile p where p.UserLicenseId IN (Select  u.Id From UserLicense u where u.Name IN ('Chatter External','Chatter Free'))];
        for(Profile profile:profileList)
        {
            profileIds.add(profile.Id);
        }
        return profileIds;
    }
    
    public static Set<Id> getExclusionProfileIds()
    {
        Set<Id> profileIds = new Set<Id>();
        List<Profile> profileExclList = [Select p.Id,p.Name From Profile p where p.Name IN ('GSA OCR Title VI OHVCP User')];
        for(Profile profile1:profileExclList)
        {
            profileIds.add(profile1.Id);
        }
        
        return profileIds;
    }
*/
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
    
    public static List<String> getUserProvisioningUtilValuesByType(String type)
    {
    //List<UserProvisioningUtil__c> userProvisioningValues = [select Name from UserProvisioningUtil__c where type__c = 'UserDefaultPermissionSet'];
        List<UserProvisioningUtil__c> userProvisioningValues = [select Name,api_name__c from UserProvisioningUtil__c where type__c = :type];

        List<String> values = new List<String>();
        
        for(UserProvisioningUtil__c value: userProvisioningValues )
        {
            values.add(value.api_name__c);
        }
        return values;
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
    
    // case# 22001 - added - BEGIN
    @future
    public static void createGroupMembers(List<String> membersSer) {
        GrpMemberhelper gm = null;
        List<GroupMember> grpList = new List<GroupMember>();
        for (String ser : membersSer) {
            gm = (GrpMemberhelper) JSON.deserialize(ser, GrpMemberhelper.class);
            System.debug('Deserialized group Id: '+gm.grpId+', userId: '+gm.userId);
            grpList.add(new GroupMember(GroupId=gm.grpId,UserOrGroupId=gm.userId));
        }
        if(grpList.size() > 0)
            insert grpList;
    }
    
    public class GrpMemberHelper {
        public String grpId { get; set; }
        public String userId { get; set; }
        
        public GrpMemberHelper(String g, String u) {
            grpId = g;
            userId = u;    
        }
    }
    // case# 22001 - added - END
}