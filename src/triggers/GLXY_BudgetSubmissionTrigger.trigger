trigger GLXY_BudgetSubmissionTrigger on Glxy_BudgetSubmission__c (before insert, before delete, before update) {
    
    if(Glxy_RecursiveBlocker.isFutureUpdate != true){
        
        boolean blnMemberOfCOGroup = false;
        String strReportingFY;
        String strSubmissionType;
        
        String strErrorMessageCO = 'This operation is restriced to Central Office Users only.';
        String strErrorMessageUnLock = 'The Unlock operation is restriced to Central Office Users only.';
        String strErrorMessageDelete = 'This operation is restriced by the System Administrator.';
        String strRecordLocked = 'This record is locked, and can not be edited.';
        string strDefaultRegion = 'CO';
        
        //Permissions ...
        for (GroupMember gm : [SELECT Id, group.id, group.name, group.type FROM GroupMember where (UserOrGroupId = :UserInfo.getUserId() AND group.type='Regular')]){
            If (gm.group.name == 'Galaxy-CO-Users'){
                blnMemberOfCOGroup = true;
            }
        }
                
        If(Trigger.isBefore && Trigger.isInsert){
            If (!blnMemberOfCOGroup){ 
                for(Glxy_BudgetSubmission__c UpdatedRecord:trigger.new){
                    //If (!Test.isRunningTest()){
                        UpdatedRecord.addError('This operation is restriced to Central Office Users only.');
                    //} 
                }
            }
        }
        
        If(Trigger.isBefore && Trigger.isUpdate){
            If (!blnMemberOfCOGroup || Test.isRunningTest()){ 
                for(Glxy_BudgetSubmission__c UpdatedRecord:trigger.new){
                    Glxy_BudgetSubmission__c OldValues = Trigger.oldMap.get(UpdatedRecord.ID);
                    if ((UpdatedRecord.LockRAWData__c == false && OldValues.LockRAWData__c == true) ) {
                        //If (!Test.isRunningTest()){
                            UpdatedRecord.addError('The Unlock operation is restriced to Central Office Users only.');
                        //}
                    }
                    if (UpdatedRecord.LockAdjustmentData__c == false && OldValues.LockAdjustmentData__c == true) {
                        //If (!Test.isRunningTest()){
                            UpdatedRecord.addError('The Unlock operation is restriced to Central Office Users only.');
                        //}
                    }
                }
            }
        }
        
        If(Trigger.isBefore && Trigger.isDelete){
            /*If (!blnMemberOfCOGroup){ 
                for(Glxy_BudgetSubmission__c UpdatedRecord:trigger.old){
                    UpdatedRecord.addError('This operation is restriced to Central Office Users only.');
                }
            }*/
            for(Glxy_BudgetSubmission__c UpdatedRecord:trigger.old){
                //If (!Test.isRunningTest()){
                    UpdatedRecord.addError('This operation (record delete) is restriced by the System Administrator.');
                //}
            }
        }
        
        If(Trigger.isBefore && Trigger.isInsert){
             for (Glxy_BudgetSubmission__c obj: trigger.new){
                //Default the current record region to CO ...
                obj.RegionCD__c = 'CO';
                strReportingFY = obj.ReportingFiscalYear__c;
                strSubmissionType = obj.SubmissionType__c;
             }
             //Add records for other regions ...
             GLXY_FutureMethods.AddRegionalBudgetSubmissions(strReportingFY, strSubmissionType);
        }
        
    }
    
}