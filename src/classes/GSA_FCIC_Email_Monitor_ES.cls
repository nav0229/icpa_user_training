public class GSA_FCIC_Email_Monitor_ES implements Messaging.InboundEmailHandler {

    private static final String EMAIL_TAG = 'Email failure: ';
    private static final String ERROR_MESSAGE = 'Error while attempting to process the mail. Consult ccoleman@acumensolutions.com for more information.';
    private static final String PLAIN_TEXT_DELIMITER = '================ PLAIN TEXT ================\n';
    private static final String HTML_DELIMITER = '=========== HTML (No plain text version available) ===========\n';
    private static final String PAGE_RETURN = '\n';
    private static final String NO_SUBJECT = 'No subject was given';
    private static final String NO_EMAIL_CONTENT = 'No email content either in Plain Text or HTML';
    
    RecordType RecType = [Select Id From RecordType Where SobjectType = 'Exception__c' and DeveloperName = 'Email_Relay_Failure'];
    Id RecTypeId = RecType.Id;

    public GSA_FCIC_Email_Monitor_ES(){
        // do nothing
    }

    public Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope envelope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        Exception__c newException = new Exception__c();

        System.debug('======================================== ' + recTypeId + ' ========================================');


        try {
    
            // purposely crash test
            if(Test.isRunningTest() && email.Subject=='crash test') {
                email = null;
            }

            // fill the exception name with the email subject
            if(email.Subject != null){
                newException.Name = EMAIL_TAG + email.Subject;
            } else {
                newException.Name = EMAIL_TAG + ' ' + NO_SUBJECT;
            }

            // we want the email content in the description of the exception
            // use the plain text version if available
            if(email.plainTextBody != null){
                newException.Description__c = PLAIN_TEXT_DELIMITER + email.plainTextBody + PAGE_RETURN;
            }

            // if the plain text version isn't availble use the html body
            if(newException.Description__c == null && email.htmlBody != null){
                newException.Description__c = HTML_DELIMITER + email.htmlBody + PAGE_RETURN;
            }

            // if neither plain text or html version is available give an error exception; I'd be surprised if we get to this point
            if(newException.Description__c == null){
                newException.Description__c = NO_EMAIL_CONTENT;
            }
            
            result.Success = true;

        } catch (Exception e){

            result.Success = false;

            result.Message = ERROR_MESSAGE;

            newException.Name = ERROR_MESSAGE.left(80);

            newException.Description__c = ERROR_MESSAGE;

        }

        newException.RecordTypeId = RecTypeId;
        System.debug('======================================== ' + newException.RecordTypeId + ' ========================================');

        insert newException;

        return result;
    }

}