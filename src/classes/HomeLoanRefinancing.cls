/****************************************************************
 Name:  HomeLoanRefinancing
============================================================
Author: Matt
Purpose: JIRA#1340
Handles everything involved in the home loan refinancing test
============================================================

****************************************************************/

public with sharing class HomeLoanRefinancing {
	public HomeLoanRefinancing() {}

	@TestVisible public static ProcessingApplicationReviewDAO parDa = new ProcessingApplicationReviewDataAccessor();

	@TestVisible public static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	@TestVisible public static InsuranceDAO insuranceDA = new InsuranceDataAccessor();

	@TestVisible private static MapCreator MapCreatorTool = new MapCreator();

	@TestVisible private static GroupDAO groupDA = new GroupDataAccessor();

	public void runHomeLoanRefinancingTest(List<Id> applicationIds) {	
		Group loanOfficerQueue = getLoanOfficerGroup();
		List<Processing_Application_Review__c> pars = getPARFromApplicationIds(applicationIds);
		Map<Id, Application__c> parIdApplicationMap = MapCreatorTool.createPARIdApplicationMap(pars);
		Map<Id, List<Loss_Verification_Inspections__c>> parIdLossVerifications = MapCreatorTool.createPARIdLossVerificationMap(pars);
		Map<Id, List<Insurance__c>> parIdInsurancesMap = MapCreatorTool.createPARIdInsuranceMap(pars);
		Map<Id, List<Mortgage__c>> parIdMortgagesMap = MapCreatorTool.createPARIdMortgagesMap(pars);
		List<Insurance__c> insurances;
		List<Insurance__c> insurancesToUpdate = new List<Insurance__c>();


		for(Processing_Application_Review__c par : pars) {
			if(parIdApplicationMap.get(par.Id).Loan_Type__c == 'Home') {

				parIdApplicationMap.get(par.Id).Percent_of_damage_as_per_Rule_of_40__c = calculatePercentOfDamageRuleOf40(parIdLossVerifications.get(par.Id), par);
				parIdApplicationMap.get(par.Id).Percent_of_damage_as_per_Rule_of_50__c = calculatePercentOfDamageRuleOf50(parIdLossVerifications.get(par.Id), par);

				parIdApplicationMap.get(par.Id).Property_damaged_as_per_Rule_of_40__c = isPropertyDamagedAsPer40Rule(parIdApplicationMap.get(par.Id));
				parIdApplicationMap.get(par.Id).Property_damaged_as_per_Rule_of_50__c = isPropertyDamagedAsPer50Rule(parIdApplicationMap.get(par.Id));

				parIdApplicationMap.get(par.Id).Is_Property_Damaged_As_Per_40_50_Rule__c = isPropertyDamagedAsPer40or50Rule(parIdApplicationMap.get(par.Id));
				parIdApplicationMap.get(par.Id).Applicant_does_not_have_credit_elsewhere__c = checkApplicantDoesNotHaveCreditElsewhere(parIdApplicationMap.get(par.Id), par);

				parIdApplicationMap.get(par.Id).Maximum_Refinance_Eligibility__c = setMaxRefinanceEligibility(par);
				parIdApplicationMap.get(par.Id).Refinance_Amount__c = setRefinanceAmount(parIdMortgagesMap.get(par.Id), parIdApplicationMap.get(par.Id), par);

				parIdApplicationMap.get(par.Id).Is_Property_Eligible_for_Refinancing__c = isPropertyEligibleForRefinancing(parIdApplicationMap.get(par.Id), parIdMortgagesMap.get(par.Id), parIdInsurancesMap.get(par.Id));

				par.Refinancing_Test_Results__c = getRefinancingTestResult(parIdApplicationMap.get(par.Id));
				par.Refinancing_Test_Result_Date__c = System.now();

				if(parIdApplicationMap.get(par.Id).Is_Property_Eligible_for_Refinancing__c == 'Yes') {
					parIdApplicationMap.get(par.Id).OwnerId = loanOfficerQueue.Id;
				}
			}
		}

		updatePARsAndApplications(pars, parIdApplicationMap.values());
	}


	private Group getLoanOfficerGroup() {
		Group loanOfficer = new Group();

		try {
			loanOfficer = groupDA.getGroupByDeveloperNameAndType('Loan_Officer_Queue','Queue');
		}catch(QueryException e) {
			System.debug(e);
			throw new HomeLoanRefinancingException('An error occurred while retrieving Loan officer queue: ', e); 
		}
		
		return loanOfficer;
	}
	
	private List<Processing_Application_Review__c> getPARFromApplicationIds(List<Id> applicationIds) {
		List<Processing_Application_Review__c> pars;

		try{
			pars = parDa.getProcessingApplicationReviewsByAppIds(applicationIds);
		}catch(QueryException e) {
			System.debug(e);
			throw new HomeLoanRefinancingException('An error occurred while retrieving PAR records: ', e); 
		}

		return pars;
	}

	private void updatePARsAndApplications(List<Processing_Application_Review__c> pars, List<Application__c> applications) {
		try {
			parDa.updateProcessingApplicationReviews(pars);
			applicationDA.updateApplications(applications);
		}catch(DmlException e) {
			System.debug(e);
			throw new HomeLoanRefinancingException('An error occurred when updating PARs and Applications: ', e); 
		}
	}
	
	private String isPropertyEligibleForRefinancing(Application__c application, List<Mortgage__c> mortgages, List<Insurance__c> insurances) {

		if( application.Is_Property_Damaged_as_per_40_50_Rule__c == 'Yes' &&
			application.Applicant_does_not_have_credit_elsewhere__c == 'Yes' && 
			isInsuranceRecoveryForRealEstateFinalYes(insurances) == 'Yes' &&
			getAllDebtsSecuredByEligibleLienValue(mortgages) == null) {

			return 'Yes';
		}
		
		return 'No';
	}	

	private String getRefinancingTestResult(Application__c application) {

		if(application.Is_Property_Eligible_for_Refinancing__c == 'Yes') {
			return 'Fail';
		}

		return 'Pass';
	}

	private Decimal setMaxRefinanceEligibility(Processing_Application_Review__c par) {

		return par.Total_Eligible_Physical_Loss_Real_Estate__c;
	}

	private Decimal setRefinanceAmount(List<Mortgage__c> mortgages, Application__c application, Processing_Application_Review__c par) {
		Decimal lienTotal = 0;

		for(Mortgage__c mortgage : mortgages) {
			if(mortgage.Lien_Balance__c != null) {
				lienTotal += mortgage.Lien_Balance__c;
			}
		}

		if(lienTotal > 0) {
			return lienTotal;
		}else {
			return par.Total_Eligible_Physical_Loss_Real_Estate__c;
		}
	}

	private Decimal calculatePercentOfDamageRuleOf40(List<Loss_Verification_Inspections__c> lossVerifications, Processing_Application_Review__c par) {
		Decimal fairMarketValueOfLandTotal = lossVerificationFieldTotaler(lossVerifications, 'Fair_Market_Value_of_Land__c');
		Decimal fairMarketValueOfStructureTotal = lossVerificationFieldTotaler(lossVerifications, 'Fair_Market_Value_of_Structure__c');
		Decimal result = 0;

		if(par.Total_Real_Estate_Uncompensated_Loss__c != null && (fairMarketValueOfStructureTotal + fairMarketValueOfLandTotal) > 0) {
			result = (100 * (par.Total_Real_Estate_Uncompensated_Loss__c / (fairMarketValueOfLandTotal + fairMarketValueOfStructureTotal)));
		}

		return result;	
	}

	private Decimal calculatePercentOfDamageRuleOf50(List<Loss_Verification_Inspections__c> lossVerifications, Processing_Application_Review__c par) {
		Decimal fairMarketValueOfStructureTotal = lossVerificationFieldTotaler(lossVerifications, 'Fair_Market_Value_of_Structure__c');
		Decimal result = 0;

		if(par.Total_Real_Estate_Uncompensated_Loss__c != null && fairMarketValueOfStructureTotal > 0) {
			result = (100 * (par.Total_Real_Estate_Uncompensated_Loss__c / fairMarketValueOfStructureTotal));
		}

		return result;
	}

	private String isPropertyDamagedAsPer40Rule(Application__c application) {	
		if(application.Percent_of_damage_as_per_Rule_of_40__c >= 40) { 
			return 'Yes';
		}else {
			return 'No';
		}
	}

	private String isPropertyDamagedAsPer50Rule(Application__c application) {

		if(application.Percent_of_damage_as_per_Rule_of_50__c >= 50) { 
			return 'Yes';
		}else {
			return 'No';
		}
	}

	private String isPropertyDamagedAsPer40or50Rule(Application__c application) {

		if(application.Property_damaged_as_per_Rule_of_40__c == 'Yes' || application.Property_damaged_as_per_Rule_of_50__c == 'Yes') {
			return 'Yes';
		}else {
			return 'No';
		}	
	}

	private String checkApplicantDoesNotHaveCreditElsewhere(Application__c application, Processing_Application_Review__c par) {

		if(par.Credit_Elsewhere_Test__c == 'Below Market Rate') {
				return 'Yes';
		}

		return 'No';
	}

	private String isInsuranceRecoveryForRealEstateFinalYes(List<Insurance__c> insurances) {

		for(Insurance__c insurance : insurances) {
			if(insurance.Insurance_Recovery_for_Real_Estate_Final__c != 'Yes') {
				return 'No';
			}
		}

		return 'Yes';
	}

	private String getAllDebtsSecuredByEligibleLienValue(List<Mortgage__c> mortgages) {
		String returnValue = null;

		for(Mortgage__c mortgage : mortgages) {
			if(!String.isEmpty(mortgage.Debt_Must_Be_Secured_By_An_Eligible_Lien__c)) {
				if(mortgage.Lien_not_due_Taxes_Mechanics_Other__c == 'Yes' || mortgage.Lien_not_owned_by_Federal_State_Local_Go__c == 'Yes' || mortgage.Lien_Existed_Prior_to_the_Disaster__c == 'Yes') {
					returnValue = 'Yes';
				}else{
					returnValue = 'No';
					break;
				}
			}
		}

		return returnValue;
	}

	private Decimal lossVerificationFieldTotaler(List<Loss_Verification_Inspections__c> objectList, String fieldAPIName) {
		Decimal total = 0;

		for(Loss_Verification_Inspections__c lvi : objectList) {
			if(lvi.get(fieldAPIName) != null) {
				total += (Decimal)lvi.get(fieldAPIName);
			}
		}
		return total;
	}

	public class HomeLoanRefinancingException extends Exception {}
}