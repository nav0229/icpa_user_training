@isTest
private class TestIdpTrigger {

    static testMethod void myUnitTest() {
 
        
        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(2,'FY 2050','New','Team Lead',
                                                    'Manager','IDP Standard','GSA Standard Salesforce User');
        idp[0].IDP_Status__c='Approved';
        update idp[0];
        idp[1].IDP_Status__c='Approved';
        update idp[1];
       List<IDP__c> idp1 = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Team Lead',
                                                    'Manager','IDP Standard','GSA Standard Salesforce User'); 
        idp1[0].IDP_Status__c='Supervisor Review';
        update idp1[0];

        
       List<Form_SF_182__c> sf182 = IDP_TestDataFactory.createsfoneeightytwo(idp,1);
        
        system.assert(idp != null);
                               

    }
    
    static testMethod void supervisorApproval() {
        
        List<IDP__c> idp2 = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Team Lead',
                                                    'Manager','IDP Standard','GSA Standard Salesforce User');

     
        
        system.assert(idp2 != null);
                               

    }
}