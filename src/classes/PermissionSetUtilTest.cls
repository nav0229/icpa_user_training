@isTest(SeeAllData=true) 
private class PermissionSetUtilTest
{
    static testMethod void assignPermissionSetsToUsers() 
    {
        Test.startTest();
        PublicGroupUserSyncHelper.isTestMethod = true;
        Profile p = [SELECT Id FROM Profile WHERE Name='GSA Standard Platform User']; 
        UserLicense userLicence = [Select u.SystemModstamp, u.Name, u.MonthlyLoginsUsed, u.MonthlyLoginsEntitlement, u.LicenseDefinitionKey, u.Id From UserLicense u where u.Name = 'Salesforce'];
        
        
        string randomName = string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','')+'11';     
        string userName = 't123w123';   
        
        User u2 = new User(Alias = 't12a', Email=randomName+userName+'@gsa.gov', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id,MAJOR_ORG__c='A' ,Affiliation__c='Government',
        TimeZoneSidKey='America/Los_Angeles',IsActive=true, UserName=randomName+userName+'@gsa.gov',CommunityNickname='t123xy');            
        
        insert u2;
        
        List<PermissionSet> psList = PermissionSetUtil.getPermissionSetList();
        /*
        List<Id> ids = new List<Id>();
        for(PermissionSet ps : psList)
        {
            //ids.add(ps.Id);
            system.debug('Permission set Name @@2@@@@@@@@@@@@:' + ps.Name);
            
        }
        system.debug('Permission set SIZE @@2@@@@@@@@@@@@:' + psList.size());
        system.debug('Permission set Assignee ID  @@2@@@@@@@@@@@@:' + u2.id);
        */
		List<PermissionSetAssignment> psAssignmentList  = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where AssigneeId = :u2.id];
        /*
        system.debug('psAssignmentList set SIZE @@2@@@@@@@@@@@@:' + psAssignmentList.size());
        ids = new List<Id>();
        for(PermissionSetAssignment ps : psAssignmentList)
        {
            ids.add(ps.PermissionSetId);
            system.debug('Permission set Id @@2@@@@@@@@@@@@:' + ps.PermissionSetId);
        }
        List<PermissionSet> permissionSets1 = [SELECT Id,IsOwnedByProfile,Label,Name FROM PermissionSet where Id in :ids];
        for(PermissionSet ps : permissionSets1)
        {
            system.debug('Permission set Name %%%%%%%%%%%%%%%%%%%%555@@2@@@@@@@@@@@@:' + ps.Name);
        }
        */
        System.assertEquals(psAssignmentList.size()-1,psList.size());
        PublicGroupUserSyncHelper.isTestMethod = false;
        Test.stopTest();    
    }
    static testMethod void updatePermissionSetsToUsers() 
    {
        Test.startTest();
        PublicGroupUserSyncHelper.isTestMethod = true;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        UserLicense userLicence = [Select u.SystemModstamp, u.Name, u.MonthlyLoginsUsed, u.MonthlyLoginsEntitlement, u.LicenseDefinitionKey, u.Id From UserLicense u where u.Name = 'Salesforce'];
        
        string randomName = string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','');     
        string userName = 't123';   
        
        User u2 = new User(Alias = 't123xy', Email=randomName+userName+'@gsa.gov', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id,MAJOR_ORG__c='A' ,Affiliation__c='Government',
        TimeZoneSidKey='America/Los_Angeles', UserName=randomName+userName+'@gsa.gov',CommunityNickname='t123xy');            
        
        insert u2;
        
        List<PermissionSet> psList = PermissionSetUtil.getPermissionSetList();
        List<Id> ids = new List<Id>();
        for(PermissionSet ps : psList)
        {
            ids.add(ps.Id);
        }
        List<PermissionSetAssignment> psAssignmentList  = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where AssigneeId = :u2.id];
        System.assertEquals(psAssignmentList.size()-1,psList.size());
        /*
        u2.Affiliation__c='';
        update u2;
        
        u2.Affiliation__c=null;
        update u2;
       
        u2.Affiliation__c='government';
        update u2;
        */
        u2.Affiliation__c='government1';
        update u2;
        psAssignmentList  = null;
        psAssignmentList  = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where AssigneeId = :u2.id];
		System.assertEquals(psAssignmentList.size()-1,0);
        
        u2.Affiliation__c='Government';        
        update u2;
        psAssignmentList  = [Select PermissionSetId,Id,AssigneeId from PermissionSetAssignment where  AssigneeId = :u2.id];
        System.assertEquals(psAssignmentList.size()-1,psList.size());

        PublicGroupUserSyncHelper.isTestMethod = false;
        Test.stopTest();    
    }   
}