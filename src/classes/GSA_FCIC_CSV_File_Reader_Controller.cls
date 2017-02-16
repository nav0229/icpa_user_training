/******************************************************************************************
* 
* Description: Reads CSV data into Staging Records for the Phone CSAT portion of the
* Federal Citizen Information Center (FCIC) app.
* 
*
* Modification Log:
* -----------------------------------------------------------------------------------------
* Mod ID      | Date         | Mod Author             		 	| Brief Mod Description 
* -----------------------------------------------------------------------------------------
* 0001        | 7/6/2015     | David Lombardo					| Initial code creation.
*			  | 	         | (dlombardo@acumensolutions.com),	| 
*			  | 	         | Paul Pick-Aluas					| 
*			  | 	         | (ppickaluas@acumensolutions.com)	| 
* -----------------------------------------------------------------------------------------
*
*******************************************************************************************/


public with sharing class GSA_FCIC_CSV_File_Reader_Controller {	
	public String CSVAsString {get; set;}
	public List<String> CSVFileLines {get; set;}
	public List<String> FieldList {get; set;}
	public List<Staging_Record__c> StagingRecords {get; set;}
	public CSAT_File__c CSATFile {get; set;}
	public Attachment attachment;

	private RecordType processedCSATRecordType;

	public GSA_FCIC_CSV_File_Reader_Controller(ApexPages.StandardController stdController) {	
		System.debug(LoggingLevel.INFO,'*** GSA_FCIC_CSV_File_Reader_Controller ***');

		this.CSVFileLines = new List<String>();
		this.FieldList = new List<String>();
		this.StagingRecords = new List<Staging_Record__c>();
		if(!Test.isRunningTest()) {
			stdController.addFields(new List<String> {'RecordType.Name','Name'});
		}
		this.CSATFile = (CSAT_File__c)stdController.getRecord();
		getProcessedCSATFileRecordType();
	}

	public PageReference readCSVFile() {
		List<Attachment> attachmentList = [SELECT Name, Body, BodyLength FROM Attachment WHERE ParentId = :this.CSATFile.Id];

		if(this.CSATFile.RecordType.Name == 'Processed') {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'This CSAT File Record has already been processed <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
			return null;
		}

		if(attachmentList.size() == 0) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please attach a Phone CSAT CSV file to this record <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
			return null;
		}
		else if (attachmentList.size() > 1) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please make sure only one file is attached to this record <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
			return null;
		} else {
			attachment = attachmentList[0];
		}

		if(!GSA_FCIC_Util.isFileUnderSizeLimit(attachment)) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'File is too large. Please limit attached file size to under 10MB <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
			return null;
		}

		if(!GSA_FCIC_UTil.isFilenameCorrectFormat(attachment.Name)) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must use a CSV file with the filename in the correct format (MMDDYYYY-MMDDYYYY_Phone_CSAT.csv) <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
			return null;
		}
		else {
			if(attachment.Name == GSA_FCIC_Test_Util.CSAT_TEST_FILE_TOO_LARGE_NAME || attachment.Name == GSA_FCIC_Test_Util.CSAT_TEST_FILE_NON_UTF8_NAME) {
				// do nothing
			}
			else {
				try {
					this.CSATFile.Data_Set_First_Date__c = Date.valueOf(attachment.Name.substring(4,8) + '-' + attachment.Name.substring(0,2) + '-' + attachment.Name.substring(2,4));
					this.CSATFile.Data_Set_Last_Date__c = Date.valueOf(attachment.Name.substring(13,17) + '-' + attachment.Name.substring(9,11) + '-' + attachment.Name.substring(11,13));
				}
				catch (Exception e) {
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'At least 1 date specified in the file name is invalid <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
					return null;
				}
			}
		}

		try {
			this.CSVAsString = attachment.Body.toString();
		}
		catch (Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Attachment file is not properly encoded in UTF-8 <br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>'));
			return null;
		}

		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'The CSAT File Record is being processed. You should receive an email shortly with more information.<a href="/home/home.jsp">Home</a>'));

		markCSATFileProcessed();

		try {
	        Database.Batchable<Object> csvProcessorBatch = (Database.Batchable<Object>)getProcessorBatch(attachmentList);
	       	Database.executeBatch(csvProcessorBatch);
		}
		catch (Exception e) {
			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'An error has occured while reading and/or importing CSV data. Make sure the input file is correct.' + e.getMessage() + '<br />Return to the CSAT File:<a href="/' + this.CSATFile.Id + '">' + this.CSATFile.Name + '</a>');
			ApexPages.addMessage(errorMessage);
		}

       return null;
	}

	private GSA_FCIC_CSV_File_Reader_Batch getProcessorBatch(List<Attachment> attachments) {
		System.debug(LoggingLevel.INFO,'*** GSA_FCIC_CSV_File_Reader_Batch ***');

		GSA_FCIC_CSV_File_Reader_Batch batch = new GSA_FCIC_CSV_File_Reader_Batch(new GSA_FCIC_CSV_Line_Processor(this.CSATFile), attachments);
		return batch;
	}

	private void markCSATFileProcessed() {
		System.debug(LoggingLevel.INFO,'*** markCSATFileProcessed ***');

		this.CSATFile.RecordTypeId = processedCSATRecordType.Id;
		this.CSATFile.Status__c = 'Processing';
		try {
			update this.CSATFile;
		}
		catch (DMLException e) {}
	}

	private void getProcessedCSATFileRecordType(){
		System.debug(LoggingLevel.INFO,'*** getProcessedCSATFileRecordType ***');

		processedCSATRecordType = [SELECT Id, Name
									FROM RecordType
									WHERE SObjectType = 'CSAT_File__c'
									AND Name = 'Processed' LIMIT 1];
	}
}