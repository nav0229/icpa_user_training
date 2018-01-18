global with sharing class GLXY_SS_LoadLeaseProject implements Database.Batchable<sObject>,Database.stateful{
	
    global List<GLXY_LeaseProjectforSnapshot__c> objSnapShotRecords = New List<GLXY_LeaseProjectforSnapshot__c>();
	public string strSnapShotID;
	public string strSnapShotName;
	public boolean blnProcessErrors = false;
	 
    global Database.QueryLocator start(Database.BatchableContext BC){
    	
    	List<Galaxy_Snapshot__c> lstPreviouslyScheduledSnapshots = 
						[SELECT Id, Name 
						 FROM 	Galaxy_Snapshot__c 
						 Where 	Status__c = 'Started'
						 And 	Snapshot_Date__c = :Datetime.Now().Date() 
						 Limit 1];
		if(lstPreviouslyScheduledSnapshots.size() != 0){
			strSnapShotID = lstPreviouslyScheduledSnapshots[0].Id;
			strSnapShotName = lstPreviouslyScheduledSnapshots[0].Name;
		}
		
		Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		Integer intCurrentFY2 = intCurrentFY + 2;		 
        string QueryAllProjects = 	'Select ID, Name, RecordType.DeveloperName, Budget_Exclusion_Reason__c, CalculatedOldIASqFt__c, CalculatedOldNOASqFt__c, ' +
								        'CancelARentIA__c, CancelARentNOA__c, CancelPYCostIA__c, CancelPYCostNOA__c, CancelSqFtIA__c, CancelSqFtNOA__c, ' +
								        'Acceptance620Date__c, EffectiveDate__c, eEorA__c, CY_Obligation_IA__c, CY_Obligation_NOA__c, EscalARentIA__c, EscalARentNOA__c, ' +
								        'EscalPYCostIA__c, EscalPYCostNOA__c, EscalSqFtIA__c, EscalSqFtNOA__c, ExpanARentIA__c, ExpanARentNOA__c, ExpanPYCostIA__c, ' +
								        'ExpanPYCostNOA__c, ExpanSqFtIA__c, ExpanSqFtNOA__c, IAConversionDate__c, BDGFlag__c, LandOnly__c, AnnualRent__c, ' +
								        'Antennas__c, BaseStructParkSpaces__c, BaseSurfParkSpaces__c, IASquareFeet__c, Land__c, NewLease__c, NOASquareFeet__c, ' +
								        'NewRate__c, SquareFeet__c, Old_Annual_Rent__c, OAntennas__c, OBaseStructParkSpaces__c, OBaseSurfParkSpaces__c, ' +
								        'OldIASqFt__c, OLand__c, OldNOASqFt__c, OldRate__c, Old_Square_Feet__c, ParkingOnly__c, PastDueIndicator__c, ' +
								        'AssociatedLeases_lkup__c, Prospectus_Indicator__c, Prospectus_Number__c, City__c, State__c, ' +
								        'RegionCd__c, TeamCode__c, ProjectStatus__c, Project_Type__c, Total_IA_PYC__c, Total_NOA_PYC__c, CheckCOApproval__c, PreCertificationDate__c, ProcessedDate__c ' +
	        						'From  Glxy_LeaseProjects__c ' +
							    	'Where (ProjectStatus__c != \'Completed\' OR (ProjectStatus__c = \'Completed\' And FISCAL_YEAR(ProcessedDate__c) = :intCurrentFY)) ' +
	                                'ORDER BY Name '; 
	    QueryAllProjects = QueryAllProjects.Replace('\\','');                                                 
        Return Database.getQueryLocator(QueryAllProjects);  
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_LeaseProjects__c objLeaseProject = null;
	        
	        for(sObject obj: scope) {
	        	objLeaseProject = (Glxy_LeaseProjects__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeaseProjectforSnapshot__c(
		      		SnapshotName__c = strSnapShotID,
		      		Source_Record__c = objLeaseProject.ID,	
		      		UniqueID__c = strSnapShotID + '||' + objLeaseProject.ID,
		      		Budget_Exclusion_Reason__c = objLeaseProject.Budget_Exclusion_Reason__c, 
		      		CalculatedOldIASqFt__c = objLeaseProject.CalculatedOldIASqFt__c,
		      		CalculatedOldNOASqFt__c = objLeaseProject.CalculatedOldNOASqFt__c,
			        CancelARentIA__c = objLeaseProject.CancelARentIA__c, 
			        CancelARentNOA__c = objLeaseProject.CancelARentNOA__c, 
			        CancelPYCostIA__c = objLeaseProject.CancelPYCostIA__c,
			        CancelPYCostNOA__c = objLeaseProject.CancelPYCostNOA__c,
			        CancelSqFtIA__c = objLeaseProject.CancelSqFtIA__c,
			        CancelSqFtNOA__c = objLeaseProject.CancelSqFtNOA__c,
			        Acceptance620Date__c = objLeaseProject.Acceptance620Date__c, 
			        EffectiveDate__c = objLeaseProject.EffectiveDate__c, 
			        eEorA__c = objLeaseProject.eEorA__c, 
			        CY_Obligation_IA__c = objLeaseProject.CY_Obligation_IA__c,
			        CY_Obligation_NOA__c = objLeaseProject.CY_Obligation_NOA__c,
			        EscalARentIA__c = objLeaseProject.EscalARentIA__c,
			        EscalARentNOA__c = objLeaseProject.EscalARentNOA__c,
			        EscalPYCostIA__c = objLeaseProject.EscalPYCostIA__c, 
			        EscalPYCostNOA__c = objLeaseProject.EscalPYCostNOA__c, 
					EscalSqFtIA__c = objLeaseProject.EscalSqFtIA__c, 
					EscalSqFtNOA__c = objLeaseProject.EscalSqFtNOA__c, 
					ExpanARentIA__c = objLeaseProject.ExpanARentIA__c, 
					ExpanARentNOA__c = objLeaseProject.ExpanARentNOA__c, 
					ExpanPYCostIA__c = objLeaseProject.ExpanPYCostIA__c,
			        ExpanPYCostNOA__c = objLeaseProject.ExpanPYCostNOA__c, 
			        ExpanSqFtIA__c = objLeaseProject.ExpanSqFtIA__c, 
			        ExpanSqFtNOA__c = objLeaseProject.ExpanSqFtNOA__c, 
			        IAConversionDate__c = objLeaseProject.IAConversionDate__c,
			        BDGFlag__c = objLeaseProject.BDGFlag__c,  
			        LandOnly__c = objLeaseProject.LandOnly__c, 
			        AnnualRent__c = objLeaseProject.AnnualRent__c, 
			        Antennas__c = objLeaseProject.Antennas__c,
			        BaseStructParkSpaces__c = objLeaseProject.BaseStructParkSpaces__c,  
			        BaseSurfParkSpaces__c = objLeaseProject.BaseSurfParkSpaces__c, 
			        IASquareFeet__c = objLeaseProject.IASquareFeet__c, 
			        Land__c = objLeaseProject.Land__c, 
			        NewLease__c = objLeaseProject.NewLease__c, 
			        NOASquareFeet__c = objLeaseProject.NOASquareFeet__c,
			        NewRate__c = objLeaseProject.NewRate__c, 
			        SquareFeet__c = objLeaseProject.SquareFeet__c, 
			        Old_Annual_Rent__c = objLeaseProject.Old_Annual_Rent__c,
			        OAntennas__c = objLeaseProject.OAntennas__c, 
			        OBaseStructParkSpaces__c = objLeaseProject.OBaseStructParkSpaces__c,  
			        OBaseSurfParkSpaces__c = objLeaseProject.OBaseSurfParkSpaces__c,
			        OldIASqFt__c = objLeaseProject.OldIASqFt__c,
			        OLand__c = objLeaseProject.OLand__c, 
			        OldNOASqFt__c = objLeaseProject.OldNOASqFt__c,  
			        OldRate__c = objLeaseProject.OldRate__c,  
			        Old_Square_Feet__c = objLeaseProject.Old_Square_Feet__c,  
			        ParkingOnly__c = objLeaseProject.ParkingOnly__c,  
			        PastDueIndicator__c = objLeaseProject.PastDueIndicator__c,
			        PreCertificationDate__c = objLeaseProject.PreCertificationDate__c,  
			        ProcessedDate__c = objLeaseProject.ProcessedDate__c, 
			        ProjectID__c = objLeaseProject.Name, 
			        ProjectStatus__c = objLeaseProject.ProjectStatus__c, 
			        Project_Type__c = objLeaseProject.Project_Type__c, 
			        Record_Type__c = objLeaseProject.RecordType.DeveloperName,
			        RegionCd__c = objLeaseProject.RegionCd__c, 
			        TeamCode__c = objLeaseProject.TeamCode__c, 
			        Total_IA_PYC__c = objLeaseProject.Total_IA_PYC__c,
			        Total_NOA_PYC__c = objLeaseProject.Total_NOA_PYC__c, 
			        CheckCOApproval__c = objLeaseProject.CheckCOApproval__c,
			        AssociatedLeases_lkup__c = objLeaseProject.AssociatedLeases_lkup__c,
			        Prospectus_Indicator__c = objLeaseProject.Prospectus_Indicator__c,
			        Prospectus_Number__c = objLeaseProject.Prospectus_Number__c,
			        City__c = objLeaseProject.City__c,
			        State__c = objLeaseProject.State__c
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	}catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				Status__c = 'Failed',
				StatusMessage__c = 'Snapshot process error (Loading Lease Project data) - ' + e.getMessage()
			);
			Update objSnapshotStatus;
			
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed Lease Project snap shot; Loading Project Lump Sum data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadProjectLumpSum());
    	}
    }
    
}