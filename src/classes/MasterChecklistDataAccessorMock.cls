/****************************************************************
 Name: MasterChecklistDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor for Master_Checklist__c
============================================================

****************************************************************/
@isTest
public with sharing class MasterChecklistDataAccessorMock implements MasterChecklistDAO {
	public Integer getMasterChecklistsCallCount {get; private set;}
	public Integer getMasterChecklistByChecklistCodeCallCount {get; private set;}
	public Integer getMasterChecklistsByChecklistCodesCallCount {get; private set;}
	public Integer getMasterChecklistsMapByIdCallCount {get; private set;}

	public List<Master_Checklist__c> getMasterChecklistsReturn;
	public Map<Id, Master_Checklist__c> getMasterChecklistsMapByIdReturn;
	public Master_Checklist__c getMasterChecklistByChecklistCodeReturn;
	public List<Master_Checklist__c> getMasterChecklistsByChecklistCodesReturn;

	public MasterChecklistDataAccessorMock(){
		getMasterChecklistsCallCount = 0;
		getMasterChecklistsMapByIdCallCount = 0;
		getMasterChecklistByChecklistCodeCallCount = 0;
		getMasterChecklistsByChecklistCodesCallCount = 0;

		getMasterChecklistsReturn = new List<Master_Checklist__c>();
		getMasterChecklistsMapByIdReturn = new Map<Id, Master_Checklist__c>();
		getMasterChecklistByChecklistCodeReturn = new Master_Checklist__c();
		getMasterChecklistsByChecklistCodesReturn = new List<Master_Checklist__c>();
	}

	public List<Master_Checklist__c> getMasterChecklists() {
		getMasterChecklistsCallCount++;
		return getMasterChecklistsReturn;
	}

	public Map<Id, Master_Checklist__c> getMasterChecklistsMapById(List<Id> masterChecklistIds){
		getMasterChecklistsMapByIdCallCount++;
		return getMasterChecklistsMapByIdReturn;
	}

	public Master_Checklist__c getMasterChecklistByChecklistCode(String checklistCode) {
		getMasterChecklistByChecklistCodeCallCount++;
		return getMasterChecklistByChecklistCodeReturn;
	}

	public List<Master_Checklist__c> getMasterChecklistsByChecklistCodes(List<String> checklistCodes) {
		getMasterChecklistsByChecklistCodesCallCount++;	
		return getMasterChecklistsByChecklistCodesReturn;
	}
}