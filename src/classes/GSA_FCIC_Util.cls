/******************************************************************************************
*
* Description: Provides regex, Exception, and other miscellaneous functions for the Phone
* CSAT portion of the Federal Citizen Information Center (FCIC) app.
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
* 0002		  | 6/3/2016	 | Christian Coleman, 				| Adjusted the create exception method.
* 			  |				 | (ccoleman@acumensolutions.com)	|
* -----------------------------------------------------------------------------------------
*
*******************************************************************************************/

public with sharing class GSA_FCIC_Util {
	private static final String REGEX_CSV_FILE_FORMAT = '([0-9]{8})(\\-)([0-9]{8})(_Phone_CSAT)(\\.)(csv)';
	private static final Integer CSV_FILE_SIZE_LIMIT_BYTES = 10485760;

	public static Boolean isFilenameCorrectFormat(String fileName) {
		if(fileName == GSA_FCIC_Test_Util.CSAT_TEST_FILE_TOO_LARGE_NAME || fileName == GSA_FCIC_Test_Util.CSAT_TEST_FILE_NON_UTF8_NAME) return true;
		return Pattern.compile(REGEX_CSV_FILE_FORMAT).matcher(fileName).matches();
	}

	public static Boolean isFileUnderSizeLimit(Attachment a) {
		return a.BodyLength < CSV_FILE_SIZE_LIMIT_BYTES;
	}

	public static Exception__c createException(String message, Id csatPhoneExceptionId) {
		Exception__c ex = new Exception__c();
		ex.Name = message.left(80);
		ex.RecordTypeId = csatPhoneExceptionId;
		ex.Description__c = message;
		return ex;
	}

	public static void createExceptions(List<String> messageList, Id csatPhoneExceptionId){
		List<Exception__c> exceptionList = new List<Exception__c>();
		for(String message : messageList){
			Exception__c ex = new Exception__c();
			ex.Name = message.left(80);
			ex.RecordTypeId = csatPhoneExceptionId;
			ex.Description__c = message;
			exceptionList.add(ex);
		}
		insert exceptionList;
	}

	public class emailUtil {

		private Id CSATfile;
		private Id recipient;
		private Id templateID;
		private Id oweaID;
		private Id csatPhoneExceptionId;

		private Messaging.SingleEmailMessage mail;

		public emailUtil(Id csatPhoneExceptionId) {
			this.csatPhoneExceptionId = csatPhoneExceptionId;
		}

		public emailUtil CSATfile(Id curID) {
			CSATfile = curID;
        	return this;
		}

		public emailUtil templateID(Id curID) {
			templateID = curID;
        	return this;
		}

		public emailUtil oweaID(Id curID) {
			oweaID = curID;
			return this;
		}

		public emailUtil recipient(Id curID) {
	    	User[] CSATOwnerUser = [select Id, Email from User where Id =: curID];
	    	String[] CSATOwnerUserAddress = new String[] {CSATOwnerUser.get(0).Email};
	    	Contact[] CSATOwnerContact = [select Id from Contact where Email =: CSATOwnerUserAddress[0]];

	    	recipient = CSATOwnerContact.get(0).Id;
	    	return this;
		}

		private emailUtil build() {
        	mail = new Messaging.SingleEmailMessage();
			mail.setTemplateId(this.templateID);
			mail.setWhatId(this.CSATfile);
			mail.setTargetObjectId(this.recipient);
			mail.setOrgWideEmailAddressId(this.oweaID);
			mail.setBccSender(false);
			mail.setUseSignature(false);
			mail.setSaveAsActivity(false);
			return this;
		}

		public List<Messaging.SendEmailResult> sendEmail() {
			List<Messaging.SendEmailResult> sendEmailResults = new List<Messaging.SendEmailResult>();

			try {
				build();
				sendEmailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }, false);

				System.debug(LoggingLevel.INFO,'sendEmail: sendEmailResults = ');
				System.debug(LoggingLevel.INFO,sendEmailResults);
			}
			catch(Exception e) {
				insert GSA_FCIC_Util.createException('Could not send confirmation email', csatPhoneExceptionId);
			}

			return sendEmailResults;
		}
	}

}