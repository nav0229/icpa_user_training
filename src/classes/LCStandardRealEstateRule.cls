/****************************************************************
 Name: LCStandardRealEstateRule
============================================================
Author: Lenny
Purpose: DCMM-2138
	Loan Condition Rule to determine whether automated
	Standard Real Estate Loan Condition Checklist should be created
============================================================

****************************************************************/
public class LCStandardRealEstateRule implements LoanConditionRuleInterface {
	private final String STANDARD_REAL_ESTATE = 'Standard Real Estate';
	private final Set<String> RE_STD_UP_CODES = new Set<String>{
		'UP-00','UP-04','UP-17','UP-18','UP-19','UP-25','UP-26','UP-41','UP-43','UP-44','UP-45','UP-53'
	};

	public Loan_Condition_Checklist__c applyRuleAndCreateLoanCondition(LoanConditionGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Master_Checklist__c re_std_MasterChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.STANDARD_REAL_ESTATE_CODE);
		
		Decimal totalUpCodeAmount = 0;
		for(UP_Codes__c upCode : generationCriteria.relatedUPCodes){
			if(RE_STD_UP_CODES.contains(upCode.UP_Code__c)){
				totalUpCodeAmount += upCode.Amount__c;
			}
		}

		if(totalUpCodeAmount > 0){
			return new Loan_Condition_Checklist__c(
				Name = STANDARD_REAL_ESTATE,
				Master_Checklist__c = re_std_MasterChecklist.Id,
				Application__c = generationCriteria.application.Id,
				Active__c = true
			);
		}
		return null;
	}
}