/****************************************************************
 Name: CBRCreditProfileProcessorMock
============================================================
Author: 
Purpose: Mock Class for CBRCreditProfileProcessor
============================================================

****************************************************************/

@isTest
public with sharing class CBRCreditProfileProcessorMock {
	public Integer sendCreditProfileRequestCallCount {get; private set;}

	public CBRCreditProfileProcessorMock() {
		sendCreditProfileRequestCallCount = 0;
	}

	public void sendCreditProfileRequest(Application__c application, Applicant__c primaryApplicant){
		sendCreditProfileRequestCallCount++;
	}
}