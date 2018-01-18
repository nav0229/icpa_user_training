global with sharing class OHRMEmailScheduler implements Schedulable {
    global void execute(SchedulableContext SC) {
        map<decimal, string> mapCustEmailTemplate = new map<decimal, string>();
        for(OHRM__c ohrmCst : OHRM__c.getall().values()){
            mapCustEmailTemplate.put(Integer.valueOf(ohrmCst.Email_Sending_Day__c), ohrmCst.Email_Template_Name__c);
            system.debug('custom setting map'+mapCustEmailTemplate);
        }
        if(mapCustEmailTemplate != null && mapCustEmailTemplate.size() > 0){
            
            map<string, EmailTemplate> mapEmailTemplate = new map<string, EmailTemplate>();
            set<string> setEmailSubject = new set<string>{'Welcome Email Sent','Transit Subsidy Email Sent'};
            system.debug('mapcustomvalues'+mapCustEmailTemplate.values());
            
            for(EmailTemplate template : [Select Id, Subject, Name From EmailTemplate 
                Where Name IN: mapCustEmailTemplate.values()]){
                mapEmailTemplate.put(template.Name, template);
                setEmailSubject.add('Email: '+template.Subject);
                setEmailSubject.add(template.Subject);     
            }

            //List<string> taskSubs = new List<string>{'Welcome Email Sent','Transit Subsidy Email Sent'};
            //setEmailSubject.add{'Welcome Email Sent','Transit Subsidy Email Sent'};
            System.debug('setEmailSubject'+setEmailSubject);
            system.debug('email map'+mapEmailTemplate);
            Id devRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('GSA').getRecordTypeId();

            Date today = system.Today();
            /*string Query = 'Select Id, Email, isActive__c, Person_Start_Date__c, Start_Date_Email_Initiation__c, '+
                            ' (Select Subject From Tasks Where Subject IN : setEmailSubject) '+
                            ' From Contact Where isActive__c = true AND Email != null AND OHRM_Last_Email_Sent__c = false '+
                            ' AND MAJOR_ORG__c NOT IN (\'G\',\'J\') AND Person_Start_Date__c != null '+ 
                            ' AND RecordTypeId= \''+devRecordTypeId+'\' AND Affiliation_Copy__c=\'Government\' ' +
                            ' AND Start_Date_Email_Initiation__c != null AND Start_Date_Email_Initiation__c <= today  ';*/

           string Query = 'Select Id, Email, isActive__c, Person_Start_Date__c, Start_Date_Email_Initiation__c, '+
                            ' (Select Subject From Tasks Where Subject IN : setEmailSubject) '+
                            ' From Contact Where isActive__c = true AND Email != null  '+
                            ' AND MAJOR_ORG__c NOT IN (\'G\',\'J\') AND Person_Start_Date__c != null '+
                            ' AND RecordTypeId= \''+devRecordTypeId+'\' AND Affiliation_Copy__c!=\'Contractor\' ' +
                            ' AND Start_Date_Email_Initiation__c != null AND Start_Date_Email_Initiation__c <= today  ';
            OHRMEmailBatch objSched = new OHRMEmailBatch(Query,mapCustEmailTemplate,mapEmailTemplate,setEmailSubject);
            database.executebatch(objSched,200);
        }
    }
}