/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestOGCCaseHistoryController {

    static testMethod void testRedirectPersonnelCases() {
    	// insert a test personnel case  
        OCIO_OGC_Case_Tracking__c obj = new OCIO_OGC_Case_Tracking__c();
        obj.Name = 'testing123';
        obj.Account_OGC_Case__c = [SELECT ID FROM Account WHERE IsDeleted=false LIMIT 1].Id;
        obj.RecordTypeId = [SELECT ID FROM RecordType WHERE Name = 'Personnel Case'].Id;
        obj.Client__c = 'Staff Offices';
        obj.Case_Type_OGC_Case_Tracking__c = 'CDA';
        obj.Date_Filed__c = System.Now().date();
        obj.Originating_Region__c = '1';
        obj.Description_OGC_Case__c = 'testing123';
        obj.Estimated_Claim_Amount__c = 10000.00;
        
        insert obj;
        
        // get the record id for the url parameter
        ApexPages.currentPage().getParameters().put('parentId', obj.Id);
        
        // instantiate controller and call the doRedirect method
        OGCCaseHistoryController controller = new OGCCaseHistoryController();
        PageReference nextPage = controller.doRedirect();
        
        // get the RecordType Id from the new page url and compare it against that of personnel case history data
        Id recordTypeId = nextPage.getParameters().get('RecordType');
        System.debug(recordTypeId);
        System.assert(recordTypeId == [select Id from RecordType where Name = 'Personnel Case History Data'].Id);            	
    }
    
    static testMethod void testRedirectNonPersonnelCases() {    	
    	// insert a test non-personnel case  
    	OCIO_OGC_Case_Tracking__c obj = new OCIO_OGC_Case_Tracking__c();
    	obj.Name = 'testing123';
    	obj.Account_OGC_Case__c = [SELECT ID FROM Account WHERE IsDeleted=false LIMIT 1].Id;
    	obj.RecordTypeId = [SELECT ID FROM RecordType WHERE Name = 'Non-Personnel Case'].Id;
    	obj.Client__c = 'Staff Offices';
    	obj.Case_Type_OGC_Case_Tracking__c = 'CDA';
    	obj.Date_Filed__c = System.Now().date();
    	obj.Originating_Region__c = '1';
    	obj.Description_OGC_Case__c = 'testing123';
    	obj.Estimated_Claim_Amount__c = 10000.00;
    	
    	insert obj;
    	
    	// get the record id for the url parameter
        ApexPages.currentPage().getParameters().put('parentId', obj.Id);
        
        // instantiate controller and call the doRedirect method
        OGCCaseHistoryController controller = new OGCCaseHistoryController();
        PageReference nextPage = controller.doRedirect();
        
        // get the RecordType Id from the new page url and compare it against that of non-personnel case history data
        Id recordTypeId = nextPage.getParameters().get('RecordType');
        System.debug(recordTypeId);
        System.assert(recordTypeId == [select Id from RecordType where Name = 'Non-Personnel Case History Data'].Id);        
    }
}