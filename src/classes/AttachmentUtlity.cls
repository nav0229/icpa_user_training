public with sharing class AttachmentUtlity {
    
    //Declaring a parent Id varible 
    public String parentId {get;set;}
    //Declaring case number variable
    public String caseNumber {get; set;}
    //Declaring attachment variable
    public transient Attachment attach {get;set;}
    //Creating a list for attachments
    public List<innerWrapper> attachName {get; set;}
    //Declaring attachment size variable for size of an attachment
    public String attachSize {get; set;}
    List<Attachment> attachments;
    //Declaring file name for attachment name
    private String fileName;
    //Declaring the file size for attachment size
    private Integer fileSize;
    //Declaring blog for attachment
    private transient Blob fileBody;
    public Boolean IsPrivate {get; set;}
    
    //Calling the wrapper list and new attachments
    public AttachmentUtlity() 
    {
        IsPrivate = false;
        attachName = new List<innerWrapper>();
        attach = new Attachment();
        parentId = Apexpages.currentPage().getParameters().get('recordId');
        }
    
    
    //This method get the file name
    public String getFileName()
    {
        return this.fileName;
    }
    //Passing the file name and assigning the file name 
    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }
    //Getting the attachment
    public Blob getFileBody()
    {
        return this.fileBody;
    }
    //Assigning the attachment
    public void setFileBody(Blob fileBody)
    {
        this.fileBody = fileBody;
        setFileSize(this.fileBody.size());
    }
    //Getting the file size
    public Integer getFileSize()
    {
        return this.fileSize;
    }
    //Assigning the file size
    public void setFileSize(Integer fileSize)
    {
        this.fileSize = fileSize;
    }
      public String upload {get; set;}
    //Uploading attachments and assiging the Attachment to the created case
    public Pagereference upload()
    {    
      system.debug('attachment name ==============>' + fileName);
      if(fileName == null || fileName == null){
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please select a file.');
            ApexPages.addMessage(myMsg);
            return null;
          }else{
                   attach = new Attachment();
                   attach.Body = this.fileBody;
                   attach.Name = this.fileName;
                   attach.ParentId = parentId;
                   attach.IsPrivate = IsPrivate; 
        
        attachName.add(new innerWrapper(this.fileName,this.fileBody.size()));
        
        insert attach;
        fileName = null;
       return null;
      }
    }
    // Menthod to display uploaded attachments with Name and Size of the attachment
    public class innerWrapper{
    public String strName{get;set;}
    public Integer intSize{get;set;}
    Public innerWrapper(String attName,Integer attSize){
    this.strName = attName;
    this.intSize = attSize;
    }
    }

}