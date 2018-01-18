public with sharing class Glxy_extProjectStepRents {
	
	private final Glxy_LeaseDigest__c objRecord;
	public List<Glxy_LPStepRent__c> objProjectStepRents {get;set;}
	
	public Glxy_extProjectStepRents(ApexPages.StandardController controller) {
       objRecord = (Glxy_LeaseDigest__c) controller.getRecord();
       Glxy_LeaseDigest__c objRecordDetail = [select LeaseNumber__c From Glxy_LeaseDigest__c Where id =:objRecord.id];
       objProjectStepRents = [Select ID, Name, ProjectNumber__c, RegionCD__c, EffectiveDate__c, ExpirationDate__c, ProcessedDate__c, Amount__c, TeamCode__c 
       						 From 	Glxy_LPStepRent__c 
       						 Where 	ProjectNumber__r.NewLease__c = :objRecordDetail.LeaseNumber__c];
    }
	
	@isTest static void Glxy_extProjectStepRentsTest(){
	 	
	 	Date myDate =  date.newinstance(2012, 2, 17);
		Date myDate1 = date.newinstance(2013, 2, 17);
		
		Glxy_Lease__c objLease = new Glxy_Lease__c();
		objLease.Name = 'LDE00374';
		insert objLease;
		
  		Glxy_LeaseProjects__c project= new Glxy_LeaseProjects__c();
		project.ProjectStatus__c = 'Active';
		project.EffectiveDate__c = myDate ;
		project.RegionCd__c = '3';
		project.RexusNewNOASqFt__c = 1000;
		project.RexusNewIASqFt__c = 1000;
		Project.NewLease__c = 'LDE00374';
		insert project;
		system.assertNotEquals(NULL,project);
			   
	  	Glxy_LPStepRent__c SR = new Glxy_LPStepRent__c();
	   	SR.ProjectNumber__c = project.id;
	   	insert SR;
		system.assertNotEquals(NULL,SR);
		
		Glxy_Transaction__c objTransaction = new Glxy_Transaction__c (
            LeaseNumber__c = objLease.id,  
            Project_Number__c = project.id ,
            RecordTypeId = Schema.SObjectType.Glxy_Transaction__c.getRecordTypeInfosByName().get('Project Final Certification').getRecordTypeId(), 
            BA53_User__c = 'test',
            New_Lease_Number__c = 'LDE00374',
            Region__c = 'test'
    	);
        insert objTransaction;
        system.assertNotEquals(NULL,objTransaction);
        
        Glxy_LeaseDigest__c objDigest = new Glxy_LeaseDigest__c (
            Transaction__c = objTransaction.id,  
            LeaseNumber__c = 'LDE00374',
            DigestID__c = 1234567
    	);
        insert objDigest;
        system.assertNotEquals(NULL,objDigest);
	   	
	   	ApexPages.StandardController con = new ApexPages.StandardController(objDigest);
	  	Glxy_extProjectStepRents objPaymentLines = new Glxy_extProjectStepRents(con);
  }
  
}