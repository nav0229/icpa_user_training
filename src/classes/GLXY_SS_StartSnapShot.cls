global with sharing class GLXY_SS_StartSnapShot implements Schedulable{
	
	global void execute(SchedulableContext sc){
		
		/*List<Galaxy_Snapshot__c> lstPreviouslyScheduledSnapshots = 
			[SELECT Id, Name 
			 FROM 	Galaxy_Snapshot__c 
			 Where 	Status__c = 'Scheduled'
			 And 	Snapshot_Date__c = :Datetime.Now().Date() 
			 Limit 1];
		
		System.Debug('MyDebugSS-' + lstPreviouslyScheduledSnapshots.size());
		if(lstPreviouslyScheduledSnapshots.size() != 0){
			
			Galaxy_Snapshot__c objSnapshotStatus = New Galaxy_Snapshot__c(
				ID = lstPreviouslyScheduledSnapshots[0].Id,
				Status__c = 'Started',
				StatusMessage__c = 'Snapshot creation started, loading lease data ...'
			);
			Update objSnapshotStatus;
			
			database.executeBatch(new GLXY_SS_LoadLease());

		}*/
		
		database.executeBatch(new GLXY_SS_LoadLease());
	}
}