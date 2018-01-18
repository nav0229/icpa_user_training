global with sharing class GLXY_SS_LoadCPI implements Database.Batchable<sObject>,Database.stateful{
 
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
        string QuerySOQL = 'Select  ID, RecordType.DeveloperName, Acceptance620Date__c, AnnualAmount__c, Budget_Exclusion_Reason__c, EffectiveDate__c, ' +
	                       	'		FY_Obligation__c, FY_Obligation_IA__c, FY_Obligation_NOA__c, IA_Sq_Ft__c, ' +
							'		BDGFlag__c, LeaseNumber__r.Name, EscalationType__c, NOA_Sq_Ft__c, ' +
							'		ProcessedDate__c, PaymentID__c, StatusCD__c, LeaseNumber__r.ID, PastDueIndicator__c ' +
					    	'From 	Glxy_ConsumerPriceIndex__c ' +
					    	'Where (StatusCD__c != \'Actual\' OR (StatusCD__c = \'Actual\' And FISCAL_YEAR(ProcessedDate__c) = :intCurrentFY)) ' +    	
	                        'ORDER BY Name ';
        Return Database.getQueryLocator(QuerySOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_ConsumerPriceIndex__c objCPI = null;
	        
	        for(sObject obj: scope) {
	        	objCPI = (Glxy_ConsumerPriceIndex__c) obj;
		      	objSnapShotRecords.Add(new GLXY_LeasePaymentsSnapshot__c(
		        	Acceptance620Date__c = objCPI.Acceptance620Date__c,
		        	AnnualAmount__c = objCPI.AnnualAmount__c,
		        	BudgetExclusionReason__c = objCPI.Budget_Exclusion_Reason__c,
		        	EffectiveDate__c = objCPI.EffectiveDate__c,
		        	ExpirationDate__c = null,
		        	FYObligation__c = objCPI.FY_Obligation__c,
		        	FYObligationIA__c = objCPI.FY_Obligation_IA__c,
		        	FYObligationNOA__c = objCPI.FY_Obligation_NOA__c,
		        	IASqFt__c = objCPI.IA_Sq_Ft__c,
		        	IncludeinBudgetFlag__c = objCPI.BDGFlag__c,
		        	NOASqFt__c = objCPI.NOA_Sq_Ft__c,
		        	ParentRecord__c = mapLeaseRecords.get(objCPI.LeaseNumber__r.Name),
		        	Payment_Category__c = 'Consumer Price Index',
		        	PaymentID__c = objCPI.PaymentID__c,
		        	PaymentType__c = objCPI.EscalationType__c,
		        	PastDueIndicator__c = objCPI.PastDueIndicator__c,
		        	ProcessDate__c = objCPI.ProcessedDate__c,
		        	Record_Type__c = objCPI.RecordType.DeveloperName,
		        	Source_Record__c = objCPI.ID,
		        	Status_Code__c = objCPI.StatusCD__c
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	}catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading CPI data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed CPI data; Loading Step Rent data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadStepRent());	
    	}
    }
	
}