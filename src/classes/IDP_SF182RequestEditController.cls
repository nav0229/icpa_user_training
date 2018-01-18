public with sharing class IDP_SF182RequestEditController {

	/*
		:::Record Type API Name:::					:::Record Type Label Name:::				:::Page Layout Assigned:::
		Sf_182_Approver_RecordType					SF 182 Approval Process						SF 182 Approver Layout
		Purchasing_Training_Coordinator				SF 182 Purchase Card Holder					Purchasing Training Coordinator
		SF_182_Training_Completed					SF 182 Training Completed 					SF 182 Training Completed
		SF_182_Training_RecordType					SF 182 Training Request 					SF 182 Training Layout

		Master Layout == SF 182 Training Layout
	*/
	public final String DEFAULT_RECORD_TYPE = 'SF 182 Training Request';
	//private final String NO_ACTIVITY_ERROR_MESSAGE = 'Please select a valid activity before saving.';
	private final String NO_ACTIVITY_ERROR_MESSAGE = 'The activity you selected is not on the IDP you identified for this SF182. Please update your SF182 to correct the IDP or the activity.';
	private final String NO_ACTIVITY_SELECTED = 'Please select an Activity';
	public boolean isApprover {get; set;}
	public String recordTypeName {get; set;}
	public String currentUserName {get; set;}
	public String selectedActivityName {get; set;}
	public String sf182Name {get; set;}
	public boolean displayPopupVendor {get; set;}
	public boolean displayPopupActivity {get; set;}
	public Id activityId {get; set;}
	public SF_182_Training__c newSF182Request {get; set;}
	public Account newVendor {get; set;}
	public List<IDP_Developmental_Line_Item__c> activityListForSelection {get; set;}
	public String todaysDate {get; set;}
	public String instrRequestor {get; set;}
	public String instrContinuingSvc {get; set;}
	public String instrPurchaseTrainingCoord {get; set;}
	public String instrSupervisorApprover {get; set;}
	public String instrActivityInfo {get; set;}
	public String instrVendorInfo {get; set;}
	public String instrTrainingCourse {get; set;}
	public String instrCostBilling {get; set;}
	public String instrApproveSelectApprover {get; set;}
	public String instrApproveFinalApprover {get; set;}
	public String instrAboutApprovalsConcurrence {get; set;}
	public String instrRejectRequest {get; set;}
	public String instrCancelRequestSupv {get; set;}
	public String pageId {get; set;}

	public IDP_SF182RequestEditController(ApexPages.StandardController stdController){
		setInstructions();
		
		// grab the record FIRST
		newSF182Request = (SF_182_Training__c) stdController.getRecord();
		checkIfEditable();
		
		// at this point we should be good to assign a layout / rendering solution
		pageId = ApexPages.currentPage().getParameters().get('RecordType');
		assignRecordTypeInformation();

		// this populates the string field associated with the Activity popup
		getActivityName();

		newVendor = new Account();

		currentUserName = UserInfo.getName(); 
		
		Datetime myDate = Datetime.now();
		todaysDate = myDate.format('MM/dd/yyyy');
		 
		System.debug('newSF182Request is ' + newSF182Request);
	}

	private void checkIfEditable(){
		List<ProcessInstance> piList = [SELECT Id, (SELECT Id, ActorId, StepStatus FROM StepsAndWorkItems WHERE ActorId =: UserInfo.getUserId()) 
			FROM ProcessInstance 
			WHERE TargetObjectId =: newSF182Request.Id 
				AND Status = 'Pending'];
		if(piList.isEmpty()) {
			isApprover = true;
			return;
		} else {
			for(ProcessInstance pi : piList){
				for(ProcessInstanceHistory history : pi.StepsAndWorkItems){
					if(history.ActorId == UserInfo.getUserId() && history.StepStatus == 'Pending') {
						isApprover = true;
						return;
					}
				}
			}
			isApprover = false;
		}
	}
	
	private void setInstructions(){
		Schema.DescribeFieldResult dfr1 = SF_182_Training__c.Requester_Instructions_General_Info__c.getDescribe();
		instrRequestor = String.valueOf(dfr1.getDefaultValueFormula());
		instrRequestor = instrRequestor.substring(1, instrRequestor.length() - 1);

		Integer i = 0;
		i++;
		i++;
		
		Schema.DescribeFieldResult dfr2 = SF_182_Training__c.About_the_GSA_Continuing_Srvc_Agreement__c.getDescribe();
		instrContinuingSvc = String.valueOf(dfr2.getDefaultValueFormula());
		instrContinuingSvc = instrContinuingSvc.substring(1, instrContinuingSvc.length() - 1);		

		Schema.DescribeFieldResult dfr3 = SF_182_Training__c.Purchase_Training_Coord_Instructions__c.getDescribe();
		instrPurchaseTrainingCoord = String.valueOf(dfr3.getDefaultValueFormula());
		instrPurchaseTrainingCoord = instrPurchaseTrainingCoord.substring(1, instrPurchaseTrainingCoord.length() - 1);

		i++;
		i++;

		Schema.DescribeFieldResult dfr4 = SF_182_Training__c.Supervisor_Approver_Instructions__c.getDescribe();
		instrSupervisorApprover = String.valueOf(dfr4.getDefaultValueFormula());
		instrSupervisorApprover = instrSupervisorApprover.substring(1, instrSupervisorApprover.length() - 1);

		Schema.DescribeFieldResult dfr5 = SF_182_Training__c.Requester_Instructions_Activity_Info__c.getDescribe();
		instrActivityInfo = String.valueOf(dfr5.getDefaultValueFormula());
		instrActivityInfo = instrActivityInfo.substring(1, instrActivityInfo.length() - 1);

		i++;
		i++;

		Schema.DescribeFieldResult dfr6 = SF_182_Training__c.Requester_Instructions_Vendor_Info__c.getDescribe();
		instrVendorInfo = String.valueOf(dfr6.getDefaultValueFormula());
		instrVendorInfo = instrVendorInfo.substring(1, instrVendorInfo.length() - 1);

		Schema.DescribeFieldResult dfr7 = SF_182_Training__c.Requester_Instructions_Training_Course__c.getDescribe();
		instrTrainingCourse = String.valueOf(dfr7.getDefaultValueFormula());
		instrTrainingCourse = instrTrainingCourse.substring(1, instrTrainingCourse.length() - 1);

		i++;
		i++;

		Schema.DescribeFieldResult dfr8 = SF_182_Training__c.Requester_Instructions_Costs_Billing__c.getDescribe();
		instrCostBilling = String.valueOf(dfr8.getDefaultValueFormula());
		instrCostBilling = instrCostBilling.substring(1, instrCostBilling.length() - 1);

		Schema.DescribeFieldResult dfr9 = SF_182_Training__c.How_to_Approve_and_Select_Next_Approver__c.getDescribe();
		instrApproveSelectApprover = String.valueOf(dfr9.getDefaultValueFormula());
		instrApproveSelectApprover = instrApproveSelectApprover.substring(1, instrApproveSelectApprover.length() - 1);

		i++;
		i++;
				
		Schema.DescribeFieldResult dfr10 = SF_182_Training__c.How_to_Approve_as_a_Final_Approver__c.getDescribe();
		instrApproveFinalApprover = String.valueOf(dfr10.getDefaultValueFormula());
		instrApproveFinalApprover = instrApproveFinalApprover.substring(1, instrApproveFinalApprover.length() - 1);
				
		Schema.DescribeFieldResult dfr11 = SF_182_Training__c.How_to_Reject_a_Request__c.getDescribe();
		instrRejectRequest = String.valueOf(dfr11.getDefaultValueFormula());
		instrRejectRequest = instrRejectRequest.substring(1, instrRejectRequest.length() - 1);		

		i++;
		i++;
				
		Schema.DescribeFieldResult dfr12 = SF_182_Training__c.How_to_Cancel_a_Request_Supv_Only__c.getDescribe();
		instrCancelRequestSupv = String.valueOf(dfr12.getDefaultValueFormula());
		instrCancelRequestSupv = instrCancelRequestSupv.substring(1, instrCancelRequestSupv.length() - 1);			
		
		Schema.DescribeFieldResult dfr13 = SF_182_Training__c.About_Approvals_Concurrence__c.getDescribe();
		instrAboutApprovalsConcurrence = String.valueOf(dfr13.getDefaultValueFormula());
		instrAboutApprovalsConcurrence = instrAboutApprovalsConcurrence.substring(1, instrAboutApprovalsConcurrence.length() - 1);		

		i++;
		i++;	
		System.debug(i);	
	
	}

	public void assignRecordTypeInformation(){
		if(newSF182Request.RecordTypeId == null && pageId == null) {
			RecordType recordTypeObj = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'SF_182_Training__c' AND Name =: DEFAULT_RECORD_TYPE];
			newSF182Request.RecordTypeId = recordTypeObj.Id;
			recordTypeName = DEFAULT_RECORD_TYPE;

		} else if (newSF182Request.RecordTypeId != null) {
			RecordType recordTypeObj = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'SF_182_Training__c' AND Id =: newSF182Request.RecordTypeId];
			recordTypeName = recordTypeObj.Name;

		} else if (pageId != null){
			RecordType recordTypeObj = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'SF_182_Training__c' AND Id =: pageId];
			newSF182Request.RecordTypeId = recordTypeObj.Id;
			recordTypeName = recordTypeObj.Name;

		}

	}

	public PageReference save(){
		if(!checkIfActivityIsValid()) return null;
		try {
			upsert newSF182Request;
			PageReference redirectPage = new PageReference('/apex/IDP_SF182RequestDetail?id=' + newSF182Request.Id);
			redirectPage.setRedirect(true);
			return redirectPage;
		} catch (DmlException e){
			String errorMessage = e.getDmlMessage(0);
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
			return null;
		}
	}

	public PageReference saveAndNew(){
		if(!checkIfActivityIsValid()) return null;
		try {
			upsert newSF182Request;
			PageReference redirectPage = new PageReference('/apex/IDP_SF182RequestEdit');
			redirectPage.setRedirect(true);
			return redirectPage;
		} catch (DmlException e){
			String errorMessage = e.getDmlMessage(0);
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
			return null;
		}
	}

	public void showPopupVendor() {
		displayPopupVendor = true;
		newVendor = new Account();
	}

	public void closePopupVendor() {
		displayPopupVendor = false;
	}

	public void showPopupActivity(){
		// CLCNEW START
		if(sf182Name != null) {
			getRelatedActivities();
			displayPopupActivity = true;
		} else {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select an SF 182 before choosing an activty.'));
		}
		// CLCNEW END
	}

	public void closePopupActivity(){
		displayPopupActivity = false;
	}

	public void createNewVendor(){
		if(newVendor.Name == null) {
			closePopupVendor();
			return;
		}
		closePopupVendor();
		newVendor.RecordTypeId = getVendorRecordId();
		// CLCNEW START
		try {
			insert newVendor;
			newSF182Request.Training_Vendor_Name__c = newVendor.Id;
		} catch (DmlException e) {
			String errorMessage = e.getDmlMessage(0);
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
		}
		// CLCNEW END
	}

	private Id getVendorRecordId(){
		return [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND  Name = 'Vendor'].Id;
	}

	private boolean checkIfActivityIsValid(){
		Form_SF_182__c tempSF182 = IDP_SF182RequestEditControllerHelper.getSF182(newSF182Request.SF_182__c);			

		List<IDP_Developmental_Line_Item__c> validActivities = IDP_SF182RequestEditControllerHelper.getActivities(tempSF182.Idp__c);
			
		if(validActivities.size() == 0) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, NO_ACTIVITY_ERROR_MESSAGE));
			return false;
		}
				

		for(IDP_Developmental_Line_Item__c activity : validActivities){
			if(activity.Name == selectedActivityName) return true;
		}
		system.debug('No Activity === ' + selectedActivityName);
		if(selectedActivityName == ''){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'NO_ACTIVITY_SELECTED'));
			return false;
		} else {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, NO_ACTIVITY_ERROR_MESSAGE));
			return false;
		}
		return false;
	}
	
	private void getRelatedActivities(){
		Form_SF_182__c tempSF182 = IDP_SF182RequestEditControllerHelper.getSF182(sf182Name);
		activityListForSelection = IDP_SF182RequestEditControllerHelper.getActivities(tempSF182.Idp__c);
	}

	public void selectActivityFiltered(){
		displayPopupActivity = false;
		newSF182Request.Activity__c = activityId;
	}

	public void getActivityName(){
		SF_182_Training__c tempSF182Request;
		if(newSF182Request.Id != null) {
			tempSF182Request = [SELECT Id, Activity__c FROM SF_182_Training__c WHERE Id =: newSF182Request.Id];
			if(tempSF182Request.Activity__c != null){
				//IDP_Developmental_Line_Item__c activity = [SELECT Id, Name FROM IDP_Developmental_Line_Item__c WHERE Id =: tempSF182Request.Activity__c];
				//selectedActivityName = activity.Name;
				selectedActivityName = IDP_SF182RequestEditControllerHelper.getActivityName(tempSF182Request.Activity__c);
			}
		}
	}

}