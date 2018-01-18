global with sharing class GLXY_ReconciliationJobSchedule4 implements Schedulable{
	global void execute(SchedulableContext sc){
		database.executeBatch(new GLXY_ReconciliationTotalLumpSums());
	}
	static testMethod void testReconciliationJobSchedule(){
		DateTime n = datetime.now().addMinutes(1);
   		String cron = '';
   		cron += n.second();
   		cron += ' ' + n.minute();
   		cron += ' ' + n.hour();
   		cron += ' ' + n.day();
   		cron += ' ' + n.month();
   		cron += ' ' + '?';
   		cron += ' ' + n.year();
   		System.Assert(n!=NULL);
   		System.schedule('GLXY_ReconciliationTotalLumpSums', cron, new GLXY_ReconciliationJobSchedule4());
	}
}