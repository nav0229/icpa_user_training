public with sharing class Glxy_LeaseAgencyRelatedList {
	
	Private final Glxy_Lease__c ObjLease;
	Public List<Glxy_LeaseAgencies__c> LeaseAgencies{get;set;}
	
	public Glxy_LeaseAgencyRelatedList(ApexPages.StandardController controller) {
		ObjLease = (Glxy_Lease__c)controller.getRecord();
	}
	
    public Glxy_LeaseAgencies__c[] GetLeaseAgencyRelatedListBase() {
       Glxy_Lease__c ObjLease = [select LeaseID__c from Glxy_Lease__c where id =:ObjLease.id];
	   LeaseAgencies = [select id, Name, ABCode__c, Agency_Bureau_Name__c, ASA__c, ASAIAAnnualRent__c, ASA_IASqFt__c, ASAID__c, ASANOAAnnualRent__c, ASA_NOASqFt__c, BaseStructuredParkingSpaces__c, BaseSurfaceParkingSpaces__c, SquareFeet__c from Glxy_LeaseAgencies__c Where LeaseNumber__c = :ObjLease.ID and ASA__c != null] ;
	   Return LeaseAgencies;
    }
    
    public Glxy_LeaseAgencies__c[] GetLeaseAgencyRelatedListREXUS() {
       Glxy_Lease__c ObjLease = [select LeaseID__c from Glxy_Lease__c where id =:ObjLease.id];
	   LeaseAgencies = [select id, Name, REXUSABCode__c, REXUSAgencyBureauName__c, REXUSASA__c, REXUSASAIAAnnualRent__c, REXUSASA_IASqFt__c, ASAID__c, REXUSASANOAAnnualRent__c, REXUSASA_NOASqFt__c, REXUSBaseStructuredParkingSpaces__c, REXUSBaseSurfaceParkingSpaces__c, REXUSSquareFeet__c from Glxy_LeaseAgencies__c Where LeaseNumber__c = :ObjLease.ID And REXUSASA__c != null] ;
	   Return LeaseAgencies;
    }
    
	@isTest static void Test_Glxy_LeaseAgencyRelatedList(){
		Glxy_Lease__c lease= new Glxy_Lease__c();
	   	lease.StatusCode__c = 'Active';
	   	Date myDate = date.newinstance(2012, 2, 17);
	   	Date myDate1 = date.newinstance(2013, 2, 17);
	   	lease.BaseLeaseEffectiveDate__c = myDate ;
	   	lease.ExpirationDateofLease__c = myDate1 ;
	   	lease.RegionCD__c = '3';
	   	lease.Total_NOA_Sq_feet__c = 1000;
	   	lease.Total_IA_Sq_feet__c = 1000;
	   	lease.BaseSquareFeet__c = 2000;
   		insert lease;
   		system.assertNotEquals(NULL,lease);
   		
	   	Glxy_LeaseAgencies__c pi = new Glxy_LeaseAgencies__c();
	   	pi.LeaseNumber__c=lease.id;
	   	pi.ASA__c = 'AB11';
	   	pi.SquareFeet__c = 100;
	   	insert pi;
	   	
	   	Glxy_LeaseAgencies__c pi2 = new Glxy_LeaseAgencies__c();
	   	pi2.LeaseNumber__c=lease.id;
	   	pi2.ASA__c = 'AB11';
	   	pi2.SquareFeet__c = 0;
	   	pi2.REXUSASA__c = 'ASA2';
	   	insert pi2;
   		
   		ApexPages.StandardController con = new ApexPages.StandardController(lease);
   		Glxy_LeaseAgencyRelatedList rl =  new Glxy_LeaseAgencyRelatedList(con);
   		List <Glxy_LeaseAgencies__c> reportResults1 = rl.GetLeaseAgencyRelatedListREXUS();
   		List <Glxy_LeaseAgencies__c> reportResults2 = rl.GetLeaseAgencyRelatedListBase();
   		
	}
    
    
}