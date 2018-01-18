@isTest 
public class RT_CancelRequestQAControllerTest {
    static testMethod void testcase1(){
        Request_Tracker__c ITSreq = new Request_Tracker__c();
        Id recTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'IT_Standard_Request' 
                         AND SObjectType = 'Request_Tracker__c'].Id;
        User usr = [SELECT Id, Name FROM User WHERE IsActive = true AND Id =:UserInfo.getUserId()];
        ITSreq.RecordTypeId = recTypeId;
        ITSreq.ITS_Product_Name__c = 'Multifunction Digital Copier/Printer';
        ITSreq.ITS_Product_Version__c = 'MPC3002G';
        ITSreq.OCIO_Requester__c = usr.Id;
        ITSreq.ITS_ServiceNow_Ticket__c	= 'RITM0011111';
        ITSreq.ITS_Alternative_Available__c	= 'No';
        try {insert ITSreq;}
        catch(DMLException e) {
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }  
        RT_CancelRequestQuickActionController.UpdateRequestTrackerStatusField(ITSreq.Id);  
        RT_CancelRequestQuickActionController.ReturnOwnerName(ITSreq.Id);
    }
}