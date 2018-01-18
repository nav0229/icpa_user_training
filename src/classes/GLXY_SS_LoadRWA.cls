global with sharing class GLXY_SS_LoadRWA implements Database.Batchable<sObject>,Database.stateful{
 
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
		Integer intCurrentFY2 = intCurrentFY + 2;	 
        string  QuerySOQL = 'Select 	ID, LeaseNumber__r.ID, Amount__c, EffectiveDate__c, ProcessedDate__c, ' +
                             '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, IA_Sq_Ft__c, ' +
					    	 '			LeaseNumber__r.Name, NOA_Sq_Ft__c ' +
					    	 'From 		Glxy_ReimbursableWorkAuthorization__c ' +
					    	 'Where (StatusCD__c != \'Actual\' OR (StatusCD__c = \'Actual\' And FISCAL_YEAR(ProcessedDate__c) = :intCurrentFY)) ' +
                             'ORDER BY 	Name ';
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_ReimbursableWorkAuthorization__c objRWA = null;
	        
	        for(sObject obj: scope) {
	        	objRWA = (Glxy_ReimbursableWorkAuthorization__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeasePaymentsSnapshot__c(
		        	AnnualAmount__c = objRWA.Amount__c,
		        	EffectiveDate__c = objRWA.EffectiveDate__c,
		        	FYObligation__c = objRWA.FY_Obligation__c,
		        	FYObligationIA__c = objRWA.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objRWA.FY_Obligation_NOA__c,
		        	IASqFt__c = objRWA.IA_Sq_Ft__c,
		        	NOASqFt__c = objRWA.NOA_Sq_Ft__c,
		        	IncludeinBudgetFlag__c = true,
		        	Payment_Category__c = 'RWA',
		        	ParentRecord__c = mapLeaseRecords.get(objRWA.LeaseNumber__r.Name),
		        	ProcessDate__c = objRWA.ProcessedDate__c,
		        	Source_Record__c = objRWA.ID		        	
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	}catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading RWA data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed RWA data; Loading IBAA data ...'
			);
			Update objSnapshotStatus; 
			
			database.executeBatch(new GLXY_SS_LoadIBAA());	
    	}
    }
	
}