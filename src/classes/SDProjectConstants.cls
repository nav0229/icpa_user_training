public with sharing class SDProjectConstants {

	// used to add random characters to the front of a document name
	public static final String ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

	// BusinessHours details - used to add 45 work days to a field
	public static final String 	BUSINESSHOURS_NAME = 'S&D Business Hours';
	public static final Integer NUM_DAYS_PAST_COMPLETION = 45;
	public static final Integer START_TIME_HOUR = 7;
	public static final Long 	NUM_MILLISECONDS_IN_S_AND_D_BUSINESS_DAY = 11 * 60 * 60 * 1000; // hr * min * sec * mil --- as of 5/3/2017 they work 7:00 AM to 6:00 PM so: 11 hour business days
	public static final Long 	NUM_MILLISECONDS_PAST_COMPLETION = NUM_DAYS_PAST_COMPLETION * NUM_MILLISECONDS_IN_S_AND_D_BUSINESS_DAY;

	// object api names - used as conditionals in document upload vforce page
	public static final String OBJECTAPINAME_SUSPENSION_AND_DEBARMENT_RECORD = 'Suspension_and_Debarment_Case__c';
	public static final String OBJECTAPINAME_AGENCY_PROTEST_CASE = 'Agency_Protest_Case__c';

	// the different pages that the document upload controller handles
	public static final String SUSPENSION_AND_DEBARMENT_CASE_VF_PAGE = '/apex/SD_DocumentUpload_SuspAndDebarRecord?id=';
	public static final String AGENCY_PROTEST_VF_PAGE = '/apex/SD_DocumentUpload_AgencyProtestCase?id=';

	// profile related - though most things are handled via the permission sets and public groups
	public static final String 	GSA_ADMIN_PROFILE_NAME = 'GSA System Administrator';

	// public groups
	public static final String PUBGROUP_AGENCY_PROTEST_LEGAL_USERS = 'Suspension_Debarment_AP_Legal';
	public static final String PUBGROUP_SUSPENSION_AND_DEBARMENT_LEGAL_USERS = 'Suspension_Debarment_SD_Legal';

	// all permission sets dealing with the SD app
	public static final String 	PSET_LEGAL_USER_AGENCY_PROTEST = 'Suspension_Debarment_AP_Approval_User_RE';
	public static final String 	PSET_LEGAL_USER_SUSPENSION_DEBARMENT = 'Suspension_Debarment_SD_Approval_User_RE';
	public static final String 	PSET_INTEGRITY_OFFICER = 'Suspension_Debarment_User_CRE';
	public static final String 	PSET_SUPER_USER = 'Suspension_Debarment_Super_User_CRED';

	// suspension and debarment record types
	public static final String RECORDTYPENAME_SUSPENSIONDEBARMENTCASE = 'Suspension and Debarment Case';
	public static final String RECORDTYPENAME_SUSPENSIONDEBARMENTRESPONDENT = 'Suspension and Debarment Respondent';
	public static final String RECORDTYPEID_SUSPENSIONDEBARMENTCASE = Schema.SObjectType.Suspension_and_Debarment_Case__c.RecordTypeInfosByName.get(RECORDTYPENAME_SUSPENSIONDEBARMENTCASE).RecordTypeId;
	public static final String RECORDTYPEID_SUSPENSIONDEBARMENTRESPONDENT = Schema.SObjectType.Suspension_and_Debarment_Case__c.RecordTypeInfosByName.get(RECORDTYPENAME_SUSPENSIONDEBARMENTRESPONDENT).RecordTypeId;

	// document upload record types
	public static final String 	RECORDTYPENAME_SDDOCUMENTUPLOAD_SD = 'Suspension and Debarment';
	public static final String 	RECORDTYPENAME_SDDOCUMENTUPLOAD_AP = 'Agency Protest';
	public static final Id 		RECORDTYPEID_SDDOCUMENTUPLOAD_SD = Schema.SObjectType.SD_Document_Upload__c.RecordTypeInfosByName.get(RECORDTYPENAME_SDDOCUMENTUPLOAD_SD).RecordTypeId;
	public static final Id 		RECORDTYPEID_SDDOCUMENTUPLOAD_AP = Schema.SObjectType.SD_Document_Upload__c.RecordTypeInfosByName.get(RECORDTYPENAME_SDDOCUMENTUPLOAD_AP).RecordTypeId;

	// error messages
	public static final String ERROR_MSG_VFORCE_NOT_ALLOWED_TO_DELETE_THIS_DOCUMENT = 'You do not have permission to delete this document.';
	public static final String ERROR_MSG_VFORCE_DOCUMENT_NOT_SELECTED = 'You have not selected a document to delete.';
	public static final String ERROR_MSG_VFORCE_UNABLE_TO_EDIT_DOCUMENTS_WHEN_RECORD_IS_CLOSED = 'You are not allowed to edit documents when the parent case is closed.';
	public static final String ERROR_MSG_TRIGGER_CAN_NOT_INSERT_UNLESS_IN_VFORCEPAGE = 'You can only insert SD Document Upload records via the Visualforce page on the associated record';
	public static final String ERROR_MSG_TRIGGER_CAN_NOT_DELETE_UNLESS_IN_VFORCEPAGE = 'You can only delete SD Document Upload records via the Visualforce page on the associated record';
	public static final String ERROR_MSG_TRIGGER_FIELDS_REQUIRED_WHEN_GSA = 'Whenever the parent case has GSA as their lead agency the following fields are required: Basis, Business/Individual, and Direct/Imputed/Affiliated';
	public static final String ERROR_MSG_OWNER_CHANGE_WITHOUT_PERMISSION = 'You do not have the appropriate permissions to change the owner of this record.';
	public static final String ERROR_MSG_CHATTER_FEED_ITEM_UPLOAD = 'Please upload documents via the Documents section.';
}