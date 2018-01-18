trigger SF182TrainingTrigger on SF_182_Training__c(After Update,After Insert, before Insert,before Update) {
if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ){        
            String form182;
            String recordId;
            String supervisor;
            String approvalStatus;
            for(SF_182_Training__c sf182trng : Trigger.new){
                    form182 = sf182trng.SF_182__c;
                     recordId = sf182trng.SF_182__c;               
            }
            List<Form_SF_182__c> lstFormSF182 = [SELECT Id,IDP_Supervisor__c, IDP__c FROM Form_SF_182__c WHERE Id = :form182];
            for(SF_182_Training__c sfTraining : Trigger.new){
                if(sfTraining.Supervisor__c == null) {
                   sfTraining.Supervisor__c = lstFormSF182[0].IDP_Supervisor__c;                   
                   }                             
               }
              
}
 if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
            String recordId;
            String supervisor;
            String Approver1;
            String Approver2;
            String Approver3;
            String Approver4;
            String pruTraining;
            String ApprovalStatus;
            String status;
            String removeApp1;
            String removeApp2;
            String removeApp3;
            String removeApp4;
            String uid = userinfo.getUserId();
            String activity;
            String IdpId;
            String ownerId;
            String pchpg;
            String recordTypeName;
            Boolean finalApprover;
            Boolean cancelTrng;
            Boolean removeCancelTrng;
            for(SF_182_Training__c sf182trng : Trigger.new){                            
                    recordId = sf182trng.SF_182__c;               
                    supervisor = sf182trng.Supervisor__c;
                    approver1 = sf182trng.Approver_1__c;
                    approver2 = sf182trng.Approver_2__c;
                    approver3 = sf182trng.Approver_3__c;
                    approver4 = sf182trng.Approver_4__c;
                    approvalStatus = sf182trng.Approval_Status__c;
                    status = sf182trng.Request_Status__c;                                    
                    activity = sf182trng.Activity__c;
                    IdpId = sf182trng.IDP_Name__c;
                    finalApprover = sf182trng.Final_Approver__c;
                    ownerId = sf182trng.CreatedById;
                    pruTraining = sf182trng.Purchasing_Training_Coordinator__c;
                    cancelTrng = sf182trng.Cancel_My_Training__c;
                    pchpg = sf182trng.Purchasing_Training_Coordinator_Group__c;
                    //finalApprover = sf182trng.Final_Approver__c;
                    if(Trigger.isUpdate){  
                       SF_182_Training__c oldValues = Trigger.oldMap.get(sf182trng.Id);  
                        removeApp1 = oldValues.Approver_1__c;
                        removeApp2 = oldValues.Approver_2__c;
                        removeApp3 = oldValues.Approver_3__c;
                        removeApp4 = oldValues.Approver_4__c;   
                        removeCancelTrng = oldValues.Cancel_My_Training__c; 
                    }
                     }
            system.debug('This is IDP Id ' + IdpId);
           List<Group> lstG = [SELECT Id, Name, DeveloperName From Group WHERE Name = :pchpg LIMIT 1];
           List<IDP_Developmental_Line_Item__c> activityLookup = [SELECT Id, Name, IDP_ID__c, IDP_Name__c FROM IDP_Developmental_Line_Item__c WHERE Id = :activity];
           system.debug('This is activity ' + activityLookup);
           List<IDP__c> lstIdps = [SELECT Id,Name FROM IDP__c WHERE Id = :IdpId];
           
            for(SF_182_Training__c sf182trng : Trigger.new){
            //Business user don't want to add the validation for the Activity...Srini
            //if(!activityLookup.isEmpty() && activityLookup[0].IDP_ID__c != IdpId){
               //sf182trng.addError('The Activity you selected does not belong to the IDP Selected (' + lstIdps[0].Name + ') on SF 182. Please select Related Activity');
          //}
           
           if(status == 'Initiating' && supervisor == ownerId) {
                   sf182trng.addError(' Supervisor: Please select a user other than yourself.');
               } 
              
           if(uid != supervisor && cancelTrng == true){
                  sf182trng.addError(' Training Cancellation: You do not have permissions to cancel this training record. Please contact the supervisor');
           }
           if(uid != supervisor && removeCancelTrng == true && cancelTrng == false){
                 sf182trng.addError(' Training Cancellation: You do not have permissions to not cancel this training record. Please contact the supervisor');
           }
           if(ApprovalStatus == 'Reviewed by Approver 4' && approver4 != null && pruTraining == null){
                    sf182trng.addError(' Purchasing Training Coordinator: Please select a Purchasing Training Coordinator before approving the record.');
              }
           }
             if(ApprovalStatus == 'Pending Supervisor Review'){
                        List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                        new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c')              
                        };   
                             RecordSharingUtil.share(trs);                   
                 }            
              
              if(ApprovalStatus == 'Reviewed by Supervisor' || ApprovalStatus == 'Pending Approver 1 Review') {
                      List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                        new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c')              
                        };   
                             RecordSharingUtil.share(trs);                   
                 } 
              if(ApprovalStatus == 'Reviewed by Approver 1' || ApprovalStatus == 'Pending Approver 2 Review') {
                    List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                      new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Edit', 'Approver2_Access__c')              
                       };   
                            RecordSharingUtil.share(trs);                   
                 }  
                       
              if(ApprovalStatus == 'Reviewed by Approver 2' || ApprovalStatus == 'Pending Approver 3 Review') {
                    List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                       new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Edit', 'Approver2_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver3, 'Edit', 'Approver3_Access__c')              
                       };   
                            RecordSharingUtil.share(trs);                   
                 }             
              if(ApprovalStatus == 'Reviewed by Approver 3' || ApprovalStatus == 'Pending Approver 4 Review') {
                    List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                       new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Edit', 'Approver2_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver3, 'Edit', 'Approver3_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver4, 'Edit', 'Approver4_Access__c')              
                       };   
                            RecordSharingUtil.share(trs);                   
                 }
                 
                 if(finalApprover == True) {
                    if(pchpg != null) {
                    List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                       new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Edit', 'Approver2_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver3, 'Edit', 'Approver3_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, lstG[0].Id, 'Edit', 'PurchasingTrainingCoordinator_Access__c', true)              
                       };   
                            RecordSharingUtil.share(trs);     
                    }       
                    if(pruTraining != null) {
                    List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                       new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Edit', 'Approver2_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver3, 'Edit', 'Approver3_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, pruTraining, 'Edit', 'PurchasingTrainingCoordinator_Access__c')              
                       };   
                            RecordSharingUtil.share(trs);     
                    }              
                 }
              
                 if(ApprovalStatus == 'New' ){
                        List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                        new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, removeApp1, 'Edit', 'Approver1_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, removeApp2, 'Edit', 'Approver2_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, removeApp3, 'Edit', 'Approver3_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, removeApp4, 'Edit', 'Approver4_Access__c')              
                        };   
                             RecordSharingUtil.unshare(trs);                   
                 }
                 if(ApprovalStatus == 'Final Approval' ){
                        List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                        new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Edit', 'Approver1_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Edit', 'Approver2_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver3, 'Edit', 'Approver3_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, approver4, 'Edit', 'Approver4_Access__c'),
                       new recordSharingUtil.RecordSharingDefiniation(recordId, pruTraining, 'Edit', 'PurchasingTrainingCoordinator_Access__c')              
                        };   
                             RecordSharingUtil.share(trs);                   
                 }
                 if(Status == 'Rejected' || Status == 'Correction'){
                        List<RecordSharingUtil.RecordSharingDefiniation> trs = new List<recordSharingUtil.RecordSharingDefiniation>{
                        new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, approver1, 'Read', 'Approver1_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, approver2, 'Read', 'Approver2_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, approver3, 'Read', 'Approver3_Access__c'),
                        new recordSharingUtil.RecordSharingDefiniation(recordId, approver4, 'Read', 'Approver4_Access__c')              
                        };   
                             RecordSharingUtil.share(trs);                   
                 }                              
            }
 
}