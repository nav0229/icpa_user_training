/****************************************************************
 Name:  MapCreator
============================================================
Author: Matt
Purpose: JIRA#1340, 1771, 1464, 1465, 166
Holds methods for creating various different maps
============================================================

****************************************************************/

public with sharing class MapCreator {
	@TestVisible private static ProcessingApplicationReviewDAO parDa = new ProcessingApplicationReviewDataAccessor();

	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	@TestVisible private static InsuranceDAO insuranceDA = new InsuranceDataAccessor();

	@TestVisible private static MortgageDAO mortgageDA = new MortgageDataAccessor();

	@TestVisible private static PropertyDAO propertyDA = new PropertyDataAccessor(); //used to get LVs

	@TestVisible private static OtherAssistanceDAO otherAssistanceDA = new OtherAssistanceDataAccessor();

	@TestVisible public static ApplicantDAO applicantDA = new ApplicantDataAccessor();

	@TestVisible public static IRSTranscriptsDAO irsTranscriptsDA = new IRSTranscriptsDataAccessor();

	@TestVisible public static DebtsExpensesDAO debtsExpensesDA = new DebtsExpensesDataAccessor();

	@TestVisible public static LoanDAO loanDA = new LoanDataAccessor();

	@TestVisible public static CreditBureauDAO creditBureauDA = new CreditBureauDataAccessor();

	@TestVisible public static CreditBureauLineItemDAO creditBureauLineItemDA = new CreditBureauLineItemDataAccessor();


	public MapCreator() {}

	public Map<Id, Application__c> createPARIdApplicationMap(List<Processing_Application_Review__c> pars) {
		Map<Id, Application__c> parApplicationMap = new Map<Id, Application__c>();
		List<Application__c> applicationList = new List<Application__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
				applicationIds.add(par.Application__c);
		}

		try{
			applicationList = applicationDA.getApplicationsById(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving Applications by Id: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			for(Application__c application : applicationList) {
				if(par.Application__c == application.Id) {
					parApplicationMap.put(par.Id, application);
				}
			}
		}

		return parApplicationMap;
	}

	public Map<Id, List<Insurance__c>> createPARIdInsuranceMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Insurance__c>> parIdInsuranceMap = new Map<Id, List<Insurance__c>>();
		List<Insurance__c> insurances = new List<Insurance__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
			applicationIds.add(par.Application__c);
		}
		
		try{
			insurances = insuranceDA.getInsurancebyApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving Insurance Application Ids: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			List<Insurance__c> parInsurances = new List<Insurance__c>();

			for(Insurance__c insurance : insurances) {
				if(par.Application__c == insurance.Application__c) {
					parInsurances.add(insurance);                
				}
			}
			parIdInsuranceMap.put(par.Id, parInsurances);        
		}
		
		return parIdInsuranceMap;
	}

	public Map<Id, List<Mortgage__c>> createPARIdMortgagesMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Mortgage__c>> parIdMortgagesMap = new Map<Id, List<Mortgage__c>>();
		List<Mortgage__c> mortgages = new List<Mortgage__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
			applicationIds.add(par.Application__c);
		}
		
		try{
			mortgages = mortgageDA.getMortgageByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving mortgages: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			List<Mortgage__c> mortgageSingleApplication = new List<Mortgage__c>();

			for(Mortgage__c mortgage : mortgages) {
				if(par.Application__c == mortgage.Application__c) {
					mortgageSingleApplication.add(mortgage);                
				}
			}
			parIdMortgagesMap.put(par.Id, mortgageSingleApplication);        
		}
		
		return parIdMortgagesMap;
	}

	public Map<Id, List<Loss_Verification_Inspections__c>> createPARIdLossVerificationMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Loss_Verification_Inspections__c>> parLossVerificationMap = new Map<Id, List<Loss_Verification_Inspections__c>>();
		List<Property__c> damagedProperties = new List<Property__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
				applicationIds.add(par.Application__c);
		}

		try{
			damagedProperties = propertyDA.getDamagedPropertiesAndLossVerificationsByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving Damaged Property & Loss Verifications by Application Ids: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			List<Loss_Verification_Inspections__c> lossVerificationsSingleApp = new List<Loss_Verification_Inspections__c>();

			for(Property__c damagedProperty : damagedProperties) {
				if(par.Application__c == damagedProperty.Application__c) {
					lossVerificationsSingleApp.addAll(damagedProperty.Loss_Verifications__r);
				}
			}
			parLossVerificationMap.put(par.Id, lossVerificationsSingleApp);
		}

		return parLossVerificationMap;
	}

	public Map<Id, List<Other_Assistance__c>> createPARIdOtherAssistanceMap(List<Processing_Application_Review__c> pars) {
        Map<Id, List<Other_Assistance__c>> parIdOtherAssistanceMap = new Map<Id, List<Other_Assistance__c>>();
        List<Other_Assistance__c> otherAssistances = new List<Other_Assistance__c>();
        List<Id> applicationIds = new List<Id>();

        for(Processing_Application_Review__c par: pars){
            applicationIds.add(par.Application__c);
        }
        
        try{
            otherAssistances = otherAssistanceDA.getOtherAssistancebyApplicationIds(applicationIds);
        }catch(QueryException e){
        	System.debug(e);
            throw new MapCreatorException('An error occurred while retrieving Other Assistance by Application Ids: ', e); 
        }
        

        for(Processing_Application_Review__c par: pars){
            List<Other_Assistance__c> parOtherAssistances = new List<Other_Assistance__c>();

            for(Other_Assistance__c otherAssistance : otherAssistances) {
                if(par.Application__c == otherAssistance.Application__c) {
                    parOtherAssistances.add(otherAssistance);                
                }
            }
            parIdOtherAssistanceMap.put(par.Id, parOtherAssistances);        
        }

        return parIdOtherAssistanceMap;
    }

    public Map<Id, List<Applicant__c>> createPARIdApplicantMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Applicant__c>> parIdApplicantsMap = new Map<Id, List<Applicant__c>>();
		List<Applicant__c> applicants;
		List<Id> applicationIds = new List<Id>();

        for(Processing_Application_Review__c par: pars){
            applicationIds.add(par.Application__c);
        }

		try {
			applicants = applicantDA.getApplicantsByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
            throw new MapCreatorException('An error occurred while retrieving Other applicants by Application Ids: ', e); 
        }

		for(Processing_Application_Review__c par : pars){
            List<Applicant__c> applicantsForPAR = new List<Applicant__c>();

            for(Applicant__c applicant : applicants) {
                if(par.Application__c == applicant.Application__c) {
                    applicantsForPAR.add(applicant);                
                }
            }
            parIdApplicantsMap.put(par.Id, applicantsForPAR);        
        }

		return parIdApplicantsMap;
	}

	public Map<Id, List<Debts_Expenses__c>> createPARIdDebtExpenseMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Debts_Expenses__c>> parIdDebtsExpensesMap = new Map<Id, List<Debts_Expenses__c>>();
		List<Debts_Expenses__c> debtsExpenses;
		List<Id> applicationIds = new List<Id>();

        for(Processing_Application_Review__c par: pars){
            applicationIds.add(par.Application__c);
        }

        try {
			debtsExpenses = debtsExpensesDA.getDebtsAndExpensesByApplicationId(applicationIds);
		}catch(QueryException e){
			System.debug(e);
            throw new MapCreatorException('An error occurred while retrieving Debts/Expenses by Application Ids: ', e); 
        }

		for(Processing_Application_Review__c par: pars){
            List<Debts_Expenses__c> debtsExpensesForPAR = new List<Debts_Expenses__c>();

            for(Debts_Expenses__c debtsExpense : debtsExpenses) {
                if(par.Application__c == debtsExpense.Application__c) {
                    debtsExpensesForPAR.add(debtsExpense);                
                }
            }
            parIdDebtsExpensesMap.put(par.Id, debtsExpensesForPAR);        
        }

		return parIdDebtsExpensesMap;
	}	

	public Map<Id, List<IRS_Transcripts__c>> createPARIdIRSTranscriptMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<IRS_Transcripts__c>> parIdIrsTranscriptsMap = new Map<Id, List<IRS_Transcripts__c>>();
		List<IRS_Transcripts__c> irsTranscripts;
		List<Id> applicationIds = new List<Id>();

        for(Processing_Application_Review__c par: pars){
            applicationIds.add(par.Application__c);
        }

        try {
			irsTranscripts = irsTranscriptsDA.getIRSTranscriptsByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
            throw new MapCreatorException('An error occurred while retrieving IRS Transcripts by Application Ids: ', e); 
        }

		for(Processing_Application_Review__c par: pars){
            List<IRS_Transcripts__c> irsTranscriptForPAR = new List<IRS_Transcripts__c>();

            for(IRS_Transcripts__c irsTranscript : irsTranscripts) {
                if(par.Application__c == irsTranscript.Application__c) {
                    irsTranscriptForPAR.add(irsTranscript);                
                }
            }
            parIdIrsTranscriptsMap.put(par.Id, irsTranscriptForPAR);        
        }

		return parIdIrsTranscriptsMap;
	}

	public Map<Id, List<Loan__c>> createPARIdLoanMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Loan__c>> parIdLoansMap = new Map<Id, List<Loan__c>>();
		List<Loan__c> loans;
		List<Id> applicationIds = new List<Id>();

        for(Processing_Application_Review__c par: pars){
            applicationIds.add(par.Application__c);
        }

        try {
			loans = loanDA.getLoansByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
            throw new MapCreatorException('An error occurred while retrieving Loans by Application Ids: ', e); 
        }

		for(Processing_Application_Review__c par: pars){
            List<Loan__c> loansForPAR = new List<Loan__c>();

            for(Loan__c loan : loans) {
                if(par.Application__c == loan.Application__c) {
                    loansForPAR.add(loan);                
                }
            }
            parIdLoansMap.put(par.Id, loansForPAR);        
        }

		return parIdLoansMap;
	}

	public Map<Id, List<Property__c>> createPARIdDamagedPropertyMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Property__c>> parDamagedPropertyMap = new Map<Id, List<Property__c>>();
		List<Property__c> damagedProperties = new List<Property__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
				applicationIds.add(par.Application__c);
		}

		try{
			damagedProperties = propertyDA.getDamagedPropertiesAndLossVerificationsByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving Damaged Property & Loss Verifications by Application Ids: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			List<Property__c> damagedPropertySingleApp = new List<Property__c>();

			for(Property__c damagedProperty : damagedProperties) {
				if(par.Application__c == damagedProperty.Application__c) {
					damagedPropertySingleApp.add(damagedProperty);
				}
			}
			parDamagedPropertyMap.put(par.Id, damagedPropertySingleApp);
		}

		return parDamagedPropertyMap;
	}

	public Map<Id, List<Credit_Bureau__c>> createPARIdCreditBureauMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Credit_Bureau__c>> parIdCreditBureauMap = new Map<Id, List<Credit_Bureau__c>>();
		List<Credit_Bureau__c> creditBureaus = new List<Credit_Bureau__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
			applicationIds.add(par.Application__c);
		}
		
		try{
			creditBureaus = creditBureauDA.getActiveCreditBureausByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving Credit Bureau by Application Ids: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			List<Credit_Bureau__c> parCreditBureaus = new List<Credit_Bureau__c>();

			for(Credit_Bureau__c creditBureau : creditBureaus) {
				if(par.Application__c == creditBureau.Application__c) {
					parCreditBureaus.add(creditBureau);                
				}
			}
			parIdCreditBureauMap.put(par.Id, parCreditBureaus);        
		}
		
		return parIdCreditBureauMap;
	}

	public Map<Id, List<Credit_Bureau_Line_Item__c>> createPARIdCBRLineItemMap(List<Processing_Application_Review__c> pars) {
		Map<Id, List<Credit_Bureau_Line_Item__c>> parIdCBRLineItemMap = new Map<Id, List<Credit_Bureau_Line_Item__c>>();
		List<Credit_Bureau_Line_Item__c> cbrLineItems = new List<Credit_Bureau_Line_Item__c>();
		List<Id> applicationIds = new List<Id>();

		for(Processing_Application_Review__c par: pars){
			applicationIds.add(par.Application__c);
		}
		
		try{
			cbrLineItems = creditBureauLineItemDA.getActiveCreditBureauLineItemsByApplicationIds(applicationIds);
		}catch(QueryException e){
			System.debug(e);
			throw new MapCreatorException('An error occurred while retrieving Credit Bureau Line Items by Application Ids: ', e); 
		}

		for(Processing_Application_Review__c par: pars){
			List<Credit_Bureau_Line_Item__c> parCBRLineItems = new List<Credit_Bureau_Line_Item__c>();

			for(Credit_Bureau_Line_Item__c cbrLI : cbrLineItems) {
				if(par.Application__c == cbrLI.Credit_Bureau__r.Application__c) {
					parCBRLineItems.add(cbrLI);                
				}
			}
			parIdCBRLineItemMap.put(par.Id, parCBRLineItems);        
		}
		
		return parIdCBRLineItemMap;
	}


    public class MapCreatorException extends Exception {}
}