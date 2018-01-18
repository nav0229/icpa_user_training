global with sharing class GLXY_ReconciliationJobSchedule3C implements Schedulable{
	global void execute(SchedulableContext sc){
		GLXY_ReconciliationSummaryTotals3 objExecuteMe = new GLXY_ReconciliationSummaryTotals3();
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
   		System.schedule('GLXY_ReconciliationSummaryTotals3', cron, new GLXY_ReconciliationJobSchedule3C());
   		System.Assert(n!=NULL);
	}
}