public with sharing class GLXY_LPSRBuildingRelatedList {

 private final Glxy_LPStepRent__c LPSRObj;
 
 public List<Glxy_ProjectLocation__c> projectLocations{get;set;}

    public GLXY_LPSRBuildingRelatedList(ApexPages.StandardController controller) {

       LPSRObj=(Glxy_LPStepRent__c)controller.getRecord();
       
       Glxy_LPStepRent__c objSR=[select ProjectNumber__c from Glxy_LPStepRent__c where id =:LPSRObj.id];
       projectLocations=[select id, Name,BuildingNumber__c, BuildingNumber__r.Name, BuildingName__c,Address__c, City__c, State__c, LocationCode__c from Glxy_ProjectLocation__c where ProjectNumber__c=:objSR.ProjectNumber__c];
    }
    
   @isTest static void Test_GLXY_LPSRBuildingRelatedList(){
  
  
			   Glxy_LeaseProjects__c project= new Glxy_LeaseProjects__c();
			   project.ProjectStatus__c='Active';
			   Date myDate = 
					date.newinstance(2012, 2, 17);
					 Date myDate1 = 
					date.newinstance(2013, 2, 17);
			   project.EffectiveDate__c=myDate ;
			   //project.ExpirationDateofLease__c=myDate1 ;
			   project.RegionCd__c='3';
			   project.RexusNewNOASqFt__c=1000;
			   project.RexusNewIASqFt__c=1000;
			   
			   //project.BaseSquareFeet__c=2000;
			   
			   insert project;
			   
			  Glxy_LPStepRent__c pi = new Glxy_LPStepRent__c();
			   pi.ProjectNumber__c=project.id;
			   insert pi;
			   
			   PBS_Building__c build= new PBS_Building__c();
			   build.Location_Code_Plus__c='test';
			   build.Building_ID__c=123;
			   insert build;
			   
			   Glxy_ProjectLocation__c  ll= new Glxy_ProjectLocation__c ();
			   ll.ProjectNumber__c=project.id;
			   ll.BuildingNumber__c=build.id;

			   insert ll;

			   system.assertNotEquals(NULL,ll);
			   
			   ApexPages.StandardController con = new ApexPages.StandardController(pi);
			   
			   GLXY_LPSRBuildingRelatedList rl= new GLXY_LPSRBuildingRelatedList(con);
  }
   
   
}