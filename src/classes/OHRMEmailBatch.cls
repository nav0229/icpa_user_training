/*
<!-- Contact Manager Application                             -->
<!--  -----------------------------------------------------  -->
<!-- Created By      | Version |  Date    | Description      -->
<!--  -----------------------------------------------------  -->
<!-- Ramesh Dugar        1.0      04/11/2016  Created        -->
<!--  -----------------------------------------------------  -->
<!--  -----------------------------------------------------  --> 
*/
global with sharing class OHRMEmailBatch implements Database.Batchable<sObject>{

    global final string Query;
    global final map<decimal, string> mapCustEmailTemplate;//storing all custom setting values in a map
    global final map<string, EmailTemplate> mapEmailTemplate;
    global final set<string> setEmailSubject;
 
    global OHRMEmailBatch(string q,map<decimal, string> cstEmailTmp,map<string, EmailTemplate> mapEmailTmp,set<string> emailSub){
        Query = q;
        mapCustEmailTemplate =cstEmailTmp;
        mapEmailTemplate = mapEmailTmp;
        setEmailSubject= emailSub;
    }
    //public void EmailTemplates(){}
 
    global Database.QueryLocator start(Database.BatchableContext BC){
        //Id devRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();
        return Database.getQueryLocator(Query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        list<contact> lstContact = new list<contact>();
        system.debug('mapemailTemplate**'+mapEmailTemplate.size());
        if(mapEmailTemplate != null && mapEmailTemplate.size() > 0){
            String strAddress = Label.OHRM_Onboarding_Email_Address;
            OrgWideEmailAddress[] owea = [Select Id From OrgWideEmailAddress Where Address =:strAddress];
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();  
            list<Contact>  lstCont = (list<Contact>)scope;
            system.debug('cont size'+lstCont.size());    
            for(Contact objCont : lstCont){
                system.debug('entered'+objCont);
              
                set<string> setEmailSubjects = new set<string>();

                if(objCont.Tasks != null && objCont.Tasks.size() > 0){
                    for(Task objTask : objCont.Tasks){
                        setEmailSubjects.add(objTask.Subject);
                    }
                    system.debug('setEmailSubjects'+setEmailSubjects);
                } 
                Integer daysBtwn = Date.Valueof(objCont.get('Start_Date_Email_Initiation__c')).daysbetween(system.Today());
                system.debug('days between'+daysBtwn);
                if(daysBtwn!=null){
                    string tempName = mapCustEmailTemplate.get(daysBtwn+1);
                    system.debug('Template Name'+tempName);
                    if(tempName != null && tempName != ''){
                      EmailTemplate template = mapEmailTemplate.get(tempName);
                      system.debug('Template subject'+template.Subject);
                      system.debug('***'+template.Subject+' Sent');
                        if(template != null  && owea.size() > 0 && (setEmailSubjects == null || 
                            (setEmailSubjects != null && (!setEmailSubjects.contains('Email: '+template.Subject)
                                && !setEmailSubjects.contains(template.Subject+' Sent')
                                && !setEmailSubjects.contains(template.Subject) 
                                && !setEmailSubjects.contains(template.Subject+' Email Sent'))))){ 
                           
                           Integer precedingDay;
                           for(decimal dDay : mapCustEmailTemplate.keyset()){
                                if(dDay<daysBtwn+1){
                                    precedingDay=integer.valueof(dDay);
                                }
                            }
                            
                            if(precedingDay!=null){
                                string precedeTempName = mapCustEmailTemplate.get(precedingDay);  
                                if(precedeTempName!=null && precedeTempName!=''){
                                    EmailTemplate precedeTemplate = mapEmailTemplate.get(precedeTempName); 
                                    if(precedeTemplate!=null  && (setEmailSubjects == null || 
                                        (setEmailSubjects != null && (!setEmailSubjects.contains('Email: '+precedeTemplate.Subject)
                                            && !setEmailSubjects.contains(precedeTemplate.Subject+' Sent')
                                            && !setEmailSubjects.contains(precedeTemplate.Subject) 
                                            && !setEmailSubjects.contains(template.Subject+' Email Sent'))))){
                                        m = new Messaging.SingleEmailMessage();
                                        m.setTemplateId(precedeTemplate.Id);
                                        m.setOrgWideEmailAddressId(owea.get(0).Id);
                                        m.setTargetObjectId(string.valueof(objCont.get('Id')));
                                        m.setToAddresses(new String[] {string.valueof(objCont.get('email'))});
                                        allMails.add(m); 

                                    }
                                } 
                            }
                           m = new Messaging.SingleEmailMessage();
                           m.setTemplateId(template.Id);
                           m.setOrgWideEmailAddressId(owea.get(0).Id);
                           m.setTargetObjectId(string.valueof(objCont.get('Id')));
                           m.setToAddresses(new String[] {string.valueof(objCont.get('email'))});
                           allMails.add(m);
                           /*if(daysBtwn == 39){
                                lstContact.add(new contact(Id = string.valueof(objCont.get('Id')), OHRM_Last_Email_Sent__c = true));
                           }*/
                        }
                    }
                }
            } 
            system.debug('****'+allMails.size());
            
                Messaging.sendEmail(allMails);
            
            /*if(lstContact != null && lstContact.size() > 0){
            update lstContact;
            }*/
        }
    }
    
    global void finish(Database.BatchableContext BC){

         // Get the AsyncApexJob that represents the Batch job using the Id from the BatchableContext  
        AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,  
                         TotalJobItems, CreatedBy.Email, ExtendedStatus  
                         from AsyncApexJob where Id = :BC.getJobId()];  
                       
                     // Email the Batch Job's submitter that the Job is finished. 
                     
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
        String[] toAddresses = new String[] {'brittany.burns@gsa.gov'};  
        mail.setToAddresses(toAddresses);  
        mail.setSubject('OHRM Email Batch Job Status: ' + a.Status);  
        mail.setPlainTextBody('The OHRM Email batch Apex job processed ' + a.TotalJobItems +  
                              ' batches with '+ a.NumberOfErrors + ' failures. ExtendedStatus: ' + a.ExtendedStatus);  
        if(a.Status=='Failed'){   
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        } 
    }
}