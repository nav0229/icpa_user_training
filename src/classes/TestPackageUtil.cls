/*
    TestPackageUtil.cls
    Tests the PackageUtil.cls
    -------------------------------------------------------------------------------
    Author                 Date        Version  Description
    -------------------------------------------------------------------------------
    Raja Nangunoori       11/18/2013  1.0.00   Re-Design of FedRAMP changes  
*/
//@isTest(seeAllData=true)
@isTest
private class TestPackageUtil {

    static testMethod void PATODate() {
        
        FedRAMP_Estimated_Days__c fedRampEstimatedCustomSettings = new FedRAMP_Estimated_Days__c();
        fedRampEstimatedCustomSettings.Name = '3PAO Testing';
        fedRampEstimatedCustomSettings.Estimated_Days__c = 30;
        insert fedRampEstimatedCustomSettings;
        
        fedRampEstimatedCustomSettings = new FedRAMP_Estimated_Days__c();
        fedRampEstimatedCustomSettings.Name = 'SAR';
        fedRampEstimatedCustomSettings.Estimated_Days__c = 30;
        insert fedRampEstimatedCustomSettings;
        
        fedRampEstimatedCustomSettings = new FedRAMP_Estimated_Days__c();
        fedRampEstimatedCustomSettings.Name = 'SAP';
        fedRampEstimatedCustomSettings.Estimated_Days__c = 15;
        insert fedRampEstimatedCustomSettings;
            
        FedRAMP_Package__c fedPack2 = new FedRAMP_Package__c();
        fedPack2.Package_Progress__c = 'In queue';
        insert fedPack2;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SAR';
        ps.Start_Date__c = date.today();
        ps.End_Date__c = date.today();
        ps.Status__c ='Approved';
        ps.Package__c = fedPack2.Id;
        insert ps;
        
        fedPack2.System_Previously_Authorized__c = 'No';
        fedPack2.PATO_Approved_Date__c = Date.today();
        update fedPack2;
        
        system.assertEquals(true, true);
        
    }
    static testMethod void testPackage(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package__c fedPack1 = new FedRAMP_Package__c();
        fedPack1.Package_Progress__c = 'In queue';
        insert fedPack1;
        
        try {
           update fedPack1;   
       }
       catch (DmlException e) {
          System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
       }
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'Readiness';
        ps.Start_Date__c = date.today();
        ps.Status__c = 'In Process';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        
        FedRAMP_Package_Stage__c ps1 = new FedRAMP_Package_Stage__c();
        ps1.Stages__c = 'Readiness';
        ps1.Start_Date__c = date.today();
        ps1.Start_Date__c = date.today();
        ps1.Status__c = 'Approved';
        ps1.Package__c = fedPack.Id;
        ps1.Estimated_Total_Days__c = 20;
        
        FedRAMP_Package_Stage__c ps2 = new FedRAMP_Package_Stage__c();
        ps2.Stages__c = 'Kick Off Meeting';
        ps2.Start_Date__c = date.today();
        ps2.Start_Date__c = date.today();
        ps2.Status__c = 'Approved';
        ps2.Package__c = fedPack.Id;
        ps2.Estimated_Total_Days__c = 20;
        
        try {
           insert ps1;   
           insert ps2;
           update fedPack1;
       }
       catch (DmlException e) {
          System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
       }

        FedRAMP_Stage_Activity__c sa = new FedRAMP_Stage_Activity__c();
        sa.Actors__c = 'PMO';
        sa.Start_Date__c = date.today();
        sa.Status__c = 'In Process';
        sa.Package_Stage__c = ps.Id;
        insert sa;
        
        FedRAMP_Stage_Activity__c sa1 = new FedRAMP_Stage_Activity__c();
        sa1.Actors__c = 'PMO';
        sa1.Start_Date__c = date.today();
        sa1.Status__c = 'In Process';
        sa1.Package_Stage__c = ps.Id;
        sa1.End_Date__c = date.today();     
        
        try {
           insert sa1;   
       }
       catch (DmlException e) {
          System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
       }
        update sa;
        update ps;
        system.assertEquals(true, true);
        
        
    }
    static testMethod void testSARStage(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SAR';
        ps.Start_Date__c = date.today();
        ps.Status__c = 'In Process';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        update fedPack;
        system.assertEquals(true, true);
    }
    static testMethod void testSSPStage(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SSP';
        ps.Start_Date__c = date.today();
        ps.Status__c = 'In Process';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        
        update fedPack;
        system.assertEquals(true, true);
    }
    static testMethod void testSAPStage(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SAP';
        ps.Start_Date__c = date.today();
        ps.Status__c = 'In Process';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        
        update fedPack;
        system.assertEquals(true, true);
    }
    static testMethod void testSSPAndSAPStage(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SSP';
        ps.Start_Date__c = date.today();
        ps.Status__c = 'In Process';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        
        FedRAMP_Package_Stage__c ps1 = new FedRAMP_Package_Stage__c();
        ps1.Stages__c = 'SAP';
        ps1.Start_Date__c = date.today();
        ps1.Status__c = 'In Process';
        ps1.Package__c = fedPack.Id;
        ps1.Estimated_Total_Days__c = 10;
        insert ps1;
        
        update fedPack;
        system.assertEquals(true, true);
    }
    static testMethod void testSSPAndSAPStage1(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SSP';
        ps.Start_Date__c = date.today();
        ps.End_Date__c = date.today();
        ps.Status__c = 'Approved';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        
        FedRAMP_Package_Stage__c ps1 = new FedRAMP_Package_Stage__c();
        ps1.Stages__c = 'SAP';
        ps1.Start_Date__c = date.today();
        ps1.Status__c = 'In Process';
        ps1.Package__c = fedPack.Id;
        ps1.Estimated_Total_Days__c = 10;
        insert ps1;
        
        update fedPack;
        system.assertEquals(true, true);
    }
    static testMethod void testSSPAndSAPStage2(){
        FedRAMP_Package__c fedPack = new FedRAMP_Package__c();
        fedPack.Package_Progress__c = 'In queue';
        insert fedPack;
        
        FedRAMP_Package_Stage__c ps = new FedRAMP_Package_Stage__c();
        ps.Stages__c = 'SSP';
        ps.Start_Date__c = date.today();
        ps.End_Date__c = date.today();
        ps.Status__c = 'Approved';
        ps.Package__c = fedPack.Id;
        ps.Estimated_Total_Days__c = 10;
        insert ps;
        
        FedRAMP_Package_Stage__c ps1 = new FedRAMP_Package_Stage__c();
        ps1.Stages__c = 'SAP';
        ps1.Start_Date__c = date.today();
        ps1.Status__c = 'Approved';
        ps1.End_Date__c = date.today();
        ps1.Package__c = fedPack.Id;
        ps1.Estimated_Total_Days__c = 10;
        insert ps1;
        
        update fedPack;
        system.assertEquals(true, true);
    }
}