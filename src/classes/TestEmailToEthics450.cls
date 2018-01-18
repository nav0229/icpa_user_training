/*
    TestEmailToEthics450.cls
    Testing the Inbound Email Handler
    -------------------------------------------------------------------
    Author                  Date        Version  Description
    -------------------------------------------------------------------
    Damien Phillippi        12/22/2011  1.00     Creation
*/
@IsTest
private class TestEmailToEthics450
{
    static testMethod void testEmailToEthics()
    {
        //Email address used to assign the email and to test it later on
        String TEST_EMAIL_ADDRESS = 'test@test.com';
        
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'This should become an Ethics 450';
        email.fromAddress = TEST_EMAIL_ADDRESS;
        
        //Add an attachment to the email
        Messaging.InboundEmail.BinaryAttachment inAtt = new Messaging.InboundEmail.BinaryAttachment();
        inAtt.body = blob.valueOf('test');
        inAtt.fileName = 'my attachment name';
        inAtt.mimeTypeSubType = 'plain/txt';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { inAtt };
        
        //Initialize the Inbound Email
        EmailToEthics450 inboundEthics = new EmailToEthics450();
        
        //Get a label that is guaranteed to exist for the picklist value
        Schema.DescribeFieldResult fieldResult = OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c.getDescribe();
        email.subject = fieldResult.getPicklistValues()[0].getLabel();
        
        //Run the actual Inbound process
        Test.startTest();
        Messaging.InboundEmailResult result = inboundEthics.handleInboundEmail(email, env);
        Test.stopTest();
        
        //Make sure that nothing failed
        System.assert([SELECT Id FROM OCIO_Ethics_450_Form_Review__c WHERE Ethics450_Candidate_NewEmployee_s_Email__c =: TEST_EMAIL_ADDRESS].size() > 0, 'Email Address was not correctly associated.');
        System.assert(result.success, 'InboundEmailResult returned a failure message');
    }
}