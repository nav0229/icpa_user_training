/*-------------------------------------------------------------------------------------------------*
  Apex class 
  TaskHelper is used for Task object trigger
  It will send an email to the assignee on the email reminder date.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/08/2013    1.0       O&M Case # 00009464
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/

public class TaskHelper {
    
    public static void onBeforeInsert(List<Task> triggerNew) {
    // Validations
        for(Task t: triggerNew) {
            if (t.ActivityDate !=null && t.Email_Reminder_Date__c !=null) {
                DateTime dtime = t.Email_Reminder_Date__c;
                Date dtonly = Date.newInstance(dtime.year(),dtime.month(),dtime.day());
                if(dtonly > t.ActivityDate)
                    t.addError('Please select the Email Reminder Date earlier than Due Date');
            }
            
            if (t.ActivityDate ==null && t.Email_Reminder_Date__c !=null) {
                t.addError('Please select the Email Reminder Date and Due Date');
            }
        }
    }
    
    public static void onBeforeUpdate(List<Task> triggerNew, Map<Id, Task> triggerOldMap, Map<Id, Task> triggerNewMap) {
    // Invoke the email notification in EMAIL_SENT__c field update
        Set<Id> tasklst = new Set<Id>();
        if(!RecursionProcessControl.inFutureContext) {
            for(Task t: triggerNew) {
                if (t.ActivityDate !=null && t.Email_Reminder_Date__c !=null) {
                    DateTime dtime = t.Email_Reminder_Date__c;
                    Date dtonly = Date.newInstance(dtime.year(),dtime.month(),dtime.day());
                    if(dtonly > t.ActivityDate)
                        t.addError('Please select the Email Reminder Date earlier than Due Date');
                }
            
                if (t.ActivityDate ==null && t.Email_Reminder_Date__c !=null) {
                    t.addError('Please select the Email Reminder Date and Due Date');
                }
                // this is the scenario when workflow field update is triggered thru time based trigger
                if(t.ActivityDate !=null && t.Email_Reminder_Date__c !=null &&
                    t.Email_Sent__c != triggerOldMap.get(t.Id).Email_Sent__c && t.Email_Sent__c) {
                    tasklst.add(t.Id);
                }    
            }
            if(!tasklst.isEmpty()) {
                TaskHelper.updateRecordsWithDMLOptions(tasklst);
                System.debug('UPDATE COMPLETED IN TASK TRIGGER');
            }      
        }
    }
    
    @future 
    public static void updateRecordsWithDMLOptions(Set<Id> taskids) {
    // Method to update the records with email notifications 
        Database.DMLOptions dmo = new Database.DMLOptions(); 
        dmo.EmailHeader.triggerUserEmail = true; 
        List<Task> taskstoupdate = [SELECT Id, Subject FROM Task WHERE Id IN :taskids];
        RecursionProcessControl.inFutureContext = true;
        Database.update(taskstoupdate, dmo); // Actual DML operation is performed instead of implicit update
        System.debug('UPDATE COMPLETED FROM TASKHELPER CLASS FUTURE METHOD');
    }
}