@isTest
public with sharing class SDRespondentListControllerTest {

	public testMethod static void testOwnerChange_RecordOwnerChangesOwner_OwnerChangeSuccessful(){
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

		sdCase.OwnerId = otherAdmin.Id;
		update sdCase;

		System.assertEquals(sdCase.OwnerId, otherAdmin.Id);
	}

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

	public testMethod static void testSDRespondentListController_SDCaseGivenWithOwner_StatusReplacedIOandIntegrityWithUserName(){
		Suspension_and_Debarment_Case__c sdCase = new Suspension_and_Debarment_Case__c();
		sdCase.Respondent_Name__c = 'John Smith';
		sdCase.Case_Closed__c = 'Yes';
		sdCase.Suspension_Date__c = Date.newInstance(2017,1,1);
		sdCase.Proposal_for_Debarment_Date__c = Date.newInstance(2017,1,1);
		sdCase.Debarment_Decision_Date__c = Date.newInstance(2017,1,1);
		sdCase.Comments_for_SDO__c = 'Comments';
		sdCase.Lead_Agency__c = 'Test Agency';
		sdCase.Case_Status__c = 'IO';
		insert sdCase;

		Suspension_and_Debarment_Case__c sdCase2 = new Suspension_and_Debarment_Case__c();
		sdCase2.General_Case_Information__c = sdCase.Id;
		sdCase2.Respondent_Name__c = 'John Smith';
		sdCase2.Case_Closed__c = 'No';
		sdCase2.Suspension_Date__c = Date.newInstance(2017,1,1);
		sdCase2.Proposal_for_Debarment_Date__c = Date.newInstance(2017,1,1);
		sdCase2.Debarment_Decision_Date__c = Date.newInstance(2017,1,1);
		sdCase2.Comments_for_SDO__c = 'Comments';
		sdCase2.Case_Status__c = 'IO';
		insert sdCase2;
        
        Suspension_and_Debarment_Case__c sdCase3 = new Suspension_and_Debarment_Case__c();
		sdCase3.General_Case_Information__c = sdCase.Id;
		sdCase3.Respondent_Name__c = 'Kate Smith';
		sdCase3.Case_Closed__c = 'No';
		sdCase3.Suspension_Date__c = Date.newInstance(2017,1,1);
		sdCase3.Proposal_for_Debarment_Date__c = Date.newInstance(2017,1,1);
		sdCase3.Debarment_Decision_Date__c = Date.newInstance(2017,1,1);
		sdCase3.Comments_for_SDO__c = 'Comments';
		sdCase3.Case_Status__c = 'Integrity Officer';
		insert sdCase3;

		ApexPages.StandardController standardController = new ApexPages.StandardController(sdCase);
		SDRespondentListController customController = new SDRespondentListController(standardController);

		System.assert(!customController.RespondentLineItems.get(0).caseStatus.contains('IO'));
        System.assert(!customController.RespondentLineItems.get(0).caseStatus.contains('Integrity Officer'));
	}
}