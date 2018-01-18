/*-------------------------------------------------------------------------------------------------*
  Contains constants for static values used for any functionality relating to Controlled Documents
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Stefan Maurer      10/14/2014    1.0       Created
 *-------------------------------------------------------------------------------------------------*/
 public class ControlledDocumentConstants {

	public static final String INITIATED_STATUS_STRING = 'Initiated';
	public static final String APPROVED_STATUS_STIRNG = 'Approved';
	public static final String APPROVED_WITH_COMMENTS_STATUS_STIRNG = 'Approved w Comments';
	public static final String NOT_INITIATED_STATUS_STRING = 'Not Initiated';
	public static final String EXTERNAL_REVIEW_AUTOFILL_VALUE = 'OMB';
	public static final String EXTERNAL_REVIEW_ROLE_NAME = 'External Review';
	public static final Map<String,String> REQUIRED_FIELD_API_TO_LABEL_MAP = new Map<String,String>{'Sequence__c'=>'Sequence', 'Assigned_Approver__c'=>'Assigned Approver', 'Role_of_Approver__c'=>'Role of Approver', 'Office__c'=>'Office', 'Due_Date__c'=>'Due Date'};
	//public static final String CHATTER_FILE_SHARE_ERROR_MESSAGE = 'You must Be Assigned As A Chatter Feed Document Collaborator To Create or Edit An Approval Step. Please Contact the Record Owner to Request Collaboration Access. They must add you to an Approval Step or as a Document Collaborator. Press Cancel if in Edit Mode.';
	public static final String CHATTER_FILE_SHARE_ERROR_MESSAGE = 'You cannot perform this action because you do not have proper permission to the related Chatter files. Press "Grant Access to Chatter Files" first.';
	public static final String OVERRIDE_EMAIL_SUBJECT = 'ExecSec Proxy request APPROVED for ';

}