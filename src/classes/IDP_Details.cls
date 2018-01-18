public with sharing class IDP_Details{

	public static boolean isTest = false;

	public String fiscalYear {get; set;}
	public Integer idpStatusCnt {get; set;}
	
	public List<IDPWrapper> currentIDPList = new List<IDPWrapper>();
	public List<IDPWrapper> previousIDPList = new List<IDPWrapper>();
	public List<IDPWrapper> approvalIDPList = new List<IDPWrapper>();
	
	public String idpID{get;set;}
	public IDP__c approvedIDP{ get; set; }
	public Boolean buttonDisp {get; set; }
	public Boolean preClone {get; set;}
	public Boolean curClone {get; set;}
	public Boolean furClone {get; set;}
	public string pFY {get; set;}
	public String cFY {get; set;}
	public String fFY {get; set;}
	public String idpIDValue {get; set;}
	public Boolean refresh {get; set;}
	public String currentFY {get; set;}
	public String futureFY {get; set;}
	public String selectedFY {get; set;}
	public IDP_Details(){
		refresh = false;
		buttonDisp = false;
		curClone = false;
		furClone = false;      
		preClone = false;
		retrieveIDPs();
	}
	
	
	public List<SelectOption> getFiscalYearPiclist(){			
			currentFY = getCurrentFiscalYear();
			currentFY = 'FY ' + currentFY;
			Integer fiscal = Integer.valueOf(getCurrentFiscalYear());
			fiscal = fiscal+1;
			futureFY = 'FY '+String.valueOf(fiscal);
	        List<SelectOption> options = new List<SelectOption>();
	        options.add(new SelectOption('None','--None--'));
	        Schema.DescribeFieldResult fieldResult = IDP__c.Fiscal_Year_pick__c.getDescribe();
	        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        for(Schema.PicklistEntry p : ple) {
	        	if(p.getValue() == currentFY || p.getValue() == futureFY)
		        options.add(new SelectOption(p.getValue(), p.getValue()));   
	        }
	        system.debug('PicklistOptions ' + options);     
	        return options;
	    }
	
	private void retrieveIDPs(){
		
		Integer year = Date.today().year();
		Date todayAdd92 = Date.today().addDays(92);
		
		
		//Lookup the current IDP FY from Custom Settings in the IDPCustomSettings name.  10/20/2015  T. Carlough
		List<app_properties__c> IDPFiscalYear = [select value__c from app_properties__c where name = 'IDPCurrentFiscalYear'];
		Double idpCustomSettingFiscalYear = Double.valueOf(IDPFiscalYear[0].value__c);

		//System.debug('year is'+year);
		List<IDP__c> ownIDPs = [SELECT id, Name, IDP_Names__c, IDP_Status__c, Create_Date__c, Fiscal_Year_pick__c
								FROM IDP__c 
								WHERE CreatedById = :UserInfo.getUserId() 
								ORDER BY Name DESC];
		system.debug('These are my own IDPs ' + ownIDPs);
		for(IDP__c idp:ownIDPs){
			
			String idpFYYearPickVal = idp.Fiscal_Year_pick__c;
			system.debug('idpFYYearPickVal ========= ' + idpFYYearPickVal);
			String idpFYYearStringVal = idpFYYearPickVal.right(4);
			Double idpFYYear = Double.valueOf(idpFYYearStringVal);
			
			//if(idp.Year__c >= year)
			//if(idpFYYear < 2014)
			//Update to list all archived IDP's in the previous IDP list as well as pull FY from Custom Setting 10/20/2015 - T. Carlough
			if(idpFYYear < idpCustomSettingFiscalYear || idp.IDP_Status__c == 'Archived')
				previousIDPList.add(new IDPWrapper(idp,false,true));
			else
				currentIDPList.add(new IDPWrapper(idp,false,false));
		}
	}
	
	public List<IDPWrapper> getCurrentIDPS(){
	return currentIDPList;
	}
	
	public List<IDPWrapper> getPreviousIDPS(){
	return previousIDPList;
	}
	
	public List<IDPWrapper> getApprovalIDPS(){
	return approvalIDPList;
	}
	
	public PageReference gotoIDPDetailPage(){
	PageReference pageRef = new PageReference('/'+idpID);
	// pageReference pageref new PageRefarence('');
	return pageRef;  
	}
	
	public PageReference editIDP(){
	PageReference pageRef = createPageReference();
	pageRef.getParameters().put('id',idpID);
	pageRef.getParameters().put('operation','Edit');
	return pageRef;
	}
	
	
	public Boolean isValid(){
		Integer fy = [SELECT COUNT() FROM IDP__c WHERE CreatedById = :UserInfo.getUserId() AND Fiscal_Year_pick__c = :selectedFY 
		              AND IDP_Status__c IN('New','Supervisor Review','Needs Revision','Resubmit')];
		
		if(fy > 0){
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot create an IDP for ' + selectedFY + ' because there is already an IDP in progress for this FY (Status is either in "New", "Resubmit", "Supervisor Review" or "Needs Revision"). Please wait until your IDP has been "Approved".'));
			return false;		
		}
		
		if(selectedFY == 'None' || selectedFY ==''){
			system.debug('In If Condition');
			 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select Fiscal Year'));
			return false;
		}
		
		return true;
	}

	public PageReference cloneIDP(){
		idpId = idpIdValue;
		system.debug('This is IDP Id ' + idpId);		
		system.debug('Fiscal Year ' + selectedFY);
		
		if(!isValid()){
			refresh = false;
		}
		 else {
			IDP_ClonePlusController cloneCtrler = new IDP_ClonePlusController(idpId, selectedFY);
			cloneCtrler.initialiseObjectsForCloning(selectedFY);
			currentIDPList = new List<IDPWrapper>();
			previousIDPList = new List<IDPWrapper>();
			approvalIDPList = new List<IDPWrapper>();        
			updateIDPStatus();      
			refresh = true;
		}  
		return null;
	}
	
	public PageReference submitIDP(){
	PageReference pageRef = createPageReference();
	pageRef.getParameters().put('id',idpID);
	pageRef.getParameters().put('operation','Submit');
	return pageRef;    
	}
	
	public PageReference reviewIDP(){
	PageReference pageRef = createPageReference();
	pageRef.getParameters().put('id',idpID);
	pageRef.getParameters().put('operation','Review');
	return pageRef;
	}
	
	public PageReference continueEditingIDP(){
	PageReference pageRef = createPageReference();
	pageRef.getParameters().put('id',idpID);
	pageRef.getParameters().put('operation','IDPInformation');
	pageRef.getParameters().put('fiscalYear',fiscalYear);
	return pageRef;
	}
	
	public PageReference recallApproval(){
	  PageReference pageRef = createPageReference();
	  //system.debug('Original Record id ' + pageRef.getParameters().put('id',idpID));
	  pageRef.getParameters().put('id',idpID);
	  Id recId = pageRef.getParameters().put('id',idpID);
	  system.debug('Record id ' + recId);
	  
		List<ProcessInstanceWorkitem> piwi = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: recId];
		Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
		req.setAction('Removed');        
		req.setWorkitemId(piwi.get(0).Id);
		Approval.process(req,false);  
		 PageReference redirect = new PageReference('/apex/IDP_ViewPage');
		return redirect;            
	}
	
	public PageReference deleteIDP(){ 
		IDP__c deleteIDP = [SELECT Id
							FROM IDP__c
							WHERE Id = :idpID
							LIMIT 1];
							
		delete deleteIDP;
		
		currentIDPList = new List<IDPWrapper>();
		previousIDPList = new List<IDPWrapper>();
		approvalIDPList = new List<IDPWrapper>();
		
		updateIDPStatus();
		return null;
	}
	
	private String urlString;
	
	public string getCurrentFiscalYear(){
		String cfyVal;
		FiscalYearStartMonth__c getFiscalYearStartMonth = FiscalYearStartMonth__c.getValues('Fiscal Year Start Month');
	    Decimal FiscalYearStartMonth = getFiscalYearStartMonth.Fiscal_Year_Start_Month__c;
	    Date sdate = Date.today();
		Integer month = Integer.valueOf(sdate.month());
		Integer year = sdate.year();
			if(month <  Integer.valueOf(FiscalYearStartMonth) || isTest) {
				cfyVal = string.valueOf(year);
				cfyVal = cfyVal;
			} else {
				cfyVal = string.valueOf(year+1);
				cfyVal = cfyVal;
				
			}
		system.debug('====cfyVal===='+ cfyVal );	
		return cfyVal;
	}
	
	public Boolean getIDPsFiscalYear(){
	  String curFY;
	  String furFY;
	  String preFY;      
	  string fiscalYear;
	  Integer idps;      
	  FiscalYearStartMonth__c getFiscalYearStartMonth = FiscalYearStartMonth__c.getValues('Fiscal Year Start Month');
	  Decimal FiscalYearStartMonth = getFiscalYearStartMonth.Fiscal_Year_Start_Month__c;
		system.debug('This is Fiscal Year Start Month ' + FiscalYearStartMonth);
		Date sdate = Date.today();
		Integer month = Integer.valueOf(sdate.month());
		Integer year = sdate.year();
		system.debug('Month ===>>> ' + month + ' Year ===>>> ' + year);
		if(month <  Integer.valueOf(FiscalYearStartMonth) || isTest) {
			//System.debug('Current month number is less than 10');
		  curFY = string.valueOf(year);
		  curFY = 'FY ' + curFY;
		  furFY = string.valueOf(year+1);
		  furFY = 'FY ' + furFY;
		  preFY = string.valueOf(year-1);
		  preFY = 'FY ' + preFY;
		}
		else {
			//System.debug('Current month number is equal or greater than 10');
			curFY = string.valueOf(year+1);
			curFY = 'FY ' + curFY;
		  furFY = string.valueOf(year+2);
		  furFY = 'FY ' + furFY;
		  preFY = string.valueOf(year); 
			preFY = 'FY ' + preFY;
		}
	system.debug('This is Current Fiscal Year ' + curFY);
	system.debug('This is Future Fiscal Year ' + furFY);
	system.debug('This is Previous Fiscal Year ' + preFY); 
	Id userId = UserInfo.getUserId();
	//system.debug(userId);
	Integer idpPreFY = [SELECT COUNT() FROM IDP__c WHERE CreatedById = :UserInfo.getUserId() AND Fiscal_Year_pick__c = :preFY AND IDP_Status__c IN('New','Supervisor Review','Needs Revision','Resubmit')];
	Integer idpCurFY = [SELECT COUNT() FROM IDP__c WHERE CreatedById = :UserInfo.getUserId() AND Fiscal_Year_pick__c = :curFY AND IDP_Status__c IN('New','Supervisor Review','Needs Revision','Resubmit')];
	Integer idpFurFY = [SELECT COUNT() FROM IDP__c WHERE CreatedById = :UserInfo.getUserId() AND Fiscal_Year_pick__c = :furFY AND IDP_Status__c IN('New','Supervisor Review','Needs Revision','Resubmit')];
	system.debug('Pre FY ' + idpPreFY + ' ' + preFY + ' Cur FY ' + idpCurFY + ' ' + CurFY + ' Fur FY ' + ' ' + FurFY + ' ' + idpFurFY);    
	if(idpCurFY == 0 || isTest){
	  idps = 0;
	  buttonDisp = true;
	  curClone = true;
	  pFY = preFY;
	  cFY = curFY;
	  fFY = furFY;
			system.debug('This is Current FY ' + cFY);  
	}
	if(idpFurFY == 0 || isTest){
	  buttonDisp = true;
	  furClone = true;
	  pFY = preFY;
	  cFY = curFY;
	  fFY = furFY;
			system.debug('This is Future FY ' + fFY);  
	}
	if(idpPreFY == 0) {
	  buttonDisp = true;
	  preClone = true;
	  pFY = preFY;  
			cFY = curFY;
	  fFY = furFY;
	  system.debug('This is Previous FY ' + pFY + ' Pre Clone ' + preClone + ' cFY ' + cFY + ' fFY ' + fFY);  
	}
		return buttonDisp;
	}
	
	public IDP__c newIDP{ get; set; }
	
	public PageReference createIDP(){
		IDP__c newIDP = new IDP__c();
		Date sdate = Date.today();
		Integer year = sdate.year();
		String curFiscalYear = 'FY '+String.valueOf(year);
		newIDP.Fiscal_Year_pick__c = curFiscalYear;
		insert newIDP;

		String newIDPRec;
		urlString='/apex/IDP_Wizard?Id='+newIDP.Id;
		urlString += '&newIDPRec='+'newRec';
		PageReference PageRef = new PageReference(urlString);
		
		return pageRef;
	}
	
	
	public PageReference updateIDPStatus(){       
		List<IDP__c> UserIDPs = [SELECT Id
									FROM IDP__c 
									WHERE CreatedById = :UserInfo.getUserId() AND (IDP_Status__c = 'Resubmit' OR 
									IDP_Status__c = 'Supervisor Review' OR IDP_Status__c = 'Needs Revision')];
		
		idpStatusCnt = UserIDPs.size();
		
		currentIDPList = new List<IDPWrapper>();
		previousIDPList = new List<IDPWrapper>();
		approvalIDPList = new List<IDPWrapper>();
				
		retrieveIDPs();
		getIDPsFiscalYear();
		
		return null;
	}
	
	public PageReference createPageReference(){
	
	
	PageReference pageRef = new PageReference('/apex/IDP_Wizard');
	return pageRef;
	}
	
	public class IDPWrapper{
	public IDP__c idp{get;set;}
	public Boolean edit{get;set;}
	public Boolean clone{get;set;}
	public Boolean submit{get;set;}
	public Boolean view{get;set;}
	public Boolean approval{get;set;}
	public IDPWrapper(IDP__c idp,Boolean tobeApproved,Boolean previousYear){
		this.idp = idp;
		
		this.edit = false;
		this.clone = false;
		this.submit = false;
		this.view = false;
		this.approval = false;
		
		if(!previousYear){
		
		if(tobeApproved == true){
			this.approval = true;
		}else{        
		}
			
			this.clone = true;
		}
		
		}
		
	
	}
}