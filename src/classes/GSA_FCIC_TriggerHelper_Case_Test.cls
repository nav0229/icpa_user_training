@isTest
public class GSA_FCIC_TriggerHelper_Case_Test{

    private final static String CASE_TYPE = 'USA.gov';
    private final static String TEST_SUBJECT_1 = 'Test Subject 1';
    private final static String TEST_SUBJECT_2 = 'Test Subject 2';
    private final static String TEST_EMAIL_1 = 'firsttest@gmail.com';
    private final static String TEST_EMAIL_2 = 'secondtest@gmail.com';

    static testMethod void validateTier2EmailPopulation(){
        Test.startTest();

        GSA_FCIC_TriggerHelper_Case.isTest = true;
        RecordType rt = getRecordTypeForCase();
        createTriggerCustomSettings();

        // only needed for tier 2 email test
        // TEST_SUBJECT_1 and TEST_SUBJECT_2 subjects are associated with USA.gov
        createEmailCustomSettings(rt);

        Case c = new Case();
        c.RecordTypeId = rt.Id;
        c.Customer_First_Name__c = 'Test';
        c.Customer_Last_Name__c = 'User';
        c.Customer_Email_address__c = 'testuser@gmail.com';
        c.Tier_2_Subject__c = TEST_SUBJECT_1;
        insert c;

        c = [SELECT Tier_2_Subject__c, Tier_2_Email_Address_1__c FROM Case
                    WHERE Customer_First_Name__c = 'Test'
                    AND Customer_Email_address__c = 'testuser@gmail.com' LIMIT 1];

        System.assertEquals(TEST_EMAIL_1, c.Tier_2_Email_Address_1__c);

        c.Tier_2_Subject__c = TEST_SUBJECT_2;
        update c;

        c = [SELECT Tier_2_Subject__c, Tier_2_Email_Address_1__c FROM Case
                WHERE Customer_First_Name__c = 'Test'
                AND Customer_Email_address__c = 'testuser@gmail.com' LIMIT 1];

        System.assertEquals(TEST_EMAIL_2, c.Tier_2_Email_Address_1__c);

        c.Tier_2_Subject__c = null;
        update c;

        c = [SELECT Tier_2_Subject__c, Tier_2_Email_Address_1__c FROM Case
                WHERE Customer_First_Name__c = 'Test'
                AND Customer_Email_address__c = 'testuser@gmail.com' LIMIT 1];

        System.assertEquals(null, c.Tier_2_Email_Address_1__c);

        Test.stopTest();
    }

    static testMethod void validateWebToCase(){
        Test.startTest();

        createTriggerCustomSettings();

        Case c = new Case();
        c.SuppliedName = 'Oneword';
        c.SuppliedEmail = 'a@b.com';
        c.Origin = 'Web';
        insert c;
        c = [SELECT Id, Customer_Last_Name__c, Customer_Email_address__c FROM Case WHERE SuppliedName = 'Oneword'];
        System.assertEquals('Oneword', c.Customer_Last_Name__c);
        System.assertEquals('a@b.com', c.Customer_Email_address__c);

        c = new Case();
        c.SuppliedName = 'Two Words';
        c.Origin = 'Web';
        insert c;
        c = [SELECT Id, Customer_First_Name__c, Customer_Last_Name__c FROM Case WHERE SuppliedName = 'Two Words'];
        System.assertEquals('Two', c.Customer_First_Name__c);
        System.assertEquals('Words', c.Customer_Last_Name__c);

        Test.stopTest();
    }

    static testMethod void validateCreateContact(){
        Test.startTest();

        GSA_FCIC_TriggerHelper_Case.isTest = true;
        RecordType rt = getRecordTypeForCase();
        createTriggerCustomSettings();

        Case c = new Case();
        c.RecordTypeId = rt.Id;
        c.Customer_First_Name__c = 'Test';
        c.Customer_Last_Name__c = 'User';
        c.Customer_Email_address__c = 'testuser@gmail.com';
        insert c;

        Contact contact = [SELECT Id FROM Contact WHERE FirstName = 'Test' AND LastName = 'User' AND Email = 'testuser@gmail.com'];

        System.assertNotEquals(contact, null);

        Test.stopTest();
    }

    static testMethod void validateDedupContact(){
        Test.startTest();

        GSA_FCIC_TriggerHelper_Case.isTest = true;
        RecordType rt = getRecordTypeForCase();
        createTriggerCustomSettings();

        Case caseOne = new Case();
        caseOne.RecordTypeId = rt.Id;
        caseOne.Customer_First_Name__c = 'Test';
        caseOne.Customer_Last_Name__c = 'User';
        caseOne.Customer_Email_address__c = 'testuser@gmail.com';
        insert caseOne;

        Contact contactOne = [SELECT Id, FirstName, LastName, Email
                                FROM Contact
                                WHERE FirstName = :caseOne.Customer_First_Name__c
                                AND LastName = :caseOne.Customer_Last_Name__c
                                AND Email = :caseOne.Customer_Email_address__c];

        Case caseTwo = new Case();
        caseTwo.RecordTypeId = rt.Id;
        caseTwo.Customer_First_Name__c = 'Test';
        caseTwo.Customer_Last_Name__c = 'User';
        caseTwo.Customer_Email_address__c = 'testuser@gmail.com';
        insert caseTwo;

        Contact contactTwo = [SELECT Id, FirstName, LastName, Email
                                FROM Contact
                                WHERE FirstName = :caseOne.Customer_First_Name__c
                                AND LastName = :caseOne.Customer_Last_Name__c
                                AND Email = :caseOne.Customer_Email_address__c];

        System.assertEquals(contactOne.Id, contactTwo.Id);

        Test.stopTest();
    }

    static testMethod void validateCheckForEssentialChanges(){
        Test.startTest();

        GSA_FCIC_TriggerHelper_Case.isTest = true;
        RecordType rt = getRecordTypeForCase();
        createTriggerCustomSettings();

        Case c = new Case();
        c.RecordTypeId = rt.Id;
        c.Customer_First_Name__c = 'Abby';
        c.Customer_Last_Name__c = 'Road';
        c.Customer_Email_address__c = 'abbyroad@gmail.com';
        c.Customer_Phone__c = '2166549873';
        insert c;

        c = [SELECT Id, ContactId, Customer_First_Name__c, Customer_Last_Name__c, Customer_Email_address__c, Customer_Phone__c
                FROM Case
                WHERE Customer_First_Name__c = 'Abby'
                AND Customer_Last_Name__c = 'Road'
                AND Customer_Email_address__c = 'abbyroad@gmail.com'
                AND Customer_Phone__c = '2166549873'];

        Id firstContactId = c.ContactId;

        c.Customer_First_Name__c = 'Danny';
        update c;

        c.Customer_Last_Name__c = 'Boy';
        update c;

        c.Customer_Email_address__c = 'dannyboy@gmail.com';
        update c;

        c.Customer_Phone__c = '(231) 456-7890';
        update c;

        Contact differentContact = [SELECT Id FROM Contact
                                        WHERE FirstName = 'Danny'
                                        AND LastName = 'Boy'
                                        AND Email = 'dannyboy@gmail.com'
                                        AND Phone = '(231) 456-7890'];

        System.assertNotEquals(firstContactId, differentContact.Id);

        Test.stopTest();
    }

    static testMethod void testCalculateBusinessHoursAge(){
        Test.startTest();

        createTriggerCustomSettings();

        Case c = new Case();
        c.SuppliedName = 'Oneword';
        c.SuppliedEmail = 'a@b.com';
        c.Origin = 'Web';
        insert c;

        c.Status = 'Closed';
        update c;

        c = [SELECT Id, Status, Business_Hours_Age__c FROM Case WHERE SuppliedName = 'Oneword' AND SuppliedEmail = 'a@b.com'];

        System.assertNotEquals(null, c.Business_Hours_Age__c);

        Test.stopTest();
    }

    private static RecordType getRecordTypeForCase(){
        return [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = :CASE_TYPE LIMIT 1];
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
        
        TriggerControls__c taskTrigger = new TriggerControls__c();
        taskTrigger.Name = 'Task';
        taskTrigger.On__c = true;
        insert taskTrigger;
    }

    private static void createEmailCustomSettings(RecordType rt){
        // create custom setting to satisfy the new case
        Tier2Email__c emailCustomSetting1 = new Tier2Email__c();
        emailCustomSetting1.Name = 'Test 1'; // required but doesn't mean anything for this test
        emailCustomSetting1.Email_Address_1__c = TEST_EMAIL_1;
        emailCustomSetting1.Category__c = TEST_SUBJECT_1; // custom setting's Cattegory__c maps to case's Tier_2_Subject__c
        emailCustomSetting1.Program__c = rt.Name; // custom setting's Program__c maps to case's Site__c
        insert emailCustomSetting1;

        Tier2Email__c emailCustomSetting2 = new Tier2Email__c();
        emailCustomSetting2.Name = 'Test 2'; // required but doesn't mean anything for this test
        emailCustomSetting2.Email_Address_1__c = TEST_EMAIL_2;
        emailCustomSetting2.Category__c = TEST_SUBJECT_2; // custom setting's Cattegory__c maps to case's Tier_2_Subject__c
        emailCustomSetting2.Program__c = rt.Name; // custom setting's Program__c maps to case's Site__c
        insert emailCustomSetting2;
    }
}