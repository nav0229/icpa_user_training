global with sharing class Glxy_JobScheduleProcessDateUpdateEOYProj implements Schedulable{
	global void execute(SchedulableContext sc){
		database.executeBatch(new Glxy_UpdateProcessDateEOYProj(), 20);
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
   		System.schedule('Glxy_UpdateProcessDateEOYProj', cron, new Glxy_JobScheduleProcessDateUpdateEOYProj());
   		System.Assert(n!=NULL);
	}
}