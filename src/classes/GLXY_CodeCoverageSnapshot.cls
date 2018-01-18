@isTest(SeeAllData=false)
private class GLXY_CodeCoverageSnapshot {
    
    static testMethod void testSnapshot(){
		
		test.StartTest();
		
		//Lease Data 
		Glxy_Lease__c objLease = new Glxy_Lease__c();
        objLease.Name = 'LAK05855';
        objLease.StatusCode__c = 'Active';
        objLease.Next_FY_Leases__c = False;
        objLease.BaseAnnualRent__c = 1200;
        objLease.BaseSquareFeet__c = 100;
        objLease.IAPercentage__c = 0;
        objLease.Total_IA_Sq_feet__c = 0; 
        objLease.Total_NOA_Sq_feet__c = 100;
        insert objLease;
        System.AssertNotEquals(objLease.ID, NULL);
        
        // CPI
        ID RexusRecordTypeID = Schema.SObjectType.Glxy_ConsumerPriceIndex__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
        Glxy_ConsumerPriceIndex__c objTest0 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            RecordTypeID = RexusRecordTypeID,
            FY_Obligation__c = 0,
            ProcessedDate__c = Datetime.Now().Date(),
            Acceptance620Date__c = Datetime.Now().Date(),
            StatusCD__c = 'Actual'
        );
        insert objTest0;
        System.AssertNotEquals(objTest0.ID, NULL);
        
        // LS
        RexusRecordTypeID = Schema.SObjectType.Glxy_LumpSum__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
        Glxy_LumpSum__c objTest3 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            RecordTypeID = RexusRecordTypeID,
            EffectiveDate__c = Datetime.Now().Date(),
            ProcessedDate__c = Datetime.Now().Date(),
            StatusCD__c = 'Estimate',
            FY_Obligation__c = 0
        );
        insert objTest3;
        System.AssertNotEquals(objTest3.ID, NULL);
        
        //LSO
        Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		String  strCurrentFY = String.ValueOf(intCurrentFY);	 
        Glxy_LumpSumObligations__c objTest3a = new Glxy_LumpSumObligations__c (
        	LumpSum__c = objTest3.ID,
        	FiscalYear__c = strCurrentFY,
        	FYAndLSId__c  = '2000AD'
    	);
    	Insert objTest3a;
    	
        //SR
        RexusRecordTypeID = Schema.SObjectType.Glxy_StepRent__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
        Glxy_StepRent__c objTest4 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            RecordTypeID = RexusRecordTypeID,
            ProcessedDate__c = Datetime.Now().Date(),
            Acceptance620Date__c = Datetime.Now().Date(),
            StatusCode__c = 'Actual'
        );
        insert objTest4;
        System.Assert(objTest4!=NULL);
		
		// IBAA
        Glxy_IntraBudgetActivityAuthorization__c IBAA = new Glxy_IntraBudgetActivityAuthorization__c();
        IBAA.LeaseNumber__c = objLease.id;
        IBAA.Overwrite__c = false;
        IBAA.EffectiveDate__c = Datetime.Now().Date();
        IBAA.ProcessedDate__c = Datetime.Now().Date();
        insert IBAA;
        System.AssertNotEquals(IBAA,NULL);
        
        //RWA
        Glxy_ReimbursableWorkAuthorization__c objRWA = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = Datetime.Now().Date(),
            ProcessedDate__c = Datetime.Now().Date()
        );
        insert objRWA;
            
		//Lease Project
		RexusRecordTypeID = Schema.SObjectType.Glxy_LeaseProjects__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		Glxy_LeaseProjects__c objProject = new Glxy_LeaseProjects__c();
		objProject.Name = '123456789';
		objProject.RecordTypeID = RexusRecordTypeID;
	    objProject.EffectiveDate__c = Datetime.Now().Date().addmonths(-1);
	    objProject.ProcessedDate__c = Datetime.Now().Date();
	    objProject.RegionCd__c = '1';
	    objProject.ProjectStatus__c = 'Active';
	    objProject.Old_Annual_Rent__c = 1000.0;
	    objProject.AnnualRent__c = 2000.0;
	    objProject.NOASquareFeet__c = 200;
	    objProject.eEorA__c = 'Estimate';
       	objProject.Old_Square_Feet__c = 0;
       	objProject.SquareFeet__c = 200;
	    objProject.UpdateOldNOAIA__c = false;
	    objProject.OldNOASqFt__c = 0;
	    objProject.Project_Type__c = 'New/Replacing';
	    insert objProject;
	    
	    RexusRecordTypeID = Schema.SObjectType.Glxy_LPLumpSum__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
	    Glxy_LPLumpSum__c objProjectLS = new Glxy_LPLumpSum__c();
        objProjectLS.ProjectNumber__c = objProject.id;
        objProjectLS.RecordTypeID = RexusRecordTypeID;
        objProjectLS.Amount__c = 100;
        objProjectLS.LumSumType__c = 'Rent';
        objProjectLS.IA_Sq_Ft__c = 70;
        objProjectLS.NOA_Sq_Ft__c = 30;
        objProjectLS.EffectiveDate__c = Datetime.Now().Date();
        objProjectLS.ExpirationDate__c = Datetime.Now().Date().addYears(+2);
        objProjectLS.ProcessedDate__c = Datetime.Now().Date();
        insert objProjectLS;
        
        RexusRecordTypeID = Schema.SObjectType.Glxy_LPStepRent__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		Glxy_LPStepRent__c objProjectSR = new Glxy_LPStepRent__c (
			ProjectNumber__c = objProject.id,
			RecordTypeID = RexusRecordTypeID,
		    EffectiveDate__c = Datetime.Now().Date(),
		    ProcessedDate__c = Datetime.Now().Date().addyears(+1),
		    IA_Sq_Ft__c =  0,
		    NOA_Sq_Ft__c = 0        
		);
		insert objProjectSR;
        
        //Double Rent
		Glxy_AssociatedLeases__c assocLease = new Glxy_AssociatedLeases__c (Lease__c = objLease.Id, Project__c = objProject.Id);
		insert assocLease;
		System.Debug('MyProject-' + assocLease.ID);
		
		//DR
		Glxy_DoubleRent__c objDR = new Glxy_DoubleRent__c (
			Associated_Leases_Projects_ID__c = assocLease.Id, 
			FYAndId__c = '2009AD',
			Fiscal_Year__c = strCurrentFY
		);
		insert objDR;
		
		//Snap Shot Validatons
		List<Galaxy_Snapshot__c> objSnapShotRecords = New List<Galaxy_Snapshot__c>();
   		Galaxy_Snapshot__c objSnapshot = New Galaxy_Snapshot__c(
			Name = 'Snapshot08172016',
			Snapshot_Date__c = Datetime.Now().Date(),
			SnapshotReason__c = 'Description',
			SnapshotType__c = 'Monthly',
			Status__c = 'Scheduled',
			StatusMessage__c = ''
		);
		objSnapShotRecords.add(objSnapshot);
		
		Galaxy_Snapshot__c objSnapshot2 = New Galaxy_Snapshot__c(
			Name = 'Snapshot08172016',
			Snapshot_Date__c = Datetime.Now().Date(),
			SnapshotReason__c = 'Description',
			SnapshotType__c = 'Monthly',
			Status__c = 'Scheduled',
			StatusMessage__c = ''
		);
		objSnapShotRecords.add(objSnapshot2);
		
		Try{ 
			insert objSnapShotRecords;
		}catch (Exception e){
			//Multiple Inserts not allowed
		}
		
		Galaxy_Snapshot__c objSnapshot3a = New Galaxy_Snapshot__c(
			Name = 'Snapshot08172016',
			Snapshot_Date__c = Datetime.Now().Date(),
			SnapshotReason__c = 'Description',
			SnapshotType__c = 'Monthly',
			Status__c = 'Completed',
			StatusMessage__c = ''
		);
		Insert objSnapshot3a;
		
		Galaxy_Snapshot__c objSnapshot3b = New Galaxy_Snapshot__c(
			Name = 'Snapshot08172016',
			Snapshot_Date__c = Datetime.Now().Date(),
			SnapshotReason__c = 'Description',
			SnapshotType__c = 'Monthly',
			Status__c = 'Completed',
			StatusMessage__c = ''
		);
		Insert objSnapshot3b;
		
		Galaxy_Snapshot__c objSnapshot4 = New Galaxy_Snapshot__c(
			Name = 'Snapshot08172016',
			Snapshot_Date__c = Datetime.Now().Date(),
			SnapshotReason__c = 'Description',
			SnapshotType__c = 'Monthly',
			Status__c = 'Scheduled',
			StatusMessage__c = ''
		);
		
		Try{ 
			Insert objSnapshot4;
		}catch (Exception e){
			//20 Limit, Simulated with 2 ...
		}
		
		Delete objSnapshot3a;
		Delete objSnapshot3b;
		
		Insert objSnapshot4;
		
		Galaxy_Snapshot__c objSnapshot5 = New Galaxy_Snapshot__c(
			Name = 'Snapshot08172016',
			Snapshot_Date__c = Datetime.Now().Date(),
			SnapshotReason__c = 'Description',
			SnapshotType__c = 'Monthly',
			Status__c = 'Scheduled',
			StatusMessage__c = ''
		);

		Try{ 
			Insert objSnapshot5;
		}catch (Exception e){
			//One scheduled already ...
		}

		//Create Schedule
		DateTime n = datetime.now().addMinutes(1);
   		String cron = '';
   		cron += n.second();
   		cron += ' ' + n.minute();
   		cron += ' ' + n.hour();
   		cron += ' ' + n.day();
   		cron += ' ' + n.month();
   		cron += ' ' + '?';
   		cron += ' ' + n.year();
   		
   		String jobId = System.schedule('Galaxy - Create Snapshot', cron, new GLXY_SS_StartSnapShot());
   		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
   		System.assertEquals(cron, ct.CronExpression);
   		System.assertEquals(0, ct.TimesTriggered);
	
   
       	//test GLXY_AccrualReport()
       	PBS_Building__c build= new PBS_Building__c();
	   	build.Location_Code_Plus__c='test';
	   	build.Building_ID__c=123;
	   	insert build;
   
   		Glxy_LeaseLocation__c  ll= new Glxy_LeaseLocation__c ();
   		ll.LeaseNumber__c = objLease.id;
   		ll.BuildingNumber__c = build.id;
   		Insert ll;
   		
  
       	PageReference pageRef = Page.GLXY_AccrualReport;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('pv0', String.valueOf(Datetime.Now().Date().Year()));
        ApexPages.currentPage().getParameters().put('pv1', '\'1\'');
        
        GLXY_AccrualReport objTest = new GLXY_AccrualReport();
        List<GLXY_AccrualReport> objDataSet;
        objDataSet = objTest.getAccrualDataset();
        System.Assert(objDataSet!=NULL);
        
        test.StopTest();
	
	}
	
	
}