global with sharing class GLXY_BC_JobSchedule15b implements Schedulable{
	
    global void execute(SchedulableContext sc){
    	//system.abortJob(sc.getTriggerID());
        database.executeBatch(new GLXY_BC_GenerateFYTotals2());
    }
    
    static testMethod void testBudgetCallJobSchedule(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
		String jobId = System.schedule('GLXY_BC_GenerateFYTotals2', cron, new GLXY_BC_JobSchedule15b());
   		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
   		System.assertEquals(cron, ct.CronExpression);
    }
}