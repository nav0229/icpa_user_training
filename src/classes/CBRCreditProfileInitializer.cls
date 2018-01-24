/****************************************************************
 Name: CBRCreditProfileInitializer
============================================================
Author: Kevin
Purpose: JIRA#1336
	Queueable Class that accepts an Application Number and
	makes a Callout to Biztalk to get a CBR CreditProfile
============================================================

****************************************************************/
public class CBRCreditProfileInitializer implements Queueable, Database.AllowsCallouts {

	private static final String APPLICATION = 'Application__c';
	private static final String APPLICANT = 'Applicant__c';

	private String applicationNumber;

	private static ApplicantDAO applicantDA = new ApplicantDataAccessor();

	private ApplicationDAO applicationDA = new ApplicationDataAccessor();

	public CBRCreditProfileInitializer(String appNumber){
		this.applicationNumber = appNumber;
	}

	public void execute(QueueableContext context) {
		Application__c application = applicationDA.getApplicationByApplicationNumber(this.applicationNumber);
		Applicant__c primaryApplicant = applicantDA.getPrimaryApplicantAndRelatedContactByApplicationId(application.Id);

		if(application == null){
			throw new CBRCreditProfileInitializerException('Error: Unable to find Application with Application Number: '+this.applicationNumber);
		} else if(primaryApplicant == null) {
			throw new CBRCreditProfileInitializerException('Error: Unable to find Primary Applicant for Application Number: '+this.applicationNumber);
		}
		
		CBRCreditProfileProcessor creditProfileProcessor = new CBRCreditProfileProcessor();
		creditProfileProcessor.sendCreditProfileRequest(application, primaryApplicant);
	}

	public class CBRCreditProfileInitializerException extends Exception {}
}