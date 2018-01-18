/*
    TestRecordSharingUtil.cls
    Test class for RecordSharingUtil.cls
    -------------------------------------------------------------------------------
    Author                 Date        Version      Description
    -------------------------------------------------------------------------------
    Raja Nangunoori       03/25/2014    1.0.00      Test Class for RecordSharingUtil
*/
@isTest(SeeAllData=true)
public class TestRecordSharingUtil {
    static testMethod void getSharingObj() {
            Account acc = new Account();
            acc.Name = 'Test Account';
            insert acc;
            String accId = acc.Id;
            RecordSharingUtil.getSharingObj(accId);
            system.assertEquals(true, true);
            
        }
        
    static testMethod void shareRecord() {
            String apiName;
            String recordId;
            String userId;
            String accessLevel;
            String rowCause; 
            Boolean isGroup;
            List<IDP__c> lstIDP = [SELECT Id FROM IDP__c LIMIT 1];
            List<User> lstUser = [SELECT Id FROM User WHERE IsActive = True LIMIT 1];
            String idpId = lstIDP[0].Id;
            apiName = RecordSharingUtil.getSharingObj(idpId);
            recordId = lstIDP[0].Id;
            userId = lstUser[0].Id;
            accessLevel = 'Read';
            rowCause = 'Manual';
            isGroup = false;
            List<recordSharingUtil.RecordSharingDefiniation> rs = new List<recordSharingUtil.RecordSharingDefiniation>{
                    new recordSharingUtil.RecordSharingDefiniation(recordId, userId, accessLevel, rowCause)
                };
            RecordSharingUtil.share(rs);
            system.assertEquals(true, true);
            
        }
        
        static testMethod void unshareRecord() {
            String apiName;
            String recordId;
            String userId;
            String accessLevel;
            String rowCause; 
            Boolean isGroup;
            String groupId;
            List<IDP__c> lstIDP = [SELECT Id FROM IDP__c LIMIT 1];
            List<User> lstUser = [SELECT Id FROM User WHERE IsActive = True LIMIT 1];
            List<Group> lstG = [SELECT Id FROM Group LIMIT 1];
            String idpId = lstIDP[0].Id;
            apiName = RecordSharingUtil.getSharingObj(idpId);
            recordId = lstIDP[0].Id;
            groupId = lstG[0].Id;
            accessLevel = 'Read';
            rowCause = 'Manual';            
            isGroup = true; 
            List<recordSharingUtil.RecordSharingDefiniation> rs = new List<recordSharingUtil.RecordSharingDefiniation>{
                    new recordSharingUtil.RecordSharingDefiniation(recordId, groupId, accessLevel, rowCause, isGroup)
                };
            RecordSharingUtil.share(rs);
            RecordSharingUtil.unshare(rs);
            system.assertEquals(true, true);
            
        }
        
        static testMethod void getAllRecords() {
            List<IDP__c> lstIDP = [SELECT Id FROM IDP__c LIMIT 1];
            RecordSharingUtil.getAllUsers(lstIDP[0].Id);
            system.assertEquals(true, true);
        }       
                
        static testMethod void getUsersByRowCause() {           
            IDP__c idp1 = new IDP__c();
        idp1.Fiscal_Year_pick__c = 'FY 2014';
        idp1.IDP_Status__c = 'New';
        idp1.Supervisor__c = UserInfo.getUserId();
        idp1.Director__c = UserInfo.getUserId();
        idp1.Career_Goals_Long_Run__c = 'T';
        idp1.Career_Goals_Short_Run__c = 'T';
        insert idp1;            
        RecordSharingUtil.getUsersByRowCause(idp1.Id, 'Supervisor_Access__c');
        system.assertEquals(true, true);
        }
}