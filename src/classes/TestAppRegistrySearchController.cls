@isTest
private class TestAppRegistrySearchController
{
    private static Id testApplicationId;
    private static Id testApplicationVersionId;
    private static Id testApplicationFunctionId_1;
    private static Id testApplicationFunctionId_2;
    private static Id CONTACT_ID;

    private static void loadTestData() {
        // Insert Account
        Account testAccount = new Account();
        testAccount.industry = 'Information Technology';
        testAccount.name = 'Test Account';
        testAccount.type = 'Analyst';

        try
        {
            insert testAccount;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest() - Unable to insert test Account.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }
        
        Id gsaTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'GSA'].Id;
        
        // Insert Contact
        Contact testContact = new Contact();
        testContact.accountId = testAccount.id;
        testContact.email = 'testContact@test.com';
        testContact.lastName = 'Tester';
        testContact.RecordTypeId = gsaTypeId;

        try
        {
            insert testContact;
            CONTACT_ID = testContact.Id;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest() - Unable to insert test Contact.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }

        // Insert Application__c
        Application__c testApplication = new Application__c();
      //  testApplication.description__c = 'Test application description.';
        testApplication.name__c = 'Test Application';
        testApplication.type__c = 'Test';

        try
        {
            insert testApplication;

            testApplicationId = testApplication.id;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest.loadTestData() - Unable to insert test Application__c.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }

        // Insert Application_Version__c
        Application_Version__c testApplicationVersion = new Application_Version__c();
        testApplicationVersion.application__c = testApplication.id;
        testApplicationVersion.location__c = 'GSA Headquarters';
        testApplicationVersion.point_of_contact__c = testContact.id;
        testApplicationVersion.release_notes__c = 'Test Release';
        testApplicationVersion.state__c = 'Operational';
        testApplicationVersion.version__c = '1.0.0';

        try
        {
            insert testApplicationVersion;

            testApplicationVersionId = testApplicationVersion.id;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest.loadTestData() - Unable to insert test Application_Version__c.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }
        
        // Insert new Contact so that it can remove 1 item from the list.
        testContact = new Contact();
        testContact.accountId = testAccount.id;
        testContact.email = 'testContact2@test.com';
        testContact.lastName = 'Tester2';
        testContact.RecordTypeId = gsaTypeId;

        try
        {
            insert testContact;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest() - Unable to insert test Contact.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }
        
        // Insert Application_Version__c
        testApplicationVersion = new Application_Version__c();
        testApplicationVersion.application__c = testApplication.id;
        testApplicationVersion.location__c = 'GSA Headquarters';
        testApplicationVersion.point_of_contact__c = testContact.id;
        testApplicationVersion.release_notes__c = 'Test Release';
        testApplicationVersion.state__c = 'Operational';
        testApplicationVersion.version__c = '1.0.0';

        try
        {
            insert testApplicationVersion;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest.loadTestData() - Unable to insert test Application_Version__c.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }

        // Insert Application_Function__c
        Application_Function__c testApplicationFunction_1 = new Application_Function__c();
      //  testApplicationFunction_1.description__c = 'Test description';
        testApplicationFunction_1.name = 'Test';

        try
        {
            insert testApplicationFunction_1;

            testApplicationFunctionId_1 = testApplicationFunction_1.id;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest.loadTestData() - Unable to insert test Application_Function__c.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }

        Application_Function__c testApplicationFunction_2 = new Application_Function__c();
      //  testApplicationFunction_2.description__c = 'Remove description';
        testApplicationFunction_2.name = 'Remove';

        try
        {
            insert testApplicationFunction_2;

            testApplicationFunctionId_2 = testApplicationFunction_2.id;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest.loadTestData() - Unable to insert remove Application_Function__c.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }

        // Insert Included_Function__c
        Included_Function__c testIncludedFunction = new Included_Function__c();
        testIncludedFunction.Application_Function__c = testApplicationFunctionId_1;
        testIncludedFunction.Application_Version__c = testApplicationVersion.Id;

        try
        {
            insert testIncludedFunction;
        }
        catch (DMLException dmle)
        {
            System.debug('\n\n>> AppRegistrySearchControllerTest.loadTestData() - Unable to insert test Included_Function__c.\nDMLException encountered - ' + dmle);
            System.assert(false);
        }
    }

    static testMethod void myUnitTest(){
        System.debug('\n\n>> AppRegistrySearchControllerTest.myUnitTest() - MAX queries:  ' + Limits.getLimitQueries());
        System.debug('\n                        MAX DML rows: ' + Limits.getLimitDmlRows() + '\n');

        loadTestData();

        Test.startTest();

        // setup some ID's for the SOSL
        Id[] fixedSearchResults = new id[4];
        fixedSearchResults[0] = testApplicationId;
        fixedSearchResults[1] = testApplicationVersionId;
        fixedSearchResults[2] = testApplicationFunctionId_1;
        fixedSearchResults[3] = testApplicationFunctionId_2;
        Test.setFixedSearchResults(fixedSearchResults);

        // test AppRegistrySearchController() constructor
        AppRegistrySearchController controller = new AppRegistrySearchController();
        //System.assert(!controller.advancedSearchView);

        // test search() method - keyword required
        controller.keyWordInput = 'T';
        controller.search();
        System.assert(controller.appVersionList == null);

        // test search() method - matches
        controller.keyWordInput = 'Test*';
        controller.appType = 'Test';
        controller.functionType = testApplicationFunctionId_1;
        controller.state = 'Operational';
        controller.search();
        System.assert(controller.appVersionList.size() > 0);

        // test search() method - no matches : appType
        controller.keyWordInput = 'Test';
        controller.appType = 'Remove';
        controller.search();
        System.assert(controller.appVersionList.size() == 0);

        // test search() method - no matches : functionType
        controller.keyWordInput = 'Test';
        controller.appType= 'Test';
        controller.functionType = testApplicationFunctionId_2;
        controller.search();
        System.assert(controller.appVersionList.size() == 0);

        // test search() method - no matches : state
        controller.keyWordInput = 'Test';
        controller.appType= 'Test';
        controller.functionType = testApplicationFunctionId_1;
        controller.state = 'Remove';
        controller.search();
        System.assert(controller.appVersionList.size() == 0);
        
        // test search() method - matches
        controller.keyWordInput = 'Test*';
        controller.appType = 'Test';
        controller.functionType = testApplicationFunctionId_1;
        controller.state = 'Operational';
        controller.search();
        System.assert(controller.appVersionList.size() > 0);
        
        // test search() method - Point of Contact
        controller.keyWordInput = 'Test*';
        controller.appType = null;
        controller.state = null;
        controller.functionType = null;
        controller.appVersionPOC.Point_of_Contact__c = CONTACT_ID;
        controller.search();
        System.assert(controller.appVersionList.size() > 0);
        
        // test search() method - no keywords
        controller.keyWordInput = '';
        controller.appType= 'Test';
        controller.functionType = testApplicationFunctionId_1;
        controller.state = 'Remove';
        controller.search();
        System.assert(controller.appVersionList.size() == 0);

        Test.stopTest();
    }
}