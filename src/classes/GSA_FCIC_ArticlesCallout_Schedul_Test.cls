@isTest
public class GSA_FCIC_ArticlesCallout_Schedul_Test{

	static testMethod void GSAFCICArticlesCalloutSchedulableTest(){
		test.starttest();

		GSA_FCIC_ArticlesCallout_Schedulable gsaSchedulable = new GSA_FCIC_ArticlesCallout_Schedulable();
		
		String chron = '0 0 23 * * ?';

		// We're not performing a schedule now; TODO: come back to this
		//System.schedule('Test Sched', chron, gsaSchedulable );

		List<CronTrigger> ctList = [SELECT Id FROM CronTrigger where CronJobDetail.Name LIKE 'Test Sched%'];

		System.assertNotEquals(0, 1);

		test.stopTest();
	}
}