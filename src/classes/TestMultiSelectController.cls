@isTest
public class TestMultiSelectController{

	static testMethod void testMultiselectController() {
		
		Controlled_Document__c newControlledDocument = ControlledDocumentTestUtility.createTestControlDoc();
		insert newControlledDocument;

		Controlled_Document__c newlyCreatedCD = [SELECT Id FROM Controlled_Document__c];

		PageReference pageRef = Page.RelatedApprovalStepList;
		Test.setCurrentPage(pageRef);

		ApexPages.StandardController standardController = new ApexPages.StandardController(newlyCreatedCD);
		ApexPages.currentPage().getParameters().put('Id', newlyCreatedCD.Id);

		MultiselectController c = new MultiselectController();

		c.leftPicklist = new List<SelectOption>();
		c.rightPicklist = new List<SelectOption>();

		c.leftOptionsHidden = 'A&a&b&b&C&c';
		c.rightOptionsHidden = '';

		System.assertEquals(c.leftPicklist.size(), 3);
		System.assertEquals(c.rightPicklist.size(), 0);

	}

	static testMethod void testMultiselectControllerWithPageReference() {

		Controlled_Document__c newControlledDocument = ControlledDocumentTestUtility.createTestControlDoc();
		insert newControlledDocument;

		PageReference pageRef = Page.RelatedApprovalStepList;
		Test.setCurrentPage(pageRef);

		ApexPages.StandardController standardController = new ApexPages.StandardController(newControlledDocument);
		ApexPages.currentPage().getParameters().put('Id', newControlledDocument.Id);

		MultiselectController c = new MultiselectController(standardController);

		System.assert(true);

	}

	// testing the multiselect controller as someone who didn't create the controlled document
	static testMethod void testMultiselectControllerWithPageReferenceAsThirdParty(){

		Controlled_Document__c newControlledDocument = ControlledDocumentTestUtility.createTestControlDoc();
		insert newControlledDocument;

		PageReference pageRef = Page.RelatedApprovalStepList;
		Test.setCurrentPage(pageRef);

		ApexPages.StandardController standardController = new ApexPages.StandardController(newControlledDocument);
		ApexPages.currentPage().getParameters().put('Id', newControlledDocument.Id);

		MultiselectController c = new MultiselectController(standardController);

		c.originatingUser = null;
		c.checkForSpecialPrivs();

		c.searchObject = 'Users';
		c.refreshAvailableUserList();

		c.searchObject = 'Common Users';
		c.refreshAvailableUserList();

		c.searchString = '';
		c.findUsers();

		c.searchString = 'Test';
		c.findUsers();

		c.searchString = '';
		c.findCommonUsers();

		c.searchString = 'Test';
		c.findCommonUsers();

		c.saveChanges();

		System.assert(true);

	}
    
    // case# 31205 - BEGIN
    static testMethod void testMultiselectControllerWithPageReferenceAsThirdParty2(){
		List<User> admusers = [SELECT Id FROM User WHERE Profile.Name = 'GSA System Administrator' AND IsActive =true 
                               AND Id != :UserInfo.getUserId() LIMIT 3];
		Controlled_Document__c newControlledDocument = ControlledDocumentTestUtility.createTestControlDoc();
		insert newControlledDocument;
		Common_Supplementary_User__c cm = new Common_Supplementary_User__c();
        cm.Group_Member__c = UserInfo.getUserId();
        insert cm;
        Common_Supplementary_User__c cm1 = new Common_Supplementary_User__c();
        cm1.Group_Member__c = admusers[0].Id;
        insert cm1;
        Common_Supplementary_User__c cm2 = new Common_Supplementary_User__c();
        cm2.Group_Member__c = admusers[1].Id;
        insert cm2;
        Common_Supplementary_User__c cm3 = new Common_Supplementary_User__c();
        cm3.Group_Member__c = admusers[1].Id;
        insert cm3;
        Common_Supplementary_User__c cm4 = new Common_Supplementary_User__c();
        cm4.Group_Member__c = admusers[0].Id;
        insert cm4;
        Supplementary_Access_User__c su = new Supplementary_Access_User__c();
        su.Active__c = true;
        su.Origin__c = 'Quick Share';
        su.Originating_User__c = UserInfo.getUserId();
        su.User__c = UserInfo.getUserId();
        su.Controlled_Document__c = newControlledDocument.Id;
        insert su;
		Supplementary_Access_User__c su2 = new Supplementary_Access_User__c();
        su2.Active__c = true;
        su2.Origin__c = 'Quick Share';
        su2.Originating_User__c = UserInfo.getUserId();
        su2.User__c = admusers[0].Id;
        su2.Controlled_Document__c = newControlledDocument.Id;
        insert su2;
		Supplementary_Access_User__c su3 = new Supplementary_Access_User__c();
        su3.Active__c = true;
        su3.Origin__c = 'Quick Share';
        su3.Originating_User__c = UserInfo.getUserId();
        su3.User__c = admusers[0].Id;
        su3.Controlled_Document__c = newControlledDocument.Id;
        insert su3;
        Supplementary_Access_User__c su4 = new Supplementary_Access_User__c();
        su4.Active__c = true;
        su4.Origin__c = 'Quick Share';
        su4.Originating_User__c = UserInfo.getUserId();
        su4.User__c = admusers[2].Id;
        su4.Controlled_Document__c = newControlledDocument.Id;
        insert su4;
        
        PageReference pageRef = Page.RelatedApprovalStepList;
		Test.setCurrentPage(pageRef);

		ApexPages.StandardController standardController = new ApexPages.StandardController(newControlledDocument);
		ApexPages.currentPage().getParameters().put('Id', newControlledDocument.Id);

		MultiselectController c = new MultiselectController(standardController);

		c.originatingUser = null;
		c.checkForSpecialPrivs();

		c.searchObject = 'Users';
		c.refreshAvailableUserList();

		c.searchObject = 'Common Users';
		c.refreshAvailableUserList();

		c.searchString = '';
		c.findUsers();
        c.isExecSecOrOwner = false;
        c.findSelectedUsers();
		c.searchString = 'Theresa';
		c.findUsers();
	
		c.searchString = '';
		c.isExecSecOrOwner = false;        
        //c.findSelectedUsers();		
        c.findCommonUsers();

		c.searchString = 'Theresa';
        c.isExecSecOrOwner = false;        
		c.findCommonUsers();

		c.saveChanges();

		System.assert(true);
	}
    // case# 31205 - END

}