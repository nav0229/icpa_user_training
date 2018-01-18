trigger GLXY_ProjectRequestASATrigger on Glxy_ProjectRequestASA__c (after insert, after update, before delete, after delete) {
	
	if(Trigger.isBefore && Trigger.isDelete){
		System.Debug('MyDebug - Before Delete');
		Set<string> MasterIDsToUpdate = new Set<string>();	
		for (Glxy_ProjectRequestASA__c objRequestASA : Trigger.Old) {
        	MasterIDsToUpdate.add (objRequestASA.ProjectAgencyID__c);
        }
        GLXY_DeriveOldASA.glbMasterIDsToUpdate = MasterIDsToUpdate;
	}
	
	if(Trigger.isAfter && Trigger.isDelete){
		System.Debug('MyDebug - After Delete');
		GLXY_DeriveOldASA.fnUpdateASA(GLXY_DeriveOldASA.glbMasterIDsToUpdate);
	}
	
	if(Trigger.isAfter && !Trigger.isDelete){
		//Get all Project Agencies to be updated
		List<string> MasterIDsToUpdateList = new List<string>();
		Set<string> MasterIDsToUpdateSet = new Set<string>();	
		for (Glxy_ProjectRequestASA__c objRequestASA : Trigger.new) {
        	MasterIDsToUpdateList.add(objRequestASA.ProjectAgencyID__c);
        }     		
        MasterIDsToUpdateSet.addAll(MasterIDsToUpdateList);
		GLXY_DeriveOldASA.fnUpdateASA(MasterIDsToUpdateSet);
		System.Debug('MyDebug - After Insert or Update');
	}
}