global with sharing class GLXY_SS_LoadLumpSum implements Database.Batchable<sObject>,Database.stateful{
 
    global List<GLXY_LeasePaymentsSnapshot__c> objSnapShotRecords = New List<GLXY_LeasePaymentsSnapshot__c>();
	public string strSnapShotID;
	public string strSnapShotName;
	public boolean blnProcessErrors = false;
	Public Map<string, String> mapLeaseRecords = new Map<string, String>();
	
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
		
		// Load Lease Record Id's
		List<Glxy_LeaseSnapshot__c> listLeases = [Select ID, LeaseNumber__c From Glxy_LeaseSnapshot__c Where SnapshotName__c = :strSnapShotID];
		for(Glxy_LeaseSnapshot__c objItem : listLeases)
			mapLeaseRecords.put(objItem.LeaseNumber__c, objItem.ID);
		
		//Query Payment Lines	
		Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		String  strCurrentFY = String.ValueOf(intCurrentFY);	 
        
        //string  QuerySOQL =  'Select 	ID, RecordType.DeveloperName, Acceptance620Date__c, Amount__c, Budget_Exclusion_Reason__c, EffectiveDate__c, ExpirationDate__c, ' +
        //                     '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, IA_Sq_Ft__c, ' +
		//			    	   '			BDGFlag__c, LeaseNumber__r.Name, LumSumType__c, NOA_Sq_Ft__c, ' +
		//			    	   '			ProcessedDate__c, PaymentIDNumber__c, StatusCd__c, LeaseNumber__r.ID ' +
		//			    	   'From 		Glxy_LumpSum__c ' +
		//			    	   'Where (StatusCD__c != \'Actual\' OR (StatusCD__c = \'Actual\' And FISCAL_YEAR(ProcessedDate__c) = :intCurrentFY)) ' +
        //                     'ORDER BY 	Name ';
        string  QuerySOQL =  'Select 	LumpSum__r.ID, LumpSum__r.RecordType.DeveloperName, LumpSum__r.Acceptance620Date__c, LumpSum__r.Budget_Exclusion_Reason__c, LumpSum__r.Amount__c, LumpSum__r.EffectiveDate__c, LumpSum__r.ExpirationDate__c, ' +
                             '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, LumpSum__r.IA_Sq_Ft__c, ' +
					    	 '			LumpSum__r.BDGFlag__c, LumpSum__r.LeaseNumber__r.Name, LumpSum__r.LumSumType__c, LumpSum__r.NOA_Sq_Ft__c, ' +
					    	 '			LumpSum__r.ProcessedDate__c, LumpSum__r.PaymentIDNumber__c, LumpSum__r.StatusCd__c, LumpSum__r.LeaseNumber__r.ID ' +
					    	 'From 		Glxy_LumpSumObligations__c ' +
					    	 //'Where (LumpSum__r.StatusCD__c != \'Actual\' OR (LumpSum__r.StatusCD__c = \'Actual\' And FISCAL_YEAR(LumpSum__r.ProcessedDate__c) = :intCurrentFY)) ' +
					    	 'Where 	FiscalYear__c = :strCurrentFY ' +
                             'ORDER BY 	Name ';                    
                             
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_LumpSumObligations__c objLS = null;
	        
	        for(sObject obj: scope) {
	        	objLS = (Glxy_LumpSumObligations__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeasePaymentsSnapshot__c(
		        	Acceptance620Date__c = objLS.LumpSum__r.Acceptance620Date__c,
		        	AnnualAmount__c = objLS.LumpSum__r.Amount__c,
		        	BudgetExclusionReason__c = objLS.LumpSum__r.Budget_Exclusion_Reason__c,
		        	EffectiveDate__c = objLS.LumpSum__r.EffectiveDate__c,
		        	ExpirationDate__c = objLS.LumpSum__r.ExpirationDate__c,
		        	FYObligation__c = objLS.FY_Obligation__c,
		        	FYObligationIA__c = objLS.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objLS.FY_Obligation_NOA__c,
		        	IASqFt__c = objLS.LumpSum__r.IA_Sq_Ft__c,
		        	IncludeinBudgetFlag__c = objLS.LumpSum__r.BDGFlag__c,
		        	NOASqFt__c = objLS.LumpSum__r.NOA_Sq_Ft__c,
		        	Payment_Category__c = 'Lump Sum',
		        	ParentRecord__c = mapLeaseRecords.get(objLS.LumpSum__r.LeaseNumber__r.Name),
		        	PaymentType__c = objLS.LumpSum__r.LumSumType__c,
		        	ProcessDate__c = objLS.LumpSum__r.ProcessedDate__c,
		        	Record_Type__c = objLS.LumpSum__r.RecordType.DeveloperName,
		        	Source_Record__c = objLS.LumpSum__r.ID,
		        	Status_Code__c = objLS.LumpSum__r.StatusCd__c
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	}catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading Lump Sum data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed Lump Sum data; Loading RWA data ...'
			);
			Update objSnapshotStatus; 
			
			database.executeBatch(new GLXY_SS_LoadRWA());	
    	}
    }
	
}