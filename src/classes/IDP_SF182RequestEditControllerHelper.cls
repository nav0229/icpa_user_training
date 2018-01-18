/*
	This class only exists because the IDP_SF182RequestEditController cannot be labelled
	'without sharing' because it is associated with a Visualforce page. Usually this 
	could be defended but GSA uses a security scanner that will complain about VF pages
	labelled as 'without sharing'. Getting an exception from security for this is next to 
	impossible.
*/
public without sharing class IDP_SF182RequestEditControllerHelper {

	public static Form_SF_182__c getSF182(Id id){
		return [SELECT Id, Idp__c FROM Form_SF_182__c WHERE Id = :id];
	}

	public static Form_SF_182__c getSF182(String name){
		return [SELECT Id, Idp__c FROM Form_SF_182__c WHERE Name = :name];
	}
	
	public static List<IDP_Developmental_Line_Item__c> getActivities(Id idpId){
		return [
			SELECT Id, Name, Developmental_Objective__r.IDP__c, Total_Cost__c, Assignment_Title__c, 
				Create_Date__c, Planned_Start_Date__c, Planned_End_Date__c, Activity_Type__c
			FROM IDP_Developmental_Line_Item__c 
			WHERE Developmental_Objective__r.IDP__c = :idpId
			ORDER BY Name ASC];
	}

	public static String getActivityName(Id activityId){
		return [SELECT Id, Name FROM IDP_Developmental_Line_Item__c WHERE Id = :activityId].Name;
	}

}