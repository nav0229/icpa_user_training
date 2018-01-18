trigger PDE_MigrateCustomRecordToCaseObject on PDE_Case_Entry__c (after insert, after update) {

id TriggerId = null;
     for(PDE_Case_Entry__c pdece : Trigger.new)
     {
         if(pdece.PDE_Attachments_To_Load_Counter__c  == 0)
         {
           TriggerId = pdece.Id;
           break;
         }
         
     }
     if (TriggerId != null)
     {
         id CaseId = PDEHelper.MigrateFromCustomObject2Case(TriggerId);
         PDEHelper.sendemail(CaseId);
     }
}