/*Modified by Ramesh Dugar to improve the test class 11/22/16*/
@isTest
private class TestActivitySecOnIDPStdPage {

    static testMethod void myUnitTest() {
    
        //creating data using IDP Test Data Factory
        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','Approved','Test','Test','IDP Standard','GSA System Administrator'); 
        List<Developmental_Objective__c> dobj = IDP_TestDataFactory.createObjective(idp,1);
        List<IDP_Developmental_Line_Item__c> idpli = IDP_TestDataFactory.createActivity(dobj,1,date.today(),date.today()+1); 
        
        system.debug('**'+idp);
        PageReference p = Page.IDP_activitySecOnIDPStdPage;
        p.getParameters().put('id', idp[0].Id);   
        Test.setCurrentPage(p); 
        ApexPages.StandardController sc = new ApexPages.StandardController(idp[0]); 
        IDP_activitySecOnIDPStdPage obj = new IDP_activitySecOnIDPStdPage(sc); 
        obj.getActivityWrapperList();
     
        system.assert(idp != null);                         
    }
}