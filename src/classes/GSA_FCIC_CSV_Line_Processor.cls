/******************************************************************************************
*
* Description: Processes individual CSV file lines for the Phone CSAT portion of the
* Federal Citizen Information Center (FCIC) app.
*
*
* Modification Log:
* -----------------------------------------------------------------------------------------
* Mod Idea      | Date    		| Mod Author    					| Brief Mod Description
* -----------------------------------------------------------------------------------------
* 0001			| 7/6/2015  	| David Lombardo          			| Initial code creation.
*        		|            	| (dlombardo@acumensolutions.com),  |
*       		|            	| Paul Pick-Aluas          			|
*      			|            	| (ppickaluas@acumensolutions.com),	|
*        		|            	| Christian Coleman        			|
*        		|            	| (ccoleman@acumensolutions.com),  	|
* -----------------------------------------------------------------------------------------
* 0002			| 1/11/2016		| Christian Coleman 				| Tried my best
*				|				| (ccoleman@acumensolutions.com)	|
*
*******************************************************************************************/


public without sharing class GSA_FCIC_CSV_Line_Processor {

	private final String API_NAME_SURVEY_REPORT_CARD = 'Survey_Report_Cards__c';
	private final String API_NAME_STAGING_RECORD = 'Staging_Record__c';
	private final String API_NAME_AVAYA_UCID = 'Avaya_UCID__c';
	private final String HARDCODED_ORG_WIDE_EMAIL_ADDRESS = 'fcicsfsupport@gsa.gov';
	private final String HARDCODED_EMAILTEMPLATE_COLUMN_ERRORS_TEXT = 'CSAT_File_Column_Errors_Text';
	private final String HARDCODED_EMAILTEMPLATE_ROW_ERRORS_TEXT = 'CSAT_File_Row_Errors_Text';
	private final String HARDCODED_EMAILTEMPLATE_CONFIRMATION_TEXT = 'CSAT_File_Confirmation_Text';
	private final String EXCEPTION_INVALID_YEAR = 'Invalid year given';
	private final String EXCEPTION_DML_STAGING_RECORDS = 'DML exception - could not insert staging records';
	private final String ERROR_CODE_SUCCESS = 'success';
	private final String ERROR_CODE_UPDATE_FAILED = 'error_table_update_failed';
	private final String ERROR_CODE_NO_MAPPING = 'error_no_mapping';
	private final String ERROR_CODE_TOO_LARGE = 'error_too_large';
	private final String DYNAMIC_FIELD_TOO_LARGE = 'This field %1 exceeds the maximum allowable size of 5,000 characters\n';
	private final String DYNAMIC_NO_MAPPING_EXISTS = 'No mapping exists for this column heading: %1. Check the Field Mapping custom setting to either include this column or specify \'Ignore\' as the Data Type to prevent future errors.';
	private final String DYNAMIC_STAGING_RECORD_FAILURE = 'Cannot fill in Staging Record field --- Field: %1 | Value: %2 | Exception: %3';
	private final String DYNAMIC_NO_VALUE_MAPPING = 'No value mapping exists for %1 and input value \"%2\". Please either edit the CSV with an expected value or update the Value Mapping custom setting in order to process the CSAT file successfully.\n';
	private final String DYNAMIC_FIELD_NOT_MATCHED = 'Staging Record field %1 NOT FOUND - no match to Survey Report card object';
	private final String GENERIC_EMAIL_ERROR = 'Could not send confirmation email.';
	private final String COMMA_SEPARATION_ERROR = 'Error escaping commas in initial CSV.';
	private final String DATE_WRONG_FORMAT = 'Datetime is in an incorrect format. Examples of correct format: 1/1/2015 15:32 or 1/1/15 15:32\n';
	private final String MAPPING_TYPE_IGNORE = 'Ignore';

	private List<String> fieldList {get; set;}
	private Map<String, String> stagingFieldNameToColumnHeader = new Map<String, String>();
	private Map<SObjectField, SObjectField> stagingFieldToSurveyFieldNORMAL = new Map<SObjectField, SObjectField>();
	private Map<SObjectField, SObjectField> stagingFieldToSurveyFieldMULTISELECT = new Map<SObjectField, SObjectField>();
	private CSAT_File__c csatFileRecord;
	private String csvAsString;
	private RecordType columnErrorRecordType;
	private RecordType surveyReportCardRecordType;
	private Integer numCSVColumns;
	private Boolean columnErrors = false;
	private Boolean rowErrors = false;
	private String errorsFound = '';
	private List<String> csvFileLines;
	private List<Staging_Record__c> columnErrorsStagingRecords;
	private List<Staging_Record__c> stagingRecords;
	private List<Survey_Report_Cards__c> surveyRecords;
	private Set<String> ucids;
	private Map<String, Case> ucidsToCases;
	private Id csatPhoneExceptionId;

	public GSA_FCIC_CSV_Line_Processor(CSAT_File__c csatFileRecord) {
		this.csatFileRecord = csatFileRecord;
		this.stagingRecords = new List<Staging_Record__c>();
		this.surveyRecords = new List<Survey_Report_Cards__c>();
		this.columnErrorsStagingRecords = new List<Staging_Record__c>();
		this.fieldList = new List<String>();
		this.csvFileLines = new List<String>();
		this.ucids = new Set<String>();
		this.ucidsToCases = new Map<String, Case>();
		this.csatPhoneExceptionId = [
			select Id, Name
			from RecordType
			where SObjectType = 'Exception__c'
			and Name = 'CSAT Phone Upload'
			limit 1
		].Id;
		getColumnErrorRecordType();
		getSurveyReportCardRecordType();
	}

	public void processCSVLines(List<Attachment> attachments) {
		for(Attachment attachment : attachments) {
			this.csvAsString = attachment.Body.toString();
			this.csvFileLines = escapeCommasInCSV(csvAsString);
			// adds all of the column names / headings to a list
			for(String fieldName : this.csvFileLines[0].split(',')) {
				this.fieldList.add(fieldName);
			}
		}
	}

	public void createStagingRecords() {
		// also populates columnErrorsStagingRecords
		Map<Integer, String> columnNumberToStagingRecordField = getMapOfColumnNumberToStagingRecordField(this.fieldList);
		// inserts column errors no matter what - we want these column errors created even if the document doesn't process due to errors on the rows
		Database.insert(this.columnErrorsStagingRecords, false);
		makeStagingRecords(columnNumberToStagingRecordField);
		saveStagingRecords();
		mapUcidsToCases();
	}

	public void createSurveyRecords() {
		makeSurveyReportCards();
		saveSurveyRecords();
	}

	public void sendStatusEmail() {
		String errorTable = '';
		try {
			OrgWideEmailAddress[] owea = [SELECT Id
				FROM OrgWideEmailAddress
				WHERE Address = :HARDCODED_ORG_WIDE_EMAIL_ADDRESS];
			GSA_FCIC_Util.emailUtil emailUtil = new GSA_FCIC_Util.emailUtil(csatPhoneExceptionId);

			if (columnErrors) {
				// send column error email
				Staging_Record__c[] colErrors = [SELECT Id, Error__c, Column_Heading__c
					FROM Staging_Record__c
					WHERE (CSAT_File__c =: csatFileRecord.Id
						AND Column_Number__c != null
						AND Contains_Error__c = true)];
				for (Staging_Record__c ce : colErrors) {
					errorTable += '     Column "' + ce.Column_Heading__c + '": ' + ce.Error__c + '\n';
				}
				if (updateErrorTable(errorTable) == ERROR_CODE_SUCCESS) {
					EmailTemplate[] colErrorTemplate = [SELECT Id
						FROM EmailTemplate
						WHERE DeveloperName =: HARDCODED_EMAILTEMPLATE_COLUMN_ERRORS_TEXT];
					emailUtil.CSATfile(csatFileRecord.Id)
						.templateID(colErrorTemplate.get(0).Id)
						.recipient(UserInfo.getUserId())
						.oweaID(owea.get(0).Id)
						.sendEmail();
				}
			} else if (rowErrors) {
				// send row error email
				Staging_Record__c[] rowErrors = [SELECT Id, Error__c, Row_Number__c
					FROM Staging_Record__c
					WHERE (CSAT_File__c =: csatFileRecord.Id
						AND Column_Number__c = null
						AND Contains_Error__c = true)];
				for (Staging_Record__c re : rowErrors) {
					errorTable += '     Row ' + re.Row_Number__c + ': ' + re.Error__c + '\n';
				}

				if (updateErrorTable(errorTable) == ERROR_CODE_SUCCESS) {
					EmailTemplate[] rowErrorTemplate = [SELECT Id
						FROM EmailTemplate
						WHERE DeveloperName =: HARDCODED_EMAILTEMPLATE_ROW_ERRORS_TEXT];
					emailUtil.CSATfile(csatFileRecord.Id)
						.templateID(rowErrorTemplate.get(0).Id)
						.recipient(UserInfo.getUserId())
						.oweaID(owea.get(0).Id)
						.sendEmail();
				}

			} else {
				EmailTemplate[] successTemplate = [SELECT Id
					FROM EmailTemplate
					WHERE DeveloperName =: HARDCODED_EMAILTEMPLATE_CONFIRMATION_TEXT];
				emailUtil.CSATfile(csatFileRecord.Id)
					.templateID(successTemplate.get(0).Id)
					.recipient(UserInfo.getUserId())
					.oweaID(owea.get(0).Id)
					.sendEmail();
			}

		}
		catch(Exception e) {
			insert GSA_FCIC_Util.createException(GENERIC_EMAIL_ERROR, csatPhoneExceptionId);
		}
	}

	private List<String> escapeCommasInCSV(String csvAsStringIn) {
		// replace line feeds with carriage returns (to account for files from different operating systems)
		String csvCorrectedString1 = csvAsStringIn.replace('\n','\r');
		String csvCorrectedString2 = csvCorrectedString1.replace('\r\r','\r');
		String csvCorrectedStringFinal = csvCorrectedString2;
		try {
			csvCorrectedStringFinal = '';

			// ""  --> DBLQT
			// ,", --> $**$", --> %**%,
			// ",  --> #%%#
			// ",  --> #%%#

			// replace CSV-escaped commas with special string
			String csvCorrectedString3 = csvCorrectedString2.replace('""','DBLQT');
			String csvCorrectedString4 = csvCorrectedString3.replace(',",','$**$",');
			String csvCorrectedString5 = csvCorrectedString4.replace(',"','#%%##**#');
			String csvCorrectedString6 = csvCorrectedString5.replace('",','#%%#');
			String csvCorrectedString7 = csvCorrectedString6.replace('$**$','%**%,');
			List<String> commaEscapingList = csvCorrectedString7.split('#%%#');
			String csvCorrectedStringPreFinal = '';
			String beginEscape = '#**#';
			for(String commaEscapeString : commaEscapingList) {
				if (commaEscapeString.substring(0,4) == beginEscape) {
					String correctedEscapeString1 = commaEscapeString.replace(',','%**%');
					String correctedEscapeString2 = correctedEscapeString1.replace('#**#',',');
					String correctedEscapeString3 = correctedEscapeString2.remove('"');
					csvCorrectedStringPreFinal += correctedEscapeString3 + ',';
				} else {
					csvCorrectedStringPreFinal += commaEscapeString;
				}
			}

			csvCorrectedStringFinal = csvCorrectedStringPreFinal.replace('DBLQT','""');
		} catch (Exception e) {
			insert GSA_FCIC_Util.createException(COMMA_SEPARATION_ERROR, csatPhoneExceptionId);
		}
		List<String> csvStringList = csvCorrectedStringFinal.split('\r');
		return csvStringList;
	}

	private Map<Integer, String> getMapOfColumnNumberToStagingRecordField(List<String> fieldList){
		Map<String, Field_Mapping__c> columnHeaderToFieldMapping = new Map<String, Field_Mapping__c>();
		Map<Integer, String> columnNumberToStagingRecordField = new Map<Integer, String>();
		// gets custom settings values that map csv header to a salesforce field
		for(Field_Mapping__c mapping : Field_Mapping__c.getAll().values()){
			columnHeaderToFieldMapping.put(mapping.CSV_Input__c, mapping);
		}
		for(Integer column = 0; column < fieldList.size(); column++){
			String header = fieldList.get(column);
			Field_Mapping__c mapping = columnHeaderToFieldMapping.get(header);
			if(mapping == null || (mapping.Salesforce_Field__c == null && mapping.Data_Type__c != MAPPING_TYPE_IGNORE)){
				// Creating Column Error records here
				Staging_Record__c columnError = new Staging_Record__c();
				columnError.RecordTypeId = columnErrorRecordType.Id;
				columnError.Column_Heading__c = header;
				columnError.CSAT_File__c = csatFileRecord.Id;
				columnError.Column_Number__c = column + 1;
				columnError.Contains_Error__c = true;
				columnError.Error__c = buildString(DYNAMIC_NO_MAPPING_EXISTS, new List<String>{header});
				columnErrorsStagingRecords.add(columnError);
				columnErrors = true;
			} else if(mapping.Data_Type__c == MAPPING_TYPE_IGNORE) {
				// doing nothing
			} else {
				String salesforceField = mapping.Salesforce_Field__c;
				columnNumberToStagingRecordField.put(column, salesforceField);
				stagingFieldNameToColumnHeader.put(salesforceField, header);
			}
		}
		return columnNumberToStagingRecordField;
	}

	private void makeStagingRecords(Map<Integer, String> columnNumberToStagingRecordField){
		Integer csvFileLinesSize = this.csvFileLines.size();
		Integer rowNumber;
		for(rowNumber = 1; rowNumber < csvFileLinesSize; ++rowNumber) {
			Staging_Record__c stagingRecord = new Staging_Record__c() ;
			List<String> csvRecordData = this.csvFileLines[rowNumber].split(','); // a row of values in the csv
			while(csvRecordData.size() < this.numCSVColumns) {
				csvRecordData.add('');
			}
			for(Integer column : columnNumberToStagingRecordField.keySet()){
				String field = columnNumberToStagingRecordField.get(column);
				String originalValue;
				try {
					originalValue = csvRecordData[column];
				} catch (Exception e){
					continue;
				}
				String value = originalValue.replace('%**%',',');
				if(field == API_NAME_AVAYA_UCID && !ucids.contains(value)) {
					ucids.add(value);
				}
				value = verifySizeIsLessThan5000(value);
				if(value == ERROR_CODE_TOO_LARGE) {
					stagingRecord.Contains_Error__c = true;
					stagingRecord.Error__c += buildString(DYNAMIC_FIELD_TOO_LARGE, new List<String>{field});
					rowErrors = true;
				}
				try {
					stagingRecord.put(field, value); // fills Staging Record field in
				} catch (Exception e){
					insert GSA_FCIC_Util.createException(buildString(DYNAMIC_STAGING_RECORD_FAILURE, new List<String>{field, value, e.getMessage()}), csatPhoneExceptionId);
				}
			}
			stagingRecord.CSAT_File__c = csatFileRecord.Id;
			stagingRecord.Row_Number__c = rowNumber;
			stagingRecords.add(stagingRecord);
		}
	}

	private void saveStagingRecords() {
		try {
			insert stagingRecords;
		}
		catch(DmlException e) {
			insert GSA_FCIC_Util.createException(EXCEPTION_DML_STAGING_RECORDS, csatPhoneExceptionId);
		}
	}

	private void makeSurveyReportCards(){
		getStagingFieldsToSurveyFieldsMap();
		Map<String, List<Value_Mapping__c>> surveyFieldNameToValueMappingList = getSurveyFieldNameToValueMappingList();
		List<Survey_Report_Cards__c> curSRCwithUCID = [SELECT Id, Avaya_UCID__c
			FROM Survey_Report_Cards__c
			WHERE Avaya_UCID__c IN :this.ucids];
		Map<String, Survey_Report_Cards__c> ucidToExistingReportCardMap = new Map<String, Survey_Report_Cards__c>();
		if(curSRCwithUCID != null && curSRCwithUCID.size() > 0) {
			for(Survey_Report_Cards__c src : curSRCwithUCID) {
				ucidToExistingReportCardMap.put(src.Avaya_UCID__c, src);
			}
		}
		// make Survey Report Cards using the Staging Records we've already created
		List<String> errorsForExceptions = new List<String>();
		for(Staging_Record__c stagingRecord : stagingRecords){
			Survey_Report_Cards__c survey = new Survey_Report_Cards__c();
			stagingRecord.Error__c = ''; // allows for += later
			for(SObjectField stagingField : stagingFieldToSurveyFieldNORMAL.keySet()){
				// skip Id field otherwise you'd be assigning a staging record Id to a survey report card Id
				String stagingFieldName = stagingField.getDescribe().getName();
				if(stagingFieldName == 'Id') continue;
				boolean dateTimeIssue = false;
				try{
					SObjectField surveyField = stagingFieldToSurveyFieldNORMAL.get(stagingField);
					String surveyFieldName = surveyField.getDescribe().getName();
					if(stagingRecord.get(stagingField) != null){
						String valueInCell = (String) stagingRecord.get(stagingField);
						String mappedValue = getMappedValue(surveyField, valueInCell, surveyFieldNameToValueMappingList);
						String columnHeader = stagingFieldNameToColumnHeader.get(stagingFieldName);
						// errors caught here
						if(mappedValue == ERROR_CODE_NO_MAPPING) {
							stagingRecord.Error__c += buildString(DYNAMIC_NO_VALUE_MAPPING, new List<String>{columnHeader, valueInCell});
							stagingRecord.Contains_Error__c = true;
						}
						// if Datetime, convert to proper syntax for Salesforce, otherwise save String
						Schema.DisplayType fieldDataType = surveyField.getDescribe().getType();
						if (fieldDataType == Schema.DisplayType.DateTime) {
							dateTimeIssue = true;
							DateTime dateValue = getConvertedDatetime(mappedValue);
							dateTimeIssue = false;
							survey.put(surveyField, dateValue);
						}
						else {
							survey.put(surveyField, mappedValue);
						}
					}
				} catch(Exception e){
					stagingRecord.Contains_Error__c = true;
					if(dateTimeIssue){
						stagingRecord.Error__c += DATE_WRONG_FORMAT;
						errorsForExceptions.add(DATE_WRONG_FORMAT);
					}
					else {
						String fieldName = stagingField.getDescribe().getName();
						String error = buildString(DYNAMIC_FIELD_NOT_MATCHED, new List<String>{fieldName});
						stagingRecord.Error__c += error;
						errorsForExceptions.add(error);
					}
					rowErrors = true; // added 10/12 to ensure any exceptions caused by an invalid date will not create survey report cards
				}
			}

			for(SObjectField stagingField : stagingFieldToSurveyFieldMULTISELECT.keySet()){
				SObjectField surveyField = stagingFieldToSurveyFieldMULTISELECT.get(stagingField);
				String valueInCell = (String) stagingRecord.get(stagingField);
				String mappedValue = getMappedValue(surveyField, valueInCell, surveyFieldNameToValueMappingList);
				String stagingFieldName = stagingField.getDescribe().getName();
				String columnHeader = stagingFieldNameToColumnHeader.get(stagingFieldName);
				if(mappedValue == ERROR_CODE_NO_MAPPING) {
					stagingRecord.Error__c += buildString(DYNAMIC_NO_VALUE_MAPPING, new List<String>{columnHeader, valueInCell});
					stagingRecord.Contains_Error__c = true;
					rowErrors = true;
				} else if(mappedValue == ''){
					// do nothing - don't need to add anything
				} else {
					if(survey.get(surveyField) != null) {
						String existingString = (String) survey.get(surveyField);
						if(existingString.contains(mappedValue)) continue;
						survey.put(surveyField, existingString + ';' + mappedValue);
					} else {
						survey.put(surveyField, mappedValue);
					}
				}
			}
			try {
				if (ucidToExistingReportCardMap.get(stagingRecord.Avaya_UCID__c) != null) {
					stagingRecord.Error__c = 'A survey report card record already exists with UCID ' + survey.Avaya_UCID__c + '\n';
					stagingRecord.Contains_Error__c = true;
					rowErrors = true;
				}
				survey.Related_Case__c = this.ucidsToCases.get(survey.Avaya_UCID__c).Id;
			}
			catch(Exception e) {
				stagingRecord.Error__c = 'No case exists with UCID ' + survey.Avaya_UCID__c + '\n';
				stagingRecord.Contains_Error__c = true;
				rowErrors = true;
			}
			survey.Staging_Record__c = stagingRecord.Id;
			survey.RecordTypeId = surveyReportCardRecordType.Id;
			surveyRecords.add(survey);
		}
		GSA_FCIC_Util.createExceptions(errorsForExceptions, csatPhoneExceptionId);
	}

	private void saveSurveyRecords() {
		try {
			if((rowErrors || columnErrors) && !GSA_FCIC_Test_Util.isTest) {
				this.csatFileRecord.Status__c = 'Failed';
				update this.csatFileRecord;
				update this.stagingRecords;
				return; // not going to try an insert if there were row errors
			}

			Database.saveResult[] srList = Database.insert(surveyRecords, false);
			for (Database.saveResult sr : srList) {
				if (!sr.isSuccess()) {
					// Operation failed, so get all errors
					for(Database.Error err : sr.getErrors()) {
						System.debug(LoggingLevel.INFO,err.getStatusCode() + ': ' + err.getMessage());
						System.debug(LoggingLevel.INFO,'Fields that affected this error: ' + err.getFields());
						// copy error message to corresponding staging record
					}
				}
			}
			this.csatFileRecord.Status__c = 'Processed';
			update this.csatFileRecord;
		}
		catch(DmlException e) {
			insert GSA_FCIC_Util.createException(EXCEPTION_DML_STAGING_RECORDS, csatPhoneExceptionId);
		}
	}

	// creates two important maps to use for creating survey report cards later
	private void getStagingFieldsToSurveyFieldsMap(){
		Map<String, SObjectField> apiNameToSurveyReportCardField = Survey_Report_Cards__c.SObjectType.getDescribe().fields.getMap();
		Map<String, SObjectField> apiNameToStagingRecordField = Staging_Record__c.SObjectType.getDescribe().fields.getMap();

		for(SObjectField survey : apiNameToSurveyReportCardField.values()){
			String surveyAPIName = survey.getDescribe().getName();
			for(SObjectField staging : apiNameToStagingRecordField.values()){
				String stagingAPIName = staging.getDescribe().getName();
				String surveyNameTest = '1';
				String stagingNameTest = '2';
				try {
					surveyNameTest = surveyAPIName.substring(0,20);
					stagingNameTest = stagingAPIName.substring(0,20);
				} catch (Exception e) {
					// do nothing
				}
				// NORMAL 1:1 MAPPING
				// This is where the staging record API name matches the survey report card API name
				if(surveyAPIName == stagingAPIName){
					stagingFieldToSurveyFieldNORMAL.put(staging, survey);
				// IRREGULAR MAPPING 1:MANY MAPPING (Kinda)
				// This is where the staging record API name partially matches the name of a survey report card API name
				// Ex - staging record: This_is_an_example_with_1__c | survey report card: This_is_an_example__c
				} else if(surveyNameTest == stagingNameTest){
					stagingFieldToSurveyFieldMULTISELECT.put(staging, survey);
				}
			}
		}
	}

	private String getMappedValue(SObjectField surveyField, String valueInCell, Map<String, List<Value_Mapping__c>> surveyFieldNameToValueMappingList){
		String surveyFieldName = surveyField.getDescribe().getName();
		if(surveyFieldNameToValueMappingList.get(surveyFieldName) != null){
			if(valueInCell == null || valueInCell == '') return ''; // case where value in cell is empty - we don't want to throw an error
			for(Value_Mapping__c value : surveyFieldNameToValueMappingList.get(surveyFieldName)){
				if(value.CSV_Input__c == valueInCell) {
					return value.Salesforce_Value__c;
				}
			}
			rowErrors = true;
			return ERROR_CODE_NO_MAPPING;
		}

		return valueInCell;
	}

	private Map<String, List<Value_Mapping__c>> getSurveyFieldNameToValueMappingList(){
		Map<String, List<Value_Mapping__c>> surveyFieldNameToValueMappingList = new Map<String, List<Value_Mapping__c>>();

		for(Value_Mapping__c value : Value_Mapping__c.getAll().values()){
			String surveyField = value.Field_Mapping__c;
			if(surveyFieldNameToValueMappingList.get(surveyField) == null){
				List<Value_Mapping__c> vList = new List<Value_Mapping__c>();
				vList.add(value);
				surveyFieldNameToValueMappingList.put(surveyField, vList);
			} else {
				surveyFieldNameToValueMappingList.get(surveyField).add(value);
			}

		}

		return surveyFieldNameToValueMappingList;
	}

	private String updateErrorTable(String errorTable) {
		try {
			if (errorTable != '' && errorTable != null) {
				this.csatFileRecord.Error_Table__c = errorTable;
				update this.csatFileRecord;
			}
			return ERROR_CODE_SUCCESS;
		}
		catch(Exception e) {
			insert GSA_FCIC_Util.createException('Could not update error table', csatPhoneExceptionId);
			return ERROR_CODE_UPDATE_FAILED;
		}
	}

	private DateTime getConvertedDatetime(String inputDatetime) {
		// receives input in the form of 4/30/15 10:49
		// outputs in the form of 2015-04-30 10:49:00
		if (inputDatetime != null) {
			List<String> inputDatetimeParts = inputDatetime.split(' ');
			String inputDate = inputDatetimeParts[0];
			String inputTime = inputDatetimeParts[1];

			List<String> inputDateParts = inputDate.split('/');
			List<String> inputTimeParts = inputTime.split(':');

			String inputYear = inputDateParts[2];
			if (inputYear.length() == 2) {
				inputYear = '20' + inputYear; // this gon' break in the year 3000
			} else if (inputYear.length() == 4){
				// do nothing; look awesome
			} else {
				throw new GSA_FCIC_Exception(EXCEPTION_INVALID_YEAR);
			}

			String newDatetimeString = inputYear + '-' + inputDateParts[0] + '-' + inputDateParts[1] + ' ' + inputTimeParts[0] + ':' + inputTimeParts[1] + ':' + '00';

			DateTime ConvertedDatetime = DateTime.valueOf(newDatetimeString);

			return ConvertedDatetime;
		}
		else {
			DateTime todaysDate = DateTime.now();
			return todaysDate;
		}
	}

	private void mapUcidsToCases() {
		List<Case> cases = [SELECT Id, Avaya_UCID__c
						FROM Case
						WHERE Avaya_UCID__c IN :this.ucids];

		if(cases.size() == 0) {
			insert GSA_FCIC_Util.createException('No related cases found', csatPhoneExceptionId);
		}

		for(Case c : cases) {
			this.ucidsToCases.put(c.Avaya_UCID__c, c);
		}
	}

	private String verifySizeIsLessThan5000(String s){
		if(s != null){
			if(s.length() > 5000){
				return ERROR_CODE_TOO_LARGE;
			} else {
				return s;
			}
		} else {
			return '';
		}
	}

	private void getColumnErrorRecordType(){
		columnErrorRecordType = [SELECT Id, Name
									FROM RecordType
									WHERE SObjectType = :API_NAME_STAGING_RECORD
									AND Name = 'Column Errors' LIMIT 1];
	}

	private void getSurveyReportCardRecordType(){
		surveyReportCardRecordType = [SELECT Id, Name
									FROM RecordType
									WHERE SObjectType = :API_NAME_SURVEY_REPORT_CARD
									AND Name = 'Phone Survey Report Card' LIMIT 1];
	}

	private String buildString(String template, List<String> substitutionList){
		for(Integer i = 0; i < substitutionList.size(); i++){
			Integer pos = i + 1;
			template = template.replace('%' + pos, substitutionList.get(i));
		}
		return template;
	}

}