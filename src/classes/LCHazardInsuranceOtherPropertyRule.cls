/****************************************************************
 Name: LCHazardInsuranceOtherPropertyRule
============================================================
Author: Lenny
Purpose: DCMM-2241
	Loan Condition Rule to determine whether automated
	Hazard Insurance Loan Condition Checklist should be created
	for Other Property
============================================================

****************************************************************/
public class LCHazardInsuranceOtherPropertyRule implements LoanConditionRuleInterface {
	private final string OTHER_PROPERTY_HAZARD_INSURANCE = 'Other Property Hazard Insurance';
	
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
		Property__c otherProperty = generationCriteria.relatedProperty;

		if(application.Loan_Type__c == 'Home'
			&& otherProperty.Other_Property__c == true
			&& MIHAZ_COLLATERAL_TYPES.contains(otherProperty.Collateral_Type__c)
		){
			return new Loan_Condition_Checklist__c(
				Name = OTHER_PROPERTY_HAZARD_INSURANCE,
				Master_Checklist__c = hazardInsMasterChecklist.Id,
				Application__c = application.Id,
				Property__c = otherProperty.Id,
				Active__c = true
			);
		}
		return null;
	} 
}