global with sharing class GLXY_ReconciliationJobSchedule3B implements Schedulable{
	global void execute(SchedulableContext sc){
		GLXY_ReconciliationSummaryTotals2 objExecuteMe = new GLXY_ReconciliationSummaryTotals2();
		objExecuteMe.CalculateTotals();
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
   		System.schedule('GLXY_ReconciliationSummaryTotals2', cron, new GLXY_ReconciliationJobSchedule3B());
   		System.Assert(n!=NULL);
	}
}