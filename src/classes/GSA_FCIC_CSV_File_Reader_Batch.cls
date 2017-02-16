/******************************************************************************************
* 
* Description: Reads CSV file lines in bulk for the Phone CSAT portion of the
* Federal Citizen Information Center (FCIC) app.
* 
*
* Modification Log:
* -----------------------------------------------------------------------------------------
* Mod ID      | Date         | Mod Author             		 	| Brief Mod Description 
* -----------------------------------------------------------------------------------------
* 0001        | 7/6/2015     | David Lombardo					| Initial code creation.
*			  | 	         | (dlombardo@acumensolutions.com)	| 
* -----------------------------------------------------------------------------------------
*
*******************************************************************************************/


global with sharing class GSA_FCIC_CSV_File_Reader_Batch implements Database.Batchable<Attachment> {
	
	private GSA_FCIC_CSV_Line_Processor processor;
	private List<Attachment> attachments;
	
	public GSA_FCIC_CSV_File_Reader_Batch(GSA_FCIC_CSV_Line_Processor processor, List<Attachment> attachments) {
		System.debug(LoggingLevel.INFO,'*** GSA_FCIC_CSV_File_Reader_Batch ***');
	
		this.processor = processor;
		this.attachments = attachments;
	}
	
	global Iterable<Attachment> start(Database.BatchableContext BC) {
		return this.attachments;
	}

   	global void execute(Database.BatchableContext BC, List<Attachment> scope) {
		this.processor.processCSVLines(scope);
		this.processor.createStagingRecords();
		this.processor.createSurveyRecords();
		this.processor.sendStatusEmail();
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}