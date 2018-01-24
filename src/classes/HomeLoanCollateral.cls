/****************************************************************
 Name:  HomeLoanCollateral
============================================================
Author: Matt
Purpose: JIRA#1611
Handles everything involved in the home loan collateral test
============================================================

****************************************************************/

public with sharing class HomeLoanCollateral {
	@TestVisible public static ProcessingApplicationReviewDAO parDa = new ProcessingApplicationReviewDataAccessor();
	@TestVisible public static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible public static PropertyDAO propertyDA = new PropertyDataAccessor();
	@TestVisible public static MortgageDAO mortgageDA = new MortgageDataAccessor();
	@TestVisible public static LoanDAO loanDA = new LoanDataAccessor();
	@TestVisible private static MapCreator MapCreatorTool = new MapCreator();
	@TestVisible private static GroupDAO groupDA = new GroupDataAccessor();

	private static final Decimal LOSS_AMOUNT_TO_NEED_COLLATERAL = 25000;
	private static final Set<String> EXCEPTION_PROPERTY_TYPES = new Set<String>{'Condo/Townhouse', 'Homeowners Association', 'CO-OP', 'Boat (Not Registered with Coast Guard)', 'Vessel (Registered with Coast Guard)'};
	private static final Set<String> NOT_RENTAL_PROPERTY_TYPES = new Set<String>{'Real Estate (Owned)', 'Manufactured Home (Land Leased) - Repair', 'Manufactured Home (Land Leased) - Replaced', 'Manufactured Home (Land Owned) - Repair', 'Manufactured Home (Land Owned) - Replace', 'Real Estate (Leased Land)'};
	private static final String NEED_COLLATERAL = 'Need Collateral';
	private static final String NO_COLLATERAL_NEEDED = 'No Collateral Needed';
	private static final String EXCEPTION_STOP_PROCESS = 'Exception (stop process)';
	private static final String SECURED_LOAN = 'Secured Loan';
	private static final String UNSECURED_LOAN = 'Unsecured Loan';
	private static final String REAL_ESTATE = 'Real Estate';
	private static final String FIRST_TRUST_OR_MORTGAGE = 'First Deed of Trust or Mortgage';
	private static final String SUBORDINATE_TRUST_OR_MORTGAGE = 'Subordinate Deed of Trust or Mortgage';
	private static final String MANUFACTURED_HOME = 'Manufactured Home';
	private static final String FIRST_SECURITY_MANUFACTURED_HOUSING = 'First Security Interest: Manufactured Housing';
	private static final String SUBORDINATE_SECURITY_MANUFACTURED_HOUSING = 'Subordinate Security Interest: Manufactured Housing';
	private static final String MANUFACTURED_HOME_TO_BE_PURCHASED = 'Manufactured Home to be Purchased';
	private static final String REAL_ESTATE_OWNED = 'Real Estate (Owned)';
	private static final String MANUFACTURED_HOME_OWNED_REPAIR = 'Manufactured Home (Land Owned) - Repair';
	private static final String MANUFACTURED_HOME_LEASED_REPAIR = 'Manufactured Home (Land Leased) - Repair';
	private static final String MANUFACTURED_HOME_OWNED_REPLACED = 'Manufactured Home (Land Owned) - Replace';
	private static final String MANUFACTURED_HOME_LEASED_REPLACED = 'Manufactured Home (Land Leased) - Replaced';
	private static final String MORTGAGE = 'Mortgage';
	private static final String MANUFACTURED_HOUSING_TO_BE_PURCHASED = 'Manufactured Housing to be Purchased';
	private static final String LOAN_OFFICER_QUEUE = 'Loan_Officer_Queue';
	

	public HomeLoanCollateral() {}

	public void runHomeLoanCollateralTest(List<Id> applicationIds) {
		List<Processing_Application_Review__c> pars;
		Group loanOfficerQueue = new Group();

		try {
			pars = parDa.getProcessingApplicationReviewsByAppIds(applicationIds);
			loanOfficerQueue = groupDA.getGroupByDeveloperNameAndType(LOAN_OFFICER_QUEUE,'Queue');
		}catch(QueryException e) {
			System.debug(e);
			throw new HomeLoanCollateralException('An error occurred while retrieving PARs or loan Officer Queue: ', e); 
		}
		Map<Id, Application__c> parIdApplicationMap = MapCreatorTool.createPARIdApplicationMap(pars);
		Map<Id, List<Insurance__c>> parIdInsurancesMap = MapCreatorTool.createPARIdInsuranceMap(pars);
		Map<Id, List<Mortgage__c>> parIdMortgagesMap = MapCreatorTool.createPARIdMortgagesMap(pars);
		Map<Id, List<Property__c>> parIdDamagedPropertyMap = MapCreatorTool.createPARIdDamagedPropertyMap(pars);
		Map<Id, List<Loan__c>> parIdLoanMap = MapCreatorTool.createPARIdLoanMap(pars);
		Map<Id, List<Debts_Expenses__c>> parIdDebtsExpensesMap = MapCreatorTool.createPARIdDebtExpenseMap(pars);
		Map<Id, List<Credit_Bureau_Line_Item__c>> parIdCBRLineItemMap = MapCreatorTool.createPARIdCBRLineItemMap(pars);
		List<Application__c> applicationsToUpdate = new List<Application__c>();
		List<Property__c> damagedPropertiesToUpdate = new List<Property__c>();
		List<Mortgage__c> mortgagesToUpdate = new List<Mortgage__c>();

		for(Processing_Application_Review__c par : pars) {
			par.Collateral_Test_Result_Date__c = System.now();
			
			if(parIdApplicationMap.get(par.Id).Loan_Type__c == 'Home'){
				if(isThereOnlyOneOfEachObject(parIdDamagedPropertyMap.get(par.Id), parIdMortgagesMap.get(par.Id))) {
					if(isPropertyTypeAnException(parIdDamagedPropertyMap.get(par.Id)[0].Property_Type__c)) {
						par.System_Flag__c = EXCEPTION_STOP_PROCESS;
					}else {
						par.System_Flag__c = setSystemFlagForCollateral(par, parIdApplicationMap.get(par.Id), parIdLoanMap.get(par.Id), parIdDamagedPropertyMap.get(par.Id)[0]);

						parIdApplicationMap.get(par.Id).System_Decision__c = setSystemDecision(par.System_Flag__c);

						parIdDamagedPropertyMap.get(par.Id)[0].Collateral_Type__c = setCollateralType(parIdDamagedPropertyMap.get(par.Id)[0]);
						parIdMortgagesMap.get(par.Id)[0].Lien_Type__c = setCollateralToCollect(par, parIdDamagedPropertyMap.get(par.Id)[0], parIdMortgagesMap.get(par.Id)[0], parIdDebtsExpensesMap.get(par.Id), parIdCBRLineItemMap.get(par.Id));	
					}

					applicationsToUpdate.add(parIdApplicationMap.get(par.Id));
					damagedPropertiesToUpdate.add(parIdDamagedPropertyMap.get(par.Id)[0]);
					mortgagesToUpdate.add(parIdMortgagesMap.get(par.Id)[0]);
				}
				else if(parIdDamagedPropertyMap.get(par.Id).size() > 1 || parIdMortgagesMap.get(par.Id).size() > 1) {
					parIdApplicationMap.get(par.Id).OwnerId = loanOfficerQueue.Id;

					applicationsToUpdate.add(parIdApplicationMap.get(par.Id));
				}		
			}
		}

		try {
			parDa.updateProcessingApplicationReviews(pars);
			applicationDA.updateApplications(applicationsToUpdate);
			propertyDA.updateProperties(damagedPropertiesToUpdate);
			mortgageDA.updateMortgages(mortgagesToUpdate);

		}catch(DmlException e) {
			System.debug(e);
			throw new HomeLoanCollateralException('An error occurred while updating PARs, applications, damagedProperties, or mortgages: ', e); 
		}
	}

	private boolean isThereOnlyOneOfEachObject(List<Property__c> dps, List<Mortgage__c> mortgages) {
		if(dps.size() == 1 && mortgages.size() == 1) {
			return true;
		}

		return false;
	}

	//#1 Determine if Property_Type__c warrants an Exception 
	private boolean isPropertyTypeAnException(String propertyType) {
		if(EXCEPTION_PROPERTY_TYPES.contains(propertyType)) {
			return true;
		}
		
		return false;
	}

	//#2 Determine if Collateral is Needed
	private String setSystemFlagForCollateral(Processing_Application_Review__c par, Application__c application, List<Loan__c> loans, Property__c damagedProperty) {
		String systemFlag = EXCEPTION_STOP_PROCESS;

		if(!application.Companion__c) { 
			if(par.Total_Eligible_Physical_Loss__c > LOSS_AMOUNT_TO_NEED_COLLATERAL) {
				systemFlag = NEED_COLLATERAL;
			}else {
				systemFlag = NO_COLLATERAL_NEEDED;
			}
		}else {
			if((par.Total_Eligible_Physical_Loss__c + sumOfAllCompanionLoans(loans)) > LOSS_AMOUNT_TO_NEED_COLLATERAL) {
				systemFlag = NEED_COLLATERAL;
			}else{
				systemFlag = NO_COLLATERAL_NEEDED;
			}
		}

		if(isNotARentalProperty(damagedProperty.Property_Type__c)) {
			if(par.Total_Eligible_Physical_Loss_Real_Estate__c > 0) {
				systemFlag = NEED_COLLATERAL;
			}else if (par.Total_Eligible_Physical_Loss_Real_Estate__c == 0) {
				if((damagedProperty.Other_Real_Estate_Owned_Value__c == 0 || damagedProperty.Other_Real_Estate_Owned_Value__c == null) && damagedProperty.State__c == 'TX') {
					systemFlag = NO_COLLATERAL_NEEDED;
				}else if((damagedProperty.Other_Real_Estate_Owned_Value__c > 0) && damagedProperty.State__c == 'TX') {
					systemFlag = EXCEPTION_STOP_PROCESS;
				}else{
					systemFlag = NEED_COLLATERAL;
				}
			}
		}else {
			if(damagedProperty.Other_Real_Estate_Owned_Value__c == 0 || damagedProperty.Other_Real_Estate_Owned_Value__c == null) {
				systemFlag = NO_COLLATERAL_NEEDED;
			}
			if(damagedProperty.Other_Real_Estate_Owned_Value__c > 0) {
				systemFlag = EXCEPTION_STOP_PROCESS; 
			}
		}

		return systemFlag;
	}

	private boolean isNotARentalProperty(String propertyType) {
		
		if(NOT_RENTAL_PROPERTY_TYPES.contains(propertyType)) {
			return true;
		}

		return false;
	}

	//#3 Determine if Loan is Secure (Needs Collateral) or Unsecure (Does NOT need Collateral) 
	private String setSystemDecision(String systemFlag) {
		String decision = null;

		if(systemFlag == NEED_COLLATERAL) {
			decision = SECURED_LOAN;
		}else if(systemFlag == NO_COLLATERAL_NEEDED) {
			decision = UNSECURED_LOAN;
		}

		return decision;		
	}
	
	//#4 Determine which Collateral to Collect (Lien Type) 
	private String setCollateralToCollect(Processing_Application_Review__c par, Property__c damagedProperty, Mortgage__c mortgage, List<Debts_Expenses__c> debtsExpenses, List<Credit_Bureau_Line_Item__c> creditBureauLineItems) {
		String lienType = null;

		if(par.System_Flag__c == NEED_COLLATERAL) {
			if(damagedProperty.Collateral_Type__c == REAL_ESTATE){
				if(isThereMortgageOnApplication(debtsExpenses)){
					if(getMortgageBalance(debtsExpenses, creditBureauLineItems) == 0) {
						lienType = FIRST_TRUST_OR_MORTGAGE;
					}else if(getMortgageBalance(debtsExpenses, creditBureauLineItems) > 0) {
						lienType = SUBORDINATE_TRUST_OR_MORTGAGE;
					}
				}
			}
			else if(damagedProperty.Collateral_Type__c == MANUFACTURED_HOME) {
				if(isThereMortgageOnApplication(debtsExpenses)) {
					if(getMortgageBalance(debtsExpenses, creditBureauLineItems) == 0) {
						lienType = FIRST_SECURITY_MANUFACTURED_HOUSING;
					}
					else if(getMortgageBalance(debtsExpenses, creditBureauLineItems) > 0) {
						lienType = SUBORDINATE_SECURITY_MANUFACTURED_HOUSING; 
					}
				}
			}
			else if(damagedProperty.Collateral_Type__c == MANUFACTURED_HOME_TO_BE_PURCHASED) {
				lienType = MANUFACTURED_HOUSING_TO_BE_PURCHASED;
			}
		}

		return lienType;
	}

	private String setCollateralType(Property__c damagedProperty) {
		if(damagedProperty.Property_Type__c == REAL_ESTATE_OWNED) {
				return REAL_ESTATE;
		}
		else if(damagedProperty.Property_Type__c == MANUFACTURED_HOME_OWNED_REPAIR || damagedProperty.Property_Type__c == MANUFACTURED_HOME_LEASED_REPAIR) {
				return MANUFACTURED_HOME;
		}
		else if(damagedProperty.Property_Type__c == MANUFACTURED_HOME_OWNED_REPLACED || damagedProperty.Property_Type__c == MANUFACTURED_HOME_LEASED_REPLACED) {
				return MANUFACTURED_HOME_TO_BE_PURCHASED;
		}

		return null;
	}

	private boolean isThereMortgageOnApplication(List<Debts_Expenses__c> debtsExpenses) {
		for(Debts_Expenses__c de : debtsExpenses) {
			if(de.Type_of_Debt__c == MORTGAGE) {
				return true;
			}
		}

		return false;
	}

	private Decimal getMortgageBalance(List<Debts_Expenses__c> debtsExpenses, List<Credit_Bureau_Line_Item__c> creditBureauLineItems) {
		Decimal balance = 0;
		for(Credit_Bureau_Line_Item__c cbrLI : creditBureauLineItems) {
			if(cbrLI.Is_Mortgage__c && cbrLI.Account_Balance__c != null) {
				balance += cbrLI.Account_Balance__c;
			}
		}
		if(balance == 0) {
			for(Debts_Expenses__c debtsExpense : debtsExpenses) {
				if(debtsExpense.Type_of_Debt__c == MORTGAGE && debtsExpense.Balance__c != null) {
					balance += debtsExpense.Balance__c;
				}
			}
		}
		return balance;
	}

	private Decimal sumOfAllCompanionLoans(List<Loan__c> loans) {
		Decimal total = 0;
		for(Loan__c loan : loans) {
			if(loan.Companion__c) {
				if(loan.Loan_Amount__c != null) {
					total += loan.Loan_Amount__c;
				}
			}
		}
		return total;
	}

	public class HomeLoanCollateralException extends Exception {}
}