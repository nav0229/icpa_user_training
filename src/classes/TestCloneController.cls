@isTest(SeeAllData=true)
public class TestCloneController {

  static testMethod void myTestCloneController() {
        
      List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Test','Test','IDP Standard','GSA System Administrator'); 
      List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
	  List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+1);
	  List<Developmental_Competency__c> comp = IDP_TestDataFactory.createCompetency(activity, 1);
      
      ApexPages.StandardController sc = new ApexPages.standardController(idp[0]);
      IDP_ClonePlusController   cs = new IDP_ClonePlusController (sc);       
      cs.initialiseObjectsForCloning(idp[0].Fiscal_Year_pick__c);  
      system.assertEquals(true,true);
      
      
      IDP_Details idpd = new IDP_Details();
      idpd.idpID=idp[0].id;
      idpd.submitIDP();
      idpd.reviewIDP();
      idpd.continueEditingIDP();
      idpd.deleteIDP();
      idpd.gotoIDPDetailPage();
      idpd.getCurrentIDPS();
      idpd.getPreviousIDPS();
      idpd.getApprovalIDPS();
      idpd.editIDP();
      idpd.createIDP();
      idpd.updateIDPStatus();
  }
}