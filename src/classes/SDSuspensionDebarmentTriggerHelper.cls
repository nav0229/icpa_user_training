public with sharing class SDSuspensionDebarmentTriggerHelper {

	public static void updateIntegrityOfficerOnSuspensionAndDebarmentCaseRecords(List<Suspension_and_Debarment_Case__c> sdCaseList){

		String strSDRecordType = SDProjectConstants.RECORDTYPEID_SUSPENSIONDEBARMENTCASE;

		for(Suspension_and_Debarment_Case__c SDC1 : sdCaseList) {
			if(SDC1.RecordTypeid == strSDRecordType) {
				if(SDC1.OwnerId == null) {
					SDC1.OwnerId = UserInfo.getUserId();
				}

			}
			if(SDC1.Case_Status__c == null) {
				SDC1.Case_Status__c = 'Pending Initial IO Review';
			}
		}
	}

	public static void makeFieldsRequiredWhenLeadAgencyIsGSA(List<Suspension_and_Debarment_Case__c> sdCaseList){

		Map<Id, Suspension_and_Debarment_Case__c> parentSDsToRespondentSDsMap = getParentSDCasesMap(sdCaseList);

		if(parentSDsToRespondentSDsMap.isEmpty()) {
			return;
		}


		for(Suspension_and_Debarment_Case__c sdCase : sdCaseList){

			if(		parentSDsToRespondentSDsMap.get(sdCase.General_Case_Information__c) != null &&
					parentSDsToRespondentSDsMap.get(sdCase.General_Case_Information__c).Lead_Agency__c == 'General Services Administration'){

				if(sdCase.Basis__c == null || sdCase.Business__c == null || sdCase.Direct_Imputed_Affiliated__c == null){
					sdCase.addError(SDProjectConstants.ERROR_MSG_TRIGGER_FIELDS_REQUIRED_WHEN_GSA);
				}

			}

		}
	}

	public static void add45BusinessDaysToCompletionDate(
			Boolean isUpdate,
			Map<Id, Suspension_and_Debarment_Case__c> oldSDCaseMap,
			List<Suspension_and_Debarment_Case__c> newSDCaseList){

		Id businessHoursId = [SELECT Id FROM BusinessHours WHERE Name = :SDProjectConstants.BUSINESSHOURS_NAME].Id;

		for(Suspension_and_Debarment_Case__c sdCase : newSDCaseList) {  // using acronym 'sd' for Suspension & Debarment
			if(sdCase.Date_Record_Complete__c != null){
				Time t = Time.newInstance(SDProjectConstants.START_TIME_HOUR,0,0,0); // needs to start at same time as their business hours (7:00 AM as of 5/3/2017)
				DateTime completionDateTime = DateTime.newInstance(sdCase.Date_Record_Complete__c, t);
				DateTime resultingDateTime = BusinessHours.add(
						businessHoursId,
						completionDateTime,
						SDProjectConstants.NUM_MILLISECONDS_PAST_COMPLETION
				);
				sdCase.ARM_45_Day_Date__c = resultingDateTime.date();
			} else {
				if(isUpdate && oldSDCaseMap.get(sdCase.Id).Date_Record_Complete__c != null){
					sdCase.ARM_45_Day_Date__c = null;
				}
			}
		}
	}

	public static void verifyUserAllowedToChangeOwner(
			Map<Id, Suspension_and_Debarment_Case__c> oldSDCaseMap,
			List<Suspension_and_Debarment_Case__c> newSDCaseList){

		Id adminProfileId = [
				SELECT Id
				FROM Profile
				WHERE
						Name = :SDProjectConstants.GSA_ADMIN_PROFILE_NAME
		].Id;

		Id superUserPSetId = [
				SELECT Id
				FROM PermissionSet
				WHERE
						Name = :SDProjectConstants.PSET_SUPER_USER
		].Id;

		List<PermissionSetAssignment> superUserPSetAssignmentList = [
				SELECT Id
				FROM PermissionSetAssignment
				WHERE
				PermissionSetId = :superUserPSetId
				AND	AssigneeId = :UserInfo.getUserId()
		];

		for(Suspension_and_Debarment_Case__c newSdCase : newSDCaseList){
			Id oldOwner = oldSDCaseMap.get(newSdCase.Id).OwnerId;
			Id newOwner = newSdCase.OwnerId;
			if(oldOwner != newOwner){
				if(!userAllowedToChangeOwner(oldOwner, adminProfileId, superUserPSetAssignmentList)){
					newSdCase.addError(SDProjectConstants.ERROR_MSG_OWNER_CHANGE_WITHOUT_PERMISSION);
				}
			}
		}
	}

	public static void updateDestructionDateAndInsertIntoSandDDataObject(List<Suspension_and_Debarment_Case__c> sdCaseList){
		//Begin Update the "Destruction Date" on the master case, when a "Respondent" record is updated.
		String strRespondentRecordType = Schema.SObjectType.Suspension_and_Debarment_Case__c.getRecordTypeInfosByName().get('Suspension and Debarment Respondent').getRecordTypeId();
		Set<String> MasterIDsToUpdate = new Set<string>();
		List<Suspension_and_Debarment_Case__c> ListOfMasterTobeUpdated = new list<Suspension_and_Debarment_Case__c>();

		for(Suspension_and_Debarment_Case__c objRecord: sdCaseList) {
			if(objRecord.RecordTypeid == strRespondentRecordType) {
				if(objRecord.General_Case_Information__c == null){
					continue;
				}
				MasterIDsToUpdate.add(objRecord.General_Case_Information__c);
			}
		}

		AggregateResult[] MasterDestructionDate = [
				SELECT General_Case_Information__c, Max(SD_Destruction_Date__c) DestructionDate
				FROM Suspension_and_Debarment_Case__c
				WHERE General_Case_Information__c in :MasterIDsToUpdate
				Group By General_Case_Information__c
		];

		for(AggregateResult RowData : MasterDestructionDate) {
			ListOfMasterTobeUpdated.Add(new Suspension_and_Debarment_Case__c(
					ID = (ID) RowData.get('General_Case_Information__c'),
					SD_RecType_Destruction_Date__c = (Date) RowData.get('DestructionDate'))
			);
		}

		try {
			Update ListOfMasterTobeUpdated;
		} catch (DmlException e){
			// record is locked due to approval
		}
		//End

		//Begin Insert records into S&D Data object
		List<S_D_Data__c> lstSDData = new List<S_D_Data__c>();
		String strGovFYearFinalAction;
		String strGovFYearActions;
		string strRespRecordType1 = Schema.SObjectType.Suspension_and_Debarment_Case__c.getRecordTypeInfosByName().get('Suspension and Debarment Respondent').getRecordTypeId();
		Date OtherHearingdate;

		for(Suspension_and_Debarment_Case__c SDResp : sdCaseList) {
			if(SDResp.RecordTypeid == strRespRecordType1) {

				//insert records for Grounds for Debarment under Reason with Debarment Date FY
				if(SDResp.Debarment_Decision_Date__c != null) {
					strGovFYearFinalAction = String.valueOf(SDResp.Debarment_Decision_Date__c.addDays(92).year());
				}

				if(SDResp.Grounds_for_Debarment__c != null) {
					List<String> GroundsDebarValues = SDResp.Grounds_for_Debarment__c.split(';'); // Split to get the individual Grounds_for_Debarment__c values

					for(String GroundsDebar : GroundsDebarValues) {
						S_D_Data__c SDData = new S_D_Data__c();
						SDData.Respondent_ID__c = SDResp.Id;
						SDData.Action_Reason__c = GroundsDebar;
						SDData.Report_Category__c = 'Reason';
						SDData.Government_Fiscal_Year__c = strGovFYearFinalAction;

						if(SDResp.Grounds_for_Debarment__c != null && strGovFYearFinalAction != null) {
							lstSDData.add(SDData);
						}
					}
				}
				//End for Reason records

				//Insert S&D Data record for Action for dates under SDO Actions section
				//insert Requests for Information
				if(SDResp.Request_for_Information_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Request_for_Information_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataRof = new S_D_Data__c();
				SDDataRof.Respondent_ID__c = SDResp.Id;
				SDDataRof.Action_Reason__c = 'Requests for Information';
				SDDataRof.Report_Category__c = 'Action';
				SDDataRof.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataRof);
				}
				//insert Show Cause Letters
				strGovFYearActions = null;
				if(SDResp.Show_Cause_Letter_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Show_Cause_Letter_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataScl = new S_D_Data__c();
				SDDataScl.Respondent_ID__c = SDResp.Id;
				SDDataScl.Action_Reason__c = 'Show Cause Letters';
				SDDataScl.Report_Category__c = 'Action';
				SDDataScl.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataScl);
				}
				//insert Suspensions
				strGovFYearActions = null;
				if(SDResp.Suspension_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Suspension_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataS = new S_D_Data__c();
				SDDataS.Respondent_ID__c = SDResp.Id;
				SDDataS.Action_Reason__c = 'Suspensions';
				SDDataS.Report_Category__c = 'Action';
				SDDataS.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataS);
				}
				//insert Proposals for Debarment
				strGovFYearActions = null;
				if(SDResp.Proposal_for_Debarment_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Proposal_for_Debarment_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataPod = new S_D_Data__c();
				SDDataPod.Respondent_ID__c = SDResp.Id;
				SDDataPod.Action_Reason__c = 'Proposals for Debarment';
				SDDataPod.Report_Category__c = 'Action';
				SDDataPod.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataPod);
				}
				//insert Hearings
				strGovFYearActions = null;
				if(SDResp.Hearing_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Hearing_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataH = new S_D_Data__c();
				SDDataH.Respondent_ID__c = SDResp.Id;
				SDDataH.Action_Reason__c = 'Hearings';
				SDDataH.Report_Category__c = 'Action';
				SDDataH.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataH);
				}

				// insert Other Hearing Dates
				strGovFYearActions = null;
				if(SDResp.Other_Hearing_Dates__c != null) {
					List<String> OtherHearingValues = SDResp.Other_Hearing_Dates__c.split(','); // Split to get the individual Other_Hearing_Dates__c values

					for(String OtherHearing : OtherHearingValues) {
						if(OtherHearing != null) {
							try {
								OtherHearingdate = date.parse(OtherHearing);
								strGovFYearActions = String.valueOf(OtherHearingdate.addDays(92).year());
							} catch(Exception e) {
								SDResp.adderror('Invalid Other Hearing Dates, enter comma separated values in mm/dd/yyyy format.');
							}
						}
						S_D_Data__c SDDataOtherH = new S_D_Data__c();
						SDDataOtherH.Respondent_ID__c = SDResp.Id;
						SDDataOtherH.Action_Reason__c = 'Hearings';
						SDDataOtherH.Report_Category__c = 'Action';
						SDDataOtherH.Government_Fiscal_Year__c = strGovFYearActions;

						if(OtherHearing != null && strGovFYearActions != null) {
							lstSDData.add(SDDataOtherH);
						}
					}
				}

				strGovFYearActions = null;
				if(SDResp.Early_Termination_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Early_Termination_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataT2 = new S_D_Data__c();
				SDDataT2.Respondent_ID__c = SDResp.Id;
				SDDataT2.Action_Reason__c = 'Terminations';
				SDDataT2.Report_Category__c = 'Action';
				SDDataT2.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataT2);
				}

				strGovFYearActions = null;
				if(SDResp.Terminate_Preliminary_Action_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Terminate_Preliminary_Action_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataT3 = new S_D_Data__c();
				SDDataT3.Respondent_ID__c = SDResp.Id;
				SDDataT3.Action_Reason__c = 'Terminations';
				SDDataT3.Report_Category__c = 'Action';
				SDDataT3.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataT3);
				}

				//insert Debarments
				strGovFYearActions = null;
				if(SDResp.Debarment_Decision_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.Debarment_Decision_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataD = new S_D_Data__c();
				SDDataD.Respondent_ID__c = SDResp.Id;
				SDDataD.Action_Reason__c = 'Debarments';
				SDDataD.Report_Category__c = 'Action';
				SDDataD.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataD);
				}
				//insert No Actions
				strGovFYearActions = null;
				if(SDResp.No_Action_Decision_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.No_Action_Decision_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataNoAct = new S_D_Data__c();
				SDDataNoAct.Respondent_ID__c = SDResp.Id;
				SDDataNoAct.Action_Reason__c = 'No Actions';
				SDDataNoAct.Report_Category__c = 'Action';
				SDDataNoAct.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataNoAct);
				}
				//insert Administrative Compliance Agreements
				strGovFYearActions = null;
				if(SDResp.ACA_Decision_Date__c != null) {
					strGovFYearActions = String.valueOf(SDResp.ACA_Decision_Date__c.addDays(92).year());
				}
				S_D_Data__c SDDataAdCompAgr = new S_D_Data__c();
				SDDataAdCompAgr.Respondent_ID__c = SDResp.Id;
				SDDataAdCompAgr.Action_Reason__c = 'Administrative Compliance Agreements';
				SDDataAdCompAgr.Report_Category__c = 'Action';
				SDDataAdCompAgr.Government_Fiscal_Year__c = strGovFYearActions;
				if(strGovFYearActions != null) {
					lstSDData.add(SDDataAdCompAgr);
				}
			}
		}
		//Insert S&D Data records
		try{
			insert lstSDData;
		} catch (System.DMLException e){
			//put error handling here
		}
		
		//End
	}

	public static void deleteAllCorrespondingSandDDataRecordsExceptLeadAgencyTransfers(List<Suspension_and_Debarment_Case__c> sdCaseList){
		Date chkOtherHearingdate;
		String chkstrGovFYearActions;
		String strRespRecordType = SDProjectConstants.RECORDTYPEID_SUSPENSIONDEBARMENTRESPONDENT;
		Set<Id> SDRespids = new Set<Id>();

		for(Suspension_and_Debarment_Case__c SDResp : sdCaseList) {
			if(SDResp.RecordTypeid == strRespRecordType) {
				SDRespids.add(SDResp.Id);
			}
		}

		try{
			delete [
					SELECT Id
					from S_D_Data__c
					where Respondent_ID__c IN :SDRespids
					and Action_Reason__c <> 'Lead Agency Transfers'
			];
		}
		catch (System.DMLException e){
			//put error handling here
		}

		//insert corresponding S&D Data records for Lead Agency Transfers to Respondents
		string strSDRecordType = SDProjectConstants.RECORDTYPEID_SUSPENSIONDEBARMENTCASE;
		Set<Id> SDids = new Set<Id>();
		string strGovFYearDot;

		//get Master Id and Date of Transfer FY
		for(Suspension_and_Debarment_Case__c SDMaster : sdCaseList) {
			if(SDMaster.RecordTypeid == strSDRecordType) {
				SDids.add(SDMaster.Id);
				if(SDMaster.Date_of_Transfer__c != null) {
					strGovFYearDot = String.valueOf(SDMaster.Date_of_Transfer__c.addDays(92).year());
				}
			}
		}
		//delete existing S&D Data records for Lead Agency Transfers to Respondents
		Set<Id> SDDataoldids = new Set<Id>();
		List<Suspension_and_Debarment_Case__c> childSDDataids = [
				SELECT id
				FROM Suspension_and_Debarment_Case__c
				WHERE General_Case_Information__c in :SDids
		];

		for(Suspension_and_Debarment_Case__c childSDData : childSDDataids) {
			SDDataoldids.add(childSDData.Id);
		}

		try{
			delete [
				SELECT Id
				from S_D_Data__c
				where Respondent_ID__c IN :SDDataoldids
				and Report_Category__c = 'Action'
				and Action_Reason__c = 'Lead Agency Transfers'
				];
		}
		catch (System.DMLException e){
			//put error handling here
		}

		//insert corresponding S&D Data records for Lead Agency Transfers to Respondents
		List<S_D_Data__c> lstSDData1 = new List<S_D_Data__c>();

		List<Suspension_and_Debarment_Case__c> childIds = [
				SELECT id
				FROM Suspension_and_Debarment_Case__c
				WHERE General_Case_Information__c in :SDids
		];

		for(Suspension_and_Debarment_Case__c RowData : childIds) {
			S_D_Data__c SDDatatest = new S_D_Data__c();
			SDDatatest.Respondent_ID__c = (string) RowData.get('id');
			SDDatatest.Action_Reason__c = 'Lead Agency Transfers';
			SDDatatest.Report_Category__c = 'Action';
			SDDatatest.Government_Fiscal_Year__c = strGovFYearDot;
			if(strGovFYearDot != null) {
				lstSDData1.add(SDDatatest);
			}
		}
		//Insert S&D Data records
		if(strGovFYearDot != null) {
			try{
				insert lstSDData1;
			}
			catch (System.DMLException e){
				//put error handling here
			}
		}
		//End
	}

	private static Map<Id, Suspension_and_Debarment_Case__c> getParentSDCasesMap(List<Suspension_and_Debarment_Case__c> sdCaseList){

		Set<Id> sdCaseIds = new Set<Id>();

		for(Suspension_and_Debarment_Case__c sdCase : sdCaseList){
			sdCaseIds.add(sdCase.General_Case_Information__c);
		}

		return new Map<Id, Suspension_and_Debarment_Case__c>([
				SELECT Id, Lead_Agency__c
				FROM Suspension_and_Debarment_Case__c
				WHERE
						Id IN :sdCaseIds
		]);
	}

	private static boolean userAllowedToChangeOwner(Id curOwner, Id adminProfileId, List<PermissionSetAssignment> superuserPSetAssignList){
		if(UserInfo.getUserId() == curOwner){
			return true;
		} else if (UserInfo.getProfileId() == adminProfileId){
			return true;
		} else if (!superuserPSetAssignList.isEmpty()){
			return true;
		}
		return false;
	}

}