/****************************************************************
 Name: CBRCreditProfileProcessorInterface
============================================================
Author: 
Purpose: Interface for CBRCreditProfileProcessor
============================================================

****************************************************************/

public interface CBRCreditProfileProcessorInterface {

	void sendCreditProfileRequest(Application__c application, Applicant__c primaryApplicant);
}