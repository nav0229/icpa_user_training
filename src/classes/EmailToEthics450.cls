/*
    EmailToEthics450.cls
    Inbound email handler class that will accept an email and create an associated ethics 450 form
    -------------------------------------------------------------------
    Author                 Date        Version  Description
    -------------------------------------------------------------------
    Sathish Durairaj       12/20/2011  1.0.0    Creation
    Damien Phillippi       12/22/2011  1.1.0    Creating Ethics object from Email
*/
global class EmailToEthics450 implements Messaging.InboundEmailHandler
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        OCIO_Ethics_450_Form_Review__c ethicsFormReview = new OCIO_Ethics_450_Form_Review__c();
        
        ethicsFormReview.Candidate_New_Employee_Name__c = email.fromName;
        ethicsFormReview.Ethics450_Candidate_NewEmployee_s_Email__c = email.fromAddress;
        
        Schema.DescribeFieldResult fieldResult = OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c.getDescribe();
        Set<String> regionValues = new Set<String>();
        for(Schema.PicklistEntry f: fieldResult.getPicklistValues())
        {
            regionValues.add(f.getLabel());
            regionValues.add(f.getValue());
        }
        
        if (regionValues.contains(email.subject)){
            ethicsFormReview.Ethics450_Region__c = email.subject;
        }
        ethicsFormReview.description__c = email.subject + '\n' + email.plainTextBody;
        
        insert ethicsFormReview;
        
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0)
        {
            for (integer i = 0 ; i < email.binaryAttachments.size() ; i++)
            {
                Attachment attachment = new Attachment();
                // attach to the newly created contact record
                attachment.ParentId = ethicsFormReview.Id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.Body = email.binaryAttachments[i].body;
                insert attachment;
            }
        }
        
        ethicsFormReview.Ethics450_Run_Workflow__c = true;
        update ethicsFormReview;
        
        return result;
    }
}