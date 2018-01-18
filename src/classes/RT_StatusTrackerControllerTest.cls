@isTest 
public class RT_StatusTrackerControllerTest {
    static testMethod void TestRTStatusTracker(){       
        
        String recordTypeID = Schema.SObjectType.Request_Tracker__c.getRecordTypeInfosByName().get('IT Standard Request').getRecordTypeId();
        
        Request_Tracker__c rt = CreateRTrecords(recordTypeID);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(rt);
        RT_StatusTrackerController controller = new RT_StatusTrackerController(sc);
        String result =  RT_StatusTrackerController.TrackerUpdate(rt.Id);
        system.assertEquals(result,'Open');
    }      
    private static Request_Tracker__c CreateRTrecords(String recordTypeID){
    	
        RecordType rt = [SELECT Id,Name, DeveloperName 
                         FROM RecordType 
                         WHERE SobjectType='Account' AND DeveloperName='Account' LIMIT 1];
        RecordType contRT = [SELECT Id, Name, DeveloperName, SObjectType 
                             FROM RecordType 
                             WHERE SObjectType='Contact' AND DeveloperName ='GSA' LIMIT 1];
        User employee = [SELECT Id, Email, FederationIdentifier FROM User 
                            WHERE Id = :UserInfo.getUserId() 
                            AND IsActive = true LIMIT 1];
        User supervisor = [SELECT Id, Email, FederationIdentifier FROM User 
                            WHERE Id != :UserInfo.getUserId() 
                            AND ProfileId IN (SELECT Id FROM Profile WHERE Name='GSA System Administrator') 
                            AND IsActive = true LIMIT 1];
        Account acct = new Account();
        acct.Name='GSA';
        acct.RecordTypeId = rt.Id;
        // insert account
        insert acct;
        Contact cont2 = new Contact();
        cont2.LastName = 'TestSupervisor';
        cont2.FirstName = 'Firstname';
        cont2.Email='Firstname.testsupervisor@gsa.gov';
        cont2.RecordTypeId = contRT.Id;
        cont2.Person_Start_Date__c = Date.today()-1;
        cont2.Contact_Federated_ID__c = supervisor.FederationIdentifier;
        cont2.AccountId = acct.id;
         insert cont2;
        
        Request_Tracker__c requestTracker = new Request_Tracker__c();
        requestTracker.ITS_Product_Name__c = 'TestProduct';
        requestTracker.ITS_Product_Version__c ='Testversion';
        requestTracker.ITS_ServiceNow_Ticket__c = 'RITM1212';
        requestTracker.ITS_Alternative_Available__c ='No';
        requestTracker.RecordTypeId=recordTypeID;
        requestTracker.Requestor__c =cont2.id;
        
        insert requestTracker;
        return requestTracker;
    }
    
}