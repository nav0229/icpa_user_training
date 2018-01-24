/****************************************************************
 Name: LossVerificationDataAccessor
============================================================
Author: 
Purpose: Data Accessor for Loss_Verification_Inspections__c
============================================================

****************************************************************/

public with sharing class LossVerificationDataAccessor implements LossVerificationDAO  {

	private final String LOSS_VERIFICATION = 'Loss_Verification_Inspections__c';

	private Set<String> lossVerificationFields;

	public LossVerificationDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.lossVerificationFields = schemaMap.get(LOSS_VERIFICATION).getDescribe().fields.getMap().keySet();
	}

	public List<Loss_Verification_Inspections__c> getLossVerificationsByLoanIds(Set<Id> loanIds){
		QueryBuilder lossVerificationQueryBuilder = new QueryBuilder(LOSS_VERIFICATION);
		lossVerificationQueryBuilder.addSelectField(this.lossVerificationFields);
		lossVerificationQueryBuilder.addWhereCondition('Loan__c', new List<Id>(loanIds), QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(lossVerificationQueryBuilder.generateQuery());
	}

	public List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationIds(Set<Id> applicationIds){
		return new List<Loss_Verification_Inspections__c>([
			SELECT 	Id, 
					Contents_Verified_Loss__c, 
					Motor_Vehicle_Verified_Loss__c, 
					Real_Estate_Verified_Loss__c, 
					Verified_Loss_for_Landscape__c,
					Total_Verified_Loss__c
			FROM 	Loss_Verification_Inspections__c
			WHERE 	Property__c IN :[SELECT Id FROM Property__c WHERE Application__c IN :applicationIds]
		]);
	}

	public List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationId(Id applicationId){
		return new List<Loss_Verification_Inspections__c>([
			SELECT 	Id, 
					Contents_Verified_Loss__c, 
					Motor_Vehicle_Verified_Loss__c, 
					Real_Estate_Verified_Loss__c, 
					Verified_Loss_for_Landscape__c,
					Total_Verified_Loss__c
			FROM 	Loss_Verification_Inspections__c
			WHERE 	Property__c IN :[SELECT Id FROM Property__c WHERE Application__c = :applicationId]
		]);
	}

	public List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationId(Id applicationId){
		return new List<Loss_Verification_Inspections__c>([
			SELECT 	Id, 
					Property__r.Application__r.RecordType.Name,
					Property__c,
					Property__r.Property_Use_Type__c,
					Property__r.Property_Type__c,
					(SELECT Id, 
							UP_Code__c,
							Amount__c 
					FROM UP_Codes__r
                    WHERE Amount__c > 0) 
			FROM Loss_Verification_Inspections__c 
			WHERE Property__r.Application__c =:applicationId 
		]);
	}

	public List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationIds(List<Id> applicationIds){
		return new List<Loss_Verification_Inspections__c>([
			SELECT 	Id,
					Property__r.Application__r.RecordType.Name,
					Property__c,
					Property__r.Property_Use_Type__c,
					Property__r.Property_Type__c,
					(SELECT Id,
							UP_Code__c,
							Amount__c,
							New_Category__c
					FROM UP_Codes__r
                    WHERE Amount__c > 0)
			FROM Loss_Verification_Inspections__c
			WHERE Property__r.Application__c IN :applicationIds
		]);
	}
}