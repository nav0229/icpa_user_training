/****************************************************************
 Name: BiztalkEndpoint
============================================================
Author: Kevin
Purpose: Static class to fetch Biztalk Callout Endpoint URL Paths
============================================================

****************************************************************/
public with sharing class BiztalkEndpoint {
	
	public static String setEndpoint(String methodName){
		String endpoint = IntegrationSettings.getSettings().BiztalkCallout;
		endpoint += [
			SELECT URL_Path__c
			FROM Biztalk_Endpoint__mdt
			WHERE DeveloperName = :methodName
		].URL_Path__c;
		return endpoint;
	}
}