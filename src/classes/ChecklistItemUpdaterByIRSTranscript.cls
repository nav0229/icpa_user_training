/****************************************************************
 Name: ChecklistItemUpdaterByIRSTranscript
============================================================
Author: Lenny
Purpose: Class for updating ChecklistItem by IRS Transcript
============================================================

****************************************************************/

public with sharing class ChecklistItemUpdaterByIRSTranscript extends ChecklistItemUpdater {
	@TestVisible private static IRSTranscriptsDAO irsTranscriptDA = new IRSTranscriptsDataAccessor();

	private Map<Id,List<IRS_Transcripts__c>> applicationIdToIRSTranscriptListMap;


	private boolean relatedObjectsAreValid(Id applicationId){
		for (IRS_Transcripts__c transcript : applicationIdToIRSTranscriptListMap.get(applicationId)) {
			if(transcript.Error_Message__c != null) {
				return false;
			}
		}
		return true;
	}


	private Map<Id, Application__c> getApplicationMap(){
		List<IRS_Transcripts__c> transcripts;
		try{
			transcripts = (List<IRS_Transcripts__c>)sObjects;
		} 
		catch (TypeException e) {
			System.debug(e);
			throw new ChecklistItemUpdaterException('handleChecklistUpdates requires a List of IRS Transcripts as input.', e);
		}

		List<Id> applicationIds = new List<Id>();
		for(IRS_Transcripts__c transcript : transcripts) {
			applicationIds.add(transcript.Application__c);
		}

		return getApplicationDA().getApplicationsMapById(applicationIds);
	}
	

	private void initializeRelatedObjects(List<Id> applicationIds) {
		applicationIdToIRSTranscriptListMap = new Map<Id,List<IRS_Transcripts__c>>();
		List<IRS_Transcripts__c> relatedTranscripts = irsTranscriptDA.getIRSTranscriptsByApplicationIds(applicationIds);

		for(IRS_Transcripts__c transcript : relatedTranscripts){
			if(applicationIdToIRSTranscriptListMap.containsKey(transcript.Application__c)){
				applicationIdToIRSTranscriptListMap.get(transcript.Application__c).add(transcript);
			} else {
				applicationIdToIRSTranscriptListMap.put(transcript.Application__c, new List<IRS_Transcripts__c>{transcript});
			}
		}
	}


	public Map<Id, Checklist_Item__c> getApplicationIdToChecklistItemMap(){
	 	return buildApplicationIdChecklistItemMap(MasterChecklistDataAccessor.IRS_TRANSCRIPT_CODE);
	}
}