global with sharing class GLXY_SS_LoadLease implements Database.Batchable<sObject>,Database.stateful{
    
    global List<Glxy_LeaseSnapshot__c> objSnapShotRecords = New List<Glxy_LeaseSnapshot__c>();
	public string 	strSnapShotID;
	public string 	strSnapShotName;
	public boolean 	blnProcessErrors = false;
	public string	strLimitClause = '';
	 
    global Database.QueryLocator start(Database.BatchableContext BC){
    	
    	List<Galaxy_Snapshot__c> lstPreviouslyScheduledSnapshots = 
						[SELECT Id, Name 
						 FROM 	Galaxy_Snapshot__c 
						 Where 	Status__c = 'Scheduled'
						 And 	Snapshot_Date__c = :Datetime.Now().Date() 
						 Limit 1];
		if(lstPreviouslyScheduledSnapshots.size() != 0){
			strSnapShotID = lstPreviouslyScheduledSnapshots[0].Id;
			strSnapShotName = lstPreviouslyScheduledSnapshots[0].Name;
					
			//Update the status to Started
			Galaxy_Snapshot__c objProcessing = lstPreviouslyScheduledSnapshots[0];
			objProcessing.Status__c = 'Started';
			Update objProcessing;
		} else {
			//Salesforce does not provide mechanism to exit start method
			strLimitClause = 'Limit 0';
		}
	 
        string QueryAllLeases = 'Select ID, Name, Antennas__c, BaseAnnualRent__c, BaseSquareFeet__c, BaseStructuredParkingSpaces__c, ' +
		                                 'BaseSurfaceParkingSpaces__c, DelegatedLease__c, IAConverstionDate__c, IAPercentage__c, ' +
								    	 'LandOnly__c, BaseLeaseEffectiveDate__c, ExpirationDateofLease__c, TerminationDateofLease__c, ' +
								    	 'Next_FY_Leases__c, NOAPercentage__c, ParkingOnly__c, RealtySpecialist__c, HoldoverExpirationDate__c, HoldoverStatusInd__c, ' +
								    	 'RegionCD__c, StatusCode__c, TeamCode__c, Total_IA_Sq_feet__c, Total_NOA_Sq_feet__c ' +  
						    	 'From  GLXY_Lease__c ' +
						    	 //'Where StatusCode__c = \'Active\' ' + 
                                 //'And   Next_FY_Leases__c = False ' +
                                 'ORDER BY Name ' + strLimitClause;
        Return Database.getQueryLocator(QueryAllLeases);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        try{
        	objSnapShotRecords.clear();
	        Glxy_Lease__c objLease = null;
	        
	        for(sObject obj: scope) {
	        	objLease = (Glxy_Lease__c) obj;
		      	objSnapShotRecords.Add(new Glxy_LeaseSnapshot__c(
		        	Antennas__c = objLease.Antennas__c,
		        	BaseAnnualRent__c = objLease.BaseAnnualRent__c,
		        	BaseSquareFeet__c = objLease.BaseSquareFeet__c,
		        	BaseStructuredParkingSpaces__c = objLease.BaseStructuredParkingSpaces__c,
		        	BaseSurfaceParkingSpaces__c = objLease.BaseStructuredParkingSpaces__c,
		        	DelegatedLease__c = objLease.DelegatedLease__c,
		        	HoldoverExpirationDate__c = objLease.HoldoverExpirationDate__c,
		        	HoldoverStatusInd__c = objLease.HoldoverStatusInd__c,
		        	IAConverstionDate__c = objLease.IAConverstionDate__c,
		        	IAPercentage__c = objLease.IAPercentage__c,
		        	LandOnly__c = objLease.LandOnly__c,
		        	LeaseEffectiveDate__c = objLease.BaseLeaseEffectiveDate__c,
		        	LeaseExpirationDate__c = objLease.ExpirationDateofLease__c,
		        	LeaseNumber__c = objLease.Name,
		        	LeaseTerminationDate__c = objLease.TerminationDateofLease__c,
		        	NextFYLeases__c = objLease.Next_FY_Leases__c,
		        	NOAPercentage__c = objLease.NOAPercentage__c,
		        	RealtySpecialistEmail__c = objLease.RealtySpecialist__c,
		        	RegionCode__c = objLease.RegionCD__c,
		        	SnapshotName__c = strSnapShotID,
		        	SourceRecord__c = objLease.ID,
		        	StatusCode__c = objLease.StatusCode__c,
		        	Team_Code__c = objLease.TeamCode__c,
		        	TotalIASqft__c = objLease.Total_IA_Sq_feet__c,
		        	TotalNOASqft__c = objLease.Total_NOA_Sq_feet__c,
		        	UniqueID__c = strSnapShotID + '||' + objLease.ID
		        ));
        	}	
        	Database.SaveResult[] result = Database.Insert(objSnapShotRecords);
	 	
	 	}catch (Exception e){
	 		blnProcessErrors = true;
        	Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID, Status__c = 'Failed', StatusMessage__c = 'Snapshot process error (Loading Lease data) - ' + e.getMessage());
			Update objSnapshotStatus;
    	}

    }
    
    global void finish(Database.BatchableContext BC){
    	If (!blnProcessErrors && (strLimitClause != 'Limit 0')){
    		Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = strSnapShotID,
				StatusMessage__c = 'Completed Lease snap shot; Loading CPI data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadCPI());
    	}
    }

}