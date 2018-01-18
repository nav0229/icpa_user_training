@isTest
private class TestIDPListView{
    /*public static testmethod void testSupervisorList(){
        IDP_ListView ext = new IDP_ListView();
        system.assertEquals(true, true);
    }
    */

    public static testMethod void testSupervisorApprovedOnly(){

        IDP_ListView ext = new IDP_ListView();

        User current = new User();
        current.Id = UserInfo.getUserId();

        Profile p = [SELECT Id FROM Profile WHERE Name='GSA Standard Salesforce User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@gsa.gov.testuser', manager = current);

        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Test',
                                                    'Test','IDP Standard','GSA Standard Salesforce User');
        idp[0].supervisor__c = UserInfo.getUserId();
        update idp[0]; /*Updated this to get current user info*/
            
        // Create an approval request for the account
        Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(idp[0].id); 
        
         // Submit on behalf of a specific submitter
        req1.setSubmitterId(U.Id); 
        
        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('IDP_Approval_Process');
        req1.setSkipEntryCriteria(true);
        
        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        
        // Verify the result
        System.assert(result.isSuccess());
        
        System.assertEquals(
            'Pending', result.getInstanceStatus(), 
            'Instance Status'+result.getInstanceStatus());
        
        // Approve the submitted request
        // First, get the ID of the newly created item
        List<Id> newWorkItemIds = result.getNewWorkitemIds();
        
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req2 = 
            new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approve');
        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        
        // Use the ID from the newly created item to specify the item to be worked
        req2.setWorkitemId(newWorkItemIds.get(0));
        
        // Submit the request for approval
        Approval.ProcessResult result2 =  Approval.process(req2);
        
        ext.getIDPsBySupervisor();
        
        // Verify the results
        System.assert(result2.isSuccess(), 'Result Status:'+result2.isSuccess());
        
        System.assertEquals(
            'Approved', result2.getInstanceStatus(), 
            'Instance Status'+result2.getInstanceStatus());
    }
}