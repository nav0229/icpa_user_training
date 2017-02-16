public class GSA_FCIC_KBArticles_Exception extends GSA_FCIC_Exception {



	//private string errorMessage;
   // private Exception exeption;
   // private static final String EXCP_RECORD_TYPE_NAME = 'KB Sync Failure';
   // List<Exception__c> excepRecord = new List<Exception__c>();
	//public override void createExceptionRecord() {
	public void createExceptionRecord(String str1, String str2) {
		Exception__c exceptionRecord = new Exception__c();
		this.exType = ExceptionType.KBSYNC;
		KBSyncSettings__c settings = KBSyncSettings__c.getValues('SyncSettings');
		if(settings.Create_Exception_Record__c) {
			setExceptionFields(exceptionRecord, settings.Email_Exception__c);
			exceptionRecord.Description__c = exceptionRecord.Description__c + str1 + str2;
			List<Exception__c> excepRecord = new List<Exception__c>();
			excepRecord.add(exceptionRecord);
			insertExceptionRecord(excepRecord);
		}

	}

	protected override void setExceptionFields(Exception__c exceptionRecord, Boolean emailExceptions) { 
		super.setExceptionFields(exceptionRecord, emailExceptions);
		exceptionRecord.Name = 'KB Sync Error '+Datetime.now().format();
		/*
		exceptionRecord.Description__c = this.getMessage();
		system.debug('$$$$$$$$$$'+exceptionRecord.Description__c);
		if(exceptionRecord.Description__c.contains('DNIS')){
			exceptionRecord.Exception_Type__c = 'CTI_Case_Creation';
			exceptionRecord.Stack_Trace__c = this.getStackTraceString();
			exceptionRecord.Line_Number__c = this.getLineNumber();
			exceptionRecord.Email_Exception__c = true;
			exceptionRecord.RecordTypeID = getExceptionRecordTypeId();
			exceptionRecord.Name = 'CTI Error '+Datetime.now().format();
		
		}else{
		exceptionRecord.Stack_Trace__c = this.getStackTraceString();
		exceptionRecord.Exception_Type__c =  this.getTypeName();
		exceptionRecord.Line_Number__c = this.getLineNumber();
		exceptionRecord.Email_Exception__c = emailExceptions;
		exceptionRecord.RecordTypeID = getExceptionRecordTypeId();
		exceptionRecord.Name = 'KB Sync Error '+Datetime.now().format();
		} 
		excepRecord.add(exceptionRecord);*/
		
	}


}