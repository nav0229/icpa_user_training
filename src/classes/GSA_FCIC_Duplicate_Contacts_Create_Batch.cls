global with sharing class GSA_FCIC_Duplicate_Contacts_Create_Batch implements Database.Batchable<sObject>{

global Database.QueryLocator start(Database.BatchableContext bc) {
    RecordType rt = [SELECT Id, SobjectType, Name FROM RecordType WHERE DeveloperName = 'FCIC_Duplicate' AND SobjectType = 'Contact' LIMIT 1];
    return Database.getQueryLocator([SELECT Id FROM Contact WHERE RecordTypeId = :rt.Id]);
}

global void execute(Database.BatchableContext BC, List<sObject> scope){
    Database.delete(scope, false);
}

global void finish(Database.BatchableContext BC) {

}

}