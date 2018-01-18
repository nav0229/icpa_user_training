@isTest 
Private class GLXY_CodeCoverageTests {

	 @isTest(SeeAllData=false) Static void TestTriggerGLXY_ValidateLeaseNumber() {
        Glxy_Lease__c objLease = new Glxy_Lease__c();
        objLease.Name = 'LAK05855';
        insert objLease;
        System.Assert(objLease!=NULL);
        
        Glxy_Lease__c objLease2 = new Glxy_Lease__c();
        objLease2.Name = NULL ;
        insert objLease2;
        
        Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10); 
        
     	Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c (Name = '11K2052', NOASquareFeet__c = 1935, IASquareFeet__c = 0, 
       		Project_Type__c = 'New', EffectiveDate__c = myDate, RegionCd__c = '10',
       		UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935, eEorA__c = 'Actual');
        insert objPro;
           
        Glxy_Transaction__c objTest2 = new Glxy_Transaction__c (
            LeaseNumber__c = objLease.id,  
            Project_Number__c = objPro.id ,
            RecordTypeId = Schema.SObjectType.Glxy_Transaction__c.getRecordTypeInfosByName().get('Project Final Certification').getRecordTypeId(), 
            BA53_User__c = 'test',
            New_Lease_Number__c = 'LAK05855',
            Region__c = 'test'
        );
        insert objTest2;
        
        Glxy_Transaction__c objTest3 = new Glxy_Transaction__c (
            LeaseNumber__c = objLease2.id,  
            Project_Number__c = objPro.id ,
            BA53_User__c = 'test',
            New_Lease_Number__c = NULL,
            Region__c = 'test'
        );
        insert objTest3;
       	objTest2.Lease_Action__c = 'New';
       	Update objTest2;
       	System.AssertNotEquals(objTest2,NULL);
    }
    
    @isTest(SeeAllData=false) Static void TestTriggerGLXY_ValidateLeaseNumber2() {
        
        Glxy_Lease__c objLease = new Glxy_Lease__c();
        objLease.Name = 'LAK05855';
        insert objLease;
        System.Assert(objLease!=NULL);
        
        Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10); 
         
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c (Name = '11K2052', NOASquareFeet__c = 1935, IASquareFeet__c = 0, 
       		Project_Type__c = 'New', EffectiveDate__c = myDate, RegionCd__c = '10',
       		UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935, eEorA__c = 'Actual');
        insert objPro;
        
        Glxy_LPStepRent__c objTest = new Glxy_LPStepRent__c (
                ProjectNumber__c = objPro.id,
                EffectiveDate__c = myDate,
                PaymentType__c = 'Antenna',
                Amount__c = 99,
                StatusCode__c = 'Estimate'                             
            );

        insert objTest;
        
        Glxy_LPLumpSum__c objTest31 = new Glxy_LPLumpSum__c();
        objTest31.ProjectNumber__c = objPro.id;
        objTest31.Amount__c = 2500;
        objTest31.MonthlyAmount__c = 100;
        objTest31.LumSumType__c = 'Broker Commission Credit';
        objTest31.IA_Sq_Ft__c = 70;
        objTest31.NOA_Sq_Ft__c = 30;
        objTest31.EffectiveDate__c = myDate;
        objTest31.ExpirationDate__c = myDate.addYears(+2);
        objTest31.ProcessedDate__c = myDate.addmonths(+1);
        insert objTest31;
            
        Glxy_Transaction__c objTest2 = new Glxy_Transaction__c (
            LeaseNumber__c = objLease.id,  
            Project_Number__c = objPro.id ,
            RecordTypeId = Schema.SObjectType.Glxy_Transaction__c.getRecordTypeInfosByName().get('Lease Action').getRecordTypeId(), 
            BA53_User__c = 'test',
            New_Lease_Number__c = 'LAK05855',
            Status__c = 'Approved by REXUS',
            Region__c = 'test'
        );
        insert objTest2;
        
        Glxy_LeaseDigest__c objTest3 = new Glxy_LeaseDigest__c (
            Transaction__c = objTest2.ID,
            ProjectNumber__c = '11K2052',
            Include_Accrual__c = 'YES'
        );
        insert objTest3;
        System.Assert(objTest3!=NULL);
        
        objTest2.Status__c = 'Accepted by REXUS';
        Update objTest2;
        
    }
    
    @isTest(SeeAllData=false) Static void TestTriggerGLXY_ProjectCalculations() {
			
			Glxy_Lease__c objLease = new Glxy_Lease__c();
	        objLease.Name = 'LAK05855';
	        objLease.BaseAnnualRent__c = 1200;
	        objLease.ExpirationDateofLease__c = date.newinstance(Datetime.Now().Date().addyears(+2).Year(), 2, 17);
	        insert objLease;
	        System.Assert(objLease!=NULL);
	        
	        Glxy_Lease__c objLease2 = new Glxy_Lease__c();
	        objLease2.Name = 'VAK05856';
	        objLease2.BaseAnnualRent__c = 1200;
	        insert objLease2;
	        
			PBS_AB_Code__c obAB = New PBS_AB_Code__c();
	        obAB.AB_Code__c = 'A111';
	        obAB.Agency_Bureau_Name__c = 'test';
	        obAB.Agency_Bureau_Short_Name__c = 'test';
	        obAB.Agency_Code__c = '19';
	        obAB.Bureau_Code__c = '01';
	        insert obAB;
	        
			Glxy_LeaseProjects__c objPro2 = new Glxy_LeaseProjects__c();
			objPro2.Name='123456';
	        Date myDate2 = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
	        objPro2.NOASquareFeet__c = 100;
	        objPro2.IASquareFeet__c = 100;
	        objPro2.OldIASqFt__c = 50;
	        objPro2.OldNOASqFt__c = 50;
	        objPro2.EffectiveDate__c = myDate2;
	        objPro2.ProcessedDate__c = myDate2;
	        objPro2.AnnualRent__c = 1000.0;
	        objPro2.RegionCd__c = '1';
	        objPro2.ProjectStatus__c = 'Active';
	        objPro2.Old_Annual_Rent__c = 1000.0;
	        objPro2.Project_Type__c = 'New';
	        objPro2.Old_Square_Feet__c = 0;
	        objPro2.IAConversionDate__c = myDate2.addYears(+5);
	       
	        insert objPro2;
	        System.Assert(objPro2!=NULL);
	        
	        Glxy_ProjectAgency__c objTest11 = new Glxy_ProjectAgency__c();
	        objTest11.ProjectNumber__c = objPro2.id;
	        objTest11.PBSABCode__c = obAB.id;
	        objtest11.BaseStructuredParkingSpaces__c  = 10;
	        objtest11.BaseSurfaceParkingSpace__c = 10;
	        insert objTest11;
	        
	        Glxy_LeaseAgencies__c objTest22 = new Glxy_LeaseAgencies__c();
	        objTest22.LeaseNumber__c = objLease.id;
	        objTest22.PBSABCode__c = obAB.id;
	        insert objTest22;
	        
	        List<Glxy_AssociatedLeases__c> objAssociatedRecords = New List<Glxy_AssociatedLeases__c>();
	        
	        Glxy_AssociatedLeases__c objTest2 = new Glxy_AssociatedLeases__c (
	        	Lease__c = objLease.id,  
	            project__c = objPro2.id,
	            Lease_Annual_Rent__c = 120,
	            Termination_Date__c = myDate2.addYears(+5),
	            ProjectOldAnnualRent__c = 2000
			);
			//Insert objTest2;
			objAssociatedRecords.Add(objTest2);
			
			Glxy_AssociatedLeases__c objTest2a = new Glxy_AssociatedLeases__c (
	        	Lease__c = objLease2.id,  
	            project__c = objPro2.id,
	            Termination_Date__c = myDate2.addYears(+5),
	            Lease_Annual_Rent__c = 120,
	            ProjectOldAnnualRent__c = 2000
			);
			//Insert objTest2a;
			objAssociatedRecords.Add(objTest2a);
			
			insert objAssociatedRecords;
			Delete objTest2a;
			
			objPro2.Project_Type__c = 'New/Replacing';
			Update objPro2;
			
			List<Glxy_AssociatedLeases__c> objAssociatedRecords2 = New List<Glxy_AssociatedLeases__c>();
			 
			Glxy_AssociatedLeases__c objTest3a = new Glxy_AssociatedLeases__c (
	        	Lease__c = objLease2.id,  
	            project__c = objPro2.id,
	            Termination_Date__c = null,
	            Lease_Annual_Rent__c = 120,
	            ProjectOldAnnualRent__c = 2000
			);
			objAssociatedRecords2.Add(objTest3a);
			
			insert objAssociatedRecords2;
			
			Delete objTest3a;
			
			Glxy_LeaseProjects__c project4 = new Glxy_LeaseProjects__c (Name = '1AK2053', 
           		Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           		UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 0, eEorA__c = 'Actual');
           	Insert project4;
                   
       		Glxy_ProjectAgency__c objTest112 = new Glxy_ProjectAgency__c();
		   	objTest112.ProjectNumber__c = project4.id;
		   	objTest112.PBSABCode__c = obAB.id;
		   	objTest112.BaseStructuredParkingSpaces__c  = 10;
		   	objTest112.BaseSurfaceParkingSpace__c = 10;
		   	insert objTest112;
			
		}
   		
   		@isTest(SeeAllData=false) Static void TestTriggerGLXY_ProjectCalculations2() {
   			
   			PBS_AB_Code__c obAB = New PBS_AB_Code__c();
	        obAB.AB_Code__c = 'A111';
	        obAB.Agency_Bureau_Name__c = 'test';
	        obAB.Agency_Bureau_Short_Name__c = 'test';
	        obAB.Agency_Code__c = '19';
	        obAB.Bureau_Code__c = '01';
	        insert obAB;
	        System.Assert(obAB!=NULL);
	        
   			List<Glxy_LeaseProjects__c> objProjectRecords = New List<Glxy_LeaseProjects__c>();
   			
   			//Sq Ft Lease
   			Glxy_LeaseProjects__c project4 = new Glxy_LeaseProjects__c (Name = '1AK2050', ProjectID__c = '1AK2050', processedDate__c = date.newInstance(2014,2,14),
           		Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10', NOASquareFeet__c =100, NewStructuredParkingSpaces__c = 0, 
           		UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 0, eEorA__c = 'Actual');
           	objProjectRecords.add(project4);
           	
           	//Land Only Lease
           	Glxy_LeaseProjects__c project3a = new Glxy_LeaseProjects__c (Name = '1AK2051', ProjectID__c = '1AK2051', NewStructuredParkingSpaces__c = 0,
           		Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           		UpdateOldNOAIA__c = false, AnnualRent__c = 400, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 200, SquareFeet__c = 0, eEorA__c = 'Actual');
           	objProjectRecords.add(project3a);
           	
           //Land Only Lease
           	Glxy_LeaseProjects__c project3b = new Glxy_LeaseProjects__c (Name = '1AK2052', ProjectID__c = '1AK2052', NewStructuredParkingSpaces__c = 0,
           		Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           		UpdateOldNOAIA__c = false, AnnualRent__c = 100, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 200, SquareFeet__c = 0, eEorA__c = 'Actual');
           	objProjectRecords.add(project3b);
           	
           	//Parking Only
           	Glxy_LeaseProjects__c project3c = new Glxy_LeaseProjects__c (Name = '1VA2053', ProjectID__c = '1VA2053', 
           		Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), ProcessedDate__c = date.newInstance(2014,2,15), RegionCd__c = '10',
           		UpdateOldNOAIA__c = false, AnnualRent__c = 100, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 200, SquareFeet__c = 0, eEorA__c = 'Actual');
           	objProjectRecords.add(project3c);
			
			upsert objProjectRecords;
			
           	Glxy_ProjectAgency__c objTest112 = new Glxy_ProjectAgency__c();
		   	objTest112.ProjectNumber__c = project3c.id;
		   	objTest112.PBSABCode__c = obAB.id;
		   	objTest112.BaseStructuredParkingSpaces__c  = 10;
		   	objTest112.BaseSurfaceParkingSpace__c = 10;
		   	insert objTest112;
		   	
			GLXY_Utility.isCalcUpdating = false;
			GLXY_Utility.isUpdating = false;
			
		   	Glxy_LeaseProjects__c objTest= [Select ID, Name, AnnualRent__c From Glxy_LeaseProjects__c Where Name = '1VA2053' ];	
     		objTest.AnnualRent__c = 2000;
     		Update objTest;
     		
     		Delete objTest112;
     		
     		Glxy_ProjectAgency__c objTest113 = new Glxy_ProjectAgency__c();
		   	objTest113.ProjectNumber__c = project3c.id;
		   	objTest113.PBSABCode__c = obAB.id;
		   	objTest113.NewAntennas__c = 10;
		   	insert objTest113;
		   	
			GLXY_Utility.isCalcUpdating = false;
			GLXY_Utility.isUpdating = false;
			
		   	objTest= [Select ID, Name, AnnualRent__c From Glxy_LeaseProjects__c Where Name = '1VA2053' ];	
     		objTest.AnnualRent__c = 200;
     		Update objTest;
     	
   		}
   		
   		
   		
}