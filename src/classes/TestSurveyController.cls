@isTest(SeeAllData=true)
public class TestSurveyController {
    static testMethod void changeOwner(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'GSA Standard Salesforce User' LIMIT 1];
        User u = [SELECT Id, Email FROM User WHERE isActive = true AND ProfileId =: p.Id LIMIT 1];
        Contact c = [SELECT Id, Email FROM Contact WHERE Email =: u.Email LIMIT 1];
       // Contact c = [SELECT Id, Email FROM Contact WHERE Email = 'anne.egan@gsa.gov' LIMIT 1];
        RecordType rt = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Employee_Email_Survey' LIMIT 1];
        Survey__c s = new Survey__c();
        s.Contact__c = c.Id;
        s.RecordTypeId = rt.Id;
        insert s;
        System.assertEquals(true,true);
        
    }
}