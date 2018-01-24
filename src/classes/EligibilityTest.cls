/****************************************************************
 Name:  EligibilityTest
============================================================
Author: Matt
Purpose: JIRA#2186 (1464, 1465, 1466)
Class that is invoked to run Eligibility Tests
============================================================

****************************************************************/

public with sharing class EligibilityTest {
	@TestVisible public static ProcessingApplicationReviewDAO parDa = new ProcessingApplicationReviewDataAccessor();
	@TestVisible public static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible public static GroupDAO groupDA = new GroupDataAccessor();
	@TestVisible private static MapCreator mapCreatorTool = new MapCreator();

	private MiscellaneousExceptions miscellaneousExceptionsTest = new MiscellaneousExceptions();
	private ApplicantsEligibility applicantsEligibilityTest = new ApplicantsEligibility();
	private PropertyEligibility propertyEligibilityTest = new PropertyEligibility();

	private static final String LOAN_OFFICER_QUEUE = 'Loan_Officer_Queue';
	private static final String TEAM_LEAD_QUEUE =  'Team_Lead_Queue';
	private static final String HOME =  'Home';

	public EligibilityTest() {}
	
	public void runEligibilityTests(List<Id> applicationIds) {
		List<Processing_Application_Review__c> pars = getPARsFromDatabase(applicationIds);
		Map<Id, Application__c> parIdApplicationMap = mapCreatorTool.createPARIdApplicationMap(pars);
		Map<Id, List<IRS_Transcripts__c>> parIdIrsTranscriptsMap = mapCreatorTool.createPARIdIRSTranscriptMap(pars);
		Map<Id, List<Applicant__c>> parIdApplicantsMap = mapCreatorTool.createPARIdApplicantMap(pars);
		Map<Id, List<Property__c>> parIdDamagedPropertyMap = mapCreatorTool.createPARIdDamagedPropertyMap(pars);
		Map<Id, List<Other_Assistance__c>> parIdOtherAssistanceMap = mapCreatorTool.createPARIdOtherAssistanceMap(pars);
		Map<Id, List<Loss_Verification_Inspections__c>> parIdLossVerifications = mapCreatorTool.createPARIdLossVerificationMap(pars);
		Map<Id, List<Credit_Bureau__c>> parIdCreditBureauMap = mapCreatorTool.createPARIdCreditBureauMap(pars);
		Map<Id, List<Mortgage__c>> parIdMortgageMap = mapCreatorTool.createPARIdMortgagesMap(pars);

		for(Processing_Application_Review__c par : pars) {
			if(parIdApplicationMap.get(par.Id).Loan_Type__c == HOME) {
				par.Eligibility_Test_Result_Date__c = System.now();

				par = miscellaneousExceptionsTest.runMiscellaneousTest(par, parIdApplicationMap.get(par.Id), parIdIrsTranscriptsMap.get(par.Id), parIdOtherAssistanceMap.get(par.Id), parIdApplicantsMap.get(par.Id), parIdMortgageMap.get(par.Id));
				par = applicantsEligibilityTest.runApplicantTest(par, parIdApplicantsMap.get(par.Id));
				par = propertyEligibilityTest.runPropertyTest(par, parIdDamagedPropertyMap.get(par.Id), parIdIrsTranscriptsMap.get(par.Id), parIdCreditBureauMap.get(par.Id), parIdLossVerifications.get(par.Id),parIdOtherAssistanceMap.get(par.Id));
			}

			par = assignElibilityTestResult(par);
		}
		
		List<Application__c> applications = assignToAppropiateQueue(pars, parIdApplicationMap);

		updatePARsAndApplications(pars, applications);
	}

	private Processing_Application_Review__c assignElibilityTestResult(Processing_Application_Review__c par) {
		if(isEligibilityTestFailing(par)) {

			par.Eligibility_Test_Result__c = 'Fail';

		}else if(isEligibilityTestPassing(par)) {

			par.Eligibility_Test_Result__c = 'Pass';

		}else if(isEligibilityTestMitigated(par)) {

			par.Eligibility_Test_Result__c = 'Mitigated';
		}

		return par;
	}

	private List<Application__c> assignToAppropiateQueue(List<Processing_Application_Review__c> pars, Map<Id, Application__c> parIdapplicationMap) {
		Group loanOfficerQueue = new Group();
		Group teamLeadQueue = new Group();

		try {
			loanOfficerQueue = groupDA.getGroupByDeveloperNameAndType(LOAN_OFFICER_QUEUE, 'Queue');
			teamLeadQueue = groupDA.getGroupByDeveloperNameAndType(TEAM_LEAD_QUEUE, 'Queue');
		}catch(QueryException e) {
			System.debug(e.getMessage());
			throw new EligibilityTestException('An error occurred while retrieving Team Lead Queue or Loan Officer Queue: ', e); 
		}

		for(Processing_Application_Review__c par : pars) {
			System.debug('Miscellaneous_Exceptions_Test__c' + par.Miscellaneous_Exceptions_Test__c );
			System.debug('Applicant_Eligibility_Test__c' + par.Applicant_Eligibility_Test__c );
			System.debug('Property_Eligibility_Test__c' + par.Property_Eligibility_Test__c );

			System.debug('Eligibility_Test_Result__c' + par.Eligibility_Test_Result__c );

			if(	isEligibilityTestPassing(par)) {
				System.debug('setting team lead Queue');
				parIdapplicationMap.get(par.Id).OwnerId = teamLeadQueue.Id;
			}else {
				System.debug('setting loan officer Queue');
				parIdapplicationMap.get(par.Id).OwnerId = loanOfficerQueue.Id;
			}
		}

		return parIdApplicationMap.values();
	}
	
	private List<Processing_Application_Review__c> getPARsFromDatabase(List<Id> applicationIds){
		try {
			return parDA.getProcessingApplicationReviewsByAppIds(applicationIds);
		}catch(QueryException e) {
			System.debug(e.getMessage());
			throw new EligibilityTestException('Error retrieving Processing Application Reviews with Application Ids : ', e);
		}
	}
	
	private void updatePARsAndApplications(List<Processing_Application_Review__c> pars, List<Application__c> applications) {
		try {
			parDa.updateProcessingApplicationReviews(pars);
			applicationDA.updateApplications(applications);
		}catch(DmlException e) {
			System.debug(e.getMessage());
			throw new EligibilityTestException('Error updating Processing Application Reviews and Applications: ', e);
		}
	}

	private Boolean isEligibilityTestFailing(Processing_Application_Review__c par) {
		return (par.Condo_HOA_fee_not_listed_on_Application__c == 'Fail' ||
				par.Grants_not_listed_on_application__c == 'Fail' ||
				par.IRS_Transcript_s_Received__c == 'Fail' ||
				par.Not_an_SBA_Employee__c == 'Fail' ||
				par.U_S_Citizen__c == 'Fail' ||
				par.No_Character_Issues__c == 'Fail' ||
				par.Damaged_Property_Owned_by_Applicants__c == 'Fail' ||
				par.Primary_Residence__c == 'Fail' ||
				par.Damaged_Address_IRS_CBR_Match__c == 'Fail' ||
				par.NEMIS_Primary__c == 'Fail' ||
				par.Property_NIFRA_Compliant__c == 'Fail' ||
				par.Sanctioned_Community__c == 'Fail' ||
				par.CBRA_or_OPA__c == 'Fail' ||
				par.Damaged_Property_Type_Eligibility__c == 'Fail');
	}

	private Boolean isEligibilityTestPassing(Processing_Application_Review__c par) {
		return (par.Condo_HOA_fee_not_listed_on_Application__c == 'Pass' &&
				par.Grants_not_listed_on_application__c == 'Pass' &&
				par.IRS_Transcript_s_Received__c == 'Pass' &&
				par.Not_an_SBA_Employee__c == 'Pass' &&
				par.U_S_Citizen__c == 'Pass' &&
				par.No_Character_Issues__c == 'Pass' &&
				par.Damaged_Property_Owned_by_Applicants__c == 'Pass' &&
				par.Primary_Residence__c == 'Pass' &&
				par.Damaged_Address_IRS_CBR_Match__c == 'Pass' &&
				par.NEMIS_Primary__c == 'Pass' &&
				par.Property_NIFRA_Compliant__c == 'Pass' &&
				par.Sanctioned_Community__c == 'Pass' &&
				par.CBRA_or_OPA__c == 'Pass' &&
				par.Damaged_Property_Type_Eligibility__c == 'Pass');
	}

	private Boolean isEligibilityTestMitigated(Processing_Application_Review__c par) {
		return(	(par.Condo_HOA_fee_not_listed_on_Application__c == 'Pass' || par.Condo_HOA_fee_not_listed_on_Application__c == 'Mitigated') &&
				(par.Grants_not_listed_on_application__c == 'Pass' || par.Grants_not_listed_on_application__c == 'Mitigated') &&
				(par.IRS_Transcript_s_Received__c == 'Pass' || par.IRS_Transcript_s_Received__c == 'Mitigated') &&
				(par.Not_an_SBA_Employee__c == 'Pass' || par.Not_an_SBA_Employee__c == 'Mitigated') &&
				(par.U_S_Citizen__c == 'Pass' || par.U_S_Citizen__c == 'Mitigated') &&
				(par.No_Character_Issues__c == 'Pass' || par.No_Character_Issues__c == 'Mitigated') &&
				(par.Damaged_Property_Owned_by_Applicants__c == 'Pass' || par.Damaged_Property_Owned_by_Applicants__c == 'Mitigated') &&
				(par.Primary_Residence__c == 'Pass' || par.Primary_Residence__c == 'Mitigated') &&
				(par.Damaged_Address_IRS_CBR_Match__c == 'Pass' || par.Damaged_Address_IRS_CBR_Match__c == 'Mitigated') &&
				(par.NEMIS_Primary__c == 'Pass' || par.NEMIS_Primary__c == 'Mitigated') &&
				(par.Property_NIFRA_Compliant__c == 'Pass' || par.Property_NIFRA_Compliant__c == 'Mitigated') &&
				(par.Sanctioned_Community__c == 'Pass' || par.Sanctioned_Community__c == 'Mitigated') &&
				(par.CBRA_or_OPA__c == 'Pass' || par.CBRA_or_OPA__c == 'Mitigated') &&
				(par.Damaged_Property_Type_Eligibility__c == 'Pass' || par.Damaged_Property_Type_Eligibility__c == 'Mitigated'));
	}

	public class EligibilityTestException extends Exception {}
}