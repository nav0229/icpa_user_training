public with sharing class SurveyController{
    public static void updateOwner(List<Survey__c> lstSurvey){
    Set<Id> conId = new Set<Id>();
    String recId;
        for(Survey__c s : lstSurvey){
            conId.add(s.Contact__c);
            recId = s.RecordTypeId;
        }
     RecordType rId = [SELECT Id, DeveloperName, Name FROM RecordType WHERE Id =: recId LIMIT 1];
         if(rId.DeveloperName == 'Employee_Email_Survey'){
                 Contact c = [SELECT Id, Email FROM Contact WHERE Id IN :conId LIMIT 1];     
                 User u = [SELECT Id FROM User WHERE Email =: c.Email LIMIT 1];
        for(Survey__c sur : lstSurvey){
            sur.OwnerId = u.Id;
        }
             }
    }
}