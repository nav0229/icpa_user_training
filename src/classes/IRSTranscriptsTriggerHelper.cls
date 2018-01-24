/****************************************************************
 Name: IRSTranscriptsTriggerHelper
============================================================
Author: /Matt
Purpose: Trigger Helper for IRS Transcript Trigger
============================================================

****************************************************************/

public with sharing class IRSTranscriptsTriggerHelper {
	
	@TestVisible private ChecklistItemUpdaterInterface checklistItemUpdater = new ChecklistItemUpdaterByIRSTranscript();

	@TestVisible private ApplicationIRSActualIncomeUpdater appIRSIncomeUpdater = new ApplicationIRSActualIncomeUpdater();

	public IRSTranscriptsTriggerHelper(){}

	public void afterInsert(List<IRS_Transcripts__c> newTranscripts){
		checklistItemUpdater.handleChecklistUpdates(newTranscripts);
		appIRSIncomeUpdater.updateApplicationIRSActualIncome(newTranscripts);
	}

	public void afterUpdate(List<IRS_Transcripts__c> newTranscripts, Map<Id,IRS_Transcripts__c> oldTranscriptsMap){
		checklistItemUpdater.handleChecklistUpdates(newTranscripts);
		appIRSIncomeUpdater.updateApplicationIRSActualIncome(newTranscripts);
	}

}