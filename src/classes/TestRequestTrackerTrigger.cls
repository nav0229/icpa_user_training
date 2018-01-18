/*
  TestRequestTrackerTrigger.cls
  Class for testing Request Tracker trigger on Request_Tracker__c object
  -------------------------------------------------------------------------------
  Author                 Date        Version  Description
  -------------------------------------------------------------------------------
  Rajakumar              05/01/2012  1.0      Creation
  Rajakumar              05/17/2012  1.1      Inclued the logic to share the blog 
                                              request record with the supervisor and change the owner to blog queue
  Rajakumar              01/23/2015  1.2      Revised the class for communication job log and blog request
    */
@isTest
private class TestRequestTrackerTrigger 
{
    //For validating the before insert trigger
    @isTest
    static void testBeforeInsert() {
        //List<Request_Tracker__c> compreqs = new List<Request_Tracker__c>();
        Request_Tracker__c request = new Request_Tracker__c();
        Id compRecTypeId = [SELECT Id,DeveloperName FROM RecordType WHERE Name = 'Complaint Tracker' 
                                        AND SObjectType = 'Request_Tracker__c' LIMIT 1].Id;
        Group pubgrpId = [Select Id from Group Where DeveloperName = 'Request_Tracker_Complaint_Tracker_User' LIMIT 1]; 
        User usr = [SELECT Id, Name FROM User WHERE IsActive = true AND Id =:UserInfo.getUserId()];
        request.Category__c = 'EEO';
        request.Status__c = 'Active';
        request.OCIO_Blog_InternalOrExternal__c = 'Internal GSA-Only';
        request.Priority__c = 'Low';
        request.recordTypeId = compRecTypeId; 
        try {
            insert request;
        }
        catch(DMLException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }    
    }
    
    //For validating the before update trigger
    @isTest(SeeAllData=true)
    static void testBeforeUpdate() {
        List<Request_Tracker__c> eprreqs = new List<Request_Tracker__c>();
        Set<Id> groupIds = new Set<Id>();
        Request_Tracker__c eprRequest = new Request_Tracker__c();
        
        Id EPRrecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'EvidencePreservationRequests' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
        Id EPRpublicGroupId = [Select Id from Group Where DeveloperName = 'Request_Tracker_EPR_ServerServices'].Id;
        List<GroupMember> grpuserlist = [Select GroupId, UserorGroupId from GroupMember Where GroupId = :EPRpublicGroupId LIMIT 2];
        List<Contact> contacts = [SELECT Id, Name FROM Contact LIMIT 2];
        User thisUser = [SELECT Id, Name from User WHERE Id =:UserInfo.getUserId()];
        //List<User> users = [SELECT Id FROM User WHERE IsActive = true AND Id = :grpuserlist[0].UserorGroupId LIMIT 1];
        eprRequest.recordTypeId = EPRrecTypeId;
        eprRequest.Requestor_ID__c = 'TTEST1234KL23';
        eprRequest.Requestor__c = contacts[0].Id;
        eprRequest.Requestor_Original_Date__c = Date.today();
        eprRequest.Status__c = 'Active';
        eprRequest.OCIO_CSWR_JobType__c = 'FOIA Requests';
        eprRequest.FOIA__c = '12345678';
        groupIds.add(EPRpublicGroupId);
        insert eprRequest;
        System.runAs(thisUser) {
            Test.startTest();
            RequestTrackerHelper.createGroupMembers(groupIds);
            Test.stopTest();
            try {
                //Commented below lines to improve the code Coverage - Ramesh 4/7/17
                //eprRequest.FOIA__c = '23456789';
                //eprRequest.Requestor_ID__c = 'TTEST1234KL123';
                //eprRequest.Requestor_Original_Date__c = Date.today();
                eprRequest.Number_of_Flash_Drive_s__c  = 5;
                update eprRequest;
                //Test.stopTest();
            }
            catch(DMLException e) {
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
            }
        }
    } 
}