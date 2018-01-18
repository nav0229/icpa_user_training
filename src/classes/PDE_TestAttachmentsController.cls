@isTest(SeeAllData=true)
public class PDE_TestAttachmentsController {

    static string getTestCaseEntryId()
    {
        PDE_Case_Entry__c c = new PDE_Case_Entry__c();
        c.PDE_Source_Document__c='Commitment';   
        c.PDE_Attachments_To_Load_Counter__c = 10;
        insert c;
        String s = String.valueOf(c.Id);
        s = s.substring(0, s.length()-3); 
        return s;
    }
    
    static string createEmptyAttachment(string parentId, string fileName, string contentType){
        Attachment a = new Attachment();
        a.parentId = parentId;

        a.Body = EncodingUtil.base64Decode('aGVsbG8gd29ybGQ=');
        a.Name = fileName;
        a.ContentType = contentType;        
        insert a;
        return a.Id;
    }

    static testMethod void validateCaseEntryGenerated(){
        system.assert(getTestCaseEntryId().length()>0);
    }

     /*
     * This test method is to send sample values for saveTheChunk method to create a new attachment and when last chunk is Y
     */
    static testMethod void validateSaveTheChunklastChunk(){
        string parentId = getTestCaseEntryId();
        string attachmentId = createEmptyAttachment(parentId, 'Attach5.txt', 'text/plain');
        Id id_val = PDE_AttachmentsController.saveTheChunk(parentId, 'Attach5.txt', 'VEVTVCB0ZXN0IFRFU1QgdGVzdCBiYXNlNjQgZGF0YS4=', 'text/plain', attachmentId, 'Y');
        system.assert(String.isNotBlank(id_val), 'Returned ' + id_val);
    }

    /*
     * This test method is to send sample values for saveTheChunk method to create a new attachment and when last chunk is N
     */
    static testMethod void validateSaveTheChunkForNewFile(){
        Id id_val = PDE_AttachmentsController.saveTheChunk(getTestCaseEntryId(), 'Attach5.txt', 'VEVTVCB0ZXN0IFRFU1QgdGVzdCBiYXNlNjQgZGF0YS4=', 'text/plain', '', 'Y');
        system.assert(String.isNotBlank(id_val), 'Returned ' + id_val);
    }
     /*
     * This test method is to send sample values for saveTheChunk method to append the data to existing attachment
     */
     static testMethod void validateSaveFile(){
        string parentId = getTestCaseEntryId();
        string attachmentId = createEmptyAttachment(parentId, 'Attach5.txt', 'text/plain');
        Id id_val = PDE_AttachmentsController.saveTheChunk(parentId, 'Attach5.txt', 'VEVTVCB0ZXN0IFRFU1QgdGVzdCBiYXNlNjQgZGF0YS4=', 'text/plain', attachmentId, 'Y');
        system.assert(String.isNotBlank(id_val), 'Returned ' + id_val);  
    }

}