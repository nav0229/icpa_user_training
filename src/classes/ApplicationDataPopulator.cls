/****************************************************************
 Name: ApplicationDataPopulator
============================================================
Author: Kevin
Purpose: JIRA#1473
Populates specific data on Applications
============================================================

****************************************************************/
 public with sharing class ApplicationDataPopulator implements ApplicationDataPopulatorInterface {

	@TestVisible private static AppProcessingVariablesDAO appProcessingVariablesDA = new AppProcessingVariablesDataAccessor();

	public ApplicationDataPopulator(){}

	/****************************************************************
		Purpose: Primary method that verifies that applications are new and sends new Apps to submethods that handle the data processing. 
		Parameters: List of Applications
		Returns: N/A
	****************************************************************/
	public void populateDataOnNewApplications(List<Application__c> applications){
		List<Application__c> newApplications = new List<Application__c>();
		
		for(Application__c app : applications){
			if(app.Id == null){
				newApplications.add(app);
			}
		}

		populateAppProcessingVariablesLookup(newApplications);
	}

	/****************************************************************
		Purpose: Populates App Processing Variables Lookup for Home and Business Applications
		Parameters: List of Applications
		Returns: N/A
	****************************************************************/
	private void populateAppProcessingVariablesLookup(List<Application__c> applications){
		Schema.DescribeSObjectResult describeResult = Application__c.SObjectType.getDescribe();
		Map<Id,RecordTypeInfo> recordTypeIdToRecordTypeInfoMap = describeResult.getRecordTypeInfosById();

		App_Processing_Variables__c defaultHomeAppProcVariable;
		App_Processing_Variables__c defaultBusinessAppProcVariable;

		try {
			defaultHomeAppProcVariable = appProcessingVariablesDA.getNewestActiveAppProcessingVariableByType(ApplicationDataAccessor.APPLICATION_TYPE_HOME);
		} catch(QueryException e) {
			System.debug('Unable to find Default Home Application Processing Variables record');
		}

		try {
			defaultBusinessAppProcVariable = appProcessingVariablesDA.getNewestActiveAppProcessingVariableByType(ApplicationDataAccessor.APPLICATION_TYPE_BUSINESS);
		} catch(QueryException e) {
			System.debug('Unable to find Default Business Application Processing Variables record');
		}

		Id defaultHomeId;
		Id defaultBusinessId;

		if(defaultHomeAppProcVariable != null){
			defaultHomeId = defaultHomeAppProcVariable.Id;
		}

		if(defaultBusinessAppProcVariable != null){
			defaultBusinessId = defaultBusinessAppProcVariable.Id;
		}

		for(Application__c app : applications){
			if(recordTypeIdToRecordTypeInfoMap.get(app.RecordTypeId).getName() == ApplicationDataAccessor.APP_RT_NAME_HOME){
				app.App_Processing_Variables__c = defaultHomeId;
			} else if(recordTypeIdToRecordTypeInfoMap.get(app.RecordTypeId).getName() == ApplicationDataAccessor.APP_RT_NAME_BUSINESS){
				app.App_Processing_Variables__c = defaultBusinessId;
			}

			if((recordTypeIdToRecordTypeInfoMap.get(app.RecordTypeId).getName() == ApplicationDataAccessor.APP_RT_NAME_HOME
					|| recordTypeIdToRecordTypeInfoMap.get(app.RecordTypeId).getName() == ApplicationDataAccessor.APP_RT_NAME_BUSINESS)
				&& app.App_Processing_Variables__c == null)
			{
				//add Application to Exception Queue
			}
		}
	}
}