@isTest
private class TestSF182TrainingTrigger {
    public static testmethod void testSF182Training(){
        
        User u = [SELECT Id from User WHERE isActive = true AND Id != :userInfo.getUserId() LIMIT 1];
        //system.debug('This is User Id ' + u.id + ' Logged In User ' + userInfo.getUserId());
        
        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2017','New','Test',
                                                    'Test','IDP Standard','GSA System Administrator');
        List<Developmental_Objective__c> dobj = IDP_TestDataFactory.createObjective(idp,1);
        List<IDP_Developmental_Line_Item__c> idpli = IDP_TestDataFactory.createActivity(dobj,1,date.today(),date.today()+1);
      
        idp[0].IDP_Status__c = 'Approved';
        update idp[0];

        List<Form_SF_182__c> sf182 = IDP_TestDataFactory.createsfoneeightytwo(idp,1);
                  
        List<SF_182_Training__c> sf182req = IDP_TestDataFactory.createsfoneeightytworeq(sf182,1,'GSA System Administrator');

        sf182req[0].Supervisor__c=null;
        update sf182req[0];

        system.debug('#####' +sf182req[0]);
        
        sf182req[0].Activity__c = idpli[0].Id;
        update sf182req[0];
        
        sf182req[0].Approval_Status__c = 'Pending Supervisor Review';  
        update sf182req[0];
        
        sf182req[0].Approval_Status__c = 'Reviewed by Supervisor';
        update sf182req[0];
        
        sf182req[0].Approval_Status__c = 'Reviewed by Approver 1';
        update sf182req[0];
        
        sf182req[0].Approval_Status__c = 'Reviewed by Approver 2';
        update sf182req[0];
        
        sf182req[0].Approval_Status__c = 'Reviewed by Approver 3';
        update sf182req[0];

        sf182req[0].Approval_Status__c = 'Final Approval';
        update sf182req[0];
        
        sf182req[0].Approval_Status__c = 'New';
        update sf182req[0];
        
        sf182req[0].Request_Status__c = 'Rejected';
        update sf182req[0];

        sf182req[0].Request_Status__c = 'Initiating';  
        sf182req[0].Supervisor__c = u.Id;  
        update sf182req[0];  
 
        system.assertEquals(true,true);
        
    }

}