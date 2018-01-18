/*
    OGC_Ethics450Controller.cls
    Controller for the Ethics 450 Form Submission page (Ethics450EditForm.page).
    Purpose of this controller class and VF page is to accept Ethics 450 forms from within Salesforce.
    -------------------------------------------------------------------
    Author                Date        Version  Description
    -------------------------------------------------------------------
    Acumen Solutions      12/26/2011  1.0.0    Creation
    Damien Phillippi      01/18/2012  1.1.0    Using normal attachment instead of Chatter attachment.
*/
public with sharing class OGC_Ethics450Controller {

    //public FeedItem anItem{get;set;}
    public Attachment anAttach{get;set;}
    private ApexPages.StandardController controller {get; set;}
    public Contact currentContactForUser {get;set;}
    public OCIO_Ethics_450_Form_Review__c ethics450Review {get;set;}
    public String currentAuthUserId {get; set;}
    public ID GSAContactRecTypeID {get; set;}
    public Id currContactId {get; set;}
    
    public boolean thanksFlag {get; set;}
    public boolean warningFlag {get; set;} 
    
    public Map<String, String> fieldLabel {get; private set;}
    
    public OGC_Ethics450Controller(ApexPages.StandardController stdc) {
        //anItem = new FeedItem();
        anAttach = new Attachment();
        controller = stdc;
        currentAuthUserId = UserInfo.getUserId();
        User currentUser = getUserInfo(currentAuthUserId);
        System.debug('User Info ' + currentUser);
        
        GSAContactRecTypeID = [select id, Name from RecordType where sObjectType = 'Contact'and Name = 'GSA'].id;
        currentContactForUser = getContactInfo(currentUser.Email, currentUser.FirstName, currentUser.LastName, GSAContactRecTypeID);
        
        System.debug('Current Contact Details' + currentContactForUser);
        
        ethics450Review = new OCIO_Ethics_450_Form_Review__c();
        fieldLabel = this.getFieldLabelMap();
    }
    
    public  User getUserInfo(Id userId) {
        User loggedInUser = [Select Id, ContactId, Contact.AccountId, UserType, Name, FirstName, LastName, email, username from User where Id = :userId];
        return loggedInUser;
    }
    
    public  Contact getContactInfo(String contactEmail, String fName, String lName, ID GSAConRecTypeID) {
        if (([Select count() from Contact where Email = :contactEmail and FirstName = :fName and LastName = :lName and RecordTypeID = :GSAConRecTypeID]) > 0){
            Contact conInfo = [Select FirstName, LastName, Phone, Email, Contact_Region__c, Contact_Organization_Name__c,Contact_GSA_Short_Symbol__c,Title 
                               from Contact 
                               where Email = :contactEmail and FirstName = :fName and LastName = :lName and RecordTypeID = :GSAConRecTypeID limit 1];
            warningFlag = false;
            return conInfo;
        } else {
            warningFlag = true;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Only authorized GSA employee can access this page. If you think you are authorized and need to access this page, please contact IT Service Desk.'));
            return null;
        }
    }
    
    private Map<String,String> getFieldLabelMap() {
        
        Map<String, Schema.SObjectField> fMap = Schema.SObjectType.OCIO_Ethics_450_Form_Review__c.fields.getMap();
        Map<String,String> fieldLabel = new Map<String,String>();
        
        for (Schema.SObjectField ft : fMap.values()){ 
            Schema.DescribeFieldResult fd = ft.getDescribe(); 
                fieldLabel.put(fd.getName(),fd.getLabel());
        }
        
        return fieldLabel;
    }
    
    public PageReference submit() {
        
            String msg = null;  
            msg = this.validate();
        
            if(msg == null || msg == '')
            {
                if (anAttach.Name == null || anAttach.Body == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'You are required to attach your Ethics 450 form (PDF) before submitting.'));
                    return null;
                }
                /*
                if (anItem.ContentData == null || anItem.ContentFileName == null)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'You are required to attach your Ethics 450 form (PDF) before submitting.'));
                    return null;
                }
            */
                ethics450Review.Ethics450_Employee__c = currentContactForUser.id;
                
                insert ethics450Review;
                Id ethicsId = ethics450Review.Id;
                //anItem.ParentId = ethics450Review.Id;
                anAttach.ParentId = ethicsId;
                //insert anItem;
                insert anAttach;
                
                anAttach = null;
                anAttach = new Attachment();
                anAttach.Name = null;
                anAttach.Body = null;
                /*
                anItem = null;
                anItem = new FeedItem();
                anItem.ContentData = null;
               anItem.ContentFileName = null;
               */
                thanksFlag = true;
                warningFlag = false;
                ethics450Review.Ethics450_Run_Workflow__c = true;
                update ethics450Review;
                
                return null;
                
            } else
            {
                anAttach = new Attachment();
                //anItem = new FeedItem();
                thanksFlag = false;
                warningFlag = false; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'All fields are required for submission.'));
                return null;
                
            }
        
        return null;
    }
    
    // Ethihcs 450 Form submission validation
    
    private String validate() {
        
        String msg = ': You must enter or select a value.';
        
        if ((ethics450Review.Ethics450_Employee_s_Organization__c == null) || (ethics450Review.Ethics450_Employee_s_Organization__c == '')){
            return fieldLabel.get('Ethics450_Employee_s_Organization__c') + msg;
        }
        if (ethics450Review.Ethics450_Region__c == null){
            return fieldLabel.get('Ethics450_Region__c') + msg;
        }
        
        if ((ethics450Review.Ethics450_Region__c == 'Central Office -Staff Offices') && (ethics450Review.Ethics450_Central_Office_Staff_Offices__c == null)){
            return fieldLabel.get('Ethics450_Central_Office_Staff_Offices__c') + msg;
        }
        if ((ethics450Review.Ethics450_Employee_Title__c == null) ||(ethics450Review.Ethics450_Employee_Title__c == '')){
            return fieldLabel.get('Ethics450_Employee_Title__c') + msg;
        }
        
        return null;
    }
    
    @isTest
    public static void OGC_Ethics450Controller() {
        //Test record creation and saving
        
        Profile p1 = [select Id, Name from Profile where name like 'GSA Standard Platform User' limit 1];
        Profile p = [select Id, Name from Profile where name like 'GSA System Administrator' limit 1];
        User genUser = [select id, lastName, firstName, title, email from User where profileid= :p.id and isActive = true limit 1];
        User aUser = [select id, lastName, firstName, title, email from User where name='SNA KSKonzen' and isActive = true limit 1];
        User bUser = [select id, lastName, firstName, title, email from User where name='Chatty' and isActive = true limit 1];
                
        ID contactRecordTypeId = [select Id from RecordType where name = 'GSA' limit 1].id;
        
        Contact con1 = new Contact(lastName=aUser.LastName,firstName=aUser.FirstName,title='Manager', email=aUser.Email, recordTypeId=contactRecordTypeId, Contact_Region__c = '1', Contact_Organization_Name__c = 'Test');
        Contact con2 = new Contact(lastName='dcba',firstName='lwlkej',title='Manager', email='abcd@email.com', recordTypeId=contactRecordTypeId, Contact_Region__c = '1', Contact_Organization_Name__c = 'Test');
        Contact con = new Contact(lastName=genUser.LastName,firstName=genUser.FirstName,title='Manager', email=genUser.Email, recordTypeId=contactRecordTypeId, Contact_Region__c = '1', Contact_Organization_Name__c = 'Test');
        insert con;
        insert con1;
        insert con2;
        
        //FeedItem anItem = new FeedItem();
        Attachment anAttach = new Attachment();
        Test.startTest();
        
        System.runAs(genUser) {
            
            ApexPages.Standardcontroller stdc = new ApexPages.Standardcontroller(new OCIO_Ethics_450_Form_Review__c());           
            OGC_Ethics450Controller ethics450SubmissionRec = new OGC_Ethics450Controller(stdc);   
        
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee_s_Organization__c = null;
            ethics450SubmissionRec.submit();
            
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee_s_Organization__c = 'Test'; 
            ethics450SubmissionRec.ethics450Review.Ethics450_Region__c =  null;
            ethics450SubmissionRec.submit();
            
            ethics450SubmissionRec.ethics450Review.Ethics450_Region__c =  '1';
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee__c = con.id;
            ethics450SubmissionRec.submit();
            
            ethics450SubmissionRec.ethics450Review.Ethics450_Region__c =  '1';
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee__c = con.id;
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee_s_Organization__c = 'Test'; 
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee_Title__c = null;
            ethics450SubmissionRec.submit();
            
            ethics450SubmissionRec.ethics450Review.Ethics450_Region__c =  '1';
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee__c = con.id;
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee_Title__c = 'Manager';
            ethics450SubmissionRec.ethics450Review.Ethics450_Employee_s_Organization__c = 'Test';
            ethics450SubmissionRec.anAttach.Name = null;
            //ethics450SubmissionRec.anItem.ContentFileName = null;
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            ethics450SubmissionRec.anAttach.Body = bodyBlob;
            
            ethics450SubmissionRec.submit();
            
        }
        System.runAs(genUser) {
            ApexPages.Standardcontroller stdc1 = new ApexPages.Standardcontroller(new OCIO_Ethics_450_Form_Review__c());
            OGC_Ethics450Controller ethics450SubmissionRec1 = new OGC_Ethics450Controller(stdc1);
            
            ethics450SubmissionRec1.ethics450Review.Ethics450_Region__c =  con.Contact_Region__c;
            ethics450SubmissionRec1.ethics450Review.Ethics450_Employee__c = con.id;
            ethics450SubmissionRec1.ethics450Review.Ethics450_Employee_Title__c = 'Manager';
            ethics450SubmissionRec1.ethics450Review.Ethics450_Employee_s_Organization__c = con.Contact_Organization_Name__c;
            
            ethics450SubmissionRec1.anAttach.Name = 'Test.pdf';
            Blob bodyBlob1 = Blob.valueOf('Unit Test Attachment Body');
            ethics450SubmissionRec1.anAttach.Body = bodyBlob1;
            
            ethics450SubmissionRec1.submit();
            system.assertEquals(ethics450SubmissionRec1.ethics450Review.Ethics450_Employee_Title__c, 'Manager');
        }
        
        System.runAs(aUser) {
            ApexPages.Standardcontroller stdc2 = new ApexPages.Standardcontroller(new OCIO_Ethics_450_Form_Review__c());
            OGC_Ethics450Controller ethics450SubmissionRec2 = new OGC_Ethics450Controller(stdc2);
            
            ethics450SubmissionRec2.ethics450Review.Ethics450_Region__c =  con1.Contact_Region__c;
            ethics450SubmissionRec2.ethics450Review.Ethics450_Employee__c = con1.id;
            ethics450SubmissionRec2.ethics450Review.Ethics450_Employee_Title__c = 'Manager';
            ethics450SubmissionRec2.ethics450Review.Ethics450_Employee_s_Organization__c = con1.Contact_Organization_Name__c;     
            ethics450SubmissionRec2.submit();
        }
        
        System.runAs(bUser) {
            ApexPages.Standardcontroller stdc3 = new ApexPages.Standardcontroller(new OCIO_Ethics_450_Form_Review__c());
            OGC_Ethics450Controller ethics450SubmissionRec2 = new OGC_Ethics450Controller(stdc3);
            
            
            ethics450SubmissionRec2.ethics450Review.Ethics450_Region__c =  con.Contact_Region__c;
            ethics450SubmissionRec2.ethics450Review.Ethics450_Employee__c = con.id;
            ethics450SubmissionRec2.ethics450Review.Ethics450_Employee_Title__c = 'Manager';
            ethics450SubmissionRec2.ethics450Review.Ethics450_Employee_s_Organization__c = con.Contact_Organization_Name__c;     
            ethics450SubmissionRec2.submit();
        }
        
        Test.stopTest();
    }
}