global with sharing class GLXY_ReconciliationJobSchedule2 implements Schedulable{
	global void execute(SchedulableContext sc){
		database.executeBatch(new GLXY_Reconciliation());
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
   		System.schedule('GLXY_Reconciliation', cron, new GLXY_ReconciliationJobSchedule2());
   		System.Assert(n!=NULL);
	}
}