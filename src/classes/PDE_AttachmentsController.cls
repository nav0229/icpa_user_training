public class PDE_AttachmentsController {

     /*
     * This method inserts attachment if the attachment is not already there or append the data if the attachment is already present.
     */
    
    @AuraEnabled
    public static Id saveTheChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId, String lastChunk) { 
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType, lastChunk);
            system.debug('lastChunk: ' + lastChunk);
        } else {
            appendToFile(parentId, fileId, base64Data, lastChunk);
            system.debug('lastChunk' + lastChunk);
        }
        if(lastChunk == 'Y'){
            PDE_Case_Entry__c pdecse = [Select Id, PDE_Attachments_To_Load_Counter__c from PDE_Case_Entry__c where Id = :parentId FOR UPDATE];
            system.debug('PDE Attachment Counter from Case: ' + pdecse.PDE_Attachments_To_Load_Counter__c);
            Decimal counter = pdecse.PDE_Attachments_To_Load_Counter__c;
            counter = counter - 1;
            pdecse.PDE_Attachments_To_Load_Counter__c = counter;                
            update pdecse;
        }        
        return Id.valueOf(fileId);
    }
    /*
     * This method inserts a new attachment to Case object and returns Attachment Id
     */
    @AuraEnabled
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType, String lastChunk) { 
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = new Attachment();
        a.parentId = parentId;

        a.Body = EncodingUtil.base64Decode(base64Data);
        a.Name = fileName;
        a.ContentType = contentType;
        
        insert a;
        

        
        return a.Id;
        
    }
    

    /*
     * This methods append the chunk to the existing attachment
     */
    private static void appendToFile(Id ParentId, Id fileId, String base64Data, String lastChunk) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id = :fileId
        ];
        
        String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data); 
        
        update a;
        

    }
}