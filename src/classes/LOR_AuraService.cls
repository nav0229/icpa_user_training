/****************************************************************
 Name: LOR_AuraService
============================================================
Author:
Purpose: LOR for Aura Service
============================================================

****************************************************************/
public with sharing class LOR_AuraService {

	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static ApplicantDAO applicantDA = new ApplicantDataAccessor();
	@TestVisible private static DisasterDAO disasterDA = new DisasterDataAccessor();
	@TestVisible private static LoanDAO loanDA = new LoanDataAccessor();
	@TestVisible private static PropertyDAO propertyDA = new PropertyDataAccessor();
	@TestVisible private static AssetIncomesDAO assetIncomesDA = new AssetIncomesDataAccessor();
	@TestVisible private static IRSTranscriptsDAO irsTranscriptsDA = new IRSTranscriptsDataAccessor();
	@TestVisible private static InsuranceDAO insuranceDA = new InsuranceDataAccessor();
	@TestVisible private static ProcessingApplicationReviewDAO processingApplicationReviewDA = new ProcessingApplicationReviewDataAccessor();
	@TestVisible private static OtherAssistanceDAO otherAssistanceDA = new OtherAssistanceDataAccessor();

	@AuraEnabled
	public static Application__c getApplicationById(Id applicationId){
		try {
			return applicationDA.getApplicationById(applicationId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Applicant__c> getApplicantsAndRelatedContactsByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Applicant__c>();
			}
			return applicantDA.getApplicantsAndRelatedContactsByApplicationId(applicationId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Loan__c> getLoansByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Loan__c>();
			}
			return loanDA.getLoansByApplicationId(applicationId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static Disaster__c getDisasterById(Id disasterId){
		try {
			return disasterDA.getDisasterById(disasterId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Property__c>();
			}
			return propertyDA.getDamagedPropertiesAndLossVerificationsByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Asset_Incomes__c> getAssetIncomesByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Asset_Incomes__c>();
			}
			return assetIncomesDA.getAssetIncomesByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<IRS_Transcripts__c> getIRSTranscriptsByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<IRS_Transcripts__c>();
			}
			return irsTranscriptsDA.getIRSTranscriptsByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Insurance__c> getActiveInsurancePoliciesByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Insurance__c>();
			}
			return insuranceDA.getActiveInsuranceByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Processing_Application_Review__c> getProcessingApplicationReviewsByApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Processing_Application_Review__c>();
			}
			return processingApplicationReviewDA.getProcessingApplicationReviewsByAppIds(new List<Id>{applicationId});
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Processing_Application_Review__c> getProcessingApplicationReviewByProcessingApplicationReviewId(Id parId) {
		try {
			if(parId == null){
				return new List<Processing_Application_Review__c>();
			}
			return processingApplicationReviewDA.getProcessingApplicationReviewsByProcessingApplicationReviewIds(new List<Id>{parId});
		}
		catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Other_Assistance__c> getOtherAssistancebyApplicationId(Id applicationId){
		try {
			if(applicationId == null){
				return new List<Other_Assistance__c>();
			}
			return otherAssistanceDA.getOtherAssistancebyApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static Processing_Application_Review__c updateProcessingApplicationReview(Processing_Application_Review__c par) {
		try {
			processingApplicationReviewDA.updateProcessingApplicationReviews(new List<Processing_Application_Review__c>{par});
			return par;
		}
		catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<String> getPicklistOptions(String sObjectDevName, String fieldDevName){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		List<Schema.PicklistEntry> picklistEntries = schemaMap.get(sObjectDevName).getDescribe().fields.getMap().get(fieldDevName).getDescribe().getPicklistValues();

		List<String> picklistOptions = new List<String>();
		for(Schema.PicklistEntry entry : picklistEntries){
			picklistOptions.add(entry.getLabel());
		}
		return picklistOptions;
	}
}