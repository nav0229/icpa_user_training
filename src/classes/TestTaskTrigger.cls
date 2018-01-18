/*-------------------------------------------------------------------------------------
  TestTaskTrigger.cls
  Class for testing Task trigger on Task object
  -------------------------------------------------------------------------------------
  Author                |Date       |Version  |Description
  -------------------------------------------------------------------------------------
  Rajakumar              11/12/2013  1.0       O&M Case # 00009464
  Rajakumar              07/01/2014  1.1       Updated SOQL query for user selection
  -------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------
*/  
@isTest
private class TestTaskTrigger {
    
    @isTest
    static void testRecordInsertValidation() {
        List<Task> taskslist = new List<Task>();
        List<Id> recordIds = new List<Id>();
        List<User> users = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
            
        for(Integer i=0;i<2;i++) {
            taskslist.add(new Task(Subject='Trig0231$Test0Task', OwnerId=users[0].Id,
                                   ActivityDate=Date.Today()-1, Email_Reminder_Date__c = DateTime.Now(), Email_Sent__c=true));
            taskslist.add(new Task(Subject='Trig0231$Test0Task', OwnerId=users[0].Id,
                                   ActivityDate=null, Email_Reminder_Date__c = DateTime.Now(), Email_Sent__c=false));                                               
        }
        try {
            insert taskslist;   
        }
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
    }
    
    @isTest
    static void testRecordUpdateValidation() {
        List<Task> taskslist = new List<Task>();
        List<Id> recordIds = new List<Id>();
        List<User> users = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
            
        for(Integer i=0;i<2;i++) {
            taskslist.add(new Task(Subject='Trig0231$Test1Task', OwnerId=users[0].Id,
                                   ActivityDate=Date.Today()+2, Email_Reminder_Date__c = DateTime.Now(), Email_Sent__c=true));
            taskslist.add(new Task(Subject='Trig0231$Test1Task', OwnerId=users[0].Id,
                                   ActivityDate=Date.Today()+2, Email_Reminder_Date__c = DateTime.Now(), Email_Sent__c=false));                                               
        }
        insert taskslist;
        List<Task> textract = [SELECT Id, Subject, Email_Sent__c FROM Task WHERE Email_Sent__c = false
                                    AND Subject = 'Trig0231$Test1Task'];
        for(Task t: taskslist) {
            if(t.Email_Sent__c == true) 
                t.ActivityDate = null;
            else
                t.ActivityDate = Date.Today()-1;            
        }
        
        try {
            update taskslist;   
        }
                
        catch (DmlException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
    }
    
    @isTest
    static void testRecordInsertUpdateBulk() {
        List<Task> taskslist = new List<Task>();
        List<Id> recordIds = new List<Id>();
        List<User> users = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        
        for(Integer i=0;i<100;i++) {
            taskslist.add(new Task(Subject='Trig0231$Test2Task', OwnerId=users[0].Id,
                                   ActivityDate=Date.Today()+1, Email_Reminder_Date__c = DateTime.Now(), Email_Sent__c=true));
            taskslist.add(new Task(Subject='Trig0231$Test2Task', OwnerId=users[0].Id,
                                   ActivityDate=Date.Today()+1, Email_Reminder_Date__c = DateTime.Now(), Email_Sent__c=false));                                               
        }
        insert taskslist;
        List<Task> extract = [SELECT Id, Subject, Email_Sent__c FROM Task WHERE Subject = 'Trig0231$Test2Task'];
        
        for(Task t: extract) {
            recordids.add(t.Id);
        }
        //System.assertEquals(extract.size(),comslist.size());
        List<Task> textract = [SELECT Id, Subject, Email_Sent__c FROM Task WHERE Email_Sent__c = true AND Subject = 'Trig0231$Test2Task'];
        System.assertEquals(100,textract.size());
        
        for(Task t: taskslist) {
            if(t.Email_Sent__c == false) 
                t.Email_Sent__c = true;
        }        
        update taskslist;
        
        List<Task> textract2 = [SELECT Id, Subject, Email_Sent__c FROM Task WHERE Subject = 'Trig0231$Test2Task' AND Email_Sent__c = true];
        System.assertEquals(200,textract2.size());
    }
}