global with sharing class IDP_Email_Batch implements Database.Batchable<sObject> 
{
    global String query = '';
    
    global IDP_Email_Batch() {
        // Test Coverage - updated WHERE Condition to reflect the correct API Names - 4/22/2014
        List<PermissionSet> PermissionSetList = [SELECT Id, Name FROM PermissionSet 
                                                  WHERE Name = 'HR_Access_to_IDP_and_related_Objects' 
                                                  OR Name = 'IDP_All_Users'];
        Set<String> permissionId = new Set<String>();
        for(PermissionSet p: PermissionSetList) {
            permissionId.add(p.id);
        }
        query = 'SELECT Assignee.Id, PermissionSetId FROM PermissionSetAssignment WHERE PermissionSetId IN' + quoteKeySet(permissionId) ;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug(query);
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<sObject> batch) {
        List<PermissionSetAssignment> AssignmentList= new List<PermissionSetAssignment>();
        List<ID> AssigneeId = new List<ID>();
        Map <String,Id> userEmail = new Map <String,Id> ();
        Messaging.Email[] mailLST = new Messaging.Email[]{};

        AssignmentList = batch;
        for(PermissionSetAssignment al: AssignmentList) {
            AssigneeId.add(al.Assignee.Id);
        }
        
        ID BeginTemplate = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Beginning_of_IDP_Period_Message' LIMIT 1].Id;
        ID MidTemplate = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'IDP_Mid_Year_Message' LIMIT 1].Id;

        List<User> userlist = [SELECT Email FROM User WHERE Id IN :AssigneeId];
        
        for(User u: userlist) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSaveAsActivity(false);
            mail.setTargetObjectId(u.id);
            if(Date.Today().Month() == 4) {
                mail.setTemplateId(MidTemplate); //Send mid year message
            }
            else {
                mail.setTemplateId(BeginTemplate); // Send Beginning year message
            }
            System.debug(mail);
            mailLST.add(mail);
        }

        if (mailLST.size() != 0) {
            try {
                Messaging.sendEmail(mailLST);
            }
            catch(exception e) {
                System.debug('Error sending mails');
            }
        }
    }

    global void finish(Database.BatchableContext bc) {
    
    }
    
    global String quoteKeySet(Set<String> mapKeySet) {
        String newSetStr = '' ;
        for(String str : mapKeySet)
            newSetStr += '\'' + str + '\',';

        newSetStr = newSetStr.lastIndexOf(',') > 0 ? '(' + newSetStr.substring(0,newSetStr.lastIndexOf(',')) + ')': newSetStr;
        System.debug('query'+newSetStr);
        return newSetStr;
    }
}