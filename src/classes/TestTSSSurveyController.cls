/*-------------------------------------------------------------------------------------------------*
  Test class for TSSSurveyController - survey functionality
  TSS Action Planning application
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          05/19/2015    1.1       Survey form - created.

 *-------------------------------------------------------------------------------------------------*

 *-------------------------------------------------------------------------------------------------*/
@isTest()
public class TestTSSSurveyController {
    // setup method for creating the respective records for the testing
    @testSetup public static void dataPrep() {
        RecordType rt = [SELECT Id,Name, DeveloperName
                         FROM RecordType
                         WHERE SobjectType='Account' AND DeveloperName='Account' LIMIT 1];
        RecordType contRT = [SELECT Id, Name, DeveloperName, SObjectType
                             FROM RecordType
                             WHERE SObjectType='Contact' AND DeveloperName ='GSA' LIMIT 1];
        Account acct = new Account();
        acct.Name='GSA';
        acct.RecordTypeId = rt.Id;
        // insert account
        insert acct;
        Contact cont = new Contact();
        cont.LastName = 'Kumar';
        cont.FirstName = 'Raj';
        cont.Email='rajakumar.pallepati@gsa.gov';
        cont.RecordTypeId = contRT.Id;
        // insert contact
        insert cont;
        List<TSS_Result_Action_Plan__c> acplist = new List<TSS_Result_Action_Plan__c>();

        List<User> admusers = [SELECT Id FROM User WHERE IsActive = true AND ProfileId IN
                            (SELECT Id FROM Profile WHERE Name = 'GSA System Administrator') LIMIT 2];
        Set<Id> recIds = new Set<Id>();
        for(Integer i=0;i<1;i++) {
            String acpname = 'ACPTRGI' + String.valueOf(i);
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname,
                        Building_Address__c='ABC',
                        Building_Name__c='ABC',
                        City__c='FAIRFAX',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY16',
                        Location_Code_Plus__c=acpname,
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='VA',
                        Supervisor__c=admusers[0].Id));
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname+'1',
                        Building_Address__c='VIRTUAL 16',
                        Building_Name__c='VIRTUAL 16',
                        City__c='WASHINGTON',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY16',
                        Location_Code_Plus__c='VIRTUAL16',
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='DC',
                        Supervisor__c=admusers[0].Id));
            //added new data to accomodate building not Listed 
            acplist.add(new TSS_Result_Action_Plan__c(Name=acpname+'1',
                        Building_Address__c='Not Listed',
                        Building_Name__c='Not Listed',
                        City__c='WASHINGTON',
                        Field_Office__c='CO',
                        Fiscal_Year__c='FY16',
                        Location_Code_Plus__c='BuildingNotListed16',
                        Occupancy__c=2000,
                        Property_Manager__c=admusers[0].Id,
                        Property_Status__c='Leased',
                        Region__c='CO',
                        Service_Center__c='CO',
                        State__c='DC',
                        Supervisor__c=admusers[0].Id));
        }
        // insert buildings
        insert acplist;
        List<TSS_Survey__c> surveylist = new List<TSS_Survey__c>();
        for(Integer i=0; i<1; i++) {
            String sname = 'Survey' + String.valueOf(i);
            surveylist.add(new TSS_Survey__c(Name=sname,
                     TSS_Result_Action_Plan__c=acplist[0].Id,FY__c='FY16',
                     Contact__c=cont.Id,
                     ResponseId__c=sname));
        }
        // insert surveys
        insert surveylist;

        System.assertEquals(true,true);
    }

    // method to validate the page behaviour when there is no parent record id passed to the page
    @isTest public static void testNegative() {
        PageReference pageRef = Page.TSSSurveyWizard1;
        Test.setCurrentPage(pageRef);
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('id', null);
        TSSSurveyController controller = new TSSSurveyController();
        System.assertEquals(false, controller.contactfound);
    }

    // method to validate the page behavior when there is a valid parent record id (existing with comments) passed to the page
    
    @isTest public static void testPostive() {
        PageReference pageRef = Page.TSSSurveyWizard1;
        Test.setCurrentPage(pageRef);
        List<TSS_Result_Action_Plan__c> ext = [SELECT Id, Name FROM TSS_Result_Action_Plan__c
                                               WHERE Location_Code_Plus__c != 'VIRTUAL16' LIMIT 1];
        List<Contact> contact = [SELECT Id, Email FROM Contact];
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('id', contact[0].Id);
        ApexPages.currentPage().getHeaders().put('User-Agent','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36');
        TSSSurveyController controller = new TSSSurveyController();

        List<SelectOption> agencies = controller.getAgencies();
        for(SelectOption s: agencies){
            controller.agency = s.getValue();
            List<SelectOption> bureaus2 = controller.getBureaus();
        }
        List<SelectOption> bureaus = controller.getBureaus();
        List<SelectOption> states = controller.getStates();
        controller.agency = 'DEPARTMENT OF EDUCATION';
        controller.bureau = 'DEPARTMENT OF EDUCATION';
        controller.state = 'VA';
        List<SelectOption> cities = controller.cities;
        controller.city = 'FAIRFAX';
        List<SelectOption> buildings = controller.buildings;
        controller.building = ext[0].Id;
        controller.contact = contact[0].Id;
        controller.telework = 'No';
        String nextbutton = controller.next().getURL();
        System.assertEquals('/apex/tsssurveywizard2',nextbutton);
        String prevbutton = controller.previous().getURL();
        System.assertEquals('/apex/tsssurveywizard1',prevbutton);
        controller.cleancat1 = '1';
        controller.cleancat2 = '2';
        controller.cleancat3 = '3';
        controller.cleancat4 = '4';
        controller.workcat1 = '1';
        controller.workcat2 = '2';
        controller.workcat3 = '3';
        controller.workcat4 = '4';
        controller.condcat1 = '1';
        controller.condcat2 = '2';
        controller.condcat3 = '3';
        controller.condcat4 = '4';
        controller.elevator = '1';
        controller.comments = 'COMMENT ADDED';
        controller.meetspace = '2';
        controller.overallsat = '4';
        controller.bldgmgmt1 = '1';
        controller.bldgmgmt2 = '1';
        controller.security = '1';
        controller.securityPersonnel ='1';
        controller.wkspacetype = 'Other';
        String nextpage = controller.save().getUrl();
        System.assertEquals('/apex/tsssurveythankyou', nextPage);
        String bldgId = ext[0].Id;
        String contId = contact[0].Id;
        List<TSS_Survey__c> surveys = [SELECT Id, Name, Contact__c, TSS_Result_Action_Plan__c
                                FROM TSS_Survey__c
                                WHERE TSS_Result_Action_Plan__c = :bldgId
                                AND Contact__c = :contId];
        System.assertEquals(2, surveys.size());//modified the assert statement
    }

    // method to validate the page behavior when there is a valid parent record id passed to the page (virtual=yes)
    @isTest public static void testVirtualPostive() {
        PageReference pageRef = Page.TSSSurveyWizard1;
        Test.setCurrentPage(pageRef);
        List<TSS_Result_Action_Plan__c> extvirtbuilding = [SELECT Id, Name FROM TSS_Result_Action_Plan__c
                                               WHERE Location_Code_Plus__c = 'VIRTUAL16' LIMIT 1];
        List<Contact> contact = [SELECT Id, Email FROM Contact];
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('id', contact[0].Id);
        TSSSurveyController controller = new TSSSurveyController();
        controller.building = extvirtbuilding[0].Id;
        controller.contact = contact[0].Id;
        controller.telework = 'Yes';
        String nextpage = controller.save().getUrl();
        System.assertEquals('/apex/tsssurveythankyou', nextPage);
        String bldgId = extvirtbuilding[0].Id;
        String contId = contact[0].Id;
        List<TSS_Survey__c> surveys = [SELECT Id, Name, Contact__c, TSS_Result_Action_Plan__c
                                FROM TSS_Survey__c
                                WHERE TSS_Result_Action_Plan__c = :bldgId
                                AND Contact__c = :contId];
        System.assertEquals(1, surveys.size());
    }
}