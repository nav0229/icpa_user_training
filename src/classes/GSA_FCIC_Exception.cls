public virtual class GSA_FCIC_Exception extends Exception {
	public enum ExceptionType {
		GENERAL,
		KBSYNC,
		CTI
	}	

	public ExceptionType exType;
	private string errorMessage;
    private Exception exeption;

    public virtual void createExceptionRecord(){createExceptionRecord(false, false);}

	public virtual void createExceptionRecord(Boolean logOnly, Boolean emailExceptions) {
		exType = ExceptionType.GENERAL;
		Exception__c exceptionRecord = new Exception__c();
		setExceptionFields(exceptionRecord, emailExceptions);
		if(!logOnly) {
            List<Exception__c> excepRecord = new List<Exception__c>();
            excepRecord.add(exceptionRecord);
			insertExceptionRecord(excepRecord);
		} else {
			outputErrorToLog(exceptionRecord);
		}


	}
	
	protected virtual void setExceptionFields(Exception__c exceptionRecord, Boolean emailExceptions) {
        exceptionRecord.Description__c = this.getMessage();
        exceptionRecord.Stack_Trace__c = this.getStackTraceString();
        exceptionRecord.Line_Number__c = this.getLineNumber();
        exceptionRecord.RecordTypeID = getExceptionRecordTypeId();
        exceptionRecord.Exception_Type__c = this.getTypeName();
        exceptionRecord.Email_Exception__c = emailExceptions;
        exceptionRecord.Name = 'General Exception '+Datetime.now().format();      
    }

    protected void outputErrorToLog(Exception__c exceptionRecord) {
    	System.debug('*******Exception Thrown********');
    	system.debug('Description: '+exceptionRecord.Description__c);
    	system.debug('Stack Trade: '+exceptionRecord.Stack_Trace__c);
    	system.debug('Line Number: '+exceptionRecord.Line_Number__c);
    	system.debug('ExceptionType: '+exceptionRecord.Exception_Type__c);
    	system.debug('Exception Name: '+exceptionRecord.Name);
    	System.debug('*******************************');
    }

    protected void insertExceptionRecord(List<Exception__c> exceptionRecord) {
    	
        try {
            insert exceptionRecord;
        } catch(DmlException e) {
            system.debug('Exception: ' + e.getMessage());
        }
    }

    protected Id getExceptionRecordTypeId() {
    	Schema.RecordTypeInfo rti = Schema.SObjectType.Exception__c.getRecordTypeInfosByName().get(getRecordTypeName());
    	if(rti != null) {
          return rti.getRecordTypeId();
    	} else {
    		return null;
    	}
    }

    protected String getRecordTypeName() {
    	if(exType == ExceptionType.KBSYNC) {
    		return 'KB Sync Failure';
    	} else {
    		return 'General Exception';
    	}
    }
}