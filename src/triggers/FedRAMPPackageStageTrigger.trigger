trigger FedRAMPPackageStageTrigger on FedRAMP_Package_Stage__c (after insert, after update, before insert, before update) {
    if (Trigger.isBefore&& Trigger.isInsert) {
        PackageUtil.stageValidations(Trigger.new);
    }
    if (Trigger.isBefore&& Trigger.isUpdate) {
        PackageUtil.stageValidations(Trigger.new);      
    }
    
    if(Trigger.isAfter && Trigger.isInsert){
        PackageUtil.updatePackageProgress(Trigger.new);
        //UpdatePackageProgress.updatePackageProcess(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        PackageUtil.updatePackageProgress(Trigger.new);
        //UpdatePackageProgress.updatePackageProcess(Trigger.new);
    }
}