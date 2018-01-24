/****************************************************************
 Name:  PropertyEligibility
============================================================
Author: Matt
Purpose: JIRA#2210 (1464, 1465, 1466)
Class the handles the Property Eligibility Test
============================================================

****************************************************************/

public with sharing class PropertyEligibility {
	public PropertyEligibility() {}

	private static final Set<String> NOT_ELIGIBLE_PROPERTY_TYPES = new Set<String>{'CO-OP', 'Boat (Not Registered with Coast Guard)', 'Vessel (Registered with Coast Guard)', 'Vacant Land'};

	public Processing_Application_Review__c runPropertyTest(Processing_Application_Review__c par, List<Property__c> damagedProperties, List<IRS_Transcripts__c> irsTranscripts, List<Credit_Bureau__c> creditBureaus, List<Loss_Verification_Inspections__c> lossVerifications, List<Other_Assistance__c> otherAssistances) {
		par.Property_Eligibility_Test_Time__c = System.now();		

		if(isAnyObjectEmpty(damagedProperties, irsTranscripts, creditBureaus, lossVerifications, otherAssistances)){
			return par;
		}

		par.Damaged_Property_Owned_by_Applicants__c = isPropertyOwnedByApplicants(damagedProperties);
		par.Primary_Residence__c = isPropertyThePrimaryResidence(damagedProperties);
		par.Damaged_Address_IRS_CBR_Match__c = doesPropertyAddressMatchIRSorCBR(damagedProperties, irsTranscripts, creditBureaus);
		par.NEMIS_Primary__c = doesPrimaryPropertyAddressMatchNEMIS(damagedProperties, otherAssistances);
		par.Property_NIFRA_Compliant__c = isPropertyNEMIScompliant(otherAssistances);
		par.Sanctioned_Community__c = isPropertyNotInSanctionedCommunity(lossVerifications);
		par.CBRA_or_OPA__c = isPropertyNotCBRAorOPAcompliant(lossVerifications);
		par.Damaged_Property_Type_Eligibility__c = isPropertyAnEligibleType(lossVerifications);
		
		return par;
	}

	private Boolean isAnyObjectEmpty(List<Property__c> damagedProperties, List<IRS_Transcripts__c> irsTranscripts, List<Credit_Bureau__c> creditBureaus, List<Loss_Verification_Inspections__c> lossVerifications, List<Other_Assistance__c> otherAssistances) {
		if(damagedProperties.isEmpty() || irsTranscripts.isEmpty() || creditBureaus.isEmpty() || lossVerifications.isEmpty() || otherAssistances.isEmpty()) {
			return true;
		}

		return false;
	}

	private String isPropertyOwnedByApplicants(List<Property__c> damagedProperties) {
		for(Property__c damagedProperty : damagedProperties) {
			if(damagedProperty.Owned_By_Applicant__c != 'Yes') {
				return 'Fail';
			}   
		}

		return 'Pass';
	}

	private String isPropertyThePrimaryResidence(List<Property__c> damagedProperties) {
		for(Property__c damagedProperty : damagedProperties) {
			if(damagedProperty.Primary_Residence__c == 'True') {
				return 'Pass';
			}
		}

		return 'Fail';
	}

	private String doesPropertyAddressMatchIRSorCBR(List<Property__c> damagedProperties, List<IRS_Transcripts__c> irsTranscripts, List<Credit_Bureau__c> creditBureaus) {
		for(Property__c damagedProperty : damagedProperties) {
			if( damagedProperty.Property_Address__c != null ||
				damagedProperty.City__c != null ||
				damagedProperty.State__c != null ||
				damagedProperty.Zip_Code__c != null) {

				for(IRS_Transcripts__c irsTranscript : irsTranscripts) {
					if(damagedProperty.Property_Address__c == irsTranscript.Address__c &&
					   damagedProperty.City__c == irsTranscript.City__c &&
					   damagedProperty.State__c == irsTranscript.State__c &&
					   damagedProperty.Zip_Code__c == irsTranscript.Zip_Code__c ) {

						return 'Pass';
					}
				}

				for(Credit_Bureau__c creditBureau : creditBureaus) {

					if(damagedProperty.Property_Address__c == creditBureau.Mailing_Address__c &&
					   damagedProperty.City__c == creditBureau.City__c &&
					   damagedProperty.State__c == creditBureau.State__c &&
					   damagedProperty.Zip_Code__c == creditBureau.Zip_Code__c ) {

						return 'Pass';
					}
				}
			}		
		}

		return 'Fail';
	}

	private String doesPrimaryPropertyAddressMatchNEMIS(List<Property__c> damagedProperties, List<Other_Assistance__c> otherAssistances) {
		String primaryAddress = null;

		for(Property__c damagedProperty : damagedProperties) {
			if(damagedProperty.Primary_Residence__c == 'True') {
				primaryAddress = damagedProperty.Property_Address__c;
			}
		}

		for(Other_Assistance__c otherAssistance : otherAssistances) {
			if(primaryAddress != null) {
				if(otherAssistance.Damaged_Property_Address__c.contains(primaryAddress)) {
					return 'Pass';
				}
			}
		}

		return 'Fail';
	}

	private String isPropertyNEMIScompliant(List<Other_Assistance__c> otherAssistances) {
		for(Other_Assistance__c otherAssistance : otherAssistances) {
			if(otherAssistance.NFIRA_Compliant__c != 'Yes') {
				return 'Fail';
			}
		}

		return 'Pass';
	}

	private String isPropertyNotInSanctionedCommunity(List<Loss_Verification_Inspections__c> lossVerifications) {
		for(Loss_Verification_Inspections__c lv : lossVerifications) {
			if((lv.Flood_Zone__c != 'A' || lv.Flood_Zone__c != 'V') && lv.Sanctioned_Community__c == 'No') {
				return 'Pass';
			}else if((lv.Flood_Zone__c == 'A' || lv.Flood_Zone__c == 'V') && lv.Sanctioned_Community__c == 'Yes') {
				return 'Fail';
			}
		}

		return '';
	}

	private String isPropertyNotCBRAorOPAcompliant(List<Loss_Verification_Inspections__c> lossVerifications) {
		for(Loss_Verification_Inspections__c lv : lossVerifications) {
			if(lv.CBRA_Compliant__c == 'No' && lv.OPA_Compliant__c == 'No') {
				return 'Pass';
			}else if(lv.CBRA_Compliant__c == 'Yes' && lv.OPA_Compliant__c == 'Yes') {
				return 'Fail';
			}
		}

		return '';
	}

	private String isPropertyAnEligibleType(List<Loss_Verification_Inspections__c> lossVerifications) {
		for(Loss_Verification_Inspections__c lv : lossVerifications) {
			if(NOT_ELIGIBLE_PROPERTY_TYPES.contains(lv.Property_Type__c)) {
				return 'Fail';
			}
		}   

		return 'Pass';
	}
}