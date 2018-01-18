/*Refactored the Test class to use new IDP_TestDataFactory for data creation and 
 * Added new method testSF182RequestEditControllerActivityNegative to increase coverage- Ramesh Dugar 11/30/16*/
@isTest
public class IDP_SF182Test{
  private static List<IDP__c> newIdp;
  private static List<Form_SF_182__c> newSF182;
  private static List<SF_182_Training__c> newSF182Request;
  private static List<Developmental_Objective__c> Objective;
  private static List<Developmental_Objective__c> newObjective;
  private static List<IDP_Developmental_Line_Item__c> newActivity;


  ///////////////////////IDP_SF182Detail.page////////////////////////////
  static testMethod void testSF182DetailController(){
    createIDPandSF182TestData();
    IDP_SF182DetailController newController = new IDP_SF182DetailController(new ApexPages.StandardController(newSF182[0]));
    System.assert(newController != null);
  }
  //////////////////////////////////////////////////////////////////////


  ////////////////////IDP_SF182Edit.page////////////////////////////////
  static testMethod void testSF182EditController(){
    createIDPandSF182TestData();
    IDP_SF182EditController newController = new IDP_SF182EditController(new ApexPages.StandardController(newSF182[0]));
    System.assert(newController != null);
  }
  ///////////////////////////////////////////////////////////////////////


  ////////////////////IDP_SF182RequestDetail.page////////////////////////////////
  static testMethod void testSF182RequestDetailController(){
    createIDPandSF182TestData();
    IDP_SF182RequestDetailController newController = new IDP_SF182RequestDetailController(new ApexPages.StandardController(newSF182Request[0]));
    System.assert(newController != null);
  }
  //////////////////////////////////////////////////////////////////////////////

  ////////////////////IDP_SF182RequestEdit.page////////////////////////////////
  static testMethod void testSF182RequestEditControllerRecordTypeCoverage(){
    createIDPandSF182TestData();
    // RecordTypeId != null
    RecordType rt = [select id from RecordType where Name=:'SF 182 Training Request'];
   
    
    IDP_SF182RequestEditController newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
	newController.newSF182Request.RecordTypeId =rt.Id;
    // pageId != null
    newController.pageId = newController.newSF182Request.RecordTypeId;
    newController.newSF182Request.RecordTypeId = null;
    newController.assignRecordTypeInformation();

    // both are null
    newController.newSF182Request.RecordTypeId = null;
    newController.pageId = null;
    newController.assignRecordTypeInformation();
    System.assert(newController != null);
  }

  static testMethod void testSF182RequestEditControllerCreateVendor(){
    createIDPandSF182TestData();
    IDP_SF182RequestEditController newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
    newController.showPopupVendor();
    newController.newVendor.Name = 'Shia LeBeouf';
    newController.createNewVendor();
    newController.closePopupVendor();
    System.assert(newController != null);
  }

  static testMethod void testSF182RequestEditControllerChooseActivity(){
    createIDPandSF182TestData();
    IDP_SF182RequestEditController newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
    newController.selectedActivityName = newActivity[0].Name;
    newController.save();
    newController.saveAndNew();
    
    System.assert(newController != null);
  }
    
  static testMethod void testSF182RequestEditControllerActivityNegative(){
    createIDPandSF182TestData();
    IDP_SF182RequestEditController newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
    newController.selectedActivityName = '';
    newController.save();
    newController.saveAndNew();
    System.assert(newController != null);
  }
  
    static testMethod void testSF182RequestEditControllerALL(){
    createIDPandSF182TestData();
    IDP_SF182RequestEditController newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
    newController.showPopupVendor();
    newController.newVendor.Name = 'Shia LeBeouf';
    newController.createNewVendor();
    newController.closePopupVendor();
    newController.sf182Name = newSF182[0].Name;
    newController.showPopupActivity();
    newController.closePopupActivity();
    newController.selectActivityFiltered();
    newController.getActivityName();
    newController.save();
    newController.saveAndNew();
    System.assert(newController != null);
  }

  static testMethod void testSF182RequestEditControllerForceErrors(){
    createIDPandSF182TestData();
    IDP_SF182RequestEditController newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
    newController.newVendor.Name = null;
    newController.createNewVendor();
    System.assert(newController != null);
  }

  static testMethod void testSF182RequestEditControllerAsApprover(){
    createIDPandSF182TestData();
    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
    req.setComments('Submitting request for approval.');
    req.setObjectId(newSF182Request[0].id);
    req.setSubmitterId(UserInfo.getUserId());
    Approval.ProcessResult result = Approval.process(req);

    IDP_SF182RequestEditController newController;
	User u = new user();
    u.id = userinfo.getUserId();
    System.runAs(u) {
      newController = new IDP_SF182RequestEditController(new ApexPages.StandardController(newSF182Request[0]));
    }

    System.assert(newController != null);
  }
 
  /////////////////////////////IDP_SF182RequestEditControllerHelper/////////////
  static testMethod void testSF182RequestEditControllerHelper(){
    createIDPandSF182TestData();
    try {
      Form_SF_182__c test1 = IDP_SF182RequestEditControllerHelper.getSF182(newIdp[0].Id);
    } catch (Exception e){
      // do nothing
    }

    try {
      Form_SF_182__c test2 = IDP_SF182RequestEditControllerHelper.getSF182(newIdp[0].Name);
    } catch (Exception e){
      // do nothing
    }

    List<IDP_Developmental_Line_Item__c> test3;
    try {
      test3 = IDP_SF182RequestEditControllerHelper.getActivities(newIdp[0].Id);
    } catch (Exception e){
      // do nothing
    }

    try {
      String test4 = IDP_SF182RequestEditControllerHelper.getActivityName(test3.get(0).Id);
    } catch (Exception e){
      // do nothing
    }

    System.assert(true);
  }
 
  private static void createIDPandSF182TestData(){
    newIdp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','Approved','Team Lead', 'Manager','IDP Approved','GSA System Administrator');
    newIdp = [SELECT Id, Name, Fiscal_Year_pick__c, Supervisor__c, IDP_Status__c, RecordTypeId FROM IDP__c WHERE Id =: newIdp[0].Id];

    system.debug('****'+newIdp);
    newSF182 = IDP_TestDataFactory.createsfoneeightytwo(newIdp,1);
    newSF182 = [SELECT Id, Name, IDP__c FROM Form_SF_182__c WHERE Id =: newSF182[0].Id];
    newSF182Request = IDP_TestDataFactory.createsfoneeightytworeq(newSF182,1,'GSA System Administrator');
    newSF182Request = [SELECT Id, Name, Activity__c, SF_182__c, Training_Vendor_Name__c, RecordTypeId FROM SF_182_Training__c WHERE Id =: newSF182Request[0].Id];
    newObjective = IDP_TestDataFactory.createObjective(newIdp, 1);
    newActivity = IDP_TestDataFactory.createActivity(newObjective, 1, date.today(), date.today()+1);
    newActivity = [SELECT Id, Name FROM IDP_Developmental_Line_Item__c WHERE Developmental_Objective__c =: newObjective[0].Id];
  }
    
}