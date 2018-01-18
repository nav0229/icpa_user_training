global with sharing class GLXY_SS_LoadProjectStepRent implements Database.Batchable<sObject>,Database.stateful{
 
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
		Integer intCurrentFY2 = intCurrentFY + 2;	 
        string  QuerySOQL = 'Select 	ID, RecordType.DeveloperName, Acceptance620Date__c, Amount__c, Budget_Exclusion_Reason__c, EffectiveDate__c, ExpirationDate__c, ' +
                             '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, IA_Sq_Ft__c, ' +
					    	 '			BDGFlag__c, ProjectNumber__r.Name, PaymentType__c, NOA_Sq_Ft__c, ' +
					    	 '			ProcessedDate__c, PaymentID__c, StatusCode__c, ProjectNumber__r.ID ' +
					    	 'From 		Glxy_LPStepRent__c ' +
					    	 'Where (ProjectNumber__r.ProjectStatus__c != \'Completed\' OR (ProjectNumber__r.ProjectStatus__c = \'Completed\' And FISCAL_YEAR(ProjectNumber__r.ProcessedDate__c) = :intCurrentFY)) ' +
                             'ORDER BY 	Name ';
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_LPStepRent__c objSR = null;
	        
	        for(sObject obj: scope) {
	        	objSR = (Glxy_LPStepRent__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeaseProjectPaymentsForSnapshot__c(
		        	Acceptance620Date__c = objSR.Acceptance620Date__c,
		        	AnnualAmount__c = objSR.Amount__c,
		        	BudgetExclusionReason__c = objSR.Budget_Exclusion_Reason__c,
		        	EffectiveDate__c = objSR.EffectiveDate__c,
		        	ExpirationDate__c = objSR.ExpirationDate__c,
		        	FYObligation__c = objSR.FY_Obligation__c,
		        	FYObligationIA__c = objSR.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objSR.FY_Obligation_NOA__c,
		        	IASqFt__c = objSR.IA_Sq_Ft__c,
		        	IncludeinBudgetFlag__c = objSR.BDGFlag__c,
		        	NOASqFt__c = objSR.NOA_Sq_Ft__c,
		        	ParentRecord__c = mapProjectRecords.get(objSR.ProjectNumber__r.Name),
		        	Payment_Category__c = 'Lease Proj. Step Rent',
		        	PaymentID__c = string.valueOf(objSR.PaymentID__c),
		        	PaymentType__c = objSR.PaymentType__c,
		        	ProcessDate__c = objSR.ProcessedDate__c,
		        	Record_Type__c = objSR.RecordType.DeveloperName,
		        	Source_Record__c = objSR.ID,
		        	Status_Code__c = objSR.StatusCode__c
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	} catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading Lease Project Step Rent data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				Status__c = 'Completed', 
				StatusMessage__c = 'Data Snapshot completed; data ready for reporting purposes.'
			);
			Update objSnapshotStatus;
    	}
    }
	
}