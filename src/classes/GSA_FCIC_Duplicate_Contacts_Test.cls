@isTest
public class GSA_FCIC_Duplicate_Contacts_Test{

    private final static String CASE_TYPE = 'USA.gov';
    private final static String CONTACT_DUPE_TYPE = 'FCIC_Duplicate';

    static testMethod void validateBatch(){

        RecordType caseRt = getRecordTypeForCase();
        RecordType contactDupeRt = getDuplicateContactType();

        createTriggerCustomSettings();

        Case caseOne = new Case();
        caseOne.Customer_First_Name__c = 'Ruby';
        caseOne.Customer_Last_Name__c = 'Ruby';
        caseOne.Customer_Email_address__c = 'ruby@ruby.com';
        insert caseOne;

        Account accountOne = [SELECT Id, Name FROM Account WHERE Name = 'Ruby Ruby'];

        Contact contactTwo = new Contact();
        contactTwo.AccountId = accountOne.Id;
        contactTwo.FirstName = 'Ruby';
        contactTwo.LastName = 'Ruby';
        contactTwo.Email = 'ruby@ruby.com';
        insert contactTwo;

        List<Contact> contactListBeforeBatch = [SELECT Id, RecordTypeId FROM Contact WHERE FirstName = 'Ruby' AND LastName = 'Ruby' AND Email = 'ruby@ruby.com'];

        System.assertEquals(2, contactListBeforeBatch.size());

        Test.startTest();

        GSA_FCIC_Duplicate_Contacts_Create_Batch dupeBatch = new GSA_FCIC_Duplicate_Contacts_Create_Batch();
        Database.executeBatch(dupeBatch);

        Test.stopTest();

        List<Contact> contactListAfterBatch = [SELECT Id, RecordTypeId FROM Contact WHERE FirstName = 'Ruby' AND LastName = 'Ruby' AND Email = 'ruby@ruby.com'];

        System.assertEquals(1, contactListAfterBatch.size());

    }

    static testMethod void validateScheduledBatch(){
        Test.startTest();

        GSA_FCIC_Duplicate_Contacts_Schedulable deleteDupes = new GSA_FCIC_Duplicate_Contacts_Schedulable();
        String schedule = '0 0 23 * * ?';
        System.schedule('Delete duplicated contacts batch', schedule, deleteDupes);

        List<CronTrigger> ctList = [SELECT Id FROM CronTrigger where CronJobDetail.Name LIKE 'Delete duplicated%'];

        System.assertNotEquals(0, ctList.size());

        Test.stopTest();
    }

    private static RecordType getRecordTypeForCase(){
        return [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = :CASE_TYPE LIMIT 1];
    }

    private static RecordType getDuplicateContactType(){
        return [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Contact' AND DeveloperName = :CONTACT_DUPE_TYPE LIMIT 1];
    }

    private static void createTriggerCustomSettings(){
        TriggerControls__c caseTrigger = new TriggerControls__c();
        caseTrigger.Name = 'Case';
        caseTrigger.On__c = true;
        insert caseTrigger;

        TriggerControls__c contactTrigger = new TriggerControls__c();
        contactTrigger.Name = 'Contact';
        contactTrigger.On__c = true;
        insert contactTrigger;
    }

}