global with sharing class Glxy_JobScheduleProcessDateUpdateEOY implements Schedulable{
	global void execute(SchedulableContext sc){
		database.executeBatch(new Glxy_UpdateProcessDateEOYCPI());
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
   		System.schedule('Glxy_UpdateProcessDateEOY', cron, new Glxy_JobScheduleProcessDateUpdateEOY());
   		System.Assert(n!=NULL);
	}
}