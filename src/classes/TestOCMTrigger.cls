/*-------------------------------------------------------------------------------------------------------------------
  TestOCMTrigger.cls
  Class for testing the trigger on Comms_Marketing_Service__c custom object (OCM request tracker)
  -------------------------------------------------------------------------------------------------------------------
   Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------------------------------------------
   Rajakumar              07/15/2014  1.0       Created - Link the Project record with OCM record and vice versa
  
  -------------------------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------------------------
*/  

@isTest(seeAllData = true)
private class TestOCMTrigger {
    // test the insert without convert to project
    @isTest
    static void doInsertWithoutConversion() {
        Id cmRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Communications_and_Marketing_Services' 
                             AND SObjectType = 'Comms_Marketing_Service__c'].Id;
        Comms_Marketing_Service__c cm = new Comms_Marketing_Service__c();
        cm.RecordTypeId = cmRecTypeId;
        cm.Services_Requested__c = 'Photography';
        cm.Service_Type__c ='Portrait';
        cm.Submitting_Org__c = 'A-Ofc of the Administrator';
        cm.Source_of_Request__c = 'Client Request';
        cm.Brief_Title__c = 'TestInsert$1234$1';
        cm.Actual_Delivery_Date__c = Date.today();
        cm.Estimated_Time_to_Complete__c = 24.05;
        cm.Convert_To_Project__c = false;
        Test.startTest();
        insert cm;
        Test.stopTest();
        System.assertEquals(null, cm.Project_Central_ID__c);        
    }
    // test the insert with convert to project
    @isTest
    static void doInsertWithConversion() {
        Id cmRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Communications_and_Marketing_Services' 
                             AND SObjectType = 'Comms_Marketing_Service__c'].Id;
        Comms_Marketing_Service__c cm = new Comms_Marketing_Service__c();
        cm.RecordTypeId = cmRecTypeId;
        cm.Services_Requested__c = 'Photography';
        cm.Service_Type__c ='Portrait';
        cm.Submitting_Org__c = 'A-Ofc of the Administrator';
        cm.Source_of_Request__c = 'Client Request';
        cm.Brief_Title__c = 'TestInsert$1234$2';
        cm.Actual_Delivery_Date__c = Date.today();
        cm.Estimated_Time_to_Complete__c = 24.05;
        cm.Convert_To_Project__c = true;
        Test.startTest();
        insert cm;
        Test.stopTest();
        Comms_Marketing_Service__c cmExtract = [SELECT Id, Project_Central_ID__c FROM Comms_Marketing_Service__c WHERE Id = : cm.Id];
        //GPM_Project__c proj = [SELECT Id, 
        System.assert(cmExtract.Project_Central_ID__c != null);
    }
    
    // test the bulk insert
    @isTest
    static void doInsertBulk() {
        List<Comms_Marketing_Service__c> cmList = new List<Comms_Marketing_Service__c>(); 
        Id cmRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Communications_and_Marketing_Services' 
                             AND SObjectType = 'Comms_Marketing_Service__c'].Id;
        for(Integer i = 0; i< 200; i++) {
            Comms_Marketing_Service__c cm = new Comms_Marketing_Service__c();
            cm.RecordTypeId = cmRecTypeId;
            cm.Services_Requested__c = 'Photography';
            cm.Service_Type__c ='Portrait';
            cm.Submitting_Org__c = 'A-Ofc of the Administrator';
            cm.Source_of_Request__c = 'Client Request';
            cm.Brief_Title__c = 'TestInsert$1234$3';
            cm.Actual_Delivery_Date__c = Date.today();
            cm.Estimated_Time_to_Complete__c = 24.05;
            cm.Convert_To_Project__c = true;
            cmList.add(cm);
        }
        Test.startTest();
        insert cmList;
        Test.stopTest();
        List<Comms_Marketing_Service__c> cmExtract = [SELECT Id, Project_Central_ID__c, Brief_Title__c 
                                        FROM Comms_Marketing_Service__c 
                                        WHERE Brief_Title__c = 'TestInsert$1234$3' AND Project_Central_ID__c != null];
        System.assertEquals(200, cmExtract.size());
        List<GPM_Project__c> projExtract = [SELECT Id, PM_Tool_Link__c, Name FROM GPM_Project__c 
                                        WHERE Name = 'TestInsert$1234$3' AND PM_Tool_Link__c != null];
        System.assertEquals(200, projExtract.size());   
    }
    
    // test the update
    @isTest
    static void doUpdate() {
        Id cmRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Communications_and_Marketing_Services' 
                             AND SObjectType = 'Comms_Marketing_Service__c'].Id;
        Comms_Marketing_Service__c cm = new Comms_Marketing_Service__c();
        cm.RecordTypeId = cmRecTypeId;
        cm.Services_Requested__c = 'Photography';
        cm.Service_Type__c ='Portrait';
        cm.Submitting_Org__c = 'A-Ofc of the Administrator';
        cm.Source_of_Request__c = 'Client Request';
        cm.Brief_Title__c = 'TestUpdate$1234$1';
        cm.Actual_Delivery_Date__c = Date.today();
        cm.Estimated_Time_to_Complete__c = 24.05;
        cm.Status__c = 'test';
        //cm.Convert_To_Project__c = false;
        insert cm;
        cm.Convert_To_Project__c = true;
        //cm.Agree_to_Convert_to_a_Project__c = true;
        cm.Project_Central_ID__c = null;
        Point_of_Contact__c pc = new Point_of_Contact__c();
        Test.startTest();
        update cm;
        Test.stopTest();
        Comms_Marketing_Service__c cmExtract = [SELECT Id, Project_Central_ID__c FROM Comms_Marketing_Service__c WHERE Id = : cm.Id];
        System.assert(cmExtract.Project_Central_ID__c != null);        
    }
    
    // test the bulk update
    @isTest
    static void doUpdateBulkWhenProjectURLIsNull() {
        List<Comms_Marketing_Service__c> cmList = new List<Comms_Marketing_Service__c>(); 
        Id cmRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Communications_and_Marketing_Services' 
                             AND SObjectType = 'Comms_Marketing_Service__c'].Id;
        for(Integer i = 0; i < 200; i++) {
            Comms_Marketing_Service__c cm = new Comms_Marketing_Service__c();
            cm.RecordTypeId = cmRecTypeId;
            cm.Services_Requested__c = 'Photography';
            cm.Service_Type__c ='Portrait';
            cm.Submitting_Org__c = 'A-Ofc of the Administrator';
            cm.Source_of_Request__c = 'Client Request';
            cm.Brief_Title__c = 'TestUpdate$1234$2';
            cm.Actual_Delivery_Date__c = Date.today();
            cm.Estimated_Time_to_Complete__c = 24.05;
            cm.Convert_To_Project__c = false;
            cmList.add(cm);
        }
        Set<Id> recordIds = new Set<Id>();
        insert cmList;
        for(Comms_Marketing_Service__c cms : cmList) {
            recordIds.add(cms.Id);
            cms.Convert_To_Project__c = true;
            cms.Project_Central_ID__c = null;
            //cms.Agree_to_Convert_to_a_Project__c = true;
        }
        Test.startTest();
        update cmList;
        Test.stopTest();
        List<Comms_Marketing_Service__c> cmExtract = [SELECT Id, Project_Central_ID__c, Brief_Title__c 
                                        FROM Comms_Marketing_Service__c 
                                        WHERE Brief_Title__c = 'TestUpdate$1234$2' AND Project_Central_ID__c != null];
        System.assertEquals(200, cmExtract.size());
        List<GPM_Project__c> projExtract = [SELECT Id, PM_Tool_Link__c, Name FROM GPM_Project__c 
                                        WHERE Name = 'TestUpdate$1234$2' AND PM_Tool_Link__c != null];
        System.assertEquals(200, projExtract.size());
    }
    
    @isTest
    static void doUpdateBulkWhenProjectURLNotNull() {
        List<Comms_Marketing_Service__c> cmList = new List<Comms_Marketing_Service__c>(); 
        Id cmRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Communications_and_Marketing_Services' 
                             AND SObjectType = 'Comms_Marketing_Service__c'].Id;
        for(Integer i = 0; i < 200; i++) {
            Comms_Marketing_Service__c cm = new Comms_Marketing_Service__c();
            cm.RecordTypeId = cmRecTypeId;
            cm.Services_Requested__c = 'Photography';
            cm.Service_Type__c ='Portrait';
            cm.Submitting_Org__c = 'A-Ofc of the Administrator';
            cm.Source_of_Request__c = 'Client Request';
            cm.Brief_Title__c = 'TestUpdate$1234$22';
            cm.Actual_Delivery_Date__c = Date.today();
            cm.Estimated_Time_to_Complete__c = 24.05;
            cm.Convert_To_Project__c = false;
            cmList.add(cm);
        }
        Set<Id> recordIds = new Set<Id>();
        insert cmList;
        for(Comms_Marketing_Service__c cms : cmList) {
            recordIds.add(cms.Id);
            cms.Convert_To_Project__c = true;
            //cms.Project_Central_ID__c = null;
            //cms.Agree_to_Convert_to_a_Project__c = true;
        }
        Test.startTest();
        update cmList;
        Test.stopTest();
        List<Comms_Marketing_Service__c> cmExtract = [SELECT Id, Project_Central_ID__c, Brief_Title__c 
                                        FROM Comms_Marketing_Service__c 
                                        WHERE Brief_Title__c = 'TestUpdate$1234$22' AND Project_Central_ID__c != null];
        System.assertEquals(200, cmExtract.size());
        List<GPM_Project__c> projExtract = [SELECT Id, PM_Tool_Link__c, Name FROM GPM_Project__c 
                                        WHERE Name = 'TestUpdate$1234$22' AND PM_Tool_Link__c != null];
        System.assertEquals(200, projExtract.size());
    }
}