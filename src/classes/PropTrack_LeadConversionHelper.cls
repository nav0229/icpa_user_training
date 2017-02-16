public with sharing class PropTrack_LeadConversionHelper {
	public static String newOpptyId;
	public static String convertedLeadId;
	@InvocableMethod
	public static void transferAttachedDocs(List<PropTrack_LeadAndOpportunityIDs> ids) {
		System.debug('1');
        newOpptyId = ids.get(0).opptyId;
        System.debug('newOpptyId:' + ids.get(0).opptyId);
        System.debug('2');
		convertedLeadId = ids.get(0).leadId;
        System.debug('3');
        if (!String.isEmpty(newOpptyId)) {
            System.debug('4');
    		createAndInsertContentDocumentLinks();
            System.debug('5');
        	insertAttachments();
            System.debug('6');
        }    
	}

	public class PropTrack_LeadAndOpportunityIDs {
		@InvocableVariable public String leadId;
		@InvocableVariable public String opptyId;
	}

    private static void createAndInsertContentDocumentLinks() {
        List<ContentDocumentLink> oldcdls = getContentDocumentLinks();
        List<ContentDocumentLink> newcdls = new List<ContentDocumentLink>();

        for (ContentDocumentLink cdl : oldcdls) {
            ContentDocumentLink newcld = new ContentDocumentLink(ContentDocumentId = cdl.ContentDocumentId,
                    linkedEntityId = newOpptyId,
                    sharetype = cdl.sharetype,
                    visibility = cdl.visibility);
            newcdls.add(newcld);
        }

        insert newcdls;
    }

    public static List<ContentDocumentLink> getContentDocumentLinks(){
        return [
                SELECT Id, ContentDocumentId, ShareType, visibility
                FROM ContentDocumentLink
                WHERE linkedEntityId= :convertedLeadId
        ];
    }

    private static void insertAttachments(){
        List<Attachment> attachmentList = getAttachments();
        List<Attachment> newAttachments = getAttachmentsWithOppty(attachmentList);
        insert newAttachments;
    }
 
    private static List<Attachment> getAttachmentsWithOppty(List<Attachment> attachmentList){
        List<Attachment> newAttachments = new List<Attachment>();
        for(Attachment a : attachmentList){
            Attachment newAttachment = new Attachment(body = a.Body,
                    Name = a.Name,
                    Description = a.Description,
                    isPrivate = a.isPrivate,
                    OwnerId = a.OwnerId,
                    ParentId = newOpptyId);
            newAttachments.add(newAttachment);
        }
        return newAttachments;
    }


    private static List<Attachment> getAttachments(){
        return [
                SELECT Id, Name, Body, Description, isPrivate, OwnerId, ParentId
                FROM Attachment
                WHERE ParentID = :convertedLeadId
        ];
    }
}