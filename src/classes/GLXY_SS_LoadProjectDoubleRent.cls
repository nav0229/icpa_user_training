global with sharing class GLXY_SS_LoadProjectDoubleRent implements Database.Batchable<sObject>,Database.stateful{
 
    global List<GLXY_LeaseProjectPaymentsForSnapshot__c> objSnapShotRecords = New List<GLXY_LeaseProjectPaymentsForSnapshot__c>();
	public string strSnapShotID;
	public string strSnapShotName;
	public boolean blnProcessErrors = false;
	Public Map<string, String> mapProjectRecords = new Map<string, String>();
	
	global Database.QueryLocator start(Database.BatchableContext BC){
    	
    	// Snapshot processing ...
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
		
		// Load Lease Project Record Id's
		List<GLXY_LeaseProjectforSnapshot__c> listProjects = [Select ID, ProjectID__c From GLXY_LeaseProjectforSnapshot__c Where SnapshotName__c = :strSnapShotID];
		for(GLXY_LeaseProjectforSnapshot__c objItem : listProjects)
			mapProjectRecords.put(objItem.ProjectID__c, objItem.ID);
			
		//Query Payment Lines	
		Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		String  strCurrentFY = String.ValueOf(intCurrentFY);
		//string  QuerySOQL =  'Select 	ID, RecordType.DeveloperName, Project__r.Acceptance620Date__c, Double_Rent__c, Project_Effective_Date__c, ' +
        //                     '			DoubleRentIA__c, DoubleRentNOA__c, Project__r.IASquareFeet__c, LeaseExpiration_lkp__c, ' +
		//			    	   '			Project__r.BDGFlag__c, Project__r.Name, Project__r.NOASquareFeet__c, ' +
		//			    	   '			Project__r.ProcessedDate__c, Project__r.ID ' +
		//			    	   'From 		Glxy_AssociatedLeases__c ' +
		//			    	   'Where (Project__r.ProjectStatus__c != \'Completed\' OR (Project__r.ProjectStatus__c = \'Completed\' And FISCAL_YEAR(Project__r.ProcessedDate__c) = :intCurrentFY)) ' +
        //                     'ORDER BY 	Name ';	 
        string  QuerySOQL = 'Select 	Associated_Leases_Projects_ID__r.ID, Associated_Leases_Projects_ID__r.RecordType.DeveloperName, Associated_Leases_Projects_ID__r.Project__r.Acceptance620Date__c, Associated_Leases_Projects_ID__r.Double_Rent__c, Associated_Leases_Projects_ID__r.Project_Effective_Date__c, ' +
                             '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, Associated_Leases_Projects_ID__r.Project__r.IASquareFeet__c, Associated_Leases_Projects_ID__r.LeaseExpiration_lkp__c, ' +
					    	 '			Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c, Associated_Leases_Projects_ID__r.Project__r.Name, Associated_Leases_Projects_ID__r.Project__r.NOASquareFeet__c, ' +
					    	 '			Associated_Leases_Projects_ID__r.Project__r.ProcessedDate__c, Associated_Leases_Projects_ID__r.Project__r.ID ' +
					    	 'From 		Glxy_DoubleRent__c ' +
					    	 'Where (Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c != \'Completed\' OR (Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c = \'Completed\' And FISCAL_YEAR(Associated_Leases_Projects_ID__r.Project__r.ProcessedDate__c) = :intCurrentFY)) ' +
					    	 'And    Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c <> \'Cancelled\' ' +
					    	 'And   Fiscal_Year__c = :strCurrentFY ' +
                             'ORDER BY 	Name ';
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_DoubleRent__c objDR = null;
	        
	        for(sObject obj: scope) {
	        	objDR = (Glxy_DoubleRent__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeaseProjectPaymentsForSnapshot__c(
		        	Acceptance620Date__c = objDR.Associated_Leases_Projects_ID__r.Project__r.Acceptance620Date__c,
		        	AnnualAmount__c = objDR.Associated_Leases_Projects_ID__r.Double_Rent__c,
		        	BudgetExclusionReason__c = '',
		        	EffectiveDate__c = objDR.Associated_Leases_Projects_ID__r.Project_Effective_Date__c,
		        	ExpirationDate__c = objDR.Associated_Leases_Projects_ID__r.LeaseExpiration_lkp__c,
		        	FYObligation__c = objDR.FY_Obligation__c,
		        	FYObligationIA__c = objDR.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objDR.FY_Obligation_NOA__c,
		        	IASqFt__c = objDR.Associated_Leases_Projects_ID__r.Project__r.IASquareFeet__c,
		        	IncludeinBudgetFlag__c = objDR.Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c,
		        	NOASqFt__c = objDR.Associated_Leases_Projects_ID__r.Project__r.NOASquareFeet__c,
		        	ParentRecord__c =  mapProjectRecords.get(objDR.Associated_Leases_Projects_ID__r.Project__r.Name),
		        	Payment_Category__c = 'Double Rent',
		        	PaymentID__c = '',
		        	PaymentType__c = '',
		        	ProcessDate__c = objDR.Associated_Leases_Projects_ID__r.Project__r.ProcessedDate__c,
		        	Record_Type__c = objDR.Associated_Leases_Projects_ID__r.RecordType.DeveloperName,
		        	Source_Record__c = objDR.Associated_Leases_Projects_ID__r.ID,
		        	Status_Code__c = ''
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	} catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading Lease Project Double Rent data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed Lease Project Double Rent data; Loading Lease Project Step Rent data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadProjectStepRent());	
    	}
    }
	
}