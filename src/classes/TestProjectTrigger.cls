/*-------------------------------------------------------------------------------------
  TestProjectTrigger.cls
  Class for testing the apex trigger on GPM_Project__c custom object
  -------------------------------------------------------------------------------------
   Author        |Date       |Version  |Description
  -------------------------------------------------------------------------------------
   Rajakumar      02/17/2015  1.0       Created.
   Rajakumar      03/18/2015  1.1       Commented code- remove the executive summary section
  -------------------------------------------------------------------------------------
  
  -------------------------------------------------------------------------------------
*/  
@isTest
private class TestProjectTrigger {
    @testSetup static void dataPrep() {
        List<GPM_Project__c> prjlist = new List<GPM_Project__c>();
        Id recTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Project_Central' AND SObjectType = 'GPM_Project__c'].Id;
        Id accountTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Account' AND SObjectType = 'Account'].Id;
        Id contTypeId = [SELECT Id FROM RecordType WHERE DeveloperName='GSA' AND SObjectType='Contact'].Id;
        Account acct = new Account(Name='GSATEST$TRIG', RecordTypeId=accountTypeId);
        insert acct;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer j=0; j<2; j++) {
            Contact cont = new Contact(RecordTypeId=contTypeId, LastName='PrkPTEST'+j, Email='rp'+j+'trigtestgsa@gsa.gov');
            contacts.add(cont);
        }        
        insert contacts;
        
        for(Integer i = 0; i< 200; i++) {
            GPM_Project__c pr = new GPM_Project__c();
            pr.RecordTypeId = recTypeId;
            pr.Name = 'SmplTrig$123ABC';
            pr.Status__c = 'Concept Approval';
            pr.Project_Description__c = 'SampleDescription';
            pr.SSO_Goals_Themes__c = 'Lead IT Innovation Across the Fed Govt';
            pr.Service_Staff_Office__c = 'I - Office of the GSA IT';
            pr.OCIO_Strategic_Initiative__c = 'None';
            pr.Project_Tier__c = 'Tier 1';
            pr.Project_Manager__c = contacts[0].Id;
            pr.PMO_Lead__c = contacts[1].Id;
            prjlist.add(pr);
        }
        insert prjlist; 
        
        List<GPM_Milestone__c> milestones = new List<GPM_Milestone__c>();
        GPM_Milestone__c ms = new GPM_Milestone__c(GPM_Project__c=prjlist[0].Id, Milestone_Progress__c='Planned', Name__c ='SMStone1',
                                    Milestone_Status__c='Yellow',Planned_End_Date__c=Date.today()+15);
        milestones.add(ms);
        insert milestones;  
        System.assertEquals(true,true);   
    }
    /* 1.1 commented - begin
    @isTest static void doCountInsert() {
        List<GPM_Project__c> gpr = [SELECT Id, Project_Objective_formula__c, 
                                        SSO_Goals_Themes_formula__c, 
                                        Key_Principles_Initiatives_formula__c FROM GPM_Project__c];
        System.assertEquals(200, gpr.size());           
    }
    
    @isTest static void doValidateInsertObjective() {
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c LIMIT 1];
        System.assertEquals(gpr[0].Project_Description__c, gpr[0].Project_Objective_formula__c);        
    }
    
    @isTest static void doValidateInsertSSOGoals() {
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c LIMIT 1];
        System.assertEquals(gpr[0].SSO_Goals_Themes__c, gpr[0].SSO_Goals_Themes_formula__c);      
    }
    
    @isTest static void doValidateInsertKeyPrinciples() {
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c LIMIT 1];
        System.assertEquals(gpr[0].OCIO_Strategic_Initiative__c, gpr[0].Key_Principles_Initiatives_formula__c);      
    }
    
    @isTest static void doCountUpdate() {
        List<GPM_Project__c> gprList = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        for(GPM_Project__c pr : gprList) {
            pr.SSO_Goals_Themes__c = 'Deliver Business Value';
            pr.Project_Description__c = 'SAMPLEUpdatedRecord';
            pr.OCIO_Strategic_Initiative__c = 'Open Source Software (OSS)';
        }
        update gprList;
        List<GPM_Project__c> extract = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        System.assertEquals(200, extract.size());      
    }
    
    @isTest static void doValidateUpdateObjective() {
        List<GPM_Project__c> gprList = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        for(GPM_Project__c pr : gprList) {
            pr.SSO_Goals_Themes__c = null;
            pr.Project_Description__c = 'SAMPLEUpdatedRecord';
            pr.OCIO_Strategic_Initiative__c = 'Open Source Software (OSS)';
        }
        update gprList;
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        System.assertEquals(gpr[0].Project_Description__c, gpr[0].Project_Objective_formula__c);       
    }
    
    @isTest static void doValidateUpdateSSOGoals() {
        List<GPM_Project__c> gprList = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        for(GPM_Project__c pr : gprList) {
            pr.SSO_Goals_Themes__c = 'Deliver Business Value';
            pr.Project_Description__c = 'SAMPLEUpdatedRecord';
            pr.OCIO_Strategic_Initiative__c = null;
        }
        update gprList;
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        System.assertEquals(gpr[0].SSO_Goals_Themes__c, gpr[0].SSO_Goals_Themes_formula__c);       
    }
    
    @isTest static void doValidateUpdateKeyPrinciples() {
        List<GPM_Project__c> gprList = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        for(GPM_Project__c pr : gprList) {
            pr.SSO_Goals_Themes__c = 'Deliver Business Value';
            pr.Project_Description__c = null;
            pr.OCIO_Strategic_Initiative__c = 'Open Source Software (OSS)';
        }
        update gprList;
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Objective_formula__c, 
                                        SSO_Goals_Themes__c, SSO_Goals_Themes_formula__c, 
                                        OCIO_Strategic_Initiative__c, Key_Principles_Initiatives_formula__c 
                                     FROM GPM_Project__c];
        System.assertEquals(gpr[0].OCIO_Strategic_Initiative__c, gpr[0].Key_Principles_Initiatives_formula__c);       
    }
    1.1 commented - end */
    @isTest static void doValidateUpdatePM() {
        List<GPM_Project__c> gprList = [SELECT Id, Project_Description__c 
                                     FROM GPM_Project__c];
        List<Contact> contList = [SELECT Id FROM Contact ORDER By CreatedDate];
        for(GPM_Project__c pr : gprList) {
            pr.Project_Manager__c = contList[1].Id;
            pr.PMO_Lead__c = null;
        }
        update gprList;
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Manager__c, PMO_Lead__c
                                     FROM GPM_Project__c WHERE Project_Manager__c = :contList[1].Id];
        System.assertEquals(200, gpr.size());       
    }
    
    @isTest static void doValidateUpdatePMOLead() {
        List<GPM_Project__c> gprList = [SELECT Id, Project_Description__c 
                                     FROM GPM_Project__c];
        List<Contact> contList = [SELECT Id FROM Contact ORDER By CreatedDate];
        for(GPM_Project__c pr : gprList) {
            pr.Project_Manager__c = null;
            pr.PMO_Lead__c = contList[0].Id;
        }
        update gprList;
        List<GPM_Project__c> gpr = [SELECT Id, Project_Description__c, Project_Manager__c, PMO_Lead__c
                                     FROM GPM_Project__c WHERE PMO_Lead__c = :contList[0].Id];
        System.assertEquals(200, gpr.size());       
    }
}