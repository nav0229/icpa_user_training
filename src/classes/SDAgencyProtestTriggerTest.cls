@isTest
public with sharing class SDAgencyProtestTriggerTest {

	public testMethod static void insdata() {
		Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Suspension_and_Debarment_Case__c;
		Map<String, Schema.RecordTypeInfo> SDTypeInfo = cfrSchema.getRecordTypeInfosByName();

		Suspension_and_Debarment_Case__c SDC = new Suspension_and_Debarment_Case__c(
				id = null,
				recordtypeid = SDTypeInfo.get('Suspension and Debarment Case').getRecordTypeId()
		);

		Suspension_and_Debarment_Case__c SDC_RL = new Suspension_and_Debarment_Case__c();
		ApexPages.StandardController ctrl = new ApexPages.StandardController(SDC_RL);

		Agency_Protest_Case__c AP = new Agency_Protest_Case__c();
		ApexPages.StandardController ctrl1 = new ApexPages.StandardController(AP);

		Agency_Protest_Case__c AP2 = new Agency_Protest_Case__c();
		ApexPages.StandardController ctrl2 = new ApexPages.StandardController(AP2);

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
		Suspension_and_Debarment_Case__c Respins2 = new Suspension_and_Debarment_Case__c(
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
		system.assertNotEquals(NULL, Respins);

		Respins2.id = Respins.id;
		Respins2.ACA_Decision_Date__c = Date1;
		Respins2.Request_for_Information_Date__c = Date3;
		Respins2.Show_Cause_Letter_Date__c = Date3;
		Respins2.Suspension_Date__c = Date3;
		Respins2.Proposal_for_Debarment_Date__c = Date3;
		Respins2.Hearing_Date__c = Date3;
		Respins2.Other_Hearing_Dates__c = '1/1/2014,1/1/2016';
		Respins2.Debarment_ACA_Termination_Date__c = Date3;
		Respins2.Debarment_Decision_Date__c = Date3;
		Respins2.No_Action_Decision_Date__c = Date3;
		Respins2.ACA_Decision_Date__c = Date3;
		Respins2.Grounds_for_Debarment__c = 'Other;Theft';

		update Respins2;
		system.assertNotEquals(NULL, Respins2);

		AP.Protester__c = 'Joe Smith';
		AP.Region__c = '1';
		AP.Service__c = 'PBS';

		Date Date2 = date.newinstance(2015, 12, 19);
		Date DnGds3 = date.newinstance(2017, 11, 22);

		AP.Date_Protest_Received_by_Agency__c = DnGds3;
		AP.Decision_Grounds__c = 'Unduly Restrictive Solicitation;Unequal Treatment';
		AP.Actual_Decision_Date__c = Date3;

		insert AP;
		system.assertNotEquals(NULL, AP);

		AP2.id = AP.id;
		AP2.Protester__c = 'Ted Smith';
		AP2.Region__c = '2';
		AP2.Service__c = 'OAS';

		AP2.Date_Protest_Received_by_Agency__c = DnGds3;
		AP2.Decision_Grounds__c = 'Cancellation;Debriefing';
		AP2.Actual_Decision_Date__c = Date3;

		update AP2;
		system.assertNotEquals(NULL, AP2);

		system.assertNotEquals(NULL, SDC);
		system.assertNotEquals(NULL, SDC_RL);
		SDRespondentListController rl = new SDRespondentListController(ctrl);
	}

}