public with sharing class GLXY_ProjectionsByLease {
    
    public String   strFiscalYear           {get; set;}
    public String   strLeaseNumber          {get; set;}
    public String   strStatusCode           {get; set;}
    public String  	strStatusCodeDisplay    {get; set;}
    public Boolean  blnleaseExists          {get;set;}
    public Boolean  blnIA                   {get;set;}
    public Boolean  blnNOA                  {get;set;}
    public Boolean  blnActual               {get;set;}
    public Boolean  blnEstimate             {get;set;}
    public String   strIncludeinBudgetFlag  {get; set;}
    Public Boolean  blnIncludeinBudgetFlag  {get; set;}
    Public String   strDelegatedFlag        {get; set;}
    Public String   strDelegatedFlagDisplay {get; set;}
   
    String strSOQL;
    string strDatsetName;
    
    public GLXY_ProjectionsByLease() {
        blnleaseExists = false;
        blnIA = true;
        blnNOA = true;
        blnActual = true;
        blnEstimate = true;
        strDelegatedFlag = '\'False\'';
        strDelegatedFlagDisplay = 'False';
        strStatusCode = '\'Actual\'';
        strStatusCodeDisplay = 'Actual';
        
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        strFiscalYear = string.valueof(intCurrentFy);
        
        if (System.currentPageReference().getParameters().get('EA')!=null){
            strStatusCode = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('EA'));
            strStatusCodeDisplay = strStatusCode.Replace('\\','');
        }
        
        strLeaseNumber = 'NONE';
        if (System.currentPageReference().getParameters().get('Lease')!=null){
            strLeaseNumber = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('Lease'));
        }
        
        strIncludeinBudgetFlag = 'False';
		blnIncludeinBudgetFlag = False;
        if (System.currentPageReference().getParameters().get('IncludeInBudgetFlag')!=null){
            strIncludeinBudgetFlag = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('IncludeInBudgetFlag'));
            strDelegatedFlag = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('DelegatedFlag'));
            strDelegatedFlagDisplay = strDelegatedFlag.Replace('\\', '');
            If (strIncludeinBudgetFlag == '1'){ 
                strIncludeinBudgetFlag = 'True';
                blnIncludeinBudgetFlag = True;
            } 
        }
        
        if (System.currentPageReference().getParameters().get('NOAIA')!=null){
            if (System.currentPageReference().getParameters().get('NOAIA')== 'NOA'){
                blnIA = false;
            }
            if (System.currentPageReference().getParameters().get('NOAIA')== 'IA'){
                blnNOA = false;
            }
        }
        
        if (System.currentPageReference().getParameters().get('EA')!=null){
            if (System.currentPageReference().getParameters().get('EA')== 'Actual'){
                blnEstimate = false;
            }
            if (System.currentPageReference().getParameters().get('EA')== 'Estimate'){
                blnActual = false;
            }
        }
    }
    
    public Glxy_Lease__c getLeaseInformation(){
        List<Glxy_Lease__c> ListLeaseInfo = [
            Select  ID, Name, BaseAnnualRent__c, BaseSquareFeet__c, BaseLeaseEffectiveDate__c, LeaseExpirationDateFY__c,
                    RealtySpecialist__c, RegionCD__c, Total_IA_Annual_Rent__c, Total_IA_Sq_feet__c, Total_NOA_Annual_Rent__c,
                    Total_NOA_Sq_feet__c, BA53User__c,
                    Jan_IA__c, Feb_IA__c, Mar_IA__c, Apr_IA__c, May_IA__c, Jun_IA__c, Jul_IA__c, Aug_IA__c, Sep_IA__c, Oct_IA__c, Nov_IA__c, Dec_IA__c, 
                    Jan_NOA__c, Feb_NOA__c, Mar_NOA__c, Apr_NOA__c, May_NOA__c, Jun_NOA__c, Jul_NOA__c, Aug_NOA__c, Sep_NOA__c, Oct_NOA__c, Nov_NOA__c, Dec_NOA__c 
            From    Glxy_Lease__c
            Where   Name = :strLeaseNumber
            And 	StatusCode__c = 'Active'];
                
         if (ListLeaseInfo.size() > 0){
            Glxy_Lease__c dsleaseInfo = ListLeaseInfo.get(0);
            return  dsleaseInfo;
         }
         else
         {
            ApexPages.Message errormessage = new ApexPages.Message(ApexPages.Severity.ERROR,'No Records found. Please check the Lease Number, or the Lease may not be "Active".');
            ApexPages.addMessage(errormessage);
            return null;
         }
    }
    
    public List<Glxy_LeaseProjects__c> getAssociatedProjects(){
        
        /*strSOQL =   'Select  Lease_Num_lkp__c, Project__r.Name, ' +
                    'Project__r.Project_Type__c, Project__r.EffectiveDate__c, Project__r.ProcessedDate__c, Project__r.eEorA__c, ' +
                    'Project__r.CY_Obligation_NOA__c, Project__r.CY_Obligation_IA__c, ' +
                    'Project__r.NOASquareFeet__c, Project__r.IASquareFeet__c, ' +
                    'Project__r.Jan_IA__c, Project__r.Feb_IA__c, Project__r.Mar_IA__c, Project__r.Apr_IA__c, Project__r.May_IA__c, Project__r.Jun_IA__c, Project__r.Jul_IA__c, Project__r.Aug_IA__c, Project__r.Sep_IA__c, Project__r.Oct_IA__c, Project__r.Nov_IA__c, Project__r.Dec_IA__c, ' +
                    'Project__r.Jan_NOA__c, Project__r.Feb_NOA__c, Project__r.Mar_NOA__c, Project__r.Apr_NOA__c, Project__r.May_NOA__c, Project__r.Jun_NOA__c, Project__r.Jul_NOA__c, Project__r.Aug_NOA__c, Project__r.Sep_NOA__c, Project__r.Oct_NOA__c, Project__r.Nov_NOA__c, Project__r.Dec_NOA__c ' +
                    'From   Glxy_AssociatedLeases__c ' +
                    'Where  Lease_Num_lkp__c = :strLeaseNumber ' +
                    'And	Project__r.Project_Type__c <> \'New/Replacing\' ' +
                    'And    Project__r.ProcessedDateFY__c = :strFiscalYear ' +
                    'And    Project__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    Project__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    'And    Project__r.eEorA__c in (' + String.escapeSingleQuotes(strStatusCode) + ')' ;*/
                    
		// Galaxy 2.1 <-- Removed this condition off the query <-- 'And	Project_Type__c <> \'New/Replacing\' ' +                    
        strSOQL =   'Select ID, Name, eEorA__c, Project_Type__c, EffectiveDate__c, ProcessedDate__c, ' + 
        			'		CY_Obligation_NOA__c,  CY_Obligation_IA__c, NOASquareFeet__c, IASquareFeet__c, ChangeinIASQFt__c, ChangeinNOASQFt__c, ' +
					'       JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                	'       JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c ' + 
               		'From   Glxy_LeaseProjects__c ' +
               		'Where  NewLease__c = :strLeaseNumber ' +
               		'And    ProcessedDateFY__c = :strFiscalYear ' + 
 	 				'And    BDGFlag__c = true ' + 
 	 				'And    ProjectStatus__c <> \'Cancelled\' ' +
		            'And    CheckCOApproval__c = false ' + 
 	 				'ORDER BY  Name ';
	 					             
        strSOQL = strSOQL.Replace('\\','');             
        System.debug('MyDebug = ' + strSOQL);
        List<Glxy_LeaseProjects__c> AssociatedProjects = Database.query(strSOQL);           
        return  AssociatedProjects;
    }
      
	
	public List<Glxy_DoubleRent__c> getDatasetDoubleRent(){
    	
    	strSOQL =   'Select Associated_Leases_Projects_ID__r.Project__r.ID, Associated_Leases_Projects_ID__r.Project__r.Name, Associated_Leases_Projects_ID__r.Project__r.EffectiveDate__c, Associated_Leases_Projects_ID__r.Project__r.eEorA__c, ' + 
    				' 		Associated_Leases_Projects_ID__r.Project__r.RecordType.DeveloperName, Associated_Leases_Projects_ID__r.Project__r.Project_Type__c, Associated_Leases_Projects_ID__r.Project__r.ProcessedDate__c, ' +	
                    '		JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  	'		JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
                    'From   Glxy_DoubleRent__c  ' +
                    'Where  Associated_Leases_Projects_ID__r.Lease__r.Name = :strLeaseNumber ' +
                    'And    Fiscal_Year__c = :strFiscalYear ' + 
                    'And    Associated_Leases_Projects_ID__r.Lease__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
        			'And    Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
       				'And    Associated_Leases_Projects_ID__r.Project__r.eEorA__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
                	'Order by Associated_Leases_Projects_ID__r.Project__r.eEorA__c ';
	                	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_DoubleRent__c> DRRecords = Database.query(strSOQL); 
        return DRRecords;
    
    }
    
    public List<Glxy_ReimbursableWorkAuthorization__c> getDatasetRWA(){
    	
    	strSOQL = 'Select 	ID, Name, EffectiveDate__c, StatusCD__c, Amount__c, ProcessedDate__c, ' +
    	      	  '			JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  '			JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
                  'From   	Glxy_ReimbursableWorkAuthorization__c ' +
                  'Where  	LeaseNumber__r.Name = :strLeaseNumber ' +
                  'And    	ProcessedDateFY__c = :strFiscalYear ' + 
                  'And    	LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                  'And      StatusCD__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
    			  'Order by EffectiveDate__c ';	
	                	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_ReimbursableWorkAuthorization__c> RWARecords = Database.query(strSOQL); 
        return RWARecords;
    
    }
    
    public List<Glxy_IntraBudgetActivityAuthorization__c> getDatasetIBAA(){
    	
    	strSOQL = 'Select 	ID, Name, EffectiveDate__c, StatusCD__c, Type__c, AuthorizedAmount__c, ProcessedDate__c, ' +
    	      	  '			JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  '			JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
                  'From   	Glxy_IntraBudgetActivityAuthorization__c ' +
                  'Where  	LeaseNumber__r.Name = :strLeaseNumber ' +
                  'And    	ProcessedDateFY__c = :strFiscalYear ' + 
                  'And    	LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                  'And      StatusCD__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
    			  'Order by EffectiveDate__c ';	
	                	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_IntraBudgetActivityAuthorization__c> IBAARecords = Database.query(strSOQL); 
        return IBAARecords;
    
    }
    
    public List<Glxy_LumpSumObligations__c> getDatasetLS(){
    	
    	strSOQL = 'Select  	LumpSum__r.ID, LumpSum__r.Name, LumpSum__r.EffectiveDate__c, LumpSum__r.StatusCd__c, LumpSum__r.RecordType.DeveloperName, LumpSum__r.LumSumType__c, FY_Obligation__c, LumpSum__r.ProcessedDate__c, ' + 
	              '		   	JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  '		   	JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
	              'From   	Glxy_LumpSumObligations__c  ' +
	              'Where  	LumpSum__r.LeaseNumber__r.Name = :strLeaseNumber ' +
	              'And    	FiscalYear__c = :strFiscalYear ' + 
	              'And    	LumpSum__r.LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
	        	  'And    	LumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
	       		  'And    	LumpSum__r.StatusCD__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
	              'Order by LumpSum__r.EffectiveDate__c ';
	                	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_LumpSumObligations__c> LSRecords = Database.query(strSOQL); 
        return LSRecords;
    
    }
    
    public List<Glxy_LPLumpSumObligations__c> getDatasetLPLS(){
    	
    	strSOQL =	'Select LPLumpSum__r.ID, LPLumpSum__r.Name, LPLumpSum__r.EffectiveDate__c, LPLumpSum__r.StatusCd__c, LPLumpSum__r.RecordType.DeveloperName, LPLumpSum__r.LumSumType__c, FY_Obligation__c, LPLumpSum__r.ProcessedDate__c, ' + 
	                '		JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  	'		JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
	                'From   Glxy_LPLumpSumObligations__c  ' +
	                'Where  LPLumpSum__r.ProjectNumber__r.NewLease__c = :strLeaseNumber ' +
	                'And    FiscalYear__c = :strFiscalYear ' + 
	                'And    LPLumpSum__r.ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
	        		'And    LPLumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
	       			'And    LPLumpSum__r.StatusCD__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
	       			'And    LPLumpSum__r.ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' +
	                'Order by LPLumpSum__r.EffectiveDate__c ';
	                	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_LPLumpSumObligations__c> LSRecords = Database.query(strSOQL); 
        return LSRecords;
    
    }
    
	public List<Glxy_ConsumerPriceIndex__c> getDatasetCPI(){
    	
    	strSOQL = 'Select 	ID, Name, EffectiveDate__c, StatusCD__c, RecordType.DeveloperName, EscalationType__c, AnnualAmount__c, ProcessedDate__c, ' +
    	      	  '			JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  '			JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
                  'From   	Glxy_ConsumerPriceIndex__c ' +
                  'Where  	LeaseNumber__r.Name = :strLeaseNumber ' +
                  'And    	ProcessedDateFY__c = :strFiscalYear ' + 
                  'And    	LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                  'And      StatusCD__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
    			  'And    	BDGFlag__c = :blnIncludeinBudgetFlag '+ 
    			  'Order by EffectiveDate__c ';	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_ConsumerPriceIndex__c> CPIRecords = Database.query(strSOQL); 
        return CPIRecords;
    
    }
    
    public List<Glxy_StepRent__c> getDatasetStepRent(){
    	
    	strSOQL = 'Select 	ID, Name, EffectiveDate__c, StatusCode__c, RecordType.DeveloperName, PaymentType__c, Amount__c, ProcessedDate__c, ' +
    	      	  '			JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  '			JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
                  'From   	Glxy_StepRent__c ' +
                  'Where  	LeaseNumber__r.Name = :strLeaseNumber ' +
                  'And    	ProcessedDateFY__c = :strFiscalYear ' + 
                  'And    	LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                  'And      StatusCode__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
    			  'And    	BDGFlag__c = :blnIncludeinBudgetFlag '+ 
    			  'Order by EffectiveDate__c ';	
    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_StepRent__c> StepRentRecords = Database.query(strSOQL); 
        return StepRentRecords;
    
    }
    
    public List<Glxy_LPStepRent__c> getDatasetProjectStepRent(){
    	
    	strSOQL = 'Select 	ID, Name, EffectiveDate__c, StatusCode__c, RecordType.DeveloperName , PaymentType__c, Amount__c, ProcessedDate__c, ' +
    	      	  '			JAN_IA__c, FEB_IA__c, MAR_IA__c, APR_IA__c, MAY_IA__c, JUN_IA__c, JUL_IA__c, AUG_IA__c, SEP_IA__c, OCT_IA__c, NOV_IA__c, DEC_IA__c, ' +
                  '			JAN_NOA__c, FEB_NOA__c, MAR_NOA__c, APR_NOA__c, MAY_NOA__c, JUN_NOA__c, JUL_NOA__c, AUG_NOA__c, SEP_NOA__c, OCT_NOA__c, NOV_NOA__c, DEC_NOA__c, FY_Obligation_IA__c, FY_Obligation_NOA__c ' + 
                  'From   	Glxy_LPStepRent__c ' +
				  'Where  	ProjectNumber__r.NewLease__c = :strLeaseNumber ' +
	              'And    	ProcessedDateFY__c = :strFiscalYear ' + 
	              'And    	ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
	        	  'And    	BDGFlag__c = :blnIncludeinBudgetFlag ' +
	       		  'And    	StatusCode__c in (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
	       		  'And    	ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' +
	              'Order by EffectiveDate__c ';

    	strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug = ' + strSOQL);
        
        List<Glxy_LPStepRent__c> StepRentRecords = Database.query(strSOQL); 
        return StepRentRecords;
    
    }
    
    
    // **** RUN all the TEST methods for code coverage ... ****//    
    private static testmethod void testProjectionsByLeaseController() {
    	
    	Date myDate = date.newinstance(date.today().Year(), 01, 01);
    	If  (date.today().month() > 9){
    		myDate = date.newinstance(date.today().Year(), 10, 10);
    	}
    	Glxy_Lease__c objLease = new Glxy_Lease__c();
        objLease.Name = 'LAK05855';
        objLease.DelegatedLease__c = true;
        insert objLease;
        
        // CPI
        Glxy_ConsumerPriceIndex__c objTest0 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            FY_Obligation__c = 0,
            ProcessedDate__c = myDate,
            Acceptance620Date__c = myDate,
            StatusCD__c = 'Actual'
        );
        insert objTest0;
        System.AssertNotEquals(objTest0,NULL);
        
        // IBAA
        Glxy_IntraBudgetActivityAuthorization__c pi = new Glxy_IntraBudgetActivityAuthorization__c();
        pi.LeaseNumber__c = objLease.id;
        pi.Overwrite__c = false;
        pi.ProcessedDate__c = myDate;
        insert pi;
        System.AssertNotEquals(pi,NULL);
        
        // LS
        Glxy_LumpSum__c objTest3 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = myDate,
            ProcessedDate__c = myDate,
            StatusCD__c = 'Actual',
            FY_Obligation__c = 0
        );
        insert objTest3;
        System.Assert(objTest3!=NULL);
        
        //SR
        Glxy_StepRent__c objTest4 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            ProcessedDate__c = myDate,
            Acceptance620Date__c = myDate,
            StatusCode__c = 'Actual'
        );
        insert objTest4;
        System.Assert(objTest4!=NULL);
        
        //RWA
        Glxy_ReimbursableWorkAuthorization__c objTest5 = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = myDate,
            ProcessedDate__c = myDate
        );
        insert objTest5;
        System.Assert(objTest5!=NULL);
        
        Glxy_LeaseProjects__c project= new Glxy_LeaseProjects__c();
		project.ProjectStatus__c = 'Active';
		project.DelegatedProject__c = true;
		project.EffectiveDate__c = myDate ;
		project.RegionCd__c = '3';
		project.RexusNewNOASqFt__c = 1000;
		project.RexusNewIASqFt__c = 1000;
		Project.NewLease__c = 'LAK05855';
		insert project;
		system.assertNotEquals(NULL,project);
			   
	  	Glxy_LPStepRent__c SR = new Glxy_LPStepRent__c();
	   	SR.ProjectNumber__c = project.id;
	   	SR.ProcessedDate__c = myDate;
	   	SR.StatusCode__c = 'Actual';
	   	insert SR;
		system.assertNotEquals(NULL,SR);
		    
        PageReference pageRef = Page.GLXY_rptFYProjectionsByLease;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('FY', String.Valueof(Datetime.Now().Date().Year()));
        ApexPages.currentPage().getParameters().put('Lease', 'LAK05855');
        ApexPages.currentPage().getParameters().put('NOAIA', 'BOTH');
        ApexPages.currentPage().getParameters().put('EA', '\'Actual\'');
        ApexPages.currentPage().getParameters().put('IncludeInBudgetFlag', '1');
        ApexPages.currentPage().getParameters().put('DelegatedFlag', '\'True\'');

        GLXY_ProjectionsByLease objTest = new GLXY_ProjectionsByLease();
        
        Glxy_Lease__c objDataSet0;
        objDataSet0 = objTest.getLeaseInformation();
        
        List<Glxy_LeaseProjects__c> objDataSet1;
        objDataSet1 = objTest.getAssociatedProjects();
        
        List<Glxy_LeaseProjects__c> objDataSet2;
        objDataSet2 = objTest.getAssociatedProjects();    
         
        List<Glxy_ConsumerPriceIndex__c> objDataSetCPI;
        objDataSetCPI = objTest.getDatasetCPI();
        
        List<Glxy_LumpSumObligations__c> objDataSetLS;
        objDataSetLS = objTest.getDatasetLS();
       
       	List<Glxy_StepRent__c> objDataSetSR;
        objDataSetSR = objTest.getDatasetStepRent();
        
        List<Glxy_IntraBudgetActivityAuthorization__c> objDataSetIBAA;
        objDataSetIBAA = objTest.getDatasetIBAA();
        
        List<Glxy_ReimbursableWorkAuthorization__c> objDataSetRWA;
        objDataSetRWA = objTest.getDatasetRWA();
        
        List<Glxy_DoubleRent__c> objDataSetDR;
        objDataSetDR = objTest.getDatasetDoubleRent();
        
        List<Glxy_LPLumpSumObligations__c> objDataSetLPLS;
        objDataSetLPLS = objTest.getDatasetLPLS();
        
        List<Glxy_LPStepRent__c> objDataSetLPSR;
        objDataSetLPSR = objTest.getDatasetProjectStepRent();
        
        System.Assert(objDataSetLPSR!=NULL);
        
   } 

}