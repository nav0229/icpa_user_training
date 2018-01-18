@isTest
public class TestGITGOTargetExtension {
static testMethod void CustomerMailingTarget_Test()
{
        //Create a test Target
        Target__c t = new Target__c();
        t.Name = 'Test target';
        t.Organization__c = 'Test';
        insert t;
        
        System.assertEquals('Test target', t.Name);
        
        //Create a test Contact
        Contact c = new Contact();
        c.LastName = 'Last';
        c.Contact_Organization_Name__c = 'Test organization';
        c.Contact_Region__c = 'Test region';
        c.Major_Org_Description__c = 'Test Major Organization';
        insert c;
        
        System.assertEquals('Last', c.LastName);
                                 
        //create a reference to the Visualforce page
        PageReference testPage = Page.GITGOCustomerMailingTarget;
        Test.setCurrentPage(testPage);
              
        //create an instance of the controller extension as if creating a new target
        ApexPages.StandardController sc = new ApexPages.standardController(t);
        GITGOTargetExtension ext = new GITGOTargetExtension(sc);
        
        //call the method for populuating the Organization picklist
        List<selectOption> orgList = ext.getOrgs();
               
       sc.save();

}
}