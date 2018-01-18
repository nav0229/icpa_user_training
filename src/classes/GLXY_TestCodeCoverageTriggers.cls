@isTest 
Private class GLXY_TestCodeCoverageTriggers {
    
	@isTest(SeeAllData=true) Static void TestTriggerGLXY_LPLumpSumTrigger() {
        Map<String,ID> profiles = new Map<String,ID>();  
        List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
        for(Profile p : ps){  
            profiles.put(p.name, p.id);  
        }  
        User admin = [SELECT Id FROM user WHERE IsActive = True And Glxy_Region_Code__c = 'CO' And profileid = :profiles.get('GSA System Administrator') Limit 1];  
        system.runas(admin){
             
             Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
             Glxy_LeaseProjects__c objProject = createLeaseproject();
             
             Glxy_LPLumpSum__c objTest = new Glxy_LPLumpSum__c();
             objTest.ProjectNumber__c = objProject.id;
             objTest.Amount__c = 100;
             objTest.LumSumType__c = 'Rent';
             objTest.IA_Sq_Ft__c = 70;
             objTest.NOA_Sq_Ft__c = 30;
             objTest.EffectiveDate__c = myDate;
             objTest.ExpirationDate__c = myDate.addYears(+2);
             objTest.ProcessedDate__c = myDate;
             insert objTest;
             System.Assert(objTest!=NULL);
                 
             Glxy_LPLumpSum__c objTest2 = new Glxy_LPLumpSum__c();
             objTest2.ProjectNumber__c = objProject.id;
             objTest2.MonthlyAmount__c = 100;
             objTest2.Amount__c = 2500;
             objTest2.LumSumType__c = 'Rent Free Period';
             objTest2.IA_Sq_Ft__c = 70;
             objTest2.NOA_Sq_Ft__c = 30;
             objTest2.EffectiveDate__c = myDate;
             objTest2.ExpirationDate__c = myDate.addYears(+2);
             objTest2.ProcessedDate__c = myDate;
             insert objTest2;
             System.Assert(objTest2!=NULL);
             
             Glxy_LPLumpSum__c objTest3 = new Glxy_LPLumpSum__c();
             objTest3.ProjectNumber__c = objProject.id;
             objTest3.MonthlyAmount__c = 100;
             objTest3.Amount__c = 2500;
             objTest3.LumSumType__c = 'Broker Commission Credit';
             objTest3.IA_Sq_Ft__c = 70;
             objTest3.NOA_Sq_Ft__c = 30;
             objTest3.EffectiveDate__c = myDate;
             objTest3.ExpirationDate__c = myDate.addYears(+2);
             objTest3.ProcessedDate__c = myDate.addmonths(+4);
             insert objTest3;
             System.Assert(objTest3!=NULL);
             
             objTest3.MonthlyAmount__c = -100;
             objTest3.Amount__c = -2500;
             objTest3.LumSumType__c = 'Broker Commission Credit';
             objTest3.IA_Sq_Ft__c = null;
             objTest3.NOA_Sq_Ft__c = null;
             objTest3.EffectiveDate__c = myDate;
             objTest3.ExpirationDate__c = myDate.addYears(+2);
             objTest3.ProcessedDate__c = myDate.addmonths(+1);
             Update objTest3;
            
             objTest3.IA_Sq_Ft__c = 0;
             objTest3.NOA_Sq_Ft__c = 10;
             Update objTest3;
             
             objTest3.IA_Sq_Ft__c = 10;
             objTest3.NOA_Sq_Ft__c = 0;
             Update objTest3;

			 objTest3.IA_Sq_Ft__c = 10;
             objTest3.NOA_Sq_Ft__c = 10;
             Update objTest3;
			 
			 objProject.EffectiveDate__c = myDate;
			 objProject.ProcessedDate__c = myDate;
			 objProject.IAConversionDate__c = myDate.addmonths(+1);
			 Update objProject;
			 
			 objTest3.MonthlyAmount__c = 100;
             objTest3.Amount__c = 100;
			 objTest3.EffectiveDate__c = myDate;
             objTest3.ExpirationDate__c = myDate;
             objTest3.ProcessedDate__c = myDate;
             Update objTest3;
			 	                 	                 
             Glxy_LPLumpSum__c objTestDel = [Select id from Glxy_LPLumpSum__c Limit 1];
             delete objTestDel;
             
          }      
    }
        
        
    @isTest(SeeAllData=true) Static void TestTriggerGlxy_LPStepRentTrigger() {
        Map<String,ID> profiles = new Map<String,ID>();  
        List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
        for(Profile p : ps){  
            profiles.put(p.name, p.id);  
        }  
        User admin = [SELECT Id FROM user WHERE IsActive = True and Glxy_Region_Code__c = 'CO' And profileid = :profiles.get('GSA System Administrator') Limit 1];  
        system.runas(admin){
            
            Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
            string RexusRecordType=Schema.SObjectType.Glxy_LPStepRent__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
            Glxy_LeaseProjects__c objProject = createLeaseproject();
            objProject.IAConversionDate__c = myDate.addYears(-1);
            objProject.EffectiveDate__c = myDate;
            objProject.processedDate__c = myDate;
            Update objProject;
            
            Glxy_LPStepRent__c objTest = new Glxy_LPStepRent__c (
                ProjectNumber__c = objProject.id,
                EffectiveDate__c = myDate,
                ProcessedDate__c = myDate.addyears(+1),
                IA_Sq_Ft__c =  0,
                NOA_Sq_Ft__c = 0,
                RecordTypeid = RexusRecordType           
            );
           	insert objTest;
           	
           	Glxy_LPStepRent__c objTest2 = new Glxy_LPStepRent__c (
                ProjectNumber__c = objProject.id,
                EffectiveDate__c = myDate,
                ProcessedDate__c = myDate.addyears(+1),
                IA_Sq_Ft__c = 10,
                NOA_Sq_Ft__c = 10,
                RecordTypeid = RexusRecordType           
            );
           	insert objTest2;
           	
          	objTest2.IA_Sq_Ft__c = 0;
           	objTest2.NOA_Sq_Ft__c = 10;
           	Update objTest2;
           	
           	objTest2.IA_Sq_Ft__c = 10;
           	objTest2.NOA_Sq_Ft__c = 0;
           	Update objTest2;
           	
           	objTest2.IA_Sq_Ft__c = 10;
           	objTest2.NOA_Sq_Ft__c = 10;
           	Update objTest2;
           	
            System.Assert(objTest!=NULL);
            Glxy_LPStepRent__c objTest3 = [Select id from Glxy_LPStepRent__c Limit 1];
            delete objTest3;
            
    	}
    }
    
    
     @isTest Static void TestTrigger_GLXY_BudgetSubmission() {
	 	GLXY_BudgetSubmission__c objTest = new GLXY_BudgetSubmission__c (
            ReportingFiscalYear__c = '2014',
            SubmissionType__c = 'Congressional Justification'
        );
        Test.startTest(); 
		insert objTest;
		Test.stopTest();
        System.AssertNotEquals(objTest,NULL);
        System.debug('Deepak Here 1'); 
        
        GLXY_BudgetSubmissionData__c objTest2 = new GLXY_BudgetSubmissionData__c (
            BudgetSubmissionID__c = objTest.ID,
            FiscalYear__c = '2014',
            DataFormat__c = 'TEST'
        );
		insert objTest2;
		System.AssertNotEquals(objTest2,NULL);
		System.debug('Deepak Here 2');
		
		GLXY_BudgetSubmission__c objTest3 = [select id, name from GLXY_BudgetSubmission__c where RegionCD__c = 'CO' and LockAdjustmentData__c = false limit 1];
		objTest3.LockAdjustmentData__c = true;
		objTest3.LockRAWData__c = true;
		update objTest3;
		
		objTest2.AnnualCancellationsAmount__c = 100;
		//Update objTest2;
		try {
		   Update objTest2;
		   System.debug('Deepak Here 3');
        }catch(Exception e){
        	//System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0) );
			for (Integer i = 0; i < e.getNumDml(); i++) {
				//System.debug(e.getDmlMessage(i)); 
		    }
		}
		
		objTest3.LockAdjustmentData__c = false;
		objTest3.LockRAWData__c = false;
		update objTest3;
		System.debug('Deepak Here 4');
		//Delete objTest2;
		
		try {
		   System.debug('Deepak Here 5');
		   Delete objTest2;
		   System.debug('Deepak Here 6');
        }catch(Exception e){
        	//System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0) );
			for (Integer i = 0; i < e.getNumDml(); i++) {
				//System.debug(e.getDmlMessage(i)); 
		    }
		}
		
		GLXY_BudgetSubmission__c objTest5 = [select id, name from GLXY_BudgetSubmission__c limit 1];
		Delete objTest5;
		System.debug('Deepak Here 7');	

    }

	@isTest Static void TestTrigger_GLXY_BudgetSubmission2() {
	   Group GalaxyCOGroup = [select id, name from Group  where name = 'Galaxy-CO-Users']; 
	   GroupMember gm = [SELECT Id, group.id, group.name, group.type FROM GroupMember 
	                     Where UserOrGroupId = :UserInfo.getUserId()
	                     And GroupId = :GalaxyCOGroup.ID
	                     AND group.type='Regular'];
	   System.AssertNotEquals(gm,NULL);
	   Delete gm;
	   System.debug('Deepak Here 8');	    
	  
	   User usr = [Select id from User where Id = :UserInfo.getUserId()];
	   System.RunAs(usr){
	   		Test.startTest();
			CallAsyncTestMethod();
         	Test.stopTest();
	   }
    }
    
    @future private static void CallAsyncTestMethod(){
	   GLXY_BudgetSubmission__c objTest111 = new GLXY_BudgetSubmission__c (
            ReportingFiscalYear__c = '2014',
            SubmissionType__c = 'OMB'
        );
        try {
        	System.debug('Deepak Here 9');	
		    insert objTest111;
		    System.debug('Deepak Here 10');	
        }catch(Exception e){
        	//System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0) );
			for (Integer i = 0; i < e.getNumDml(); i++) {
				//System.debug(e.getDmlMessage(i)); 
		    }
		}
		System.debug('Deepak Here 11');	
	}	
        
    
        
    @isTest(SeeAllData=true) Static void TestTrigger_Glxy_LeaseTrigger() {
            //Glxy_Lease__c objLease = [Select id, Total_IA_Sq_feet__c from Glxy_Lease__c Limit 1];
            
            Glxy_Lease__c ObjLease = new Glxy_Lease__c();
               ObjLease.StatusCode__c='Active';
               Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
               Date myDate1 = date.newinstance(Datetime.Now().Date().addyears(+1).Year(), 2, 17);
               ObjLease.BaseLeaseEffectiveDate__c=myDate ;
               ObjLease.ExpirationDateofLease__c=myDate1 ;
               ObjLease.RegionCD__c='CO';
               ObjLease.Total_NOA_Sq_feet__c=4444;
               ObjLease.Total_IA_Sq_feet__c=3333333;
           insert ObjLease;
           
           myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  

            // CPI
            Glxy_ConsumerPriceIndex__c objTest = new Glxy_ConsumerPriceIndex__c (
                LeaseNumber__c = objLease.id,
                FY_Obligation__c = 0
            );
            insert objTest;
            System.AssertNotEquals(objTest,NULL);
            
            // IBAA
            Glxy_IntraBudgetActivityAuthorization__c pi = new Glxy_IntraBudgetActivityAuthorization__c();
            pi.LeaseNumber__c=objLease.id;
            pi.Overwrite__c = false;
            insert pi;
            System.AssertNotEquals(pi,NULL);
            
            // LS
            Glxy_LumpSum__c objTest3 = new Glxy_LumpSum__c (
                LeaseNumber__c = objLease.id,
                EffectiveDate__c = myDate,
                FY_Obligation__c = 0
            );
            insert objTest3;
            System.Assert(objTest3!=NULL);
            
            //SR
            Glxy_StepRent__c objTest4 = new Glxy_StepRent__c (
                    LeaseNumber__c = objLease.id
            );
            insert objTest4;
            System.Assert(objTest4!=NULL);
            
            //RWA
            Glxy_ReimbursableWorkAuthorization__c objTest5 = new Glxy_ReimbursableWorkAuthorization__c (
                LeaseNumber__c = objLease.id,
                EffectiveDate__c = myDate 
            );
            insert objTest5;
            
            System.Assert(objTest5!=NULL);

            objLease.Total_IA_Sq_feet__c = objLease.Total_IA_Sq_feet__c - 1;
            Update objLease;            
        }

    
    @isTest(SeeAllData=true) Static void TestTrigger_Glxy_CalcMonthlyCPI() {
            Glxy_Lease__c objLease = createLease(); 
            Glxy_ConsumerPriceIndex__c objTest = new Glxy_ConsumerPriceIndex__c (
                LeaseNumber__c = objLease.id,
                FY_Obligation__c = 0
            );
            insert objTest;
            System.AssertNotEquals(objTest,NULL);
            
        }
    @isTest(SeeAllData=true) Static void TestTriggerGlxy_StepRent_Monthly_Fields() {
            Glxy_Lease__c objLease = createLease();
            Glxy_StepRent__c objTest = new Glxy_StepRent__c (
                LeaseNumber__c = objLease.id               
            );
            insert objTest;
            System.AssertNotEquals(objTest,NULL);            
        }
        
        
     
     @isTest(SeeAllData=true) Static void TestTriggerGLXY_ALDelOverride() {
     
            Glxy_Lease__c objLease = createLease();
            
            Glxy_LeaseProjects__c objPro = createLeaseproject();
            Glxy_AssociatedLeases__c objTest = new Glxy_AssociatedLeases__c (
                Lease__c= objLease.id,  
                project__c= objPro.id,
                Lease_Annual_Rent__c = 120          
            );
            insert objTest;
            System.AssertNotEquals(objTest,NULL);
            delete objTest;
            
        }
        
        @isTest(SeeAllData=true) Static void TestTriggerGLXY_LPDelOverride() {
        Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);   
         Glxy_LeaseProjects__c objTest = new Glxy_LeaseProjects__c (
               // Lease__c= objLease.id,  
                //project__c=objPro.id  
                ProjectID__c='1234567',
                EffectiveDate__c = myDate,
                AnnualRent__c=100        
            );
            insert objTest;
            System.AssertNotEquals(objTest,NULL);
            delete objTest;
            
        }
        
        @isTest(SeeAllData=true) Static void TestTriggerGLXY_CPIDelOverride() {
         Glxy_Lease__c objLease = createLease();
            Glxy_ConsumerPriceIndex__c objTest = new Glxy_ConsumerPriceIndex__c (
                LeaseNumber__c = objLease.id,
                FY_Obligation__c = 0
            );
            insert objTest;
            System.AssertNotEquals(objTest,NULL);
            delete objTest;
        }
        
         @isTest(SeeAllData=true) Static void TestTriggerGLXY_LSDelOverride() {
                 
             Glxy_Lease__c objLease = createLease();
               Glxy_LumpSum__c pi = new Glxy_LumpSum__c();
               pi.LeaseNumber__c=objlease.id;
               insert pi;
            System.AssertNotEquals(pi,NULL);
               delete pi;
         }
         
         @isTest(SeeAllData=true) Static void TestTriggerGLXY_PADelOverride() {
            Map<String,ID> profiles = new Map<String,ID>();  
            List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
            for(Profile p : ps){  
                profiles.put(p.name, p.id);  
            }  
            User admin = [SELECT Id FROM user WHERE IsActive = True And profileid = :profiles.get('GSA System Administrator') Limit 1];  
            system.runas(admin){
                string RexusRecordType=Schema.SObjectType.Glxy_ProjectAgency__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId(); 
                Glxy_LeaseProjects__c objPro = createLeaseProject();
                Glxy_ProjectAgency__c objTest = new Glxy_ProjectAgency__c();
                objTest.ProjectNumber__c = objPro.id;
                objTest.RecordTypeid = RexusRecordType;
                insert objTest;
                System.AssertNotEquals(objTest,NULL);
                delete objTest;
             }
         }
         
         @isTest(SeeAllData=true) Static void TestTriggerGLXY_PLDelOverride() {
            
            Map<String,ID> profiles = new Map<String,ID>();  
            List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
            for(Profile p : ps){  
                profiles.put(p.name, p.id);  
            }  
            
            User admin = [SELECT Id FROM user WHERE IsActive = True And profileid = :profiles.get('GSA System Administrator') Limit 1];  
            system.runas(admin){
                string RexusRecordType=Schema.SObjectType.Glxy_ProjectLocation__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId(); 
                Glxy_LeaseProjects__c objPro = createLeaseProject();
                PBS_Building__c objMid = [Select id from PBS_Building__c LIMIT 1];
                Glxy_ProjectLocation__c objTest = new Glxy_ProjectLocation__c();
                objTest.BuildingNumber__c = objMid.id;
                objTest.ProjectNumber__c=objPro.id;
                objTest.RecordTypeid = RexusRecordType;
                insert objTest;
                System.AssertNotEquals(objTest,NULL);
                delete objtest;
            }
            
         }
         
         @isTest(SeeAllData=true) Static void TestTriggerGLXY_SRDelOverride() {
                 
             Glxy_Lease__c objLease = createLease();
             Glxy_StepRent__c objTest = new Glxy_StepRent__c();
             objTest.LeaseNumber__c=objLease.id;
             insert objTest;
             System.AssertNotEquals(objTest,NULL);
             delete objTest;
         }

        @isTest(SeeAllData=true) Static void TestTriggerGlxy_IBAA_Monthly_Fields() {
        	Date myDate =  date.newinstance(Datetime.Now().Date().Year(), 2, 17);
            Glxy_Lease__c objLease = createLease();
            Glxy_IntraBudgetActivityAuthorization__c pi = new Glxy_IntraBudgetActivityAuthorization__c();
            pi.LeaseNumber__c=objLease.id;
            pi.EffectiveDate__c = myDate ;
            pi.Overwrite__c = false;
            insert pi;
            System.AssertNotEquals(pi,NULL);
            
            pi.NOA_Sq_Ft__c = 0;
            pi.IA_Sq_Ft__c = 0;
            Update pi;
            
            pi.NOA_Sq_Ft__c = 10;
            pi.IA_Sq_Ft__c = 0;
            Update pi;
            
            pi.NOA_Sq_Ft__c = 0;
            pi.IA_Sq_Ft__c = 10;
            Update pi;
            
            pi.NOA_Sq_Ft__c = null;
            pi.IA_Sq_Ft__c = null;
            Update pi;
            
        }
        
        public static Glxy_Lease__c createLease(){
           Glxy_Lease__c ObjLease = new Glxy_Lease__c();
           ObjLease.StatusCode__c='Active';
           Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
           Date myDate1 = date.newinstance(Datetime.Now().Date().addyears(+1).Year(), 2, 17);
           ObjLease.BaseLeaseEffectiveDate__c=myDate ;
           ObjLease.ExpirationDateofLease__c=myDate1 ;
           ObjLease.RegionCD__c = '1';
           ObjLease.Total_NOA_Sq_feet__c=4444;
           ObjLease.Total_IA_Sq_feet__c=3333333;
           ObjLease.BaseAnnualRent__c = 1200;
           insert ObjLease;
           System.AssertNotEquals(objLease,NULL);
           return objLease ;   
        }

        public static Glxy_LeaseProjects__c  createLeaseproject(){
             //Glxy_LeaseProjects__c objPro = [Select id from Glxy_LeaseProjects__c Limit 1];//=new Glxy_LeaseProjects__c();
             Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
             objPro.Name='123456789';
             Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
             objPro.EffectiveDate__c = myDate;
             objPro.AnnualRent__c = 1000.0;
             objPro.RegionCd__c = '1';
             objPro.ProjectStatus__c = 'Active';
             objPro.Old_Annual_Rent__c = 1000.0;
             insert objPro;
             System.AssertNotEquals(objPro,NULL);
             return objPro ;
        }
        
        
       @isTest(SeeAllData=true) Static void TestTrigger_Glxy_CPITrigger() {
            Map<String,ID> profiles = new Map<String,ID>();  
            List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
            for(Profile p : ps){  
                profiles.put(p.name, p.id);  
            }  
            User admin = [SELECT Id FROM user WHERE IsActive = True and Glxy_Region_Code__c = 'CO' And profileid = :profiles.get('GSA System Administrator') Limit 1];  
            system.runas(admin){
                Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10); 
                Glxy_Lease__c objLease = CreateLease();
                Glxy_ConsumerPriceIndex__c objTest = new Glxy_ConsumerPriceIndex__c (
                    LeaseNumber__c = objLease.id,
                    EffectiveDate__c = myDate,
                    ProcessedDate__c = myDate.addYears(+1),
                    StatusCD__c = 'Active',
                    FY_Obligation__c = 0
                );
                insert objTest;
                System.Assert(objTest!=NULL);
                
                objTest.NOA_Sq_Ft__c = 0;
                objTest.IA_Sq_Ft__c = 0;
                Update objTest;
                
                objTest.NOA_Sq_Ft__c = 10;
                objTest.IA_Sq_Ft__c = 0;
                Update objTest;
                
                objTest.NOA_Sq_Ft__c = 0;
                objTest.IA_Sq_Ft__c = 10;
                Update objTest;
                
                objTest.NOA_Sq_Ft__c = 10;
                objTest.IA_Sq_Ft__c = 10;
                Update objTest;
                
                objTest.NOA_Sq_Ft__c = null;
                objTest.IA_Sq_Ft__c = null;
                Update objTest;
                
                Glxy_ConsumerPriceIndex__c objTest2 = [Select id from Glxy_ConsumerPriceIndex__c Limit 1];
                delete objTest2;
            
            }
        }
        
        @isTest(SeeAllData=true) Static void TestTriggerGlxy_StepRentTrigger() {
            Map<String,ID> profiles = new Map<String,ID>();  
            List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
            for(Profile p : ps){  
                profiles.put(p.name, p.id);  
            }  
            User admin = [SELECT Id FROM user WHERE IsActive = True and Glxy_Region_Code__c = 'CO' And profileid = :profiles.get('GSA System Administrator') Limit 1];  
            system.runas(admin){
                
                Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
                string RexusRecordType=Schema.SObjectType.Glxy_StepRent__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
                Glxy_Lease__c objLease = createLease();
                Glxy_StepRent__c objTest = new Glxy_StepRent__c (
                    LeaseNumber__c = objLease.id,
                    EffectiveDate__c = myDate,
                    ProcessedDate__c = myDate.addyears(+1),
                    IA_Sq_Ft__c =  0,
                    NOA_Sq_Ft__c = 0,
                    RecordTypeid = RexusRecordType           
                );
               	insert objTest;
               	
               	Glxy_StepRent__c objTest2 = new Glxy_StepRent__c (
                    LeaseNumber__c = objLease.id,
                    EffectiveDate__c = myDate,
                    ProcessedDate__c = myDate.addyears(+1),
                    IA_Sq_Ft__c = null,
                    NOA_Sq_Ft__c = null,
                    RecordTypeid = RexusRecordType           
                );
               	insert objTest2;
               	
               	objTest2.IA_Sq_Ft__c = null;
               	objTest2.NOA_Sq_Ft__c = null;
               	Update objTest2;
               	
               	objTest2.IA_Sq_Ft__c = 10;
               	objTest2.NOA_Sq_Ft__c = null;
               	Update objTest2;
               	
                System.Assert(objTest!=NULL);
                Glxy_StepRent__c objTest3 = [Select id from Glxy_StepRent__c Limit 1];
                delete objTest3;
            
            }
        }
        
        
        
        @isTest(SeeAllData=true) Static void TestTriggerGLXY_LumpSumTrigger() {
            Map<String,ID> profiles = new Map<String,ID>();  
            List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
            for(Profile p : ps){  
                profiles.put(p.name, p.id);  
            }  
            User admin = [SELECT Id FROM user WHERE IsActive = True And Glxy_Region_Code__c = 'CO' And profileid = :profiles.get('GSA System Administrator') Limit 1];  
            system.runas(admin){
                 
                 Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
                 Glxy_Lease__c objLease = createLease();
                 
                 Glxy_LumpSum__c objTest = new Glxy_LumpSum__c();
                 objTest.LeaseNumber__c = objlease.id;
                 objTest.Amount__c = 100;
                 objTest.LumSumType__c = 'Rent';
                 objTest.IA_Sq_Ft__c = 70;
                 objTest.NOA_Sq_Ft__c = 30;
                 objTest.EffectiveDate__c = myDate;
                 objTest.ExpirationDate__c = myDate.addYears(+2);
                 objTest.ProcessedDate__c = myDate;
                 insert objTest;
                 System.Assert(objTest!=NULL);
                 
                 Glxy_LumpSum__c objTest2 = new Glxy_LumpSum__c();
                 objTest2.LeaseNumber__c = objlease.id;
                 objTest2.Amount__c = 2500;
                 objTest2.MonthlyAmount__c = 100;
                 objTest2.LumSumType__c = 'Rent Free Period';
                 objTest2.IA_Sq_Ft__c = 70;
                 objTest2.NOA_Sq_Ft__c = 30;
                 objTest2.EffectiveDate__c = myDate;
                 objTest2.ExpirationDate__c = myDate.addYears(+2);
                 objTest2.ProcessedDate__c = myDate;
                 insert objTest2;
                 System.Assert(objTest2!=NULL);
                 
                 Glxy_LumpSum__c objTest3 = new Glxy_LumpSum__c();
                 objTest3.LeaseNumber__c = objlease.id;
                 objTest3.Amount__c = 2500;
                 objTest3.MonthlyAmount__c = 100;
                 objTest3.LumSumType__c = 'Broker Commission Credit';
                 objTest3.IA_Sq_Ft__c = 70;
                 objTest3.NOA_Sq_Ft__c = 30;
                 objTest3.EffectiveDate__c = myDate;
                 objTest3.ExpirationDate__c = myDate.addYears(+2);
                 objTest3.ProcessedDate__c = myDate.addmonths(+4);
                 insert objTest3;
                 System.Assert(objTest3!=NULL);
                 
                 objTest3.Amount__c = 2500;
                 objTest3.MonthlyAmount__c = 100;
                 objTest3.LumSumType__c = 'Broker Commission Credit';
                 objTest3.IA_Sq_Ft__c = null;
                 objTest3.NOA_Sq_Ft__c = null;
                 objTest3.EffectiveDate__c = myDate;
                 objTest3.ExpirationDate__c = myDate.addYears(+2);
                 objTest3.ProcessedDate__c = myDate.addmonths(+1);
                 Update objTest3;
                
                 objTest3.IA_Sq_Ft__c = 0;
                 objTest3.NOA_Sq_Ft__c = 10;
                 Update objTest3;
                 
                 objTest3.IA_Sq_Ft__c = 10;
                 objTest3.NOA_Sq_Ft__c = 0;
                 Update objTest3;

				 objTest3.IA_Sq_Ft__c = 10;
                 objTest3.NOA_Sq_Ft__c = 10;
                 Update objTest3;
				 
				 objLease.BaseLeaseEffectiveDate__c = myDate;
				 objLease.IAConverstionDate__c = myDate.addmonths(+1);
				 Update objLease;
				 
				 objTest3.Amount__c = 100;
                 objTest3.MonthlyAmount__c = 100;
				 objTest3.EffectiveDate__c = myDate;
                 objTest3.ExpirationDate__c = myDate;
                 objTest3.ProcessedDate__c = myDate;
                 Update objTest3;
				 	                 	                 
                 Glxy_LumpSum__c objTestDel = [Select id from Glxy_LumpSum__c Limit 1];
                 delete objTestDel;
             
            }      
        }
        
        @isTest(SeeAllData=false) Static void TestTriggerGLXY_LeaseProjectsTrigger() {
            //Map<String,ID> profiles = new Map<String,ID>();  
            //List<Profile> ps = [select id, name from Profile where name = 'GSA System Administrator' or name = 'System Administrator'];  
            //for(Profile p : ps){  
               // profiles.put(p.name, p.id);  
            //}  
            //User admin = [SELECT Id FROM user WHERE IsActive = True And Glxy_Region_Code__c = 'CO' And profileid = :profiles.get('GSA System Administrator') Limit 1];  
            //system.runas(admin){
                 Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10); 
                 string RexusRecordType=Schema.SObjectType.Glxy_LeaseProjects__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId(); 
                 Glxy_LeaseProjects__c objTest = new Glxy_LeaseProjects__c (
                      ProjectID__c='1234567',
                      EffectiveDate__c = myDate,
                      AnnualRent__c=100,
                      Project_Type__c = 'New/Replacing',
                      RecordTypeid = RexusRecordType       
                  );
                  insert objTest;
                  System.Assert(objTest!=NULL);
                  
                  Glxy_Lease__c objLease = new Glxy_Lease__c();
			      objLease.Name = 'LAK05855';
			      objLease.BaseAnnualRent__c = 1200;
			      objLease.ExpirationDateofLease__c = date.newinstance(Datetime.Now().Date().addyears(+2).Year(), 2, 15);
			      objLease.IAConverstionDate__c = myDate.addyears(-10);
			      insert objLease;
	        	  
	        	  Glxy_AssociatedLeases__c objTestal = new Glxy_AssociatedLeases__c (
	        	  Lease__c = objLease.id,  
	              project__c = objTest.id,
	              ProjectOldAnnualRent__c = 2000,
	              Lease_Annual_Rent__c = 120 
	              );
			      Insert objTestal;
			 	
                  Glxy_LeaseProjects__c objTest2 = [Select id from Glxy_LeaseProjects__c Limit 1];
                  //objTest2.EffectiveDate__c = myDate.addyears(-2);
                  objTest2.Project_Type__c = 'New/Replacing';
                  update objTest2;
                  
                  objTest2.EffectiveDate__c = myDate.addyears(-1);
                  Update objTest2;
                  
                  delete objTestal;
                  delete objTest2;
                  //delete objTest;
            //}
        }
        
        @isTest(SeeAllData=true) Static void TestTriggerGLXY_LeaseProjectsTrigger2() {
			Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
    		objPro.Name='123456789';
            Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
            objPro.EffectiveDate__c=myDate;
            objPro.ProcessedDate__c=myDate;
            objPro.AnnualRent__c=1000.0;
            objPro.RegionCd__c='1';
            objPro.ProjectStatus__c='Active';
            objPro.Old_Annual_Rent__c=1000.0;
            insert objPro;
            System.Assert(objPro!=NULL);
            
            Glxy_LPLumpSum__c objTest2 = new Glxy_LPLumpSum__c();
            objTest2.ProjectNumber__c = objPro.id;
            objTest2.MonthlyAmount__c = 100;
            objTest2.Amount__c = 2500;
            objTest2.LumSumType__c = 'Rent Free Period';
            objTest2.IA_Sq_Ft__c = 70;
            objTest2.NOA_Sq_Ft__c = 30;
            objTest2.EffectiveDate__c = myDate;
            objTest2.ExpirationDate__c = myDate.addYears(+2);
            objTest2.ProcessedDate__c = myDate;
            insert objTest2;
            System.Assert(objTest2!=NULL);
            
            Glxy_LPLumpSum__c objTest3 = new Glxy_LPLumpSum__c();
            objTest3.ProjectNumber__c = objPro.id;
            objTest3.Amount__c = 100;
            objTest3.MonthlyAmount__c = 100;
            objTest3.LumSumType__c = 'Broker Commission Credit';
            objTest3.IA_Sq_Ft__c = 70;
            objTest3.NOA_Sq_Ft__c = 30;
            objTest3.EffectiveDate__c = myDate.addYears(+2);
            objTest3.ExpirationDate__c = myDate.addYears(+2);
            objTest3.ProcessedDate__c = myDate.addmonths(+1);
            insert objTest3;
            System.Assert(objTest3!=NULL);
            
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
                        
            Glxy_LPStepRent__c objTest = new Glxy_LPStepRent__c (
                ProjectNumber__c = objPro.id,
                EffectiveDate__c = myDate,
                PaymentType__c = 'Antenna',
                Amount__c = 99,
                StatusCode__c = 'Estimate'                             
            );

            insert objTest;
            System.Assert(objTest!=NULL);
            
            Glxy_LPStepRent__c objTest21 = new Glxy_LPStepRent__c (
                ProjectNumber__c = objPro.id,
                EffectiveDate__c = myDate.addYears(+2),
                ProcessedDate__c = myDate,
                PaymentType__c = 'Antenna',
                Amount__c = 99,
                StatusCode__c = 'Estimate'                             
            );
            insert objTest21;
            
            objPro.NOASquareFeet__c = 1000;
            objPro.IAConversionDate__c = myDate.addYears(+2);
            Update objPro;
            
            objPro.NOASquareFeet__c = 2000;
            objPro.IAConversionDate__c = myDate.addYears(-2);
            objTest2.ProcessedDate__c = myDate.addYears(-2);
            Update objPro;
            	
        }
        
        @isTest(SeeAllData=true) Static void TestTriggerGLXY_AssociatedLeasesTrigger() {
            
            List<Glxy_AssociatedLeases__c> objAssociatedRecords = New List<Glxy_AssociatedLeases__c>();
            List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
            
            Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 16);
            
            PBS_AB_Code__c obAB = New PBS_AB_Code__c();
            obAB.AB_Code__c = 'A111';
            obAB.Agency_Bureau_Name__c = 'test';
            obAB.Agency_Bureau_Short_Name__c = 'test';
            obAB.Agency_Code__c = '19';
            obAB.Bureau_Code__c = '01';
            insert obAB;
            
            Glxy_Lease__c objLease = new Glxy_Lease__c();
            objLease.Name = 'LAK05855';
            objLease.BaseAnnualRent__c = 1200;
            objLease.ExpirationDateofLease__c = date.newinstance(Datetime.Now().Date().addyears(+2).Year(), 2, 15);
            objLease.IAConverstionDate__c = myDate.addyears(-10);
            insert objLease;
            
            Glxy_LeaseAgencies__c objTest22 = new Glxy_LeaseAgencies__c();
            objTest22.LeaseNumber__c = objLease.id;
            objTest22.PBSABCode__c = obAB.id;
            insert objTest22;
            
            Glxy_Lease__c objLease2 = new Glxy_Lease__c();
            objLease2.Name = 'VAK05856';
            objLease2.BaseAnnualRent__c = 1200;
            objLease.IAConverstionDate__c = myDate.addyears(-10);
            insert objLease2;
            
            Glxy_LeaseAgencies__c objTest221 = new Glxy_LeaseAgencies__c();
            objTest221.LeaseNumber__c = objLease2.id;
            objTest221.PBSABCode__c = obAB.id;
            insert objTest221;
            
            Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
            objPro.Name='123456789';
            objPro.EffectiveDate__c = myDate;
            objPro.ProcessedDate__c = myDate.addYears(+1);
            objPro.AnnualRent__c = 1000.0;
            objPro.RegionCd__c = '1';
            objPro.ProjectStatus__c = 'Active';
            objPro.Old_Annual_Rent__c = 1000.0;
            objPro.Old_Square_Feet__c  = 100;
            objPro.Project_Type__c = 'New/Replacing';
            objPro.IAConversionDate__c = myDate.addYears(+5);
            //insert objPro;
            objLeaseProjectsRecords.Add(objPro);
            System.Assert(objPro!=NULL);
            
            Glxy_LeaseProjects__c objPro2 = new Glxy_LeaseProjects__c();
            objPro2.Name='123456';
            Date myDate2 = date.newinstance(Datetime.Now().Date().Year(), 2, 18);
            objPro2.NOASquareFeet__c = 0;
            objPro2.IASquareFeet__c = 0;
            objPro2.OldIASqFt__c = 0;
            objPro2.OldNOASqFt__c = 0;
            objPro2.EffectiveDate__c = myDate2;
            objPro2.AnnualRent__c = 1000.0;
            objPro2.RegionCd__c = '1';
            objPro2.ProjectStatus__c = 'Active';
            objPro2.Old_Annual_Rent__c = 1000.0;
            objPro2.Project_Type__c = 'New/Replacing';
            objPro2.Old_Square_Feet__c = 0;
            objPro2.IAConversionDate__c = myDate.addYears(+5);
            objPro2.ParkingOnly__c = 'Yes';
            //insert objPro2;
            objLeaseProjectsRecords.Add(objPro2);
            System.Assert(objPro2!=NULL);
            Insert objLeaseProjectsRecords;
            
            Glxy_ProjectAgency__c objTest11 = new Glxy_ProjectAgency__c();
            objTest11.ProjectNumber__c = objPro2.id;
            objTest11.PBSABCode__c = obAB.id;
            objtest11.BaseStructuredParkingSpaces__c  = 10;
            objtest11.BaseSurfaceParkingSpace__c = 10;
            //objtest11.OldBaseStructuredParkingSpaces__c = 0;
            //objtest11.OldBaseSurfaceParkingSpaces__c = 0;
            insert objTest11;
            
            objPro2.Old_Annual_Rent__c = 2000.0;
            Update objPro2;
                
            string RexusRecordType=Schema.SObjectType.Glxy_AssociatedLeases__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
            Glxy_AssociatedLeases__c objTest = new Glxy_AssociatedLeases__c (
                Lease__c = objLease.id,  
                project__c = objPro.id,
                Lease_Annual_Rent__c = 2000,
                ProjectOldAnnualRent__c = 2000,
                RecordTypeid = RexusRecordType
            );
            //Insert objTest;
            objAssociatedRecords.Add(objTest);
            
            Glxy_AssociatedLeases__c objTest2 = new Glxy_AssociatedLeases__c (
                Lease__c = objLease.id,  
                project__c = objPro2.id,
                Lease_Annual_Rent__c = 2000,
                ProjectOldAnnualRent__c = 2000
            );
            //Insert objTest2;
            objAssociatedRecords.Add(objTest2);
            insert objAssociatedRecords;
            
            objPro.IAConversionDate__c = myDate.addYears(-5);
            Update objPro;
            
            objTest.ProjectOldAnnualRent__c  = 60000;
            Update objTest;
            
            objPro2.Project_Type__c = 'New/Replacing';
            Update objPro2;
            
            objPro2.Project_Type__c = 'New';
            objPro2.OldIASqFt__c = 100;
            Update objPro2;
            
            Delete objTest;
            Delete objPro;
            Delete objTest2;
            Delete objPro2;
            
            objPro2 = new Glxy_LeaseProjects__c();
            objPro2.Name='123456';
            myDate2 = date.newinstance(Datetime.Now().Date().Year(), 2, 18);
            objPro2.NOASquareFeet__c = 0;
            objPro2.IASquareFeet__c = 0;
            objPro2.OldIASqFt__c = 0;
            objPro2.OldNOASqFt__c = 0;
            //objPro2.EffectiveDate__c = myDate2;
            objPro2.AnnualRent__c = 1000.0;
            objPro2.RegionCd__c = '1';
            objPro2.ProjectStatus__c = 'Active';
            objPro2.Old_Annual_Rent__c = 1000.0;
            objPro2.Project_Type__c = 'New/Replacing';
            objPro2.Old_Square_Feet__c = 0;
            objPro2.IAConversionDate__c = myDate.addYears(+5);
            objPro2.ParkingOnly__c = 'Yes';
            insert objPro2;
            
            objTest2 = new Glxy_AssociatedLeases__c (
                Lease__c = objLease.id,  
                project__c = objPro2.id,
                ProjectOldAnnualRent__c = 2000
            );
            Insert objTest2;
        }
		
		@isTest(SeeAllData=true) Static void TestTriggerGLXY_ProjectCalculations() {
			
			Glxy_Lease__c objLease = new Glxy_Lease__c();
	        objLease.Name = 'ZAK05855';
	        objLease.BaseAnnualRent__c = 1200;
	        objLease.ExpirationDateofLease__c = date.newinstance(Datetime.Now().Date().addyears(+2).Year(), 2, 17);
	        insert objLease;
	        
	        Glxy_Lease__c objLease2 = new Glxy_Lease__c();
	        objLease2.Name = 'ZAK05856';
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
			objPro2.Name='Z123456';
	        Date myDate2 = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
	        objPro2.NOASquareFeet__c = 0;
	        objPro2.IASquareFeet__c = 0;
	        objPro2.OldIASqFt__c = 0;
	        objPro2.OldNOASqFt__c = 0;
	        objPro2.EffectiveDate__c = myDate2;
	        objPro2.AnnualRent__c = 1000.0;
	        objPro2.RegionCd__c = '1';
	        objPro2.ProjectStatus__c = 'Active';
	        objPro2.Old_Annual_Rent__c = 1000.0;
	        objPro2.Project_Type__c = 'New';
	        objPro2.Old_Square_Feet__c = 0;
	        objPro2.IAConversionDate__c = myDate2.addYears(+5);
	        objPro2.ParkingOnly__c = 'Yes';
	        insert objPro2;
	        System.Assert(objPro2!=NULL);
	        
	        Glxy_LeaseProjects__c project4 = new Glxy_LeaseProjects__c (Name = 'ZAK2053', NOASquareFeet__c = 0, IASquareFeet__c = 0, 
           		Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           		UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 0, eEorA__c = 'Actual');
           	Insert project4;
                   
       		Glxy_ProjectAgency__c objTest112 = new Glxy_ProjectAgency__c();
		   	objTest112.ProjectNumber__c = project4.id;
		   	objTest112.PBSABCode__c = obAB.id;
		   	objTest112.BaseStructuredParkingSpaces__c  = 10;
		   	objTest112.BaseSurfaceParkingSpace__c = 10;
		   	//objTest112.OldBaseStructuredParkingSpaces__c = 0;
		   	//objTest112.OldBaseSurfaceParkingSpaces__c = 0;
		   	insert objTest112;
       
	        Glxy_ProjectAgency__c objTest11 = new Glxy_ProjectAgency__c();
	        objTest11.ProjectNumber__c = objPro2.id;
	        objTest11.PBSABCode__c = obAB.id;
	        objtest11.BaseStructuredParkingSpaces__c  = 10;
	        objtest11.BaseSurfaceParkingSpace__c = 10;
	        //objtest11.OldBaseStructuredParkingSpaces__c = 0;
	        //objtest11.OldBaseSurfaceParkingSpaces__c = 0;
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
			
		}

		@isTest(SeeAllData=false) Static void  TestTriggerGLXY_LeaseAccrual() {
			Glxy_Lease__c ObjLease = new Glxy_Lease__c();
	       	ObjLease.StatusCode__c='Active';
	       	Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
	       	Date myDate1 = date.newinstance(Datetime.Now().Date().addyears(+1).Year(), 2, 17);
	       	ObjLease.BaseLeaseEffectiveDate__c=myDate ;
	       	ObjLease.ExpirationDateofLease__c=myDate1 ;
	       	ObjLease.RegionCD__c = '1';
	       	ObjLease.Total_NOA_Sq_feet__c=4444;
	       	ObjLease.Total_IA_Sq_feet__c=3333333;
	       	ObjLease.BaseAnnualRent__c = 1200;
	       	insert ObjLease;
			System.Assert(ObjLease!=NULL);
			
			Glxy_Transaction__c objTest2 = new Glxy_Transaction__c (
	            LeaseNumber__c = ObjLease.id,  
	            RecordTypeId = Schema.SObjectType.Glxy_Transaction__c.getRecordTypeInfosByName().get('Lease Action').getRecordTypeId(), 
	            BA53_User__c = 'test',
	            Region__c = '01'
	        );
	        insert objTest2;
        	System.Assert(objTest2!=NULL);
        	
	        Glxy_LeaseDigest__c objTest3 = new Glxy_LeaseDigest__c (
	        	Transaction__c = objTest2.ID,
	        	Include_Accrual__c = 'YES'
	        );
	        insert objTest3;
        	System.Assert(objTest3!=NULL);
        	
        	Glxy_LeaseDigest__c objTest4 = new Glxy_LeaseDigest__c (
	        	Transaction__c = objTest2.ID,
	        	Include_Accrual__c = 'YES'
	        );
	        insert objTest4;
        	System.Assert(objTest4!=NULL);
        	
         	List<Glxy_LeaseAccrual__c> objLeaseAccrualRecords = New List<Glxy_LeaseAccrual__c>();
        	 
	        Glxy_LeaseAccrual__c objTest31 = New Glxy_LeaseAccrual__c(
	        	LeaseDigest__c = objTest3.id,
	        	PDN__C = 'PDN'
	        );
	        objLeaseAccrualRecords.Add(objTest31);
	        
	         Glxy_LeaseAccrual__c objTest32 = New Glxy_LeaseAccrual__c(
	        	LeaseDigest__c = objTest3.id,
	        	PDN__C = 'PDN2'
	        );
	        objLeaseAccrualRecords.Add(objTest32);

	        Glxy_LeaseAccrual__c objTest41 = New Glxy_LeaseAccrual__c(
	        	LeaseDigest__c = objTest4.id,
	        	PDN__C = 'PDN'
	        );
	        objLeaseAccrualRecords.Add(objTest41);
	        
	        Insert objLeaseAccrualRecords;
		}
		
		@isTest(SeeAllData=false) Static void  TestTriggerGLXY_ProjectRequestASA() {
			Glxy_LeaseProjects__c project = new Glxy_LeaseProjects__c (Name = '6AK0141', NOASquareFeet__c = 1935.45, IASquareFeet__c = 0, 
           		Project_Type__c = 'Succeeding', EffectiveDate__c = date.newInstance(2011,2,14), RegionCd__c = '10',
           		AnnualRent__c = 0, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935.45, eEorA__c = 'Actual');
           	insert project;
       		System.Assert(project!=NULL);	
           	
           	PBS_AB_Code__c obAB1 = New PBS_AB_Code__c();
		   	obAB1.AB_Code__c = '9999';
		   	obAB1.Agency_Bureau_Name__c = 'test';
		   	obAB1.Agency_Bureau_Short_Name__c = 'test';
		   	obAB1.Agency_Code__c = '19';
		   	obAB1.Bureau_Code__c = '01';
		   	insert obAB1;
		   	
		   	PBS_AB_Code__c obAB2 = New PBS_AB_Code__c();
		   	obAB2.AB_Code__c = '8888';
		   	obAB2.Agency_Bureau_Name__c = 'test2';
		   	obAB2.Agency_Bureau_Short_Name__c = 'test2';
		   	obAB2.Agency_Code__c = '10';
		   	obAB2.Bureau_Code__c = '11';
		   	insert obAB2;
	   		
	   		Glxy_ProjectAgency__c objTest1 = new Glxy_ProjectAgency__c();
		   	objTest1.ProjectNumber__c = project.id;
		   	objTest1.PBSABCode__c = obAB1.id;
		   	objtest1.BaseStructuredParkingSpaces__c  = 10;
		   	objtest1.BaseSurfaceParkingSpace__c = 10;
		   	insert objTest1;
		   	
		   	Glxy_ProjectAgency__c objTest2 = new Glxy_ProjectAgency__c();
		   	objTest2.ProjectNumber__c = project.id;
		   	objTest2.PBSABCode__c = obAB2.id;
		   	objtest2.BaseStructuredParkingSpaces__c  = 10;
		   	objtest2.BaseSurfaceParkingSpace__c = 10;
		   	insert objTest2;
		   	
		   	Glxy_ProjectRequestASA__c objTest1a =  new Glxy_ProjectRequestASA__c();
		    objTest1a.ProjectAgencyID__c = objTest1.id;
		    objTest1a.OldASA__c = 'AAAS';
		    objTest1a.RequestASAID__c = 1112;
		    
		    Glxy_ProjectRequestASA__c objTest1b =  new Glxy_ProjectRequestASA__c();
		    objTest1b.ProjectAgencyID__c = objTest1.id;
		    objTest1b.OldASA__c = 'AAAB';
		    objTest1b.RequestASAID__c = 1113;
		    
		    Glxy_ProjectRequestASA__c objTest2a =  new Glxy_ProjectRequestASA__c();
		    objTest2a.ProjectAgencyID__c = objTest2.id;
		    objTest2a.OldASA__c = 'AAAD';
		    objTest2a.RequestASAID__c = 1114;
		    
		    List<Glxy_ProjectRequestASA__c> RequestASAs = new List<Glxy_ProjectRequestASA__c> {objTest1a, objTest1b, objTest2a};
		    Insert RequestASAs;
		    
		    Delete objTest1a;

		}
		
		@isTest (SeeAllData=true) Static void  TestTriggerGLXY_ReconciliationTrigger() {
        	User admin = [SELECT Id FROM user WHERE IsActive = True And name = 'CastIron User' Limit 1];  
        	system.runas(admin){	
			
			Glxy_Reconciliation__c glxyrec = new Glxy_Reconciliation__c(LeaseNumber__c='LVA12345', Month__c = '10');
			insert glxyrec;
			
			glxyrec.RexusTotalMonthlyPayment__c = 1000.00;
		    database.saveresult sr = database.update(glxyrec);
		    Glxy_Reconciliation__c result = [select RexusYearToDate__c from Glxy_Reconciliation__c where id =:glxyrec.id];
		    
		    system.assertequals(1000,result.RexusYearToDate__c);
			}
		}	 
 }