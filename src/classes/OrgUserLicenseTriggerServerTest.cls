@isTest
public with sharing class OrgUserLicenseTriggerServerTest {
    
    @isTest(SeeAllData=false) 
    Static void TestTriggerOrgUserLicenseTriggerServer() {
        
        OrgUsersLicense__c objOrgUser = New OrgUsersLicense__c();
        objOrgUser.ActiveUser__c = true;
        objOrgUser.FederationID__c = 'FedID';
        objOrgUser.OrgFedIDKey__c = 'OrgIDFedID';
        objOrgUser.OrgID__c = 'OrgID';
        objOrgUser.OrgName__c = 'OrgName';
        objOrgUser.UserID__c = 'UserID@test.com.EEO';
        objOrgUser.UserLicense__c = 'Salesforce';
        Insert objOrgUser;
        
        //Check if the Object record was created sucessfully
        System.Assert(objOrgUser.ID != NULL);
    }
         
}