public without sharing class SDAgencyProtestTriggerHelper {

	public static void updateIntegrityOfficerToCurrentLoggedInUserIfBlank(List<Agency_Protest_Case__c> apCaseList) {
		for(Agency_Protest_Case__c apCase : apCaseList) {
			if(apCase.Case_Status__c == null) {
				apCase.Case_Status__c = 'Pending Initial IO Review';
			}
		}
	}

	public static void deleteAllCorrespondingRecordsOfAPOData(List<Agency_Protest_Case__c> apCaseList) {
		Set<Id> APids = new Set<Id>();
		for(Agency_Protest_Case__c AP : apCaseList) {
			APids.add(AP.Id);
		}
		delete [
				SELECT Id
				from APO_Data__c
				where Protestor_ID__c IN :APids
		];
	}

	public static void insertRecordsIntoAPODataObjectWithDecisionGroundsAndActualDecisionDate(List<Agency_Protest_Case__c> apCaseList) {
		List<APO_Data__c> lstAPOData = new List<APO_Data__c>();
		String strGovFiscalYear;

		for(Agency_Protest_Case__c AP : apCaseList) {
			if(AP.Decision_Grounds__c != null) {
				List<String> DecnGroundsValues = AP.Decision_Grounds__c.split(';'); // Split to get the individual Decision_Grounds__c values

				for(String DecnGrounds : DecnGroundsValues) {
					APO_Data__c APOData = new APO_Data__c();
					APOData.Protestor_ID__c = AP.Id;
					APOData.Reason__c = DecnGrounds;
					if(AP.Actual_Decision_Date__c != null) {
						strGovFiscalYear = String.valueOf(AP.Actual_Decision_Date__c.addDays(92).year());
						APOData.Government_Fiscal_Year__c = strGovFiscalYear ;
					}
					if(AP.Decision_Grounds__c != null && strGovFiscalYear != null) {
						lstAPOData.add(APOData);
					}
				}
			}
		}
		insert lstAPOData;
	}

}