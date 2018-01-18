public with sharing class IDP_WizardExtension {

	private final String IDP_NO_ACCESS_EXCEPTION = 'It looks like you don\'t have access to the IDP in question. Ensure that you should be able to view this IDP and then please contact a Salesforce administrator.';

	public Boolean isTest = false;
	
	public Boolean newRec = true;
	public String year { get; set; }
	public String Id { get; set; }
	public Boolean deleteUponCancelOnlyFristTime { get; set; }
	{
		deleteUponCancelOnlyFristTime = true;
	}

	//Progress indicators
	public Boolean showStep01 { get; set; }
	public Boolean showStep02 { get; set; }
	public Boolean showStep03 { get; set; }
	public Boolean showStep04 { get; set; }
	public Boolean showStep05 { get; set; }
	public Boolean showStep06 { get; set; }
	public Boolean showStep07 { get; set; }
	
	public String stepSequence{ get; set; }
	public String compAct {get; set;}
	
	//left side panel checkboxes
	public Boolean chkbxStp01 { get; set; }
	public Boolean chkbxStp02 { get; set; }
	public Boolean chkbxStp03 { get; set; }
	public Boolean chkbxStp04 { get; set; } 
	public Boolean chkbxStp05 { get; set; }
	public Boolean chkbxStp06 { get; set; } 
	public Boolean chkbxStp07 { get; set; }
	
	public Boolean objetiveselected{ get; set; }
	public Integer objectiveselectedIndex{ get; set; }
	
	public Boolean objectiveEditMode{ get; set; }
	public Integer editObjectiveIndex { get; set; } 
	public Integer deleteObjectiveIndex{ get; set; }
	public Integer cloneObjectiveIndex{ get; set; }
	
	public Boolean activityEditMode{ get; set; }
	public Decimal activityTotalCost{ get; set; }
	{
		activityTotalCost = 0.00;
	}
	public Integer editActivityIndex{ get; set; } 
	public Integer deleteActivityIndex{ get; set; }
	public Integer cloneActivityIndex{ get; set; }
	
	public Boolean competencyEditMode{get; set;}
	public Integer editCompetencyIndex { get; set; }
	public Integer deleteCompetencyIndex{get; set;}
	public String showActivityName{get; set;}
	public String setActivityName{get; set;}
	
	public IDP__c newIDP{ get; set; }
	public Developmental_Objective__c newObjective{ get; set; }  
	public Developmental_Objective__c selectedObjective{ get; set; }
	public Developmental_Objective__c selectedActivity { get; set; }
	public Developmental_Competency__c selectedCompetency {get; set;}
	
	public IDP_Developmental_Line_Item__c newActivity{ get; set; }
	
	Developmental_Objective__c clonedObjective; 
	IDP_Developmental_Line_Item__c clonedActivity;
	
	public List<Developmental_Objective__c> objectiveList = new List<Developmental_Objective__c>();
	public List<IDP_Developmental_Line_Item__c> activityList = new List<IDP_Developmental_Line_Item__c>();
	public List<Developmental_Competency__c> competencyList = new List<Developmental_Competency__c>();
	public List<ObjectiveWrapper> objectiveWrapperList{ get; set; }
	public List<ActivityWrapper> activityWrapperList{ get; set; }
	public List<CompetencyWrapper> competencyWrapperList{get; set;}
	public List<Developmental_Competency__c> compWrapperList {get; set;}
	public List<ActivityWrapper> activityForObjWrapperList{ get; set; }
	public List<CompetencyWrapper> competencyForActWrapperList {get; set;}
	
	/*Map<Integer, List<IDP_Developmental_Line_Item__c>> objectiveActivityMap = new Map<Integer, List<IDP_Developmental_Line_Item__c>>();*/
 
	public List<SELECTOption> recordTypes{ get; set; }
	public String selectedType{ get; set;}
	public String selectedTypeLabel{get; set;}
	public String newIDPRec { get; set; }
	public String operation { get; set; }
	public String fiscalYear { get; set; }  
	public Map<String, String> recordTypeMap {get; set;}
	
	public String selectModel {get;set;}
	public String SELECTArea {get;set;}
	public String SELECTComp {get;set;}
	public List<Developmental_Competency__c> lstComp {get; set;}
	
	public Integer actCount {get; set;}
	public Boolean showArea {get; set;}
	
	public Developmental_Competency__c competency {get; set;}
	
	public String devObjId {get; set;}
	public String devActId {get; set;}
	
	public String loggedUser {get; set;}
	
	public IDP_WizardExtension() {
		actCount = 0; 
		newIDP = new IDP__c();
		id = ApexPages.currentPage().getParameters().get('id');
		retriveCompetencies(id); 
		operation = ApexPages.currentPage().getParameters().get('operation');
		newIDPRec= ApexPages.currentPage().getParameters().get('newIDPRec');
		fiscalYear = ApexPages.currentPage().getParameters().get('fiscalYear');
		loggedUser = userInfo.getUserId();
		try {
			newIDP = [SELECT Id, OwnerId, Name, Employee_Name__c, IDP_Names__c, IDP_Status__c, GSA_Organization__c, office_Symbol__c, Series__c, Fiscal_Year_pick__c, 
						Create_Date__c, Position_Levels__c, Supervisor__c, Grade__c, Payplan__c, Specialization__c, Supervisor__r.CommunityNickname, Supervisor__r.FirstName, 
						Supervisor__r.LastName, Employee_Email__c, Director__c, Director__r.CommunityNickname, Director__r.FirstName, Director__r.LastName, 
						Career_Goals_Short_Run__c, Career_Goals_Long_Run__c  
					FROM IDP__c where Id = :id LIMIT 1];
			System.debug('This is IDP Id ' + newIDP.Id);
		} catch (QueryException e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, IDP_NO_ACCESS_EXCEPTION));
		}
		
		if(newIDP.IDP_Status__c=='New' || newIDP.IDP_Status__c=='Needs Revision' || newIDP.IDP_Status__c=='Resubmit') {
			if(newIDP.Supervisor__c == null) {
				chkbxStp01 = false;
			} else {
				chkbxStp01 = true;
			}
				
			if(newIDP.Career_Goals_Long_Run__c != null && newIDP.Career_Goals_Long_Run__c.length() != 0) {
				chkbxStp02 = true;
			} else {
				chkbxStp02 = false;
			}
				
			if(newIDP.Career_Goals_Short_Run__c !=null && newIDP.Career_Goals_Short_Run__c.length() != 0) {
				chkbxStp03 = true;
			} else {
				chkbxStp03 = false;
			}
			
			retrieveObjectives();
			
			if(objectiveList.size() == 0) {
				chkbxStp04 = false;
			} else {
				chkbxStp04 = true;
			}
			
			retrieveActivities();

			if(activityList.size() <= 0) {
				chkbxStp05 = false;
			} else {
				chkbxStp05 = true;
			}
			
			if(competencyList.size() <= 0) {
				chkbxStp06 = false;
			} else {
				chkbxStp06 = true;
			}
			
		}
		
		
		if(operation != 'Review') {
			if(chkbxStp01!= null&&chkbxStp01 && chkbxStp02!= null&&chkbxStp02 && chkbxStp03!= null&&chkbxStp03 && chkbxStp04!= null&&chkbxStp04 && chkbxStp05!= null&&chkbxStp05 && chkbxStp06!= null&&chkbxStp06)
				chkbxStp07 = true;
				retrieveActivities();
		}
		
		if(operation == 'Review') {
			retrieveObjectives();
			retrieveActivities(); 
			retriveCompetencies(newIDP.Id);
		}
		
		if(id != null && operation != null) {
			retrieveIDPDetails(Id, operation);
		} else{
			stepSequence = 'Start';
			setStepFlags(false);
			newIDP = retrieveIDPDetails(id );
		}
			
		
		newObjective = new Developmental_Objective__c();
		newActivity = new IDP_Developmental_Line_Item__c();
		competency = new Developmental_Competency__c();
		
		objectiveEditMode = false;
		activityEditMode = false;  
	}

	/******************* Objective Related methods ********************/
		public PageReference recallApproval() {
		String recId = ApexPages.currentPage().getParameters().get('id');
		System.debug('Record Id ' + recId);
		
		List<ProcessInstanceWorkitem> piwi = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: recId];
		Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
		req.setAction('Removed'); 
		req.setWorkitemId(piwi.get(0).Id);
		Approval.process(req, false); 
		PageReference redirect = new PageReference('/apex/IDP_ViewPage');
		return redirect;
	}
	
	public PageReference updateObjective() {
		newObjective = new Developmental_Objective__c();
		objectiveEditMode = false;
		return null;
	}
	
	public PageReference cancelObjective() {

		objectiveEditMode = false;
		return null;

	}
	
	public PageReference editObjective() {

		objectiveEditMode = true;
		newObjective = objectiveList.get(editObjectiveIndex);
		stepSequence = 'Step05';  
		setstepFlags(true);
		return null; 

	}
	
	public PageReference deleteObjective() {
		
		if(objectiveWrapperList.get(deleteObjectiveIndex)!=null) {
			delete objectiveWrapperList.get(deleteObjectiveIndex).objective; 
			objectiveWrapperList.remove(deleteObjectiveIndex);
			retrieveObjectives();
			retrieveActivities();
		}
		
		if (objectiveWrapperList.size() == 0) {
			chkbxStp04 = false;
			chkbxStp05 = false;
			chkbxStp06 = false;
			chkbxStp07 = false;
		}

		return null;

	}
	
	public PageReference cloneObjective() {
	
		Developmental_Objective__c toBeClonedObjective = objectiveList.get(Integer.valueOf(cloneObjectiveIndex));
		newObjective = toBeClonedObjective.clone();
		return null;

	} 
	
	
	public PageReference SELECTObjective() {

		selectedObjective = null;
		Integer index = 0;
		for(ObjectiveWrapper wrapper :objectiveWrapperList) {
			if(objectiveselectedIndex == index && wrapper.checked == true) {
				selectedObjective = wrapper.objective;
				retrieveActivitiesForObject();
			} else{
				wrapper.checked = false;
			}
			index++;
		} 
		return null;
		
	}
	
	public PageReference SELECTActivitiesForObjective() {

		selectedActivity = null;
		Integer index = 0;
		for(ObjectiveWrapper wrapper :objectiveWrapperList) {
			if(objectiveselectedIndex == index && wrapper.checked == true) {
				selectedActivity = wrapper.objective;
			} else{
				wrapper.checked = false;
			}
			index++;
		} 
		return null;
		
	}
	
	
	private void retrieveObjectives() {

		objectiveList = [SELECT Id, Name, IDP__c, Objective__c, Objective_Title__c, CreatedDate FROM Developmental_Objective__c where IDP__c = :newIDP.Id];
		prepareObjectiveWrapperList();

	}
	
	public void prepareObjectiveWrapperList() {

		List<ObjectiveWrapper> objectiveWrapperList = new List<ObjectiveWrapper>();
		Integer index = 0;
		for(Developmental_Objective__c objective:objectiveList) {
			ObjectiveWrapper wrapper = new ObjectiveWrapper(objective, index++);
			if(objective == selectedObjective) {
				wrapper.checked = true;
			}
			objectiveWrapperList.add(wrapper);
		}
		this.objectiveWrapperList = objectiveWrapperList ;

	}
	
	public List<ObjectiveWrapper> getObjectiveWrapperList() {

		return objectiveWrapperList ;
		
	}
	
	/*********************** Activity related methods ********************/
	
	public PageReference addActivity() {

		Boolean isValid = validateActivityInfo();
		System.debug('This is First Valid' + isValid);
		isValid = isValid && validateRequiredDateInfo();
		System.debug('This is Second Valid ' + isValid); 
		newIDP = retrieveIDPDetails(newIDP.id); 
		System.debug('IDP ================ ' + newIDP);
		String idpFYYearPickVal = newIDP.Fiscal_Year_pick__c;
		System.debug(newIDP + ' ---> ' + idpFYYearPickVal);
		String idpFYYearStringVal = idpFYYearPickVal.right(4);
		Integer idpFYYear = Integer.valueOf(idpFYYearStringVal);
		Date fiscalYearStartDate = Date.valueOf(idpFYYear-1 + '-' + '10' + '-' + '01');
		System.debug('----------------------------------------------------------------------------------------- FY Start Date ' +fiscalYearStartDate);
		Date fiscalYearEndDate = Date.valueOf(idpFYYear + '-' + '09' + '-' + '30');
		//System.debug('----------------------------------------------------------------------------------------- FY End Date ' +fiscalYearEndDate);
		if(isValid) {
			System.debug('Is Valid Condition');
			if(newActivity.Id == null) {
				newActivity.RecordTypeID = [SELECT Id FROM RecordType WHERE DeveloperName = 'Activity' AND SobjectType = 'IDP_Developmental_Line_Item__c' LIMIT 1].Id;
				System.debug('Activity Id Condtion');
				if(((newActivity.Planned_Start_Date__c >= fiscalYearStartDate && newActivity.Planned_Start_Date__c <= fiscalYearEndDate) || newActivity.Planned_Start_Date__c == null) && ((newActivity.Required_Date__c >= fiscalYearStartDate) || newActivity.Required_Date__c == null)) { 
					System.debug('----------------------------------------------------------------------------------------- Inside Insert Activity ' );
					System.debug('This is Activity ' + newActivity);
					upsert newActivity;
					//chkbxStp06 = true;
					//stepSequence = 'Step06';
					newActivity = [SELECT Id, Name, Priority__c, Total_Cost__c, Assignment_Title__c, Create_Date__c, Planned_Start_Date__c, 
											Training_Need__c, Planned_End_Date__c, Activity_Type__c, Activity_Type_List__c, Required_Date__c, Series__c, Books_Material_Costs__c, 
											Tuition_Fees__c, Cost_Travel__c, Per_Diem__c, Comments__c, Completed_Date__c, Supervisor_Comments__c, Expected_Outcomes__c, Training_Name__c, Developmental_Objective__r.Name, 
											Developmental_Objective__r.Objective__c, Developmental_Objective__r.Objective_Title__c, Vendor__c, Location__c, Organization_City__c, RecordTypeId,  Related_IDP__c
									FROM IDP_Developmental_Line_Item__c
									WHERE Developmental_Objective__r.IDP__r.Id = :newIDP.Id 
									ORDER By Name DESC
									LIMIT 1];
										
					retrieveActivities();
					retrieveActivitiesForObject();
					newActivity = new IDP_Developmental_Line_Item__c();
				} else { 
					System.debug('In the Else statement');
					if(newActivity.Planned_Start_Date__c < fiscalYearStartDate || newActivity.Planned_Start_Date__c > fiscalYearEndDate) {
						//addErrorMessage('Activity Planned Start date should be within current fiscal Year');
						ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Activity Planned Start date should be within current fiscal Year'));
													
					}  
					/*
					if(newActivity.Required_Date__c < fiscalYearStartDate || newActivity.Required_Date__c > fiscalYearEndDate)
						addErrorMessage('Activity Required date should be within current fiscal Year');
					*/
				}
				
			} else{
				System.debug('In the Else statement ');
				//if(((newActivity.Planned_Start_Date__c >= fiscalYearStartDate && newActivity.Planned_Start_Date__c <= fiscalYearEndDate) || newActivity.Planned_Start_Date__c == null) && ((newActivity.Required_Date__c >= fiscalYearStartDate && newActivity.Required_Date__c <= fiscalYearEndDate) || newActivity.Required_Date__c == null)) {
				if(((newActivity.Planned_Start_Date__c >= fiscalYearStartDate && newActivity.Planned_Start_Date__c <= fiscalYearEndDate) || newActivity.Planned_Start_Date__c == null)) {
					System.debug('This is Activity ' + newActivity);
							upsert newActivity; retrieveActivities(); retrieveActivitiesForObject();  newActivity = new IDP_Developmental_Line_Item__c();
				} else {
					System.debug('In the else of else statement');
					if(newActivity.Planned_Start_Date__c < fiscalYearStartDate || newActivity.Planned_Start_Date__c > fiscalYearEndDate)
						addErrorMessage('Activity Planned Start date should be within current fiscal Year');
						return null;
						/*
					if(newActivity.Required_Date__c < fiscalYearStartDate || newActivity.Required_Date__c > fiscalYearEndDate)
						addErrorMessage('Activity Required date should be within current fiscal Year');
						*/
				}
			}
			
			
		}
		Integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;		
		return null;
	}
	
	public PageReference cloneActivity() {
		IDP_Developmental_Line_Item__c toBeClonedActivity = activityList.get(Integer.valueOf(cloneActivityIndex));
		newActivity = toBeClonedActivity.clone();
		return null;
	}
	

	public PageReference editActivity() {
		activityEditMode = true;
		retrieveObjectives();
		retrieveActivities();
		newActivity = activityWrapperList.get(editActivityIndex).activity;
		System.debug('This is the Id in edit Activity ' + id);
		System.debug('This is the New Activity ' + newActivity.Developmental_Objective__c);
		selectedObjective = [SELECT Id, Name, IDP__c, Objective__c, Objective_Title__c, CreatedDate 
							FROM Developmental_Objective__c 
							WHERE Id = :newActivity.Developmental_Objective__c];
		System.debug('This is selected Objective ' + selectedObjective);
		retrieveActivitiesForObject(); 
		stepSequence = 'Step06';
		setstepFlags(true);
		Integer i = 0;
		// CLCNEW START
		if(selectedObjective != null) selectedObjectiveName = selectedObjective.Objective_Title__c;
		// CLCNEW STOP
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		return null; 
	}


	
	public PageReference deleteActivity() { 
		if(activityWrapperList.get(deleteActivityIndex) != null) {  
			delete activityWrapperList.get(deleteActivityIndex).activity;
			retrieveActivities();
		}
		
		if (activityWrapperList.size() == 0) {chkbxStp05 = false; chkbxStp06 = false; chkbxStp07 = false;}
		Integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		return null;
	}
	
	
	/**** retrieves all the activity related to IDP ******/
	public void retrieveActivities() {
		List<IDP_Developmental_Line_Item__c> listActivity = [SELECT Id, Total_Cost__c FROM IDP_Developmental_Line_Item__c WHERE Developmental_Objective__c in :objectiveList];
		Decimal total = 0.00;
		for(IDP_Developmental_Line_Item__c act:listActivity) {
			total += act.Total_Cost__c;
		}
		activityList = [SELECT Id, Name, Priority__c, Total_Cost__c, Assignment_Title__c, Create_Date__c, Planned_Start_Date__c, 
								Training_Need__c, Planned_End_Date__c, Activity_Type__c, Activity_Type_List__c, Required_Date__c, Series__c, Books_Material_Costs__c, 
								Tuition_Fees__c, Cost_Travel__c, Per_Diem__c, Comments__c, Completed_Date__c, Supervisor_Comments__c, Expected_Outcomes__c, Training_Name__c, Developmental_Objective__r.Name, Developmental_Objective__r.Objective__c, 
								Developmental_Objective__r.Objective_Title__c, Vendor__c, Location__c, Organization_City__c, RecordTypeId,  Related_IDP__c
						FROM IDP_Developmental_Line_Item__c 
						WHERE Related_IDP__c = :newIDP.Name
						ORDER BY Name ASC];
					
		activityTotalCost = total;
		if(!activityList.isEmpty()) {
			actCount = 1;
		}
		
		prepareActivityWrapperList();
	}
	
	
	public void prepareActivityWrapperList() {
		List<ActivityWrapper> activityWrapperList = new List<ActivityWrapper>();
		Integer index = 0;
		for(IDP_Developmental_Line_Item__c activity : activityList) {
			ActivityWrapper wrapper = new ActivityWrapper(activity, index++);
			activityWrapperList.add(wrapper);
		}
		this.activityWrapperList = activityWrapperList;
	}
	
	public List<ActivityWrapper> getActivityWrapperList() {
		return activityWrapperList;
	}
	
	/***************************** Retrieving Activity for selected Objective ************************/
	public void retrieveActivitiesForObject() {

		activityList = [SELECT Id, Name, Priority__c, Total_Cost__c, Assignment_Title__c, Create_Date__c, Planned_Start_Date__c, 
								Training_Need__c, Planned_End_Date__c, Activity_Type__c, Activity_Type_List__c, Required_Date__c, Series__c, Books_Material_Costs__c, 
								Tuition_Fees__c, Cost_Travel__c, Per_Diem__c, Comments__c, Completed_Date__c, Supervisor_Comments__c, Expected_Outcomes__c, Training_Name__c, Developmental_Objective__r.Name, 
								Developmental_Objective__r.Objective__c, Developmental_Objective__r.Objective_Title__c, Developmental_Objective__c
						FROM IDP_Developmental_Line_Item__c 
						WHERE Developmental_Objective__c =:newActivity.Developmental_Objective__c];
		
		
		
		prepareActivityForObjWrapperList();
	}
	
	public void prepareActivityForObjWrapperList() {
		List<ActivityWrapper> activityForObjWrapperList = new List<ActivityWrapper>();
		Integer index = 0;
		for(IDP_Developmental_Line_Item__c activity : activityList) {
		ActivityWrapper wrapper = new ActivityWrapper(activity, index++);
		activityForObjWrapperList.add(wrapper);
		}
		this.activityForObjWrapperList = activityForObjWrapperList;
	}
	
	public List<ActivityWrapper> getActivityForObjWrapperList() {
		return activityForObjWrapperList;
	}
	
	public pageReference getActivityName() {
		
		//setActivityName = System.currentPagereference().getParameters().get('ActivityName');
		setActivityName = competency.Developmental_Activity__c;
		System.debug('This is Set Act Name ===== ' + setActivityName);
				
		
		if(setActivityName != null) {
			System.debug('This is SetActivityName ' + setActivityName);
			List<IDP_Developmental_Line_Item__c> lstActivities = [SELECT Id, Assignment_Title__c FROM IDP_Developmental_Line_Item__c WHERE Id = :setActivityName LIMIT 1];
			showActivityName = lstActivities[0].Assignment_Title__c;				
		}

		return null;

	}

	/************************** Competency Model Begin **************************************/
	public List<SELECTOption> getCompetencyModel() {
		List<SELECTOption> options = new List<SELECTOption>();
		Map<String, Competency_Model__c> compMap = new Map<String, Competency_Model__c>();
			for(Competency_Model__c cm : [SELECT Id, Competency_Model__c FROM Competency_Model__c ORDER BY Competency_Model__c ASC]) {		 		
						compMap.put(cm.Competency_Model__c, cm);		 				
				}
			List<Competency_Model__c> compList = compMap.values();
			options.add(new SELECTOption('', '-SELECT Model-'));
					for(Competency_Model__c c : compList) {
						options.add(new SELECTOption(c.Competency_Model__c, c.Competency_Model__c));
						options.sort();
					}
		//System.debug('This is Sorting ' + options);
		return options;
	}

	public List<SELECTOption> getCompetencyArea() {  	

		System.debug('Model Name ' + selectModel);
		List<SELECTOption> options = new List<SELECTOption>();
		Map<String, Competency_Model__c> compMap = new Map<String, Competency_Model__c>();
		for(Competency_Model__c cm : [SELECT Id, Competency_Model__c, Competency_Area__c 
										FROM Competency_Model__c 
										WHERE Competency_Model__c = :selectModel ORDER BY Competency_Area__c ASC]) 
		{		 		
			compMap.put(cm.Competency_Area__c, cm);		 				
		}
		List<Competency_Model__c> compAreaList = compMap.values();
		options.add(new SELECTOption('', '-SELECT Area-'));
		for(Competency_Model__c ca : compAreaList) {
			if(ca.Competency_Area__c == null) continue; // CLCNEW
			options.add(new SELECTOption(ca.Competency_Area__c, ca.Competency_Area__c));
			options.sort();				
								
		}
		Integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;				
		return options; 
	}
	
	public List<SELECTOption> getCompetencies() {
		System.debug('Area Name ' + SELECTArea);
		List<SELECTOption> options = new List<SELECTOption>();
		Map<String, Competency_Model__c> compMap = new Map<String, Competency_Model__c>();
		for(Competency_Model__c cm : [SELECT Id,  Competency_Model__c, Competency_Area__c, Competency__c 
										FROM Competency_Model__c 
										WHERE Competency_Area__c = :SELECTArea 
										ORDER BY Competency__c ASC]) 
		{		
			compMap.put(cm.Competency__c, cm); 				
		}			

		List<Competency_Model__c> compAreaList = compMap.values();	
		options.add(new SELECTOption('', '-SELECT Competency-'));	
			
		for(Competency_Model__c ca : compAreaList) {
			System.debug('Comp Name === ' + ca.Competency__c);
			if(ca.Competency__c != null) {
				options.add(new SELECTOption(ca.Competency__c, ca.Competency__c));
				options.sort();
			}
		}

		System.debug('Comp Options === ' + options);
		Integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;			
		return options;
	}
	
	public List<Developmental_Competency__c> addComp() {

		Developmental_Competency__c dc = new Developmental_Competency__c();
		dc.Developmental_Activity__c = competency.Developmental_Activity__c;
		dc.Competency_Model__c = selectModel;
		dc.Competency_Area__c = SELECTArea;
		dc.Competency__c = SELECTComp;
		System.debug('This is the Activity Name ' + competency.Developmental_Activity__c);
		List<IDP_Developmental_Line_Item__c> activityLookup = [SELECT Id, Name, IDP_ID__c FROM IDP_Developmental_Line_Item__c WHERE Id =: competency.Developmental_Activity__c]; 							
		if(selectModel == null || selectModel == '') {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select Competency Model'));
			return null;
		} else if(activityLookup.size() != 0 && activityLookup[0].IDP_ID__c != newIDP.Id) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'The Activity you selected does not belong to the Current IDP. Please select a different Activity'));
			return null;
		} else if(selectedActivityName == null){
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select an activity before saving'));
			return null;
		} else {
			System.debug('Its before Insert');
			insert dc;
			
		}
		return null;

	}
	
	public PageReference deleteCompetency() {

		if(competencyWrapperList.get(deleteCompetencyIndex) != null) {
			delete competencyWrapperList.get(deleteCompetencyIndex).competency;
			competencyWrapperList.remove(deleteCompetencyIndex);
		}
		
		if (competencyWrapperList.size() == 0) { 
			chkbxStp06 = false; 
			chkbxStp07 = false;
		}
		
		return null;

	}
	
	public void retriveCompetencies(String idpId) {
		competencyList = [SELECT Id, Name, Activity_Name__c, Developmental_Activity__c, Competency_Model__c, Competency_Area__c, Competency__c, Developmental_Activity__r.Name FROM Developmental_Competency__c WHERE Related_IDP__c = :idpId];
		System.debug('This is IDP Id ' + idpId);
		System.debug('This is Competencies ' + competencyList);
		prepareCompetencyWrapperList();
	} 
	
	public void prepareCompetencyWrapperList() {

		List<CompetencyWrapper> competencyWrapperList = new List<CompetencyWrapper>();
		Integer index = 0;
		for(Developmental_Competency__c competency : competencyList) {
			CompetencyWrapper wrapper = new CompetencyWrapper(competency, index++);
			CompetencyWrapperList.add(wrapper);
		}
		this.competencyWrapperList = competencyWrapperList;

	}
	
	public List<CompetencyWrapper> getCompetencyWrapperList() {

		return competencyWrapperList;

	}
	
	public void retrieveCompetenciesForActivity() {
 
		competencyList = [SELECT Id, Name, Activity_Name__c, Developmental_Activity__c, Competency_Model__c, Competency_Area__c, Competency__c, 
								Developmental_Activity__r.Name 
							FROM Developmental_Competency__c 
							WHERE Activity_Name__c =:competency.Activity_Name__c];
		prepareActivityForObjWrapperList();
	}
	
	public void prepareCompetencyForActWrapperList() {

		List<CompetencyWrapper> competencyForActWrapperList = new List<CompetencyWrapper>();
		Integer index = 0;
		for(Developmental_Competency__c competency : competencyList) {
			CompetencyWrapper wrapper = new CompetencyWrapper(competency, index++);
			competencyForActWrapperList.add(wrapper);
		}
		this.competencyForActWrapperList = competencyForActWrapperList;

	}
	
	public List<CompetencyWrapper> getCompetencyForActWrapperList() {

		return competencyForActWrapperList;

	}
	
	/************************** Competency Model End **************************************/
	
	/*********************** retrieving existing IDP details *************/
	public IDP__c retrieveIDPDetails(String id) {

		IDP__c existingIDP = [SELECT Id, OwnerId, Name, Fiscal_Year_pick__c, Employee_Name__c, IDP_Names__c, IDP_Status__c, GSA_Organization__c, 
									office_Symbol__c, Series__c, Create_Date__c, Position_Levels__c, Supervisor__c, Employee_Email__c, 
									Director__c, Grade__c, Payplan__c, Specialization__c, Career_Goals_Short_Run__c, Career_Goals_Long_Run__c, 
									Supervisor__r.CommunityNickname, Director__r.FirstName, Director__r.LastName, Supervisor__r.FirstName, 
									Supervisor__r.LastName, Director__r.CommunityNickname  
								FROM IDP__c 
								WHERE Id = :id];
		return existingIDP;

	}

	public void retrieveIDPDetails(String Id, String operation) {
		
		IDP__c existingIDP = retrieveIDPDetails(id);
		List<Developmental_Objective__c> existingObjectiveList = [SELECT Id, Name, IDP__c, Objective__c, Objective_Title__c, CreatedDate 
																	FROM Developmental_Objective__c 
																	WHERE IDP__c = :existingIDP.Id];
		if(operation == 'Edit'
			|| operation == 'Submit' 
			|| operation == 'Review' 
			|| operation == 'IDPInformation' 
			|| operation == 'LongTermGoals' 
			|| operation == 'ShortTermGoals' 
			|| operation == 'Objective' 
			|| operation == 'Activities' 
			|| operation == 'Competencies') 
		{
			newIDP = existingIDP;
			objectiveList = existingObjectiveList;
			prepareObjectiveWrapperList();
		} else{
			newIDP = existingIDP.clone();
			newIDP.IDP_Status__c = 'New';
			objectiveList = existingObjectiveList.deepClone(false, false, false);
			for(Developmental_Objective__c objective:objectiveList) {
				objective.IDP__c = null;
			}
			prepareObjectiveWrapperList();
		}
		
		if(operation == 'Edit' || operation == 'Clone') {
			stepSequence = 'Start';
			setStepFlags(false);
		} else if(operation == 'Submit' || operation == 'Review') {
			stepSequence = 'Step06';
			setStepFlags(false);
		} else if(operation == 'IDPInformation') {
		stepSequence = 'Start';
			setStepFlags(false);
		} else if(operation == 'LongTermGoals') {
		stepSequence = 'Step01';
			setStepFlags(false);
		} else if(operation == 'ShortTermGoals') {
		stepSequence = 'Step02';
			setStepFlags(false);
		} else if(operation == 'Objective') {
		stepSequence = 'Step03';
			setStepFlags(false);
		} else if(operation == 'Activities') {
		stepSequence = 'Step04';
			setStepFlags(false);
		} else if(operation == 'Competencies') {
		stepSequence = 'Step05';
			setStepFlags(false);
		}
		
		
	}
	
	
	/*************************** DML operation methods ********************/
	public PageReference save() {

		//System.debug('This is StepSequence ' + stepSequence);
		if(stepSequence == 'Step02') {
			if(newIDP.Career_Goals_Long_Run__c.length() == 0) {
			  chkbxStp02 = false;
			}
			else {
				chkbxStp02 = true;
			}
		}
		
		if(stepSequence == 'Step03') {
			if(newIDP.Career_Goals_Short_Run__c.length() == 0){ 
				chkbxStp03 = false;
			}
			else {
				chkbxStp03 = true;
			}
		}
		try{
			if(stepSequence == 'Step01' || stepSequence == 'Step02' || stepSequence == 'Step03') {
				Boolean isValid;  
				isValid = validateIDPInfo();
				if(isValid) { 
					upsert newIDP;
					newIDP = retrieveIDPDetails(newIDP.id);
				} else{
					return null;
				}
			} else if(stepSequence == 'Step04') {
				System.debug('In Step 04');
				System.debug('This is Objective ' + newObjective);
				if(newObjective.IDP__c == null) {
					System.debug('No IDP');
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c != null) {
						System.debug('Title and Objective');
						newObjective.IDP__c = newIDP.Id;
						upsert newObjective; 
						//retriveObjectives(); 
					}
					if(newObjective.Objective_Title__c == null && newObjective.Objective__c.length() != 0) {
						System.debug('No Title');
						addErrorMessage('Objective Title: Please enter Objective Title.');
						return null;
					}
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c.length() == 0) {
						System.debug('No Objective');
						addErrorMessage('Objective: Please enter Objective.');
						return null;
					}
				} else {
					System.debug('Yes IDP');
					System.debug('Yes Objective ' + newObjective.Objective_Title__c + ' === ' + newObjective.Objective__c);
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c.length() != 0) {
						upsert newObjective; 
					} else {
						addErrorMessage('Objective: Please enter Objective and Objective Title.');
					}
				}
				
				
				
			} else if(stepSequence == 'Step05') { 
				upsert newIDP;
				List< IDP_Developmental_Line_Item__c> selectedActvityList = new List< IDP_Developmental_Line_Item__c>();
				Map<String, IDP_Developmental_Line_Item__c> objectiveActivityMap = new Map<String, IDP_Developmental_Line_Item__c>();
				Integer selectedActivitySize = 0;
				for(ActivityWrapper wrapper :activityWrapperList) {
					if(wrapper.checked == true) {selectedActivitySize++; if(objectiveActivityMap.get(selectedObjective.Name+wrapper.activity.Name) == null) { selectedActvityList.add(wrapper.activity); } }
				}
				if(selectedActivitySize == 0) {
					addInformationMessage('Please SELECT activities to Save'); 
					return null;
				} else if(selectedActvityList.size() == 0) {
					addInformationMessage('Data saved successfully'); 
					return null;  
				} else{
					return null;
				}
				retrieveActivities();
				retrieveActivitiesForObject();  
			}
			
		}catch(Exception ex) {
			addErrorMessage('Error while saving data.');
			System.debug('Error while saving data.'+ex.getMessage() +' at '+ex.getLineNumber());
		}
		return null;
	}
	
	
	public pageReference clearGoalText() {
		if(stepSequence == 'Step02') {
			Boolean isValid = validateIDPInfo();
			if(isValid) {
				newIDP.Career_Goals_Long_Run__c = '';
				upsert newIDP;
				newIDP = retrieveIDPDetails(newIDP.id);
			} else{
				return null;
			}
		} else {
			if(stepSequence == 'Step03') {
				Boolean isValid = validateIDPInfo();
				if(isValid) {
					newIDP.Career_Goals_Short_Run__c= '';
					upsert newIDP;
					newIDP = retrieveIDPDetails(newIDP.id);
				} else{
					return null;
				}
			}
		
		}
		return null;
	}
	
	public PageReference submit() {  

		Integer cFY = getFiscalYear();
		Integer pFY = cFY - 1;
		String preFY = 'FY ' + string.valueOf(pFY);
		if(preFY == newIDP.Fiscal_Year_pick__c) { addErrorMessage('Please update the '+'"Fiscal Year"'+' field to a Current Fiscal Year or Future Fiscal Year'); return null; } 
		else {
			Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
			req1.setObjectId(newIDP.id);
			
			Approval.ProcessResult result = Approval.process(req1);
			PageReference pageRef = new PageReference('/apex/IDP_ViewPage');
			return pageRef;
		}
		return null;

	}
	
	//Nithin -- Approval Process
	public PageReference submitForApproval() {
		
		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
		req1.setObjectId(newIDP.id);
		
		Approval.ProcessResult result = Approval.process(req1);
		PageReference pageRef = new PageReference('/apex/IDP_ViewPage');
		pageRef.setRedirect(true);
		return pageRef;
		
	}
	
	public void addErrorMessage(String message) {

		ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, message);
		ApexPages.addMessage(msg);

	}
	
	public void addInformationMessage(String message) {

		ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO, message);
		ApexPages.addMessage(msg);

	}
	
	/************************* Validation methods ***********************/
	
	/***** For Activity Title ****/
	private Boolean validateIDPInfo() {

		return true;

	}
	
	private Boolean validateActivityInfo() {

		System.debug('Validate Activity');
		Boolean result = true;
		if (newActivity.Assignment_Title__c == null || newActivity.Assignment_Title__c.trim().length() == 0) {
			addErrorMessage('Please enter Activity Name to add Activity.');
			result = false;
		} 
		
		if (newActivity.Planned_Start_Date__c > newActivity.Planned_End_Date__c) {
			addErrorMessage('Activity Planned Start Date can not be later than Planned End date');
			result = false;
		}
		
		if (newActivity.Required_Date__c < newActivity.Planned_End_Date__c || newActivity.Required_Date__c < newActivity.Planned_Start_Date__c) {
			addErrorMessage('Required Date must be later than Planned End date');
			result = false;
		}

		List<Developmental_Objective__c> objective=[SELECT IDP__r.Id FROM Developmental_Objective__c where Id =: newActivity.Developmental_Objective__c];
		
		if (objective.size()!=0 && objective[0].IDP__r.Id != newIDP.Id) { addErrorMessage('The Objective you selected does not belong to the current IDP. Please SELECT the Objective related to current IDP ('+newIDP.Name+')'); result = false; } 

		if(objective.size() == 0) {
			addErrorMessage('Please select an objective before saving');
			result = false;
		}
		
		return result;

	}
	
	private Boolean validateRequiredDateInfo() {
		if((newActivity.Training_Need__c =='Required') && (newActivity.Required_Date__c == null)) {
			addErrorMessage('Please enter Required Date to add Activity.');
			return false;
		}
		return true;
	}
	
	public Integer getFiscalYear() {

		Integer curFY;
		FiscalYearStartMonth__c getFiscalYearStartMonth = FiscalYearStartMonth__c.getValues('Fiscal Year Start Month');
		Decimal FiscalYearStartMonth = getFiscalYearStartMonth.Fiscal_Year_Start_Month__c;
		//System.debug('This is Fiscal Year Start Month ' + FiscalYearStartMonth);
		Date sdate = Date.today();
		Integer month = sdate.month();
		Integer year = sdate.year();
		//System.debug('Month ===>>> ' + month + ' Year ===>>> ' + year);
		if(month < Integer.valueOf(FiscalYearStartMonth)) {	curFY = year; } 
		else {
			curFY = year+1;
		}
		return curFY;

	}
	
	public Integer getIDPsByFY(String fiscalYear) {

		System.debug('This is Fiscal Year ' + fiscalYear);
		Id userId = UserInfo.getUserId();
		Integer countIDPsFY = [SELECT COUNT() 
								FROM IDP__c 
								WHERE CreatedById = :UserInfo.getUserId() 
								AND Fiscal_Year_pick__c = :fiscalYear 
								AND IDP_Status__c IN ('New', 'Resubmit', 'Supervisor Review', 'Needs Revision') 
								AND Id != : newIDP.Id 
								LIMIT 10];
		return countIDPsFY;

	}
	
	/************************* Navigation Methods ***********************/
	
	public PageReference next() {
		newRec = false;//Nithin
		Integer cFY = getFiscalYear();
		String curFY = 'FY ' + string.valueOf(cFY);
		Integer fFY = cFY + 1;
		String furFY = 'FY '+ string.valueOf(fFY);
		Integer pFY = cFY - 1;
		String preFY = 'FY ' + string.valueOf(pFY);
		System.debug('This is Previous FY ' + preFY);
		System.debug('This is furture ' + furFY);
		Integer curFYIDPS = getIDPsByFY(curFY);
		Integer furFYIDPS = getIDPsByFY(furFY);
		Integer preFYIDPS = getIDPsByFY(preFY);
		System.debug('Previous FYIDPS ' + preFYIDPS + ' Current FYIDPS ' + curFYIDPS + ' Future FYIDPS ' + furFYIDPS);
		if(preFYIDPS > 0 && preFY == newIDP.Fiscal_Year_pick__c) {
			addErrorMessage('You cannot create an IDP for ' + newIDP.Fiscal_Year_pick__c + ' because there is already an IDP in progress for this FY (Status is either in "New", "Resubmit", "Supervisor Review" or "Needs Revision"). Please wait until your IDP has been "Approved". ');
			return null;
		} 
		if(preFY == newIDP.Fiscal_Year_pick__c) {addErrorMessage('Please update the '+'"Fiscal Year"'+' field to a Current Fiscal Year or Future Fiscal Year');	return null; }
		if(curFYIDPS > 0 && curFY == newIDP.Fiscal_Year_pick__c) {addErrorMessage('You cannot create an IDP for ' + newIDP.Fiscal_Year_pick__c + ' because there is already an IDP in progress for this FY (Status is either in "New", "Resubmit", "Supervisor Review" or "Needs Revision"). Please wait until your IDP has been "Approved". '); return null; } 
		if(furFYIDPS > 0 && furFY == newIDP.Fiscal_Year_pick__c) {addErrorMessage('You cannot create an IDP for ' + newIDP.Fiscal_Year_pick__c + ' because there is already an IDP in progress for this FY (Status is either in "New", "Resubmit", "Supervisor Review" or "Needs Revision"). Please wait until your IDP has been "Approved". '); return null; }
		System.debug('FRST STEP '+stepSequence);
		if(stepSequence == 'Step01') {
			if(newIDP.Supervisor__c == null) { chkbxStp01 = false; } 
			else {
				chkbxStp01 = true;
			}
			if(newIDP.Supervisor__c == userInfo.getUserId()) {
				addErrorMessage('Supervisor: Please SELECT a user other than yourself.');
				return null;
			}
			if(newIDP.Director__c == userInfo.getUserId()) { addErrorMessage('Other Viewer: Please SELECT a user other than yourself.'); return null; } update newIDP;
		}
		
		
		if(stepSequence == 'Step02') {
			if(newIDP.Career_Goals_Long_Run__c.length() == 0) {
				chkbxStp02 = false;
			}
			else {
				chkbxStp02 = true;
			}
			update newIDP;
		}
		
		if(stepSequence == 'Step03') {
			if(newIDP.Career_Goals_Short_Run__c.length() == 0) {
				chkbxStp03 = false;
			}
			else {
				chkbxStp03 = true;
			}
			update newIDP;
		}
		
		
		if(stepSequence == 'Step04' ) { 
			retrieveObjectives();
			if (objectiveWrapperList.size() == 0 && newObjective.Objective_Title__c == null) { chkbxStp04 = false; } 
			else { 
				if(newObjective.IDP__c == null) {  
				System.debug('In If '); 
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c != null) {
						System.debug('Title and Objective');
						newObjective.IDP__c = newIDP.Id;
						upsert newObjective;  
					} 
					if(newObjective.Objective_Title__c == null && newObjective.Objective__c.length() != 0) { System.debug('No Title'); addErrorMessage('Objective Title: Please enter Objective Title.'); return null; }
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c.length() == 0) { System.debug('No Objective'); addErrorMessage('Objective: Please enter Objective.'); return null; } 
				} else {
					System.debug('In Else');
					//System.debug('This is Objective ' + newObjective);
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c != null) {
						System.debug('Title and Objective');
						//newObjective.IDP__c = newIDP.Id;
						upsert newObjective;  
					} if(newObjective.Objective_Title__c == null && newObjective.Objective__c.length() != 0) {
						System.debug('No Title');
						addErrorMessage('Objective Title: Please enter Objective Title.');
						return null;
					}
					if(newObjective.Objective_Title__c != null && newObjective.Objective__c.length() == 0) {
						System.debug('No Objective');
						addErrorMessage('Objective: Please enter Objective.');
						return null;
					}					
				}
				chkbxStp04 = true;  
			}
			
		}
		
		if(stepSequence == 'Step05') {
			newIDP = retrieveIDPDetails(newIDP.id); 
			System.debug('IDP ================ ' + newIDP);
			String idpFYYearPickVal = newIDP.Fiscal_Year_pick__c;
			System.debug(newIDP + ' ---> ' + idpFYYearPickVal);
			String idpFYYearStringVal = idpFYYearPickVal.right(4);
			Integer idpFYYear = Integer.valueOf(idpFYYearStringVal);
			Date fiscalYearStartDate = Date.valueOf(idpFYYear-1 + '-' + '10' + '-' + '01'); 
			Date fiscalYearEndDate = Date.valueOf(idpFYYear + '-' + '09' + '-' + '30');
			System.debug('In the next method');  
			System.debug(newActivity + ' This is Objective ' + devObjId + 'This is Activity Id ' + devActId);  
			//if(activityList.size() == 0) {
			List<IDP_Developmental_Line_Item__c> lstAct = [SELECT Id, Developmental_Objective__c, Completed_Date__c FROM IDP_Developmental_Line_Item__c WHERE Id = :devActId LIMIT 1];
			List<Developmental_Objective__c> lstObj = [SELECT Id, IDP__c FROM Developmental_Objective__c WHERE Id = :newActivity.Developmental_Objective__c];
			if(newIDP.IDP_Status__c == 'Approved') {
				newActivity.Developmental_Objective__c = devObjId;
				newActivity.Id = devActId;
				upsert newActivity;
			}
			if(newActivity.Developmental_Objective__c != null && newActivity.Assignment_Title__c != null && newActivity.Activity_Type_List__c != null) {
				if(lstObj.size() != 0 && lstObj[0].IDP__c != newIDP.Id) {
					ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'The Objective you selected does not belong to the current IDP. Please SELECT the Objective related to current IDP ('+newIDP.Name+') '));
					return null;
				}
				if(((newActivity.Planned_Start_Date__c >= fiscalYearStartDate && newActivity.Planned_Start_Date__c <= fiscalYearEndDate) || newActivity.Planned_Start_Date__c == null)) {
				upsert newActivity;
				chkbxStp05 = true; 		
				} else {
					ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Activity Planned Start date should be within current fiscal Year'));
					return null;
				}if(newActivity.Training_Need__c == 'Required' && newActivity.Required_Date__c == null) {
					ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Required Date'));
					return null;
				} else {
					upsert newActivity;
					chkbxStp05 = true; 	
				}
				if(newActivity.Planned_Start_Date__c > newActivity.Planned_End_Date__c) {
					ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Activity Planned End date should be greater than Activity Planned Start Date'));
					return null;		 		
				} else {
					System.debug('This is Activity ' + newActivity);
					upsert newActivity; 
					chkbxStp05 = true;
					
				}
			} else {
					if(activityList.size() == 0) {
						chkbxStp05 = false; 
				}
			}
		}
		
		if(stepSequence == 'Step06') {
			System.debug('This is Comp Activity ' + compAct);
			if(competencyList.size() == 0) { chkbxStp06 = false; } //else {
			if(compAct == 'Yes') { List<IDP_Developmental_Line_Item__c> activityLookup = [SELECT Id, Name, IDP_ID__c FROM IDP_Developmental_Line_Item__c WHERE Id =: competency.Developmental_Activity__c];	System.debug('In Yes');
				if(competency.Developmental_Activity__c == null ) {	addErrorMessage('SELECT Activity: Please SELECT Activity.'); return null; } 
				else if(selectModel == null) { addErrorMessage('Competency Model: Please SELECT Competency Model.'); return null; } 
				else if ((activityLookup.size() != 0 && activityLookup[0].IDP_ID__c != newIDP.Id)) { ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'The Activity you selected does not belong to the Current IDP. Please SELECT a different Activity'));	return null; } 
				else { competency.Developmental_Activity__c = competency.Developmental_Activity__c; competency.Competency_Model__c = selectModel; competency.Competency_Area__c = SELECTArea; competency.Competency__c = SELECTComp; upsert competency;	}
			}
			chkbxStp06 = true;
			//}
		}

		Integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		
		if(stepSequence == 'Step03') {
			if(newObjective.Id == null) {
				// do nothing? CC
			}
		} else if(stepSequence == 'Step04') {
			retrieveObjectives();
			if (objectiveWrapperList.size() == 0) {
				chkbxStp04 = false;
				chkbxStp05 = false;
				chkbxStp06 = false;
				chkbxStp07 = false;
				addErrorMessage('Objective: Validation Error: Please enter and Save at least one Objective before clicking Next.');
				return null;
			}
		}
		setStepFlags(false);
		return null;
	}
	
	public PageReference cancel() {
		if ((newIDPRec != null) && newRec) {
			deleteUponCancelOnlyFristTime = false;
			delete newIDP;
		}  
			
		PageReference pageRef = new PageReference('/apex/IDP_ViewPage?sfdc.tabName=01r30000001W5n7');
		return pageRef;
	}
	
	public PageReference back() {
		if(stepSequence == 'Step05') { 
			addActivity();
			newObjective = new Developmental_Objective__c();
			newObjective.IDP__c = newIDP.id;
		}
		setStepFlags(true);
		return null;
	}
	
	public PageReference gotoIDPDetailPage() {
		PageReference pageRef = new PageReference('/'+newIDP.id);
		return pageRef; 
	}
	
	public PageReference gotoIDPObjectiveDetailPage() {
		PageReference pageRef = new PageReference('/'+selectedObjective.id);
		return pageRef; 
	}
	
	private void setStepFlags(Boolean isBack) {
		// IDP Info page 1
		if(stepSequence == 'Start') {
			showStep01 = true;
			showStep02 = false;
			showStep03 = false;
			showStep04 = false;
			showStep05 = false;
			showStep06 = false;
			showStep07 = false;
		}if(stepSequence == 'Step01') { //page1 IDP Information
			showStep01 = false;
			showStep02 = true;
			showStep03 = false;
			showStep04 = false;
			showStep05 = false;
			showStep06 = false;
			showStep07 = false;
		} else if(stepSequence == 'Step02') { //page 2 Long-Term Goals
			showStep01 = isBack; 
			showStep02 = false;
			showStep03 = !isBack;
			showStep04 = false;
			showStep05 = false;
			showStep06 = false;
			showStep07 = false;
		} else if(stepSequence == 'Step03') { //page 3 Short-Term Goals
			showStep01 = false;
			showStep02 = isBack;
			showStep03 = false;
			showStep04 = !isBack;
			showStep05 = false;
			showStep06 = false;
			showStep07 = false;
		} else if(stepSequence == 'Step04') { //page 4 Objective(s)
			showStep01 = false;
			showStep02 = false;
			showStep03 = isBack;
			showStep04 = false;
			showStep05 = !isBack;
			showStep06 = false;
			showStep07 = false;
		} else if(stepSequence == 'Step05') { //page 5 Activities
			showStep01 = false;
			showStep02 = false;
			showStep03 = false;
			showStep04 = isBack;
			showStep05 = false;
			showStep06 = !isBack;
			showStep07 = false;
		} else if(stepSequence == 'Step06') { //page 6 Competencies
			showStep01 = false;
			showStep02 = false;
			showStep03 = false;
			showStep04 = false;
			showStep05 = isBack;
			showStep06 = false;
			showStep07 = !isBack;
		} else if(stepSequence == 'Step07') { //page 7 Review and Submit
		showStep01 = false;
			showStep02 = false;
			showStep03 = false;
			showStep04 = false;
			showStep05 = false;
			showStep06 = isBack;
			showStep07 = true;
		}
	}

	/****************** Wrapper Classes for UI presentation **************/
	public class ObjectiveWrapper{

		public Developmental_Objective__c objective{get;set;}
		public Integer index{get;set;}
		public Boolean checked{get;set;}

		public ObjectiveWrapper(Developmental_Objective__c objective, Integer index) {
			this.objective = objective;
			this.index = index;
			this.checked = false;
		}

	}

	public class ActivityWrapper{
		
		public IDP_Developmental_Line_Item__c activity{get;set;}
		public Integer index{get;set;}
		public Boolean checked{get;set;}

		public ActivityWrapper(IDP_Developmental_Line_Item__c activity, Integer index) {
			this.activity = activity;
			this.index = index;
			this.checked = false;
		}

	}

	public class CompetencyWrapper{

		public Developmental_Competency__c competency{get; set;}
		public Integer index{get; set;}
		public Boolean checked{get; set;}

		public CompetencyWrapper(Developmental_Competency__c competency, Integer index) {
			this.competency = competency;
			this.index = index;
			this.checked = false;
		}

	}

	// START Christian's Christian's changes for story #20
	public boolean displayPopupObjective {get; set;}
	public boolean displayPopupActivity {get; set;}
	public List<Developmental_Objective__c> objectiveListForSelection {get; set;}
	public List<IDP_Developmental_Line_Item__c> activityListForSelection {get; set;}
	public Id objectiveId {get; set;}
	public Id activityId {get; set;}
	public String selectedObjectiveName {get; set;}
	public String selectedActivityName {get; set;}
	
	public void showPopupObjective() {
		getRelatedObjectives();
		displayPopupObjective = true;
	}

	public void showPopupActivity(){
		getRelatedActivities();
		displayPopupActivity = true;
	}

	public void closePopupObjective() {
		displayPopupObjective = false;
	}

	public void closePopupActivity(){
		displayPopupActivity = false;
	}

	public void getRelatedObjectives(){
		objectiveListForSelection = [SELECT Id, Name, IDP__c, Objective__c, Objective_Title__c, CreatedDate 
										FROM Developmental_Objective__c 
										WHERE IDP__c = :newIDP.Id];
	}

	public void getRelatedActivities(){
		activityListForSelection = [SELECT Id, Name, Total_Cost__c, Assignment_Title__c, Create_Date__c, Planned_Start_Date__c, Planned_End_Date__c, 
											Activity_Type__c, Developmental_Objective__r.IDP__c
										FROM IDP_Developmental_Line_Item__c
										WHERE Developmental_Objective__r.IDP__c = :newIDP.Id
										ORDER BY Name ASC];
	}

	public void selectObjectiveFiltered(){
		displayPopupObjective = false;
		newActivity.Developmental_Objective__c = (Id) objectiveId;
		//System.debug('#@#@@#@#@#@' + newIDP);
	}

	public void selectActivityFiltered(){
		displayPopupActivity = false;
		competency.Developmental_Activity__c = (Id) activityId;
		getActivityName();
	}
	// END Christian's changes for story #20
 
}