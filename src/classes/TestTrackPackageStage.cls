/*
    TestTrackPackageStage.cls
    Tests the TrackPackageStageTH.cls
    -------------------------------------------------------------------------------
    Author                 Date        Version  Description
    -------------------------------------------------------------------------------
    Acumen Solutions       02/2122012  1.0.00   Creation
*/
@isTest
private class TestTrackPackageStage
{
  /*  static testMethod void testTrackPackageStage()
    {
        Contact cont = new Contact();
        cont.FirstName = 'Testfirst';
        cont.LastName = 'Testlast';
        cont.RecordTypeId = ContactUtility.GSA_RECORDTYPE;
        insert cont;
        
        List<Schema.PicklistEntry> stages = FedRAMP_Package__c.Stage__c.getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> subStages = FedRAMP_Package__c.Sub_Stage__c.getDescribe().getPicklistValues();
        
        Test.startTest();
        FedRAMP_Package__c pack = new FedRAMP_Package__c();
        pack.ISSO__c = cont.Id;
        //pack.Selected_3PAO__c = cont.Id;
        pack.Stage__c = stages[0].getValue();
        pack.Sub_Stage__c = subStages[0].getValue();
        insert pack;
        
        //Put the start date 3 days in the past to check the time in a stage
        FedRAMP_Package_Timeline__c timeline = [SELECT Start_Date__c FROM FedRAMP_Package_Timeline__c WHERE FedRAMP_Package__c =: pack.Id];
        timeline.Start_Date__c = Date.today().addDays(-3);
        update timeline;
        
        pack.Stage__c = stages[1].getValue();
        pack.Sub_Stage__c = subStages[1].getValue();
        update pack;
        
        timeline = [SELECT Days_In_Stage__c FROM FedRAMP_Package_Timeline__c WHERE Id =: timeline.Id];
        System.assertEquals(3, timeline.Days_In_Stage__c, 'Days between not calculating correctly.');
        Test.stopTest();
    }*/
}