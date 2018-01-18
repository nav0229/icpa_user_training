global with sharing class GLXY_ReconciliationJobSchedule implements Schedulable{
	global void execute(SchedulableContext sc){
		database.executeBatch(new GLXY_ReconciliationCleanUp());
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
   		System.schedule('GLXY_ReconciliationCleanUp', cron, new GLXY_ReconciliationJobSchedule());
   		System.Assert(n!=NULL);
	}
		
}