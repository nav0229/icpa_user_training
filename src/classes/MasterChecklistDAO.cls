/****************************************************************
 Name: MasterChecklistDAO
============================================================
Author: 
Purpose: Data Access Object for Master_Checklist__c
============================================================

****************************************************************/

public interface MasterChecklistDAO {
	List<Master_Checklist__c> getMasterChecklists();
	Map<Id, Master_Checklist__c> getMasterChecklistsMapById(List<Id> masterChecklistIds);
	Master_Checklist__c getMasterChecklistByChecklistCode(String checklistCode);
	List<Master_Checklist__c> getMasterChecklistsByChecklistCodes(List<String> checklistCodes);
}