/****************************************************************
 Name: IRSTranscriptsDAO
============================================================
Author: Kevin
Purpose: Data Access Object for IRS_Transcripts__c
============================================================

****************************************************************/
public interface IRSTranscriptsDAO {
	List<IRS_Transcripts__c> getIRSTranscriptsByApplicationId(Id applicationsId);
	List<IRS_Transcripts__c> getIRSTranscriptsByApplicationIds(List<Id> applicationsIds);
	List<IRS_Transcripts__c> getIRSTranscriptsByApplicantIds(List<Id> applicantIds);
}