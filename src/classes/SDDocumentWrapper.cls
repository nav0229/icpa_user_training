public with sharing class SDDocumentWrapper {

	
	public SD_Document_Upload__c SdDocumentUpload {get;set;}
	public Attachment Attachment {get;set;}
	public String DocId {get;set;}
	public Datetime DocCreatedDate {get;set;}
	public String DocCreatedDateFormatted {get;set;}
	public String DocFileName {get;set;}
	public String DocOwnerId {get;set;}
	public String DocOwnerName {get;set;}
	public String DocDescription {get;set;}
	public String AttachmentId {get;set;}
	public String AttachmentFileName {get;set;}

	public SDDocumentWrapper(SD_Document_Upload__c doc, Attachment attachmnt) {
		this.SdDocumentUpload = doc;
		this.Attachment = attachmnt;
		this.DocId = doc.Id;
		this.DocCreatedDate = doc.CreatedDate;

		if(doc.CreatedDate != null){
			this.DocCreatedDateFormatted = doc.CreatedDate.format();
		}

		this.DocFileName = doc.Name;
		this.DocOwnerId = doc.OwnerId;

		if(doc.Owner != null){
			this.DocOwnerName = doc.Owner.Name;
		}

		this.DocDescription = doc.Description__c;
		this.AttachmentId = attachmnt.Id;
		this.AttachmentFileName = attachmnt.Name;
	}

}