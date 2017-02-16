public with sharing class GSA_FCIC_CaseKpiUpdateBatch implements Database.Batchable<sObject> {

	public String query;
	public String businessHoursId;

	public GSA_FCIC_CaseKpiUpdateBatch(){
		BusinessHours bsnsHours = [SELECT Id FROM BusinessHours WHERE Name = 'FCIC hours' LIMIT 1];
		businessHoursId = bsnsHours.Id;
		query = 'SELECT Id, CreatedDate, ClosedDate, Business_Hours_Age__c ' + 
			'FROM Case ' + 
			'WHERE ClosedDate != NULL';
	}

	public Database.QueryLocator start(Database.BatchableContext context){
		return Database.getQueryLocator(query);
	}

	public void execute(Database.BatchableContext context, List<sObject> scope){
		for(SObject obj : scope){
			Case c = (Case) obj;
			Datetime startTime = c.CreatedDate;
			Datetime endTime = c.ClosedDate;
			Decimal timeInMilliseconds = BusinessHours.diff(businessHoursId, startTime, endTime);
			Decimal timeInMinutes = timeInMilliseconds/1000/60;
			Decimal timeInHours = timeInMinutes/60;
			c.Business_Hours_Age__c = timeInHours;
		}
		update scope;
	}

	public void finish(Database.BatchableContext context){
	}
}