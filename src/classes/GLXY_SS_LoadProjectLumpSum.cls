global with sharing class GLXY_SS_LoadProjectLumpSum implements Database.Batchable<sObject>,Database.stateful{
 
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
        //string  QuerySOQL = 'Select 	ID, RecordType.DeveloperName, Acceptance620Date__c, Amount__c, Budget_Exclusion_Reason__c, EffectiveDate__c, ExpirationDate__c, ' +
        //                     '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, IA_Sq_Ft__c, ' +
		//			    	   '			BDGFlag__c, ProjectNumber__r.Name, LumSumType__c, NOA_Sq_Ft__c, ' +
		//			    	   '			ProcessedDate__c, PaymentID__c, StatusCd__c, ProjectNumber__r.ID ' +
		//			    	   'From 		Glxy_LPLumpSum__c ' +
		//			    	   'Where (ProjectNumber__r.ProjectStatus__c != \'Completed\' OR (ProjectNumber__r.ProjectStatus__c = \'Completed\' And FISCAL_YEAR(ProjectNumber__r.ProcessedDate__c) = :intCurrentFY)) ' +
        //                     'ORDER BY 	Name ';
		string  QuerySOQL = 'Select 	LPLumpSum__r.ID, LPLumpSum__r.RecordType.DeveloperName, LPLumpSum__r.Acceptance620Date__c, LPLumpSum__r.Amount__c, LPLumpSum__r.Budget_Exclusion_Reason__c, LPLumpSum__r.EffectiveDate__c, LPLumpSum__r.ExpirationDate__c, ' +
                             '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, LPLumpSum__r.IA_Sq_Ft__c, ' +
					    	 '			LPLumpSum__r.BDGFlag__c, LPLumpSum__r.ProjectNumber__r.Name, LPLumpSum__r.LumSumType__c, LPLumpSum__r.NOA_Sq_Ft__c, ' +
					    	 '			LPLumpSum__r.ProcessedDate__c, LPLumpSum__r.PaymentID__c, LPLumpSum__r.StatusCd__c, LPLumpSum__r.ProjectNumber__r.ID ' +
					    	 'From 		Glxy_LPLumpSumObligations__c ' +
					    	 'Where (LPLumpSum__r.ProjectNumber__r.ProjectStatus__c != \'Completed\' OR (LPLumpSum__r.ProjectNumber__r.ProjectStatus__c = \'Completed\' And FISCAL_YEAR(LPLumpSum__r.ProjectNumber__r.ProcessedDate__c) = :intCurrentFY)) ' +
					    	 'And   FiscalYear__c = :strCurrentFY ' +
                             'ORDER BY 	Name ';                             
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_LPLumpSumObligations__c objLS = null;
	        
	        for(sObject obj: scope) {
	        	objLS = (Glxy_LPLumpSumObligations__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeaseProjectPaymentsForSnapshot__c(
		        	Acceptance620Date__c = objLS.LPLumpSum__r.Acceptance620Date__c,
		        	AnnualAmount__c = objLS.LPLumpSum__r.Amount__c,
		        	BudgetExclusionReason__c = objLS.LPLumpSum__r.Budget_Exclusion_Reason__c,
		        	EffectiveDate__c = objLS.LPLumpSum__r.EffectiveDate__c,
		        	ExpirationDate__c = objLS.LPLumpSum__r.ExpirationDate__c,
		        	FYObligation__c = objLS.FY_Obligation__c,
		        	FYObligationIA__c = objLS.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objLS.FY_Obligation_NOA__c,
		        	IASqFt__c = objLS.LPLumpSum__r.IA_Sq_Ft__c,
		        	IncludeinBudgetFlag__c = objLS.LPLumpSum__r.BDGFlag__c,
		        	NOASqFt__c = objLS.LPLumpSum__r.NOA_Sq_Ft__c,
		        	ParentRecord__c =  mapProjectRecords.get(objLS.LPLumpSum__r.ProjectNumber__r.Name),
		        	Payment_Category__c = 'Lease Proj. Lump Sum',
		        	PaymentID__c = string.valueOf(objLS.LPLumpSum__r.PaymentID__c),
		        	PaymentType__c = objLS.LPLumpSum__r.LumSumType__c,
		        	ProcessDate__c = objLS.LPLumpSum__r.ProcessedDate__c,
		        	Record_Type__c = objLS.LPLumpSum__r.RecordType.DeveloperName,
		        	Source_Record__c = objLS.LPLumpSum__r.ID,
		        	Status_Code__c = objLS.LPLumpSum__r.StatusCd__c
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	} catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading Lease Project Lump Sum data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed Lease Project Lump Sum data; Loading Lease Project Double Rent data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadProjectDoubleRent());	
    	}
    }
	
}