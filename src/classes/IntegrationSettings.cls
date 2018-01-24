/****************************************************************
 Name: IntegrationSettings
============================================================
Author: Kevin
Purpose: Sets and holds Integration Callout Endpoint URL Roots
============================================================

****************************************************************/
public with sharing class IntegrationSettings {
	private static IntegrationSettings settings = null;

	public String biztalkCallout { get; private set; }

	private IntegrationSettings(){
		if(Test.isRunningTest()){
			populateTestSettings();
		} else {
			populateSettings();
		}
	}

	public static IntegrationSettings getSettings(){
		if(settings == null){
			settings = new IntegrationSettings();
		}
		return settings;
	}

	private void populateTestSettings(){
		this.biztalkCallout = '';
	}

	private void populateSettings(){
		this.biztalkCallout = Biztalk_Callout__c.getInstance().URL__c;
	}
}