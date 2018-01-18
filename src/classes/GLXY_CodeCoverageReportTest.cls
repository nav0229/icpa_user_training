@isTest 
Public class GLXY_CodeCoverageReportTest{
   
    private static testmethod void testclsNewReplacingReductionReportController() {
    
        Date myCommonDate = date.newinstance(date.today().Year(), 01, 01);
        
        List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
        
        Glxy_LeaseProjects__c objPro0 = new Glxy_LeaseProjects__c();
        objPro0.Name='1234567899';
        objPro0.Project_Type__c = 'New/Replacing';
        objPro0.IASquareFeet__c = 200;
        objPro0.NOASquareFeet__c = 200;
        objPro0.OldIASqFt__c = 50;
        objPro0.OldNOASqFt__c = 50;
        objPro0.AssociatedLeases_lkup__c = 'LA1234';
        objpro0.Old_Square_Feet__c = 100;
        objpro0.SquareFeet__c = 400;
        objPro0.EffectiveDate__c = myCommonDate;
        objPro0.ProcessedDate__c = myCommonDate;
        objPro0.BDGFlag__c = true;
        objPro0.AnnualRent__c=1000.0;
        objPro0.RegionCd__c='1';
        objPro0.DelegatedProject__c = false;
        objPro0.ProjectStatus__c='Active';
        objPro0.eEorA__c = 'ACTUAL';
        objPro0.Old_Annual_Rent__c=100.0;
        objPro0.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objPro0.ExpanSqFtNOA__c = 50;
        objPro0.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro0);
        
        Glxy_LeaseProjects__c objPro1 = new Glxy_LeaseProjects__c();
        objPro1.Name='1234567895';
        objPro1.Project_Type__c = 'Reduction';
        objPro1.IASquareFeet__c = 10;
        objPro1.NOASquareFeet__c = 10;
        objPro1.OldIASqFt__c = 50;
        objPro1.OldNOASqFt__c = 50;
        objPro1.AssociatedLeases_lkup__c = 'LA1234';
        objpro1.Old_Square_Feet__c = 100;
        objpro1.SquareFeet__c = 20;
        Date myDate1 = date.newinstance(date.today().Year(), 10, 10);
        objPro1.EffectiveDate__c = myCommonDate;
        objPro1.ProcessedDate__c = myCommonDate;
        objPro1.BDGFlag__c = true;
        objPro1.AnnualRent__c=1000.0;
        objPro1.RegionCd__c='1';
        objPro1.DelegatedProject__c = false;
        objPro1.ProjectStatus__c='Active';
        objPro1.eEorA__c = 'ACTUAL';
        objPro1.Old_Annual_Rent__c=100.0;
        objPro1.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro1.CancelSqFtIA__c = -40;
        objPro1.CancelSqFtNOA__c = -40;
        objPro1.Remarks__c = 'Reduction Project based on New/Replacing Project 1234567899 for Prior Lease LGA33138 created by the system';
        objLeaseProjectsRecords.Add(objPro1);
        
        Glxy_LeaseProjects__c objPro2 = new Glxy_LeaseProjects__c();
        objPro2.Name='1234567896';
        objPro2.Project_Type__c = 'Reduction';
        objPro2.IASquareFeet__c = 10;
        objPro2.NOASquareFeet__c = 10;
        objPro2.OldIASqFt__c = 50;
        objPro2.OldNOASqFt__c = 50;
        objPro2.AssociatedLeases_lkup__c = 'LA1234';
        objpro2.Old_Square_Feet__c = 100;
        objpro2.SquareFeet__c = 20;
        Date myDate2 = date.newinstance(date.today().Year(), 10, 10);
        objPro2.EffectiveDate__c = myCommonDate;
        objPro2.ProcessedDate__c = myCommonDate;
        objPro2.BDGFlag__c = true;
        objPro2.AnnualRent__c=1000.0;
        objPro2.RegionCd__c='1';
        objPro2.DelegatedProject__c = false;
        objPro2.ProjectStatus__c='Active';
        objPro2.eEorA__c = 'ACTUAL';
        objPro2.Old_Annual_Rent__c=100.0;
        objPro2.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro2.CancelSqFtIA__c = -40;
        objPro2.CancelSqFtNOA__c = -40;
        objPro2.Remarks__c = 'Reduction Project based on New/Replacing Project 1234567899 for Prior Lease LGA33138 created by the system';
        objLeaseProjectsRecords.Add(objPro2);
        
        Glxy_LeaseProjects__c objPro3 = new Glxy_LeaseProjects__c();
        objPro3.Name='1234567897';
        objPro3.Project_Type__c = 'Reduction';
        objPro3.IASquareFeet__c = 10;
        objPro3.NOASquareFeet__c = 10;
        objPro3.OldIASqFt__c = 50;
        objPro3.OldNOASqFt__c = 50;
        objPro3.AssociatedLeases_lkup__c = 'LA1234';
        objpro3.Old_Square_Feet__c = 100;
        objpro3.SquareFeet__c = 20;
        Date myDate3 = date.newinstance(date.today().Year(), 10, 10);
        objPro3.EffectiveDate__c = myCommonDate;
        objPro3.ProcessedDate__c = myCommonDate;
        objPro3.BDGFlag__c = true;
        objPro3.AnnualRent__c=1000.0;
        objPro3.RegionCd__c='1';
        objPro3.DelegatedProject__c = false;
        objPro3.ProjectStatus__c='Active';
        objPro3.eEorA__c = 'ACTUAL';
        objPro3.Old_Annual_Rent__c=100.0;
        objPro3.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro3.CancelSqFtIA__c = -40;
        objPro3.CancelSqFtNOA__c = -40;
        objPro3.Remarks__c = 'Reduction Project based on New/Replacing Project 1234567890 for Prior Lease LGA33138 created by the system';
        objLeaseProjectsRecords.Add(objPro3);
        
        Glxy_LeaseProjects__c objPro4 = new Glxy_LeaseProjects__c();
        objPro4.Name='1234567890';
        objPro4.Project_Type__c = 'New/Replacing';
        objPro4.IASquareFeet__c = 200;
        objPro4.NOASquareFeet__c = 200;
        objPro4.OldIASqFt__c = 50;
        objPro4.OldNOASqFt__c = 50;
        objPro4.AssociatedLeases_lkup__c = 'LA1234';
        objpro4.Old_Square_Feet__c = 100;
        objpro4.SquareFeet__c = 400;
        objPro4.EffectiveDate__c = myCommonDate;
        objPro4.ProcessedDate__c = myCommonDate;
        objPro4.BDGFlag__c = true;
        objPro4.AnnualRent__c=1000.0;
        objPro4.RegionCd__c='1';
        objPro4.DelegatedProject__c = false;
        objPro4.ProjectStatus__c='Active';
        objPro4.eEorA__c = 'ACTUAL';
        objPro4.Old_Annual_Rent__c=100.0;
        objPro4.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objPro4.ExpanSqFtNOA__c = 50;
        objPro4.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro4);
        
        Insert objLeaseProjectsRecords;
        
        Test.startTest();
        
        PageReference pageRef = Page.GLXY_NewReplacingReduction;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Region', '\'1\',\'2\',\'3\',\'4\',\'5\',\'6\',\'7\',\'8\',\'9\',\'10\',\'11\'');
        
        GLXY_clsNewReplacingReductionReport objTest = new GLXY_clsNewReplacingReductionReport();
        objTest.strRegion = '1';
        System.Assert(objTest!=NULL);
        
        Test.stopTest(); 
        
    }
    
    @isTest static void testHelpPageDetailsController() {
        
        GalaxyHelpContentInGoogleSite__c customsetting = new GalaxyHelpContentInGoogleSite__c();
        customsetting.name = 'Galaxy Help Site';
        customsetting.Galaxy_Help_for_this_Page__c='https://www.google.com';
        
        insert customsetting;
        Test.startTest();       
            
        PageReference pageRef = Page.GLXY_HelpPage;
        Test.setCurrentPage(pageRef);
            
        GLXY_clsHelpPageDetails objtest1 = new GLXY_clsHelpPageDetails();
        objtest1.redirecturl = 'https://www.google.com';        
        objtest1.load();        
      
    Test.stopTest(); 
    
    }
    
}