global with sharing class GLXY_SS_LoadIBAA implements Database.Batchable<sObject>,Database.stateful{
 
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
        string  QuerySOQL = 'Select 	ID, LeaseNumber__r.ID, AuthorizedAmount__c, EffectiveDate__c, ProcessedDate__c, ' +
                             '			FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, IA_Sq_Ft__c, ' +
					    	 '			LeaseNumber__r.Name, NOA_Sq_Ft__c, StatusCd__c  ' +
					    	 'From 		Glxy_IntraBudgetActivityAuthorization__c ' +
					    	 'Where (StatusCD__c != \'Actual\' OR (StatusCD__c = \'Actual\' And FISCAL_YEAR(ProcessedDate__c) = :intCurrentFY)) ' + 
                             'ORDER BY 	Name ';
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_IntraBudgetActivityAuthorization__c objIBAA = null;
	        
	        for(sObject obj: scope) {
	        	objIBAA = (Glxy_IntraBudgetActivityAuthorization__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeasePaymentsSnapshot__c(
		        	AnnualAmount__c = objIBAA.AuthorizedAmount__c,
		        	EffectiveDate__c = objIBAA.EffectiveDate__c,
		        	FYObligation__c = objIBAA.FY_Obligation__c,
		        	FYObligationIA__c = objIBAA.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objIBAA.FY_Obligation_NOA__c,
		        	IASqFt__c = objIBAA.IA_Sq_Ft__c,
		        	NOASqFt__c = objIBAA.NOA_Sq_Ft__c,
		        	IncludeinBudgetFlag__c = true,
		        	Payment_Category__c = 'IBAA',
		        	ParentRecord__c = mapLeaseRecords.get(objIBAA.LeaseNumber__r.Name),
		        	ProcessDate__c = objIBAA.ProcessedDate__c,
		        	Source_Record__c = objIBAA.ID,
		        	Status_Code__c = objIBAA.StatusCd__c		        	
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	}catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading IBAA data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed IBAA data; Loading Lease Projects data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadLeaseProject());	
    	}
    }
	
}