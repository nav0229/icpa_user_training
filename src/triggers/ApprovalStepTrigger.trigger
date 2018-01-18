/*-------------------------------------------------------------------------------------------------*
  Approval Step Trigger.
  Trigger on Approval Step to do the following:
   - Automated Apex Managed Sharing
   - Automated OOTB Approval Step creation
   - Date Difference Calculation
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Stefan Maurer      09/23/2014    1.0       Created
  Sathish Durairaj   10/03/2014    1.1       Updated the trigger to accommodate all logic
  Raja Kumar P       02/22/2016    1.2       To invoke the due date validation case# 22035
  Raja Kumar P       03/10/2016    1.3       Prevent the recursion for case# 22417 (Unable to initiate more than 5 approval steps at the same time) 
  Raja Kumar P       08/11/2016    1.4       case#27165- Update the date validation to bypass during batch updates of days open calculation.
  Raja Kumar P       03/30/2017    1.5       case# 31205 - Implement the logic of permission sets to validate the CDT users
 *-------------------------------------------------------------------------------------------------*/

trigger ApprovalStepTrigger on Approval_Step__c (after insert, after update, after delete, after undelete, before delete, before insert, before update) {

    public Double daysOpen;
    public List<Approval_Step__c> lstApprovalSteps;
    public BusinessHours cdtBusinessHours = [
                                    SELECT Id
                                    FROM BusinessHours
                                    WHERE Name = 'CDT Business Hours'
                                ];

    if(Trigger.isBefore) {
        // BEFORE INSERT
        if(trigger.isInsert){

            performBusinessDaysCalculations(trigger.new);
            doValidateCDTUsers(Trigger.new, null);
        }
        // BEFORE UPDATE
        if(trigger.isUpdate){
            // case# 22417 BEGIN - recursion prevention logic
            if(!ApprovalStepCheckRecursive.hasAlreadyUpdated()) {
            // case# 22417 END - recursion prevention logic
                NotificationItemCreationHandler.createApprovalStepNotifications(trigger.new);
                setActualApproverOnApprovalStep(trigger.old, trigger.new);
                performBusinessDaysCalculations(trigger.new);            
                // case# 22035 BEGIN - enforce the due date validation during field updates
                doValidateDueDate(trigger.new, trigger.oldMap);
                // case# 22035 END - enforce the due date validation during field updates
                doValidateCDTUsers(Trigger.new, Trigger.oldMap);
                DelegateFieldAssignmentOnApprovalStep.setRolesOfActualApprovers(trigger.oldMap, trigger.newMap);
            // case# 22417 BEGIN - recursion prevention logic
            }
            // case# 22417 END - recursion prevention logic
        }
        // BEFORE DELETE
        if(trigger.isDelete){
            
        }
        // BEFORE UNDELETE
        if(trigger.isUndelete){

        }

    }
    else {
        // AFTER INSERT
        if(Trigger.isInsert){

            ShareDocumentToApproversHelper.manageControlledDocumentSharing(trigger.oldMap, trigger.new);
            ChatterFileCollaboratorTH.createCollaborators(trigger.new);

        }
        // AFTER UPDATE
        else if(Trigger.isUpdate){
            // case# 22417 BEGIN - recursion prevention logic during field updates
            if(!ApprovalStepCheckRecursive.hasAlreadyUpdated()) {
            // case# 22417 END - recursion prevention logic
                ShareDocumentToApproversHelper.manageControlledDocumentSharing(trigger.oldMap, trigger.new);
                ChatterFileCollaboratorTH.updateCollaborators(trigger.oldMap, trigger.newMap);
                SupplementaryAccessUserGranterApprvlStep.updateSupplementsForApprovalSteps(trigger.oldMap, trigger.new);
                ApprovalStepCheckRecursive.setAlreadyUpdated();
            // case# 22417 BEGIN - recursion prevention logic during field updates
            }  
            // case# 22417 END - recursion prevention logic
        }
        // AFTER DELETE
        else if(Trigger.isDelete){

            // do nothing

        }
        // AFTER UNDELETE
        else{
            
            ChatterFileCollaboratorTH.createCollaborators(trigger.new);

        }
    }

    private static Long getBsnsHoursDifference(BusinessHours bsnsHours, Datetime startTime, Datetime endTime){
        
        Long l = BusinessHours.diff(bsnsHours.Id, startTime, endTime);
        return l/1000/3600/8;

    }
    
    // case# 22035 BEGIN - enforce the due date validation during field updates
    // for validating the due date during approval process field updates
    private static void doValidateDueDate(List<Approval_Step__c> newSteps, Map<Id,Approval_Step__c> oldStepsMap) {
        for(Approval_Step__c step: newSteps) {            
            if(step.Due_Date__c != null && step.Due_Date__c < Date.today() && step.Approval_Status__c == 'Initiated' && 
                // added below criteria for case# 27165
                step.Approval_Status__c != oldStepsMap.get(step.Id).Approval_Status__c) {
                step.addError('The Due Date must be equal or later than today');
            }            
        }
    }
    // case# 22035 END - enforce the due date validation during field updates
    // case# 31205 BEGIN
    private static void doValidateCDTUsers(List<Approval_Step__c> newSteps, Map<Id, Approval_Step__c> oldStepsMap) {
        // this is to validate the approver before create and update
        Set<Id> userIds = new Set<Id>();
        for(Approval_Step__c step: newSteps) {
            if(step.Assigned_Approver__c != null && (oldStepsMap == null || 
                                                     step.Assigned_Approver__c != oldStepsMap.get(step.Id).Assigned_Approver__c)) {
                userIds.add(step.Assigned_Approver__c);
            }
        }
        Map<Id,Id> userToPsetMap = new Map<Id,Id>();
        for(PermissionSetAssignment passign : [SELECT Id, AssigneeId, PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId IN :userIds AND
                                               PermissionSet.Name Like 'Controlled_Document%']) {
                                                   if(!userToPsetMap.containskey(passign.AssigneeId))
                                                       userToPsetMap.put(passign.AssigneeId, passign.PermissionSetId);
                                               }
        Map<Id, Id> adminsMap = new Map<Id, Id>();
        for(User u: [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() AND IsActive=true 
                     AND Profile.Name IN ('GSA System Administrator','GSA System User','System Administrator')]) {
            adminsMap.put(u.Id, u.Id);
        }
        for(Approval_Step__c step: newSteps) {
            if(step.Assigned_Approver__c != null && (oldStepsMap == null || 
                                                     step.Assigned_Approver__c != oldStepsMap.get(step.Id).Assigned_Approver__c)) {
                if(adminsMap.isEmpty() && !userToPsetMap.containsKey(step.Assigned_Approver__c))
                  step.addError('You must select the valid CDT user, please email executive-secretariat@gsa.gov for adding new CDT users.');
            }
        }
    }
    // case# 31205 END
    // not really sure what this is or where to put it but I wanted to make the trigger up above more readable at a glance
    private static void performBusinessDaysCalculations(List<Approval_Step__c> newSteps){

        Datetime current = System.now();
        Date currDate = current.date();
        Time currTime = Time.newInstance(0, 0, 0, 0);
        Datetime currentLocal = Datetime.newInstance(currDate, currTime);

        for (Approval_Step__c step : newSteps) {

            if ((step.Start_date__c != NULL) && (step.Approval_Status__c != 'Not Initiated')) {

                if ((step.Completed_Date__c != null)) {
                    daysOpen = getBsnsHoursDifference(cdtBusinessHours, step.Start_date__c, step.Completed_Date__c);
                }
                else {
                    daysOpen = getBsnsHoursDifference(cdtBusinessHours, step.Start_date__c, currentLocal);
                }
                step.days_open__c =  daysOpen;

            }              

        }
    }

    private static void setActualApproverOnApprovalStep(List<Approval_Step__c> oldSteps ,List<Approval_Step__c> newSteps){

        List<User> userList = [SELECT Id, Name FROM User WHERE Id = :UserInfo.getUserId()];

        if(userList.isEmpty()) return; // in what world would this happen? O__O

        for(Approval_Step__c oldStep : oldSteps){

            for(Approval_Step__c newStep : newSteps){

                if(oldStep.Approval_Status__c != newStep.Approval_Status__c 
                    && (newStep.Approval_Status__c == 'Approved' || newStep.Approval_Status__c == 'Approved w Comments')){

                    newStep.Actual_Approver__c = userList[0].Name;

                }

            }

        }

    }

}