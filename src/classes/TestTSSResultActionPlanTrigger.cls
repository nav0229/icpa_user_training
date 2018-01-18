/*-------------------------------------------------------------------------------------
  TestTSSResultActionPlanTrigger.cls
  Class for testing the apex trigger on TSS_Result_Action_Plan__c custom object, and
	test the TSSResultActionPlanHelper class for Visualforce page
  -------------------------------------------------------------------------------------
   Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------------
   Rajakumar              11/05/2014  1.0       Created.
   Rajakumar			  05/19/2015  1.1       Updated to include the vf page changes   
  -------------------------------------------------------------------------------------
  
  -------------------------------------------------------------------------------------
*/  
@isTest
private class TestTSSResultActionPlanTrigger {
    
    // setup method for creating the respective records for the testing
    @testSetup static void dataPrep() {
        List<TSS_Result_Action_Plan__c> acplist = new List<TSS_Result_Action_Plan__c>();
        
        List<User> admusers = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') LIMIT 2];
        Set<Id> recIds = new Set<Id>();                   
        for(Integer i=0;i<1;i++) {
            String acpname = 'VFPAGEI' + String.valueOf(i);
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname,
                        Building_Address__c='ABC',
                        Building_Name__c='ABC',
                        City__c='Washington',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY15',
                        Location_Code_Plus__c=acpname,
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='DC',
                        Supervisor__c=admusers[0].Id));
        }
        insert acplist;
        List<TSS_Survey__c> surveylist = new List<TSS_Survey__c>();
        for(Integer i=0; i<10; i++) {
            String sname = 'Survey' + String.valueOf(i); 
            surveylist.add(new TSS_Survey__c(Name=sname,
                     TSS_Result_Action_Plan__c=acplist[0].Id,
                     ResponseId__c=sname));
        }
        insert surveylist;
        List<TSS_Response__c> resplist = new List<TSS_Response__c>();
        for(Integer i=0;i<4000;i++) {
            String rname = 'Resp'+String.valueOf(i);
            resplist.add(new TSS_Response__c(Name=rname,
                    TSS_Survey__c=surveylist[0].Id,Type_of_Response__c='Comment',
                    Response_text__c = 'COMMENTS ADDED SUCCESSFULLY'));
        }
        insert resplist;
        System.assertEquals(true,true);
    }
    
    // method to validate the page behaviour when there is no parent record id passed to the page
    @isTest public static void testPageNegative() {
        PageReference pageRef = Page.TSSResponsePage;
        Test.setCurrentPage(pageRef);
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('id', null);
        TSSResultActionPlanHelper controller = new TSSResultActionPlanHelper();   
        System.assertEquals(false, controller.found);
    }
    
    // method to validate the page behavior when there is a valid parent record id (existing with comments) passed to the page 
    @isTest public static void testPagePostive() {
        PageReference pageRef = Page.TSSResponsePage;
        Test.setCurrentPage(pageRef);
        List<TSS_Result_Action_Plan__c> ext = [SELECT Id, Name FROM TSS_Result_Action_Plan__c];
        ApexPages.currentPage().getParameters().put('id', ext[0].Id);
        TSSResultActionPlanHelper controller = new TSSResultActionPlanHelper();
        //List<TSS_Response__c> extlist = controller.getresponses();
        System.assertEquals(4000,controller.getresponses().size()); 
    }
    
    // trigger insert testing - for owner name changes to respective property manager
    @isTest static void doTriggerInsert() {
        List<TSS_Result_Action_Plan__c> acplist = new List<TSS_Result_Action_Plan__c>();
        List<User> admusers = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') LIMIT 2];
        Set<Id> recIds = new Set<Id>();                   
        for(Integer i=0;i<200;i++) {
            String acpname = 'ACPTRGI' + String.valueOf(i);
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname,
                        Building_Address__c='ABC',
                        Building_Name__c='ABC',
                        City__c='Washington',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY14',
                        Location_Code_Plus__c=acpname,
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='DC',
                        Supervisor__c=admusers[0].Id));
        }
        Test.startTest();
        insert acplist;
        Test.stopTest();
        for(TSS_Result_Action_Plan__c tr: acplist) {
            recIds.add(tr.Id);
        }
        List<TSS_Result_Action_Plan__c> acpext = [SELECT Id, Name, Location_Code_Plus__c, OwnerId 
                                                    FROM TSS_Result_Action_Plan__c 
                                                   WHERE Location_Code_Plus__c Like 'ACPTRGI%' 
                                                     AND OwnerId =:admusers[0].Id AND Id IN :recIds];
        System.assertEquals(200,acpext.size());        
    }
    
    // trigger update testing - for owner name changes to respective property manager
    @isTest static void doTriggerUpdate() {
        List<TSS_Result_Action_Plan__c> acplist = new List<TSS_Result_Action_Plan__c>();
        List<User> admusers = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN 
                            (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') LIMIT 2];
        Set<Id> recIds = new Set<Id>();                   
        for(Integer i=0;i<200;i++) {
            String acpname = 'ACPTRGU' + String.valueOf(i);
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname,
                        Building_Address__c='ABC',
                        Building_Name__c='ABC',
                        City__c='Washington',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY14',
                        Location_Code_Plus__c=acpname,
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='D.C.',
                        Supervisor__c=admusers[0].Id));
        }
        insert acplist;
        for(TSS_Result_Action_Plan__c tr: acplist) {
            recIds.add(tr.Id);
            tr.Property_Manager__c=admusers[1].Id;
        }
        Test.startTest();
        update acplist;
        Test.stopTest();
        List<TSS_Result_Action_Plan__c> acpext = [SELECT Id, Name, Location_Code_Plus__c, OwnerId 
                                                    FROM TSS_Result_Action_Plan__c 
                                                   WHERE Location_Code_Plus__c Like 'ACPTRGU%' 
                                                     AND OwnerId =:admusers[1].Id AND Id IN :recIds];
        System.assertEquals(200,acpext.size());        
    }
}