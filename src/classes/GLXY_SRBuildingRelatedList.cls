public with sharing class GLXY_SRBuildingRelatedList {

 private final Glxy_StepRent__c SRObj;
 
 public List<Glxy_LeaseLocation__c> leaseLocations{get;set;}

    public GLXY_SRBuildingRelatedList(ApexPages.StandardController controller) {

       SRObj=(Glxy_StepRent__c)controller.getRecord();
       
       Glxy_StepRent__c objSR=[select LeaseNumber__c from Glxy_StepRent__c where id =:SRObj.id];
       leaseLocations=[select id, Name,BuildingNumber__c, BuildingNumber__r.Name, Building_Name_lkp__c, Building_Number_lkp__c, Address_lkp__c, City_lkp__c, State_lkp__c, Location_Code__c from Glxy_LeaseLocation__c where LeaseNumber__c=:objSR.LeaseNumber__c];



    }
    
    
@isTest static void Test_GLXY_SRBuildingRelatedList(){
  
			   Glxy_Lease__c lease= new Glxy_Lease__c();
			   lease.StatusCode__c='Active';
			   Date myDate = 
					date.newinstance(2012, 2, 17);
					 Date myDate1 = 
					date.newinstance(2013, 2, 17);
			   lease.BaseLeaseEffectiveDate__c=myDate ;
			   lease.ExpirationDateofLease__c=myDate1 ;
			   lease.RegionCD__c='3';
				lease.Total_NOA_Sq_feet__c=1000;
			   lease.Total_IA_Sq_feet__c=1000;
			   lease.BaseSquareFeet__c=2000;
			   
			   insert lease;
			   
			  Glxy_StepRent__c pi = new Glxy_StepRent__c();
			   pi.LeaseNumber__c=lease.id;
			   insert pi;
			   
			   PBS_Building__c build= new PBS_Building__c();
			   build.Location_Code_Plus__c='test';
			   build.Building_ID__c=123;
			   insert build;
			   
			   Glxy_LeaseLocation__c  ll= new Glxy_LeaseLocation__c ();
			   ll.LeaseNumber__c=lease.id;
			   ll.BuildingNumber__c=build.id;
			   
			   insert ll;
			   system.assertNotEquals(NULL,ll);
				ApexPages.StandardController con = new ApexPages.StandardController(pi);
			   
			   GLXY_SRBuildingRelatedList rl= new GLXY_SRBuildingRelatedList(con );
  }
}