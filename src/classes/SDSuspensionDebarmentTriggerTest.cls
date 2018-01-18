@isTest
public with sharing class SDSuspensionDebarmentTriggerTest {

	public testMethod static void testOwnerChange_AdminChangesOwner_OwnerChangeSuccessful(){
		Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Suspension_and_Debarment_Case__c;
		Map<String, Schema.RecordTypeInfo> SDTypeInfo = cfrSchema.getRecordTypeInfosByName();

		Suspension_and_Debarment_Case__c SDC = new Suspension_and_Debarment_Case__c(
				id = null,
				recordtypeid = SDTypeInfo.get('Suspension and Debarment Case').getRecordTypeId()
		);

		Suspension_and_Debarment_Case__c SDC_RL = new Suspension_and_Debarment_Case__c();
		ApexPages.StandardController ctrl = new ApexPages.StandardController(SDC_RL);

		SDC.Case_Name__c = 'New Test Case';

		Date RecDate = date.newinstance(2015, 22, 15);
		Date TransDate = date.newinstance(2016, 1, 11);

		SDC.Date_Record_Complete__c= Date.today();
		SDC.SDO_Received_Date__c = RecDate;
		SDC.Basis__c = 'Primary Basis Judicial';
		SDC.Direct_Imputed_Affiliated__c = 'Direct';
		SDC.Lead_Agency_Determination_Necessary__c = 'Yes' ;
		SDC.Lead_Agency__c = 'Test Agency';
		SDC.Date_of_Transfer__c = TransDate;

		insert SDC;

		Suspension_and_Debarment_Case__c Respins = new Suspension_and_Debarment_Case__c(
				id = null,
				recordtypeid = SDTypeInfo.get('Suspension and Debarment Respondent').getRecordTypeId()
		);

		Respins.General_Case_Information__c = SDC.id;
		Respins.Respondent_Name__c = 'Smith, John';
		Respins.Business__c = 'Individual';

		Date Date1 = date.newinstance(2015, 12, 11);
		Date Date3 = date.newinstance(2016, 2, 24);

		Respins.Lead_Agency_Action__c = 'Create';
		Respins.Lead_Agency_Action_Date__c = Date1;
		Respins.ACA_Decision_Date__c = Date1;
		Respins.Debarment_ACA_Termination_Date__c = Date3;
		Respins.Request_for_Information_Date__c = Date3;
		Respins.Show_Cause_Letter_Date__c = Date3;
		Respins.Suspension_Date__c = Date3;
		Respins.Proposal_for_Debarment_Date__c = Date3;
		Respins.Hearing_Date__c = Date3;
		Respins.Other_Hearing_Dates__c = '1/1/2014,1/1/2016';
		Respins.Debarment_ACA_Termination_Date__c = Date3;
		Respins.Debarment_Decision_Date__c = Date3;
		Respins.No_Action_Decision_Date__c = Date3;
		Respins.ACA_Decision_Date__c = Date3;
		Respins.Grounds_for_Debarment__c = 'Other;Theft';
		Respins.Grounds_for_Debarment_Other__c = 'Something';

		insert Respins;

		Suspension_and_Debarment_Case__c sdCase = [SELECT Id, OwnerId, Owner.Name FROM Suspension_and_Debarment_Case__c WHERE Id = :Respins.Id];

		Id adminProfileId = [SELECT Id FROM Profile WHERE Name = 'GSA System Administrator'].Id;
		User otherAdmin = [SELECT Id FROM User WHERE ProfileId = :adminProfileId AND IsActive = true AND Id != :UserInfo.getUserId() LIMIT 1];

		System.runAs(otherAdmin){
			sdCase.OwnerId = otherAdmin.Id;
			update sdCase;
		}

		System.assertEquals(sdCase.OwnerId, otherAdmin.Id);
	}

}