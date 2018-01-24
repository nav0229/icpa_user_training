/****************************************************************
 Name: LCCondominiumRepairsRule
============================================================
Author: Lenny
Purpose: DCMM-2138
	Loan Condition Rule to determine whether automated
	Condominium Repairs Loan Condition Checklist should be created
============================================================

****************************************************************/
public class LCCondominiumRepairsRule implements LoanConditionRuleInterface {
	private final string CONDOMINIUM_REPAIRS = 'Condominium Repairs';
	private final Set<String> OC_CRP_UP_CODES = new Set<String>{
		'UP-04','UP-17','UP-19','UP-26','UP-43','UP-44'
	};
	private final Set<String> OCCRPPropertyTypes = new Set<String>{
		PropertyDataAccessor.PROPERTY_TYPE_CONDO_TOWNHOUSE,           
		PropertyDataAccessor.PROPERTY_TYPE_HOA_OWNED,
		PropertyDataAccessor.PROPERTY_TYPE_CO_OP
	};
	
	public Loan_Condition_Checklist__c applyRuleAndCreateLoanCondition(LoanConditionGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Master_Checklist__c oc_crp_MasterChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LC_CONDOMINIUM_REPAIRS);
		
		Decimal totalUpCodeAmount = 0;
		if(generationCriteria.relatedProperty.Property_Use_Type__c == PropertyDataAccessor.PROPERTY_USE_TYPE_HOMEOWNER
			&& OCCRPPropertyTypes.contains(generationCriteria.relatedProperty.Property_Type__c)
		){
			for(UP_Codes__c upCode : generationCriteria.relatedUPCodes){
				if(OC_CRP_UP_CODES.contains(upCode.UP_Code__c)){
					totalUpCodeAmount += upCode.Amount__c;
				}
			}
		}

		if(totalUpCodeAmount > 0){
			return new Loan_Condition_Checklist__c(
				Name = CONDOMINIUM_REPAIRS,
				Master_Checklist__c = oc_crp_MasterChecklist.Id,
				Application__c = generationCriteria.application.Id,
				Property__c = generationCriteria.relatedProperty.Id,
				Active__c = true
			);
		}
		return null;
	} 
}