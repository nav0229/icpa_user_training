/**
 * The AppRegistrySearchController searches for applications with specified characteristics.
 * 
 * Revision History
 *
 * 09/20/2011   DRH - Created.
 * 09/21/2011   DRH - Implemented the advancedSearch() method.
 * 09/27/2011   DRH - Fixed bugs in Included_Function__c queries.
 * 09/29/2011   DRH - Replaceded SOQL Where Like Statements With SOSL statements.
 * 10/03/2011   DRH - Consolidated standard text and advanced search search.
 * 10/05/2011   DRH - Refined the invalidSearchParameters() method.
 * 11/15/2011   DBP - Added filtering by Point of Contact.
 */
public with sharing class AppRegistrySearchController {

	public List<SelectOption> appTypeOptions {get;set;}
	public List<SelectOption> functionTypeOptions {get;set;}
	public List<SelectOption> stateOptions {get;set;}

	public List<Application_Version__c> appVersionList {get;set;}
	public Application_Version__c appVersionPOC{get;set;}

	public String keyWordInput {get;set;}
	public String appType {get;set;}
	public String functionType {get;set;}
	public String state {get;set;}

	private Set<Id> appSet = new Set<Id>();
	private Set<Id> appVersionSet = new Set<Id>();

	private Boolean textSearchRequired = false;

	public AppRegistrySearchController() {
		setAppTypeOptions();
		setFunctionTypeOptions();
		setStateOptions();
		appVersionPOC = new Application_Version__c();
	}

	public void search() {
		System.debug('\n\n>> AppRegistrySearchController.search()');
		
		if (invalidSearchParameters()) {
			ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Your search term must have 2 or more characters.');
			ApexPages.addMessage(msg);
			return;
		}

		if (textSearchRequired) {
			searchForKeyWords();

			// retrieve list of Application_Version__c matches
			appVersionList = [SELECT av.Application__c, av.Application_Name__c, av.Application__r.Type__c, av.Application__r.Description_Abbrev__c,
									 av.Id, av.Version__c, av.State__c, av.Point_of_Contact__r.Name,
							 (SELECT avf.application_function__c From Application_Version_Functions__r avf)
								FROM Application_Version__c av
							   WHERE av.Application__c In :appSet
								  OR av.Id In :appVersionSet];
		}
		else {
			// retrieve list of Application_Version__c matches
			appVersionList = [SELECT av.Application__c, av.Application_Name__c, av.Application__r.Type__c, av.Application__r.Description_Abbrev__c,
									 av.Id, av.Version__c, av.State__c, av.Point_of_Contact__r.Name,
							 (SELECT avf.application_function__c From Application_Version_Functions__r avf)
								FROM Application_Version__c av where av.isDeleted = false];
		}

		if (appType != null) {
			Integer items = appVersionList.size();

			for (Integer i=items; i>0; i--) {
				Integer index = i-1;

				Application_Version__c appVersion = appVersionList.get(index);

				if (appVersion.Application__r.Type__c != appType) {
					appVersionList.remove(index);
				}
			}
System.debug('\n\n>> AppRegistrySearchController.search() - appType: ' + appType);
		}

		if (functionType != null) {
			Integer items = appVersionList.size();

			for (Integer i=items; i>0; i--) {
				Integer index = i-1;

				Application_Version__c appVersion = appVersionList.get(index);

				List<Included_Function__c> incFunctionList = appVersion.Application_Version_Functions__r;

				Boolean noMatches = true;

				if (incFunctionList.size() > 0) {
					
					for (Included_Function__c incFunction : incFunctionList) {
						if (incFunction.Application_Function__c == functionType) {
							noMatches = false;
							break;
						}
					}
				}
				if (noMatches) {
					appVersionList.remove(index);				   
				}
			}
System.debug('\n\n>> AppRegistrySearchController.search() - functionType: ' + functionType);
		}

		if (state != null) {
			Integer items = appVersionList.size();

			for (Integer i=items; i>0; i--) {
				Integer index = i-1;

				Application_Version__c appVersion = appVersionList.get(index);

				if (appVersion.State__c != state) {
					appVersionList.remove(index);
				}
			}
System.debug('\n\n>> AppRegistrySearchController.search() - state: ' + state);
		}
		
		if (appVersionPOC.Point_of_Contact__c != null)
		{
			integer i = 0;
			while (i < appVersionList.size())
			{
				if (appVersionList.get(i).Point_Of_Contact__c != appVersionPOC.Point_Of_Contact__c)
				{
					appVersionList.remove(i);
				}else
				{
					i++;
				}
			}
		}

		//return null;
	}

	private Boolean invalidSearchParameters() {
		Boolean invalid = true;

		textSearchRequired = false;

		if (appType != null || functionType != null || state != null || appVersionPOC.Point_Of_Contact__c != null) {
			invalid = false;
		}
		if (keywordInput != null && keywordInput.trim().length() > 0) {
			String prefix = keywordInput;

			while (prefix.length() > 1 && prefix.endsWith('*')) {
				Integer index = prefix.length() - 1;
				prefix = prefix.substring(0, index);
			}
			if (prefix.length() > 1) {
				textSearchRequired = true;

				invalid = false;
			}
			else {
				invalid = true;
			}
		}
		return invalid;
	}

	private void searchForKeyWords() {

		// clear the previous results
		appSet.clear();
		appVersionSet.clear();

System.debug('\n\n>> AppRegistrySearchController.searchForKeyWords() - keyWordInput: ' + keyWordInput);

		List<List<SObject>> searchList = [FIND :keyWordInput IN ALL FIELDS RETURNING Application__c (id), Application_Version__c (id), Application_Function__c (id)];
System.debug('\n\n>> AppRegistrySearchController.search() - searchList.size() - ' + searchList.size());

		List<Application__c> appList = searchList.get(0);

		for (Application__c app : appList){
System.debug('\n\n>> AppRegistrySearchController.advancedSearchForKeyWords() - appSet: ' + app.id);
			appSet.add(app.id);
		}

		List<Application_Version__c> appVersionList = searchList.get(1);

		for (Application_Version__c appVersion : appVersionList) {
System.debug('\n\n>> AppRegistrySearchController.advancedSearchForKeyWords(1) - appVerionSet: ' + appVersion.id);
			appVersionSet.add(appVersion.id);
		}

		Set<Id> appFunctionSet = new Set<Id>();

		List<Application_Function__c> appFunctionList = searchList.get(2);

		for (Application_Function__c appFUnction : appFunctionList) {
			appFunctionSet.add(appFunction.id);
		}

		List<Included_Function__c> incFunctionList = [Select i.Application_Version__c
														From Included_Function__c i
													   Where i.Application_Function__c In :appFunctionSet];

		for (Included_Function__c includedFunction : incFunctionList) {
System.debug('\n\n>> AppRegistrySearchController.advancedSearchForKeyWords(2) - appVerionSet: ' + includedFunction.Application_Version__c);
			appVersionSet.add(includedFunction.Application_Version__c);
		}
	}

	private void setAppTypeOptions() {
		appType = '';
		appTypeOptions = new List<SelectOption>();

		appTypeOptions.add(new SelectOption('', 'Select...'));

		Schema.DescribeFieldResult fieldDescribe = Application__c.Type__c.getDescribe();
		List<Schema.PicklistEntry> picklistValues = fieldDescribe.getPicklistValues();

		for (Schema.PicklistEntry picklistValue : picklistValues) {
			appTypeOptions.add(new SelectOption(picklistValue.getValue(), picklistValue.getLabel()));
		}
	}

	private void setFunctionTypeOptions() {
		functionType = '';
		functionTypeOptions = new List<SelectOption>();

		List<Application_Function__c> functionTypeList = [Select af.Id, af.Name
															From Application_Function__c af
															Where af.isDeleted = false
														   Order By af.Name];
							 //SD 0927 Added isDeleted = false clause to include where clause
		functionTypeOptions.add(new SelectOption('', 'Select...'));

		for (Application_Function__c functionType : functionTypeList) {
			SelectOption option = new SelectOption(functionType.Id, functionType.Name);
			functionTypeOptions.add(option);
		}
	}

	private void setStateOptions() {
		state = 'Operational';
		stateOptions = new List<SelectOption>();

		stateOptions.add(new SelectOption('', 'Select...'));

		Schema.DescribeFieldResult fieldDescribe = Application_Version__c.State__c.getDescribe();
		List<Schema.PicklistEntry> picklistValues = fieldDescribe.getPicklistValues();

		for (Schema.PicklistEntry picklistValue : picklistValues) {
			stateOptions.add(new SelectOption(picklistValue.getValue(), picklistValue.getLabel()));
		}
	}
}