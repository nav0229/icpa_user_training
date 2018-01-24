/****************************************************************
 Name: LCHazardInsuranceDamagedPropertyRule
============================================================
Author: Lenny
Purpose: DCMM-2241
	Loan Condition Rule to determine whether automated
	Hazard Insurance Loan Condition Checklist should be created
	for Damaged Property
============================================================

****************************************************************/
public class LCHazardInsuranceDamagedPropertyRule implements LoanConditionRuleInterface {
	private final string DAMAGED_PROPERTY_HAZARD_INSURANCE = 'Hazard Insurance';
	private final Set<String> MI_HAZ_UP_CODES = new Set<String>{
		'UP-00','UP-01','UP-04','UP-07','UP-09','UP-17','UP-18','UP-19','UP-20','UP-24','UP-25','UP-26','UP-27','UP-28',
		'UP-29','UP-41','UP-42','UP-43','UP-44','UP-45','UP-50','UP-51','UP-52','UP-53','UP-54','UP-55','UP-56'
	};
	private final Set<String> MIHAZ_PROPERTY_TYPES = new Set<String>{
		PropertyDataAccessor.PROPERTY_TYPE_BOAT_REG_WITH_CG,           
		PropertyDataAccessor.PROPERTY_TYPE_VSL_REG_WITH_CG
	};
	private final Set<String> MIHAZ_COLLATERAL_TYPES = new Set<String>{
		PropertyDataAccessor.COLLATERAL_TYPE_RE,
		PropertyDataAccessor.COLLATERAL_TYPE_MANU_HOME,
		PropertyDataAccessor.COLLATERAL_TYPE_MANU_HOME_TO_PURCH,
		PropertyDataAccessor.COLLATERAL_TYPE_CO_OP,
		PropertyDataAccessor.COLLATERAL_TYPE_STRUCT_IMPROV,
		PropertyDataAccessor.COLLATERAL_TYPE_ASSN_LAND
	};
	
	public Loan_Condition_Checklist__c applyRuleAndCreateLoanCondition(LoanConditionGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Master_Checklist__c hazardInsMasterChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.HAZARD_INSURANCE);
		
		Application__c application = generationCriteria.application;
		Property__c property = generationCriteria.relatedProperty;

		Decimal totalUpCodeAmount = 0;
		if(application.Loan_Type__c == 'Home'
			&& MIHAZ_PROPERTY_TYPES.contains(property.Property_Type__c)
			&& property.Other_Property__c == false
		){
			for(UP_Codes__c upCode : generationCriteria.relatedUPCodes){
				if(MI_HAZ_UP_CODES.contains(upCode.UP_Code__c)){
					totalUpCodeAmount += upCode.Amount__c;
				}
			}
		}

		if(totalUpCodeAmount > 0 
			|| MIHAZ_COLLATERAL_TYPES.contains(property.Collateral_Type__c)
		){
			return new Loan_Condition_Checklist__c(
				Name = DAMAGED_PROPERTY_HAZARD_INSURANCE,
				Master_Checklist__c = hazardInsMasterChecklist.Id,
				Application__c = application.Id,
				Property__c = property.Id,
				Active__c = true
			);
		}
		return null;
	} 
}