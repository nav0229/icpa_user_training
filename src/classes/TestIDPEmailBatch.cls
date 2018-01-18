/*-------------------------------------------------------------------------------------------------*
  Apex class 
  Test Class for IDP_Email_Batch & IDP_Batch_Scheduler classes
  *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          04/22/2014    1.0       Test coverage compliance
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
@isTest(seeAllData=false)
private class TestIDPEmailBatch {
    @isTest
    static void testSchedule() {
          Test.StartTest();
          IDP_Batch_Scheduler sh1 = new IDP_Batch_Scheduler();
          String sch = '0 0 23 * * ?';
          string JobId = system.schedule('IDP_Batch_Scheduler', sch, sh1);
            CronTrigger ct = [SELECT id
                                     ,CronExpression
                                     ,TimesTriggered 
                                     ,NextFireTime
                              FROM CronTrigger 
                              WHERE id = :jobId];
    
        System.assertEquals(sch, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        //System.abortJob(JobId) ;
        Test.StopTest();
    }
    
    @isTest
    static void testEmailBatch(){
        Test.startTest();    
        IDP_Email_Batch objTest = new IDP_Email_Batch();
        objTest.query = 'SELECT Assignee.Id, PermissionSetId from PermissionSetAssignment WHERE PermissionSetId IN (SELECT Id From PermissionSet WHERE Name=\'HR_Access_to_IDP_and_related_Objects\' OR Name=\'IDP_All_Users\') LIMIT 1';
        Id processId = Database.executeBatch(objTest, 1);
        Test.stopTest();    
        System.assert(processId != null); 
    }
}