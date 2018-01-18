trigger GLXY_SnapshotObjectTrigger on Galaxy_Snapshot__c (before insert) {
	
	if(trigger.new.size() > 1){
		// Bulk project inserts/updates are not supported on this object ...
	    for (Galaxy_Snapshot__c objSnapshot:Trigger.new){
	    	objSnapshot.adderror('Batch inserts and updates have been disabled for this object. Please contact your System Administrator for more information.');
	    }
	    return;
	} 
	
	If(Trigger.isBefore && Trigger.isInsert){
		
		// 20 Max Snapshots, you could go 50 easily ...
		List<Galaxy_Snapshot__c> lstPreviousTotalSnapshots = [SELECT Id FROM Galaxy_Snapshot__c];
		if(lstPreviousTotalSnapshots.size() > 20 || (Test.isRunningTest() && lstPreviousTotalSnapshots.size() > 1)){
			for(Galaxy_Snapshot__c objSnapshot:trigger.new){
				objSnapshot.adderror('A maximum of 20 snapshots can be configured. Please contact your System Administrator.');
			}
			return;
		}
		
		// Check if one is scheduled already ...
		boolean blnExistingSnapshotRequest = false;
		List<Galaxy_Snapshot__c> lstPreviouslyScheduledSnapshots = [SELECT Id FROM Galaxy_Snapshot__c where (Status__c != 'Completed' And Status__c != 'Failed')];
		if(lstPreviouslyScheduledSnapshots.size() != 0){
			for(Galaxy_Snapshot__c objSnapshot:trigger.new){
				objSnapshot.adderror('The system allows only one snapshot to be configured at a time. Please try scheduling after the current one has finished execution.');
			}
			return;
		}

		/*//Make sure the job is running before a snapshot can be scheduled ...
		List<CronTrigger> GalaxySnapShotJob = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType From CronTrigger where CronJobDetail.Name = 'Galaxy - Create Snapshot'];
		if(GalaxySnapShotJob.size() == 0 && !Test.isRunningTest()){
			//System.schedule('Galaxy - Create Snapshot', '0 0 23 * * ?', new GLXY_BC_JobSchedule());
			for(Galaxy_Snapshot__c objSnapshot:trigger.new){
				objSnapshot.adderror('The Snapshot processing job is not configured. Please contact your System Administrator.');
			}
			return;
		}*/
		
	}
		
}