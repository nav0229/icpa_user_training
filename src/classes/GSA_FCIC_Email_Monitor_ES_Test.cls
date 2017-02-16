@isTest
private class GSA_FCIC_Email_Monitor_ES_Test {

    static testMethod void testEmailService() {

    	// test regular email

        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        email.subject = 'hello Johnny';
        email.fromName = 'test test';
        email.plainTextBody = 'Hello, this a test email body. for testing purposes only.';
        envelope.fromAddress = 'user@acme.com';

        GSA_FCIC_Email_Monitor_ES catcher = new GSA_FCIC_Email_Monitor_ES();
        Messaging.InboundEmailResult result = catcher.handleInboundEmail(email, envelope);
        System.assertEquals(result.success, true);


        // test missing body and subject

        Messaging.InboundEmail email2 = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope2 = new Messaging.InboundEnvelope();

        email2.fromName = 'test again';
        envelope2.fromAddress = 'user@acme.com';

        GSA_FCIC_Email_Monitor_ES catcher2 = new GSA_FCIC_Email_Monitor_ES();
        Messaging.InboundEmailResult result2 = catcher2.handleInboundEmail(email2, envelope2);
        System.assertEquals(result2.success, true);


        // test HTML body

        Messaging.InboundEmail email3 = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope3 = new Messaging.InboundEnvelope();

        email3.fromName = 'another test';
        email3.htmlBody = '<b>Hello, this a test email body. for testing purposes only.</b>';
        envelope3.fromAddress = 'user@acme.com';

        GSA_FCIC_Email_Monitor_ES catcher3 = new GSA_FCIC_Email_Monitor_ES();
        Messaging.InboundEmailResult result3 = catcher3.handleInboundEmail(email3, envelope3);
        System.assertEquals(result3.success, true);


        // negative case test

        Messaging.InboundEmail email4 = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope4 = new Messaging.InboundEnvelope();

        email4.fromName = 'party crasher';
        email4.subject = 'crash test';
        envelope4.fromAddress = 'user@acme.com';

        GSA_FCIC_Email_Monitor_ES catcher4 = new GSA_FCIC_Email_Monitor_ES();
        Messaging.InboundEmailResult result4 = catcher4.handleInboundEmail(email4, envelope4);
        System.assertEquals(result4.success, false);
    }

}