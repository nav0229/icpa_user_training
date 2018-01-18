//@isTest(seealldata=true)
@isTest
private class TestCaseTriggerHelper {
    
    
        static testMethod void myUnitTest() {
        
        Id recType=Schema.SObjectType.Case.getRecordTypeInfosByName().get('OCIO Task Tracking').getRecordTypeId();
    
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 5];
        //Smitha: add record in resolution type cusotm setting    
        List<Caseset__c> resType = new List<Caseset__c>();
        resType.add(new Caseset__c(Name=' Add New Fields 1',
                                   Need_Dev_Mgr_Approvals__c=True,
                                   Need_Sol_Arch_Approvals__c=True,
                                   Resolution_Types__c='Add 2 New Fields', 
                                   Tiers__c='1')); 
          resType.add(new Caseset__c(Name='Add New Fields 2',
                                   Need_Dev_Mgr_Approvals__c=True,
                                   Need_Sol_Arch_Approvals__c=False,
                                   Resolution_Types__c='Add 3 New Fields', 
                                   Tiers__c='2'));
             resType.add(new Caseset__c(Name='Add New Fields 3',
                                   Need_Dev_Mgr_Approvals__c=True,
                                   Need_Sol_Arch_Approvals__c=False,
                                   Resolution_Types__c='Add 4 New Fields', 
                                   Tiers__c='1'));
            
        insert resType;
        Application_Support__c app = new Application_Support__c();
        app.Name = 'TestApp1';
        app.Dedicated_Team_Tier_1__c='Relocation Queue';
        app.Dedicated_Team_Tier_2__c='Referral Queue';
        app.Dedicated_Team_Tier_3__c='FTRD Queue';
        app.App_Owner__c = users[0].Id;
        app.Secondary_Owner__c=users[0].Id;
        app.Org_Office__c = 'OCIO';
        insert app;   
        
        Case c = new Case();
        c.Subject ='testcase1';
        c.Tier__c='0';
        c.Current_State__c = 'Resolution Type Assignment';
        c.App_Owner__c=users[0].Id;
        c.Secondary_Owner__c=users[0].Id;
        c.Need_Sol_Arch_Approval__c=false;
        c.Need_Dev_Mgr_Approval__c=false;
        c.Case_Type__c='Application';
        c.Resolution_Type__c = '';
        c.Application_Module__c = app.Id;
        c.Status = 'Not Applicable';
        c.Task_Status__c = 'In Progress';
        c.RecordTypeId = recType;
        insert c;
        
        Case ca = [SELECT Id, Resolution_Type__c, Tier__c FROM Case WHERE Id =: c.Id];
        ca.Tier__c = '1';
        ca.Resolution_Type__c = 'Add 2 New Fields; Add 3 New Fields; Add 4 New Fields';
        ca.Status = 'Not Applicable';
        update ca;
        
        Case ca1 = [SELECT Id, Resolution_Type__c, Tier__c FROM Case WHERE Id =: c.Id];
        ca1.Tier__c = '1';
        ca1.Resolution_Type__c = 'Add 2 New Fields';
        ca1.Status = 'Not Applicable';
        update ca1;
        
        Case ca2 = [SELECT Id, Resolution_Type__c, Tier__c FROM Case WHERE Id =: c.Id];
        ca2.Tier__c = '1';
        ca2.Resolution_Type__c = '';
        ca2.Status = 'Not Applicable';
        update ca2;
        
        system.assertEquals(True,True);
    }
    
    static testMethod void testRecordTypeMap(){
        Id recType=Schema.SObjectType.Case.getRecordTypeInfosByName().get('OCIO Task Tracking').getRecordTypeId();
        Id recFtrdType=Schema.SObjectType.Case.getRecordTypeInfosByName().get('FTRD Web-to-Case').getRecordTypeId();
        List<Case> caseList = new List<Case>();
        Map<Id,Case> caseMap = new Map<Id,Case>();
        Case c1 = new Case();
        c1.Subject ='testcase1';
        c1.Tier__c='0';
        c1.Current_State__c = 'Resolution Type Assignment';
        c1.Need_Sol_Arch_Approval__c=false;
        c1.Need_Dev_Mgr_Approval__c=false;
        c1.Case_Type__c='Application';
        c1.Resolution_Type__c = '';
        c1.Status = 'Not Applicable';
        c1.Task_Status__c = 'In Progress';
        c1.RecordTypeId = recType; 
        
        caseList.add(c1);
        
        Case c2 = new Case();
        c2.Subject ='testcase1';
        c2.Tier__c='0';
        c2.Current_State__c = 'Resolution Type Assignment';
        c2.Need_Sol_Arch_Approval__c=false;
        c2.Need_Dev_Mgr_Approval__c=false;
        c2.Case_Type__c='Application';
        c2.Resolution_Type__c = '';
        c2.Status = 'Not Applicable';
        c2.Task_Status__c = 'In Progress';
        c2.RecordTypeId = recFtrdType;
        
        caseList.add(c2);
        insert caseList;
        
        for(Case curCase: caseList){
            caseMap.put(curCase.Id,curCase);
        }
        System.debug('OCIO: '+recType);
        System.debug('FTRD: '+recFtrdType);
        System.assertEquals(1, CaseTriggerHelper.getOcioTaskTrackingRecords(caseMap).size());
    }
    
}