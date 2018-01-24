/****************************************************************
 Name: LoanConditionElementGeneratorRuleFactory
============================================================
Author: Kevin
Purpose: DCMM-2148
	Factory class that determines which rules should be applied to criteria
	This class also house the Generator Rule classes
============================================================

****************************************************************/
public with sharing class LoanConditionElementGeneratorRuleFactory {
	public static final String OCSHD = 'OC-SHD';
	public static final String OCFPL = 'OC-FPL';
	public static final String OCTPI = 'OC-TPI';
	public static final String OCCRP = 'OC-CRP';
	public static final String RAACM = 'RA-ACM';
	public static final String RALAW = 'RA-LAW';
	public static final String DCLAC = 'DC-LAC';
	public static final String LPEXT = 'LP-EXT';
	public static final String LPFLA = 'LP-FLA';
	public static final String MIHAZ = 'MI-HAZ';
	public static final String OCTAG = 'OC-TAG';
	public static final String OCORE = 'OC-ORE';
	public static final String OCOVS = 'OC-OVS';
	public static final String OCOMH = 'OC-OMH';

	public static final Set<String> SHARED_REPAIR_RESPONSIBILITY_RULE_CODES = new Set<String>{
		OCSHD
	};
	public static final Set<String> POLICY_TYPE_RULE_CODES = new Set<String>{
		OCFPL,
		OCTPI
	};
	public static final Set<String> POLICY_NUMBER_RULE_CODES = new Set<String>{
		OCFPL,
		OCTPI
	};
	public static final Set<String> NAME_OF_POLICY_HOLDER_RULE_CODES = new Set<String>{
		OCFPL,
		OCTPI
	};
	public static final Set<String> PROPERTY_NUMBER_RULE_CODES = new Set<String>{
		OCCRP,
		LPFLA,
		RAACM,
		RALAW,
		OCORE,
		OCOVS,
		OCOMH
	};
	public static final Set<String> ADDRESS_RULE_CODES = new Set<String>{
		OCCRP
	};
	public static final Set<String> DEFENDENT_NAME_RULE_CODES = new Set<String>{
		RALAW
	};
	public static final Set<String> DEFENDENT_TITLE_RULE_CODES = new Set<String>{
		RALAW
	};
	public static final Set<String> CASE_NUMBER_RULE_CODES = new Set<String>{
		RALAW
	};
	public static final Set<String> NAME_OF_COURT_RULE_CODES = new Set<String>{
		DCLAC,
		RALAW
	};
	public static final Set<String> NAME_RULE_CODES = new Set<String>{
		DCLAC
	};
	public static final Set<String> TITLE_POSITION_RULE_CODES = new Set<String>{
		DCLAC
	};
	public static final Set<String> DOLLAR_AMOUNT_RULE_CODES = new Set<String>{
		DCLAC
	};
	public static final Set<String> PERCENT_COLA_RULE_CODES = new Set<String>{
		DCLAC
	};
	public static final Set<String> LENGTH_OF_LEASE_RULE_CODES = new Set<String>{
		LPEXT
	};
	public static final Set<String> MONTHLY_LEASE_AMOUNT_RULE_CODES = new Set<String>{
		LPEXT
	};
	public static final Set<String> ADDRESS_INFO_RULE_CODES = new Set<String>{
		LPEXT,
		OCORE,
		OCOMH
	};
	public static final Set<String> REAL_ESTATE_RULE_CODES = new Set<String>{
		MIHAZ
	};
	public static final Set<String> CONTENTS_RULE_CODES = new Set<String>{
		MIHAZ
	};
	public static final Set<String> LOSS_PAYEE_RULE_CODES = new Set<String>{
		MIHAZ
	};
	public static final Set<String> WINDSTORM_RULE_CODES = new Set<String>{
		MIHAZ
	};
	public static final Set<String> NAME_OF_TRUST_RULE_CODES = new Set<String>{
		OCTAG
	};

	public LoanConditionElementGeneratorRuleFactory(){}

	public List<LoanConditionElementRuleInterface> getLoanConditionElementGeneratorRules(){
		List<LoanConditionElementRuleInterface> rulesList = new List<LoanConditionElementRuleInterface>();

		rulesList.add(new SharedRepairResponsibilityRule());
		rulesList.add(new PolicyTypeRule());
		rulesList.add(new PolicyNumberRule());
		rulesList.add(new NameOfPolicyHolderRule());
		rulesList.add(new PropertyNumberRule());
		rulesList.add(new AddressRule());
		rulesList.add(new DefendantNameRule());
		rulesList.add(new DefendantTitleRule());
		rulesList.add(new CaseNumberRule());
		rulesList.add(new NameOfCourtRule());
		rulesList.add(new NameRule());
		rulesList.add(new TitlePositionRule());
		rulesList.add(new DollarAmountRule());
		rulesList.add(new PercentCOLARule());
		rulesList.add(new LengthOfLeaseRule());
		rulesList.add(new MonthlyLeaseAmountRule());
		rulesList.add(new RealEstateRule());
		rulesList.add(new ContentsRule());
		rulesList.add(new LossPayeeRule());
		rulesList.add(new WindstormRule());
		rulesList.add(new StreetAddressRule());
		//rulesList.add(new AddressTwoRule());
		rulesList.add(new CityRule());
		rulesList.add(new StateRule());
		rulesList.add(new ZipCodeRule());
		rulesList.add(new NameOfTrustRule());

		return rulesList;
	}


	public class SharedRepairResponsibilityRule implements LoanConditionElementRuleInterface {
		private final String SHARED_REPAIR_RESPONSIBILITY = 'Shared Repair Responsibility';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.SHARED_REPAIR_RESPONSIBILITY_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c srrChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.SHARED_REPAIR_RESPONSIBILITY);

			return new Loan_Condition_Element__c(
				Name = SHARED_REPAIR_RESPONSIBILITY,
				Master_Checklist__c = srrChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = SHARED_REPAIR_RESPONSIBILITY,
				Required__c = true
			);
		}
	}

	public class PolicyTypeRule implements LoanConditionElementRuleInterface {
		private final String POLICY_TYPE = 'Policy Type';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.POLICY_TYPE_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c policyTypeChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.POLICY_TYPE_CODE);

			return new Loan_Condition_Element__c(
				Name = POLICY_TYPE,
				Master_Checklist__c = policyTypeChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = POLICY_TYPE,
				Required__c = false
			);
		}
	}

	public class PolicyNumberRule implements LoanConditionElementRuleInterface {
		private final String POLICY_NUMBER = 'Policy Number';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.POLICY_NUMBER_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c policyNumberChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.POLICY_NUMBER_CODE);

			return new Loan_Condition_Element__c(
				Name = POLICY_NUMBER,
				Master_Checklist__c = policyNumberChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = POLICY_NUMBER,
				Required__c = false
			);
		}
	}

	public class NameOfPolicyHolderRule implements LoanConditionElementRuleInterface {
		private final String NAME_OF_POLICY_HOLDER = 'Name of Policy Holder';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.NAME_OF_POLICY_HOLDER_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c policyHolderChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.POLICY_HOLDER_CODE);

			return new Loan_Condition_Element__c(
				Name = NAME_OF_POLICY_HOLDER,
				Master_Checklist__c = policyHolderChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = NAME_OF_POLICY_HOLDER,
				Required__c = false
			);
		}
	}

	public class PropertyNumberRule implements LoanConditionElementRuleInterface {
		private final String PROPERTY_NUMBER = 'Property Number';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.PROPERTY_NUMBER_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c propertyNumberChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PROPERTY_NUMBER_CODE);

			return new Loan_Condition_Element__c(
				Name = PROPERTY_NUMBER,
				Master_Checklist__c = propertyNumberChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Custom_Element_Value__c = loanConditionCriteria.property.External_ID__c,
				Element_Type__c = PROPERTY_NUMBER,
				Required__c = false
			);
		}
	}

	public class AddressRule implements LoanConditionElementRuleInterface {
		private final String ADDRESS = 'Address';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.ADDRESS_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			return new Loan_Condition_Element__c(
				Name = ADDRESS,
				Master_Checklist__c = loanConditionCriteria.loanCondition.Master_Checklist__c,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = ADDRESS,
				Required__c = false
			);
		}
	}

	public class DefendantNameRule implements LoanConditionElementRuleInterface {
		private final String DEFENDENT_NAME = 'Defendant Name';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.DEFENDENT_NAME_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c defNameChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.DEFENDANT_NAME_CODE);

			return new Loan_Condition_Element__c(
				Name = DEFENDENT_NAME,
				Master_Checklist__c = defNameChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = DEFENDENT_NAME,
				Required__c = false
			);
		}
	}

	public class DefendantTitleRule implements LoanConditionElementRuleInterface {
		private final String DEFENDANT_TITLE = 'Defendant Title';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.DEFENDENT_TITLE_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c defTitleChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.DEFENDANT_TITLE_CODE);

			return new Loan_Condition_Element__c(
				Name = DEFENDANT_TITLE,
				Master_Checklist__c = defTitleChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = DEFENDANT_TITLE,
				Required__c = false
			);
		}
	}

	public class CaseNumberRule implements LoanConditionElementRuleInterface {
		private final String CASE_NUMBER = 'Case Number';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.CASE_NUMBER_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c caseNumberChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.CASE_NUMBER_CODE);

			return new Loan_Condition_Element__c(
				Name = CASE_NUMBER,
				Master_Checklist__c = caseNumberChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = CASE_NUMBER,
				Required__c = false
			);
		}
	}

	public class NameOfCourtRule implements LoanConditionElementRuleInterface {
		private final String NAME_OF_COURT = 'Name of Court';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.NAME_OF_COURT_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c courtNameChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.COURT_NAME_CODE);

			return new Loan_Condition_Element__c(
				Name = NAME_OF_COURT,
				Master_Checklist__c = courtNameChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = NAME_OF_COURT,
				Required__c = false
			);
		}
	}

	public class NameRule implements LoanConditionElementRuleInterface {
		private final String NAME = 'Name';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.NAME_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c nameChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.NAME_FL_CODE);

			return new Loan_Condition_Element__c(
				Name = NAME,
				Master_Checklist__c = nameChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = NAME,
				Required__c = false
			);
		}
	}

	public class TitlePositionRule implements LoanConditionElementRuleInterface {
		private final String TITLE_POSITION = 'Title/Position';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.TITLE_POSITION_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c titlePosChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TITLE_POSITION_CODE);

			return new Loan_Condition_Element__c(
				Name = TITLE_POSITION,
				Master_Checklist__c = titlePosChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = TITLE_POSITION,
				Required__c = false
			);
		}
	}

	public class DollarAmountRule implements LoanConditionElementRuleInterface {
		private final String DOLLAR_AMOUNT = 'Dollar Amount';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.DOLLAR_AMOUNT_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c dollarAmtChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.DOLLAR_AMOUNT_CODE);

			return new Loan_Condition_Element__c(
				Name = DOLLAR_AMOUNT,
				Master_Checklist__c = dollarAmtChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = DOLLAR_AMOUNT,
				Required__c = false
			);
		}
	}

	public class PercentCOLARule implements LoanConditionElementRuleInterface {
		private final String PERCENT_COLA = 'Percent COLA';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.PERCENT_COLA_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c percentCOLAChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.PERCENT_COLA_CODE);

			return new Loan_Condition_Element__c(
				Name = PERCENT_COLA,
				Master_Checklist__c = percentCOLAChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = PERCENT_COLA,
				Required__c = false
			);
		}
	}

	public class LengthOfLeaseRule implements LoanConditionElementRuleInterface {
		private final String LENGTH_OF_LEASE = 'Length of Lease (Years)';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.LENGTH_OF_LEASE_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c lengthOfLeaseChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LEASE_LENGTH_CODE);

			return new Loan_Condition_Element__c(
				Name = LENGTH_OF_LEASE,
				Master_Checklist__c = lengthOfLeaseChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = LENGTH_OF_LEASE,
				Required__c = false
			);
		}
	}

	public class MonthlyLeaseAmountRule implements LoanConditionElementRuleInterface {
		private final String MONTHLY_LEASE_AMOUNT = 'Monthly Lease Amount';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.MONTHLY_LEASE_AMOUNT_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c monthlyAmountChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.MONTHLY_AMOUNT_CODE);

			return new Loan_Condition_Element__c(
				Name = MONTHLY_LEASE_AMOUNT,
				Master_Checklist__c = monthlyAmountChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = MONTHLY_LEASE_AMOUNT,
				Required__c = false
			);
		}
	}

	public class StreetAddressRule implements LoanConditionElementRuleInterface {
		private final String ADDRESS = 'Street Address';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.ADDRESS_INFO_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c streetAddressChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.STREET_ADDRESS);

			return new Loan_Condition_Element__c(
				Name = ADDRESS,
				Master_Checklist__c = streetAddressChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Custom_Element_Value__c = loanConditionCriteria.property.Property_Address__c,
				Element_Type__c = ADDRESS,
				Required__c = true
			);
		}
	}

	//public class AddressTwoRule implements LoanConditionElementRuleInterface {
	//	private final String ADDRESS_TWO = 'Address Two';

	//	public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
	//		return LoanConditionElementGeneratorRuleFactory.ADDRESS_INFO_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
	//	}

	//	public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
	//		MasterChecklistData mcData = MasterChecklistData.getInstance();
	//		Master_Checklist__c addressTwoChecklist = 
	//			 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ADDRESS_TWO_CODE);

	//		return new Loan_Condition_Element__c(
	//			Name = ADDRESS_TWO,
	//			Master_Checklist__c = addressTwoChecklist.Id,
	//			Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
	//			Element_Type__c = ADDRESS_TWO,
	//			Required__c = false
	//		);
	//	}
	//}

	public class CityRule implements LoanConditionElementRuleInterface {
		private final String CITY = 'City';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.ADDRESS_INFO_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c cityChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.CITY_CODE);

			return new Loan_Condition_Element__c(
				Name = CITY,
				Master_Checklist__c = cityChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Custom_Element_Value__c = loanConditionCriteria.property.City__c,
				Element_Type__c = CITY,
				Required__c = true
			);
		}
	}

	public class StateRule implements LoanConditionElementRuleInterface {
		private final String STATE = 'State';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.ADDRESS_INFO_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c stateChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.STATE_CODE);

			return new Loan_Condition_Element__c(
				Name = STATE,
				Master_Checklist__c = stateChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Custom_Element_Value__c = loanConditionCriteria.property.State__c,
				Element_Type__c = STATE,
				Required__c = true
			);
		}
	}

	public class ZipCodeRule implements LoanConditionElementRuleInterface {
		private final String ZIP_CODE = 'Zip Code';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.ADDRESS_INFO_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c zipCodeChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ZIP_CODE_CODE);

			return new Loan_Condition_Element__c(
				Name = ZIP_CODE,
				Master_Checklist__c = zipCodeChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Custom_Element_Value__c = loanConditionCriteria.property.Zip_Code__c,
				Element_Type__c = ZIP_CODE,
				Required__c = true
			);
		}
	}

	public class RealEstateRule implements LoanConditionElementRuleInterface {
		private final String REAL_ESTATE = 'Real Estate';

		private final Set<String> categories = new Set<String>{
			'REAL ESTATE (REPAIR/REPLACE)',
			'REAL ESTATE (OTHER)',
			'MITIGATION',
			'CONTRACTOR\'S MALFEASANCE',
			'CUSTOM - RE'
		};

		private final Set<String> collateralTypes = new Set<String>{
			'Real Estate',
			'Manufactured Home',
			'Manufactured Home to be Purchased',
			'CO-OP',
			'Structure and Improvements',
			'Assignment of Land Sales Contract'
		};

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			if(!LoanConditionElementGeneratorRuleFactory.REAL_ESTATE_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c)){
				return false;
			}

			if(loanConditionCriteria.upCodes != null){
				for(UP_Codes__c upCode : loanConditionCriteria.upCodes){
					if(upCode.Amount__c  > 0 && categories.contains(upCode.New_Category__c)){
						return true;
					}
				}
			}
			
			if(loanConditionCriteria.property != null
				&& loanConditionCriteria.property.Active_Collateral__c == true
				&& collateralTypes.contains(loanConditionCriteria.property.Collateral_Type__c)
			){
				return true;
			}

			return false;
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c realEstateChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.REAL_ESTATE_CODE);

			return new Loan_Condition_Element__c(
				Name = REAL_ESTATE,
				Master_Checklist__c = realEstateChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = REAL_ESTATE,
				Required__c = true
			);
		}
	}

	public class ContentsRule implements LoanConditionElementRuleInterface {
		private final String CONTENTS = 'Contents';

		private final Set<String> categories = new Set<String>{
			'CONTENTS',
			'REPAY IHP',
			'CUSTOM - CONTENTS'
		};

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			if(!LoanConditionElementGeneratorRuleFactory.CONTENTS_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c)){
				return false;
			}

			if(loanConditionCriteria.upCodes != null){
				for(UP_Codes__c upCode : loanConditionCriteria.upCodes){
					if(upCode.Amount__c > 0 && categories.contains(upCode.New_Category__c)){
						return true;
					}
				}
			}

			return false;
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c contentsChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.CONTENTS_CODE);

			return new Loan_Condition_Element__c(
				Name = CONTENTS,
				Master_Checklist__c = contentsChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = CONTENTS,
				Required__c = true
			);
		}
	}

	public class LossPayeeRule implements LoanConditionElementRuleInterface {
		private final String LOSS_PAYEE = 'Loss';

		private final Set<String> collateralTypes = new Set<String>{
			'Real Estate',
			'Manufactured Home',
			'Manufactured Home to be Purchased',
			'CO-OP',
			'Structure and Improvements',
			'Assignment of Land Sales Contract'
		};

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			if(!LoanConditionElementGeneratorRuleFactory.LOSS_PAYEE_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c)){
				return false;
			}

			if(loanConditionCriteria.property != null
				&& collateralTypes.contains(loanConditionCriteria.property.Collateral_Type__c)){
				return true;
			}

			return false;
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c lossPayeeChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LOSS_PAYEE_CODE);

			return new Loan_Condition_Element__c(
				Name = LOSS_PAYEE,
				Master_Checklist__c = lossPayeeChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = LOSS_PAYEE,
				Required__c = true
			);
		}
	}

	public class WindstormRule implements LoanConditionElementRuleInterface {
		private final String WINDSTORM = 'Windstorm';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.WINDSTORM_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c windstormChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.WINDSTORM_CODE);

			return new Loan_Condition_Element__c(
				Name = WINDSTORM,
				Master_Checklist__c = windstormChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = WINDSTORM,
				Required__c = true
			);
		}
	}

	public class NameOfTrustRule implements LoanConditionElementRuleInterface {
		private final String NAME_OF_TRUST = 'Name of Trust';

		public Boolean doesRuleApply(LoanConditionCriteria loanConditionCriteria){
			return LoanConditionElementGeneratorRuleFactory.NAME_OF_TRUST_RULE_CODES.contains(loanConditionCriteria.loanCondition.Loan_Condition_Code__c);
		}

		public Loan_Condition_Element__c applyRuleAndCreateLoanConditionElement(LoanConditionCriteria loanConditionCriteria){
			MasterChecklistData mcData = MasterChecklistData.getInstance();
			Master_Checklist__c trustNameChecklist = 
				 mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.TRUST_NAME_CODE);

			return new Loan_Condition_Element__c(
				Name = NAME_OF_TRUST,
				Master_Checklist__c = trustNameChecklist.Id,
				Loan_Condition__c = loanConditionCriteria.loanCondition.Id,
				Element_Type__c = NAME_OF_TRUST,
				Required__c = true
			);
		}
	}

}