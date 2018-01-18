trigger FedRAMPStageActivity on FedRAMP_Stage_Activity__c (after insert, after update, before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert) {     
           PackageUtil.checkActorActivity(trigger.new);
           PackageUtil.checkEndDate(trigger.new);
        }
    if (Trigger.isBefore && Trigger.isUpdate) {
           PackageUtil.checkEndDate(trigger.new);
    }

}