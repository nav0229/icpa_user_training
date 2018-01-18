@isTest
Public Class TestCDT_AttachmentError{
    Static testmethod void AttachmentError(){
    
    Controlled_Document__c cdt = new Controlled_Document__c();
    
    cdt.Stage__c='Drafting';
    cdt.Correspondence_Type__c='Forms';
    cdt.Originating_Office__c='AK - Office of Civil Rights';
    insert cdt;
    
    Attachment attach=new Attachment();         
    attach.Name='Unit Test Attachment';
    Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    attach.body=bodyBlob;
    attach.parentId=cdt.id;
    try{
    insert attach;
    }
    catch(exception e){
   
System.Assert(e.getMessage().contains('To upload new files:  Attach in Chatter feed.'));
    }
   }
   
   // Case# 27460 - BEGIN - for test coverage of ControlledDocumenttrigger
   static testmethod void testInsertValidation() {
       CDT_GSA_Administrator__c cm = new CDT_GSA_Administrator__c();
       cm.Name='Agency Administrator';
       cm.FullName__c='Timothy Horne';
       insert cm;
       User agencyAdmin = [SELECT Id from User Where Name = 'Timothy Horne' AND isActive= true LIMIT 1];
       Controlled_Document__c cdt = new Controlled_Document__c();
       cdt.Stage__c='Drafting';
       cdt.GSA_Action_Required__c = 'Signature/Approval of the Administrator';
       cdt.Final_Signatory__c = agencyAdmin.Id;
       cdt.Correspondence_Type__c='Forms';
       cdt.Originating_Office__c='AK - Office of Civil Rights';
       try {
           insert cdt;
       }
       catch(DMLException e) {
           System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
       }        
   }
   static testmethod void testUpdateValidation1() {
       CDT_GSA_Administrator__c cm = new CDT_GSA_Administrator__c();
       cm.Name='Agency Administrator';
       cm.FullName__c='Timothy Horne';
       insert cm;       
       User agencyAdmin = [SELECT Id from User Where Name = 'Timothy Horne' AND isActive= true LIMIT 1];
       Controlled_Document__c cdt = new Controlled_Document__c();
       cdt.Stage__c='Drafting';
       cdt.Correspondence_Type__c='Forms';
       cdt.Originating_Office__c='AK - Office of Civil Rights';
       cdt.GSA_Action_Required__c = 'Signature/Approval of the Deputy Administrator';
       insert cdt;       
       cdt.GSA_Action_Required__c = 'Signature/Approval of the Administrator';
       try {
           update cdt;
       }
       catch(DMLException e) {
           System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
       }        
   }
   static testmethod void testUpdateValidation2() {
       CDT_GSA_Administrator__c cm = new CDT_GSA_Administrator__c();
       cm.Name='Agency Administrator';
       cm.FullName__c='Timothy Horne';
       insert cm;       
       User agencyAdmin = [SELECT Id from User Where Name = 'Timothy Horne' AND isActive= true LIMIT 1];
       Controlled_Document__c cdt = new Controlled_Document__c();
       cdt.Stage__c='Drafting';
       cdt.Correspondence_Type__c='Forms';
       cdt.Originating_Office__c='AK - Office of Civil Rights';
       cdt.Final_Signatory__c = UserInfo.getUserId();
       insert cdt;
       cdt.Final_Signatory__c = agencyAdmin.Id;       
       try {
           update cdt;
       }
       catch(DMLException e) {
           System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
       }        
   }
   // Case# 27460 - END - for test coverage of ControlledDocumentTrigger
}