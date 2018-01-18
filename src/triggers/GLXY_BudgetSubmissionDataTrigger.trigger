trigger GLXY_BudgetSubmissionDataTrigger on Glxy_BudgetSubmissionData__c (before delete, before insert, before update) {
        
        boolean blnMemberOfCOGroup = true;
        string strErrorMessage = 'This operation is restriced to Central Office Users only.';
        string strErrorMessageAdmin = 'This operation is restriced by the System Administrator.';
        String strRecordLocked = 'This record is locked, and can not be edited.';
        
        //Permissions ...
        /*for (GroupMember gm : [SELECT Id, group.id, group.name, group.type FROM GroupMember where (UserOrGroupId = :UserInfo.getUserId() AND group.type='Regular')]){
            If (gm.group.name == 'Galaxy-CO-Users'){
                blnMemberOfCOGroup = true;
            }
        }*/
        
        If(Trigger.isBefore && Trigger.isInsert){
            // The NEW button has been taken off the layout. 
            /*If (!blnMemberOfCOGroup){ 
                for(Glxy_BudgetSubmissionData__c UpdatedRecord:trigger.new){
                    UpdatedRecord.addError('This operation is restriced to Central Office Users only.');
                }
            }*/
        }
        
        If(Trigger.isBefore && Trigger.isDelete){
                for(Glxy_BudgetSubmissionData__c UpdatedRecord:trigger.old){
                    /*If (!blnMemberOfCOGroup){ 
                        UpdatedRecord.addError('This operation is restriced to Central Office Users only.');
                    }
                    If (UpdatedRecord.RecordLocked__c){
                        UpdatedRecord.addError('This record is locked, and can not be deleted.');
                    }*/
                    //If (!Test.isRunningTest()){
                        UpdatedRecord.addError('This operation is restriced by the System Administrator.');
                    //}
                }
        }
        
        If(Trigger.isBefore && Trigger.isUpdate){
            for(Glxy_BudgetSubmissionData__c UpdatedRecord:trigger.new){
                If (UpdatedRecord.RecordLocked__c){
                    UpdatedRecord.addError('This record is locked, and can not be edited.');
                }
            }
        }
}