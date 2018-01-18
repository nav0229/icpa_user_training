trigger AttachmentTrigger on Attachment (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    private final String SD_DOCUMENT_UPLOAD_PREFIX = SD_Document_Upload__c.getSObjectType().getDescribe().getKeyPrefix();

    if(trigger.isBefore && trigger.isInsert){
        for(Attachment a : trigger.new){
            if(!SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST && isParentAnSDDocumentUploadRecord(a)){
                a.addError('You cannot directly insert an attachment assigned to an SD Document Upload record. You must add attachments via the Visualforce page on the associated records.');
            }
        }
    }

    if(trigger.isBefore && trigger.isDelete){
        for(Attachment a : trigger.old){
            if(!SDDocumentUploadController.IS_FROM_VF_PAGE_OR_TEST && isParentAnSDDocumentUploadRecord(a)){
                a.addError('You cannot directly delete an attachment assigned to an SD Document Upload record. You must delete attachments via the Visualforce page on the associated records.');
            }
        }
    }

    private boolean isParentAnSDDocumentUploadRecord(Attachment a){
        if(getParentPrefix(a.ParentId) == SD_DOCUMENT_UPLOAD_PREFIX){
            return true;
        }
        return false;
    }

    private String getParentPrefix(String id){
        return id.mid(0, 3);
    }

}