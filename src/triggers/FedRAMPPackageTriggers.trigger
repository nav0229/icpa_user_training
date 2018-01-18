/*
    FedRAMPPackageTriggers.trigger
    Creates the Timelines that track how long a Package was in each stage.
    -------------------------------------------------------------------------------
    Author                 Date        Version  Description
    -------------------------------------------------------------------------------
    Damien Phillippi       02/21/2012  1.0.00   Creation
*/
trigger FedRAMPPackageTriggers on FedRAMP_Package__c (after insert, after update, before update)
{
    if (Trigger.isBefore && Trigger.isUpdate)
    {
        PackageUtil.updatePackage(Trigger.new);
    }
    
}