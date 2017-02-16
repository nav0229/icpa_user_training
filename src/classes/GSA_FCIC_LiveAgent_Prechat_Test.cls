@isTest
public class GSA_FCIC_LiveAgent_Prechat_Test{

    static testMethod void instantiateController(){
        Test.startTest();
        createPageCustomSettings();
        GSA_FCIC_LiveAgent_Prechat_Controller page = new GSA_FCIC_LiveAgent_Prechat_Controller();
        System.assertNotEquals(null, page);
        Test.stopTest();
    }

    private static void createPageCustomSettings(){
        RecordTypeRefs__c busa = new RecordTypeRefs__c();
        busa.Name = 'BusinessUSA.gov';
        busa.Id__c = 'AAA';
        insert busa;

        RecordTypeRefs__c gobierno = new RecordTypeRefs__c();
        gobierno.Name = 'GobiernoUSA.gov';
        gobierno.Id__c = 'BBB';
        insert gobierno;

        RecordTypeRefs__c usa = new RecordTypeRefs__c();
        usa.Name = 'USA.gov';
        usa.Id__c = 'CCC';
        insert usa;

        RecordTypeRefs__c exim = new RecordTypeRefs__c();
        exim.Name = 'ExIm.gov';
        exim.Id__c = 'DDD';
        insert exim;
    }

}