public with sharing class Glxy_BC_TrendAnalysis {
	
	public String 	strRegion               {get; set;}
    Public Boolean 	blnIncludeinBudgetFlag  {get; set;}
    Public String 	strDelegatedFlag        {get; set;}
	Public String 	strCurrrentFY        	{get; set;}
    
	public String  strFiscalYear1	{get; set;}
	public Decimal EscalationNOA1	{get; set;}
	public Decimal CancellationNOA1	{get; set;}
	public Decimal LumpSumNOA1		{get; set;}
	public Decimal ExpansionNOA1	{get; set;}
	public Decimal EscalationIA1	{get; set;}
	public Decimal CancellationIA1	{get; set;}
	public Decimal ExpansionIA1		{get; set;}
	public Decimal LumpSumIA1		{get; set;}
	
	public String  strFiscalYear2	{get; set;}
	public Decimal EscalationNOA2	{get; set;}
	public Decimal CancellationNOA2	{get; set;}
	public Decimal LumpSumNOA2		{get; set;}
	public Decimal ExpansionNOA2	{get; set;}
	public Decimal EscalationIA2	{get; set;}
	public Decimal CancellationIA2	{get; set;}
	public Decimal ExpansionIA2		{get; set;}
	public Decimal LumpSumIA2		{get; set;}
	
	public String  strFiscalYear3	{get; set;}
	public Decimal EscalationNOA3	{get; set;}
	public Decimal CancellationNOA3	{get; set;}
	public Decimal LumpSumNOA3		{get; set;}
	public Decimal ExpansionNOA3	{get; set;}
	public Decimal EscalationIA3	{get; set;}
	public Decimal CancellationIA3	{get; set;}
	public Decimal ExpansionIA3		{get; set;}
	public Decimal LumpSumIA3		{get; set;}
	
	public String  strFiscalYear4	{get; set;}
	public Decimal EscalationNOA4	{get; set;}
	public Decimal CancellationNOA4	{get; set;}
	public Decimal LumpSumNOA4		{get; set;}
	public Decimal ExpansionNOA4	{get; set;}
	public Decimal EscalationIA4	{get; set;}
	public Decimal CancellationIA4	{get; set;}
	public Decimal ExpansionIA4		{get; set;}
	public Decimal LumpSumIA4		{get; set;}
	
	public String  strFiscalYear5	{get; set;}
	public Decimal EscalationNOA5	{get; set;}
	public Decimal CancellationNOA5	{get; set;}
	public Decimal LumpSumNOA5		{get; set;}
	public Decimal ExpansionNOA5	{get; set;}
	public Decimal EscalationIA5	{get; set;}
	public Decimal CancellationIA5	{get; set;}
	public Decimal ExpansionIA5		{get; set;}
	public Decimal LumpSumIA5		{get; set;}
	
	Private String strSOQL;
	Private String strFiscalYear;
	AggregateResult[] AgR;
	 
	Public Decimal fnCheckNull(Decimal DataInput) {
        if (DataInput == null){
            return 0;
        } else {
            return DataInput;
        }   
    }
    
    public Glxy_BC_TrendAnalysis(){
     	
     	if (System.currentPageReference().getParameters().get('Region')!=null){
            strRegion = System.currentPageReference().getParameters().get('Region');
            strDelegatedFlag = '\'False\'';
            blnIncludeinBudgetFlag = True;
        }else{
            strRegion = '\'4\'';
            strDelegatedFlag = '\'False\'';
            blnIncludeinBudgetFlag = True;
        }
        
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        strCurrrentFY = String.ValueOf(intCurrentFy);
               
        //Column 1: (Fiscal Year - 2)
        strFiscalYear1 = String.ValueOf(intCurrentFy - 2);
        subBuildSQL (strFiscalYear1, False);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
        	EscalationNOA1   = (Decimal) RowData.get('EscalationNOA');
        	CancellationNOA1 = (Decimal) RowData.get('CancellationNOA');
        	ExpansionNOA1    = (Decimal) RowData.get('ExpansionNOA');
        	EscalationIA1    = (Decimal) RowData.get('EscalationIA');
        	CancellationIA1  = (Decimal) RowData.get('CancellationIA');
        	ExpansionIA1     = (Decimal) RowData.get('ExpansionIA');
        }
        
        //Column 2: (Fiscal Year - 1)
        strFiscalYear2 = String.ValueOf(intCurrentFy - 1);
        subBuildSQL (strFiscalYear2, False);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
        	EscalationNOA2   = (Decimal) RowData.get('EscalationNOA');
        	CancellationNOA2 = (Decimal) RowData.get('CancellationNOA');
        	ExpansionNOA2    = (Decimal) RowData.get('ExpansionNOA');
        	EscalationIA2    = (Decimal) RowData.get('EscalationIA');
        	CancellationIA2  = (Decimal) RowData.get('CancellationIA');
        	ExpansionIA2     = (Decimal) RowData.get('ExpansionIA');
        }
        
        //Column 3: (Fiscal Year)
        strFiscalYear3 = String.ValueOf(intCurrentFy);
       	subBuildSQL (strFiscalYear3, False);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
        	EscalationNOA3   = (Decimal) RowData.get('EscalationNOA');
        	CancellationNOA3 = (Decimal) RowData.get('CancellationNOA');
        	ExpansionNOA3    = (Decimal) RowData.get('ExpansionNOA');
        	EscalationIA3    = (Decimal) RowData.get('EscalationIA');
        	CancellationIA3  = (Decimal) RowData.get('CancellationIA');
        	ExpansionIA3     = (Decimal) RowData.get('ExpansionIA');
        }
        
        //Column 4: (Fiscal Year + 1)
        strFiscalYear4 = String.ValueOf(intCurrentFy + 1);
       	subBuildSQL (strFiscalYear4, True);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
        	EscalationNOA4   = (Decimal) RowData.get('EscalationNOA');
        	CancellationNOA4 = (Decimal) RowData.get('CancellationNOA');
        	ExpansionNOA4    = (Decimal) RowData.get('ExpansionNOA');
        	EscalationIA4    = (Decimal) RowData.get('EscalationIA');
        	CancellationIA4  = (Decimal) RowData.get('CancellationIA');
        	ExpansionIA4     = (Decimal) RowData.get('ExpansionIA');
        }
        
        //Column 5: (Fiscal Year + 2)
        strFiscalYear5 = String.ValueOf(intCurrentFy + 2);
       	subBuildSQL (strFiscalYear5, True);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
        	EscalationNOA5   = (Decimal) RowData.get('EscalationNOA');
        	CancellationNOA5 = (Decimal) RowData.get('CancellationNOA');
        	ExpansionNOA5    = (Decimal) RowData.get('ExpansionNOA');
        	EscalationIA5    = (Decimal) RowData.get('EscalationIA');
        	CancellationIA5  = (Decimal) RowData.get('CancellationIA');
        	ExpansionIA5     = (Decimal) RowData.get('ExpansionIA');
        }
        
        subLoadLumpSumData(intCurrentFy);
	}
	
	Private void subBuildSQL(String strFiscalYear, Boolean blnFutureFiscalYear){
		
		If (blnFutureFiscalYear){
			strSOQL =  'Select Sum(EscalARentNOA__c) EscalationNOA, Sum(CancelARentNOA__c) CancellationNOA, Sum(ExpanARentNOA__c) ExpansionNOA, ' +
						'		Sum(EscalARentIA__c) EscalationIA, Sum(CancelARentIA__c) CancellationIA, Sum(ExpanARentIA__c) ExpansionIA ' +
	                    'From   Glxy_LeaseProjects__c ' +
	                    'Where 	ProcessedDateFY__c >= \'' + String.escapeSingleQuotes(strCurrrentFY) + '\' ' +
                    	'And 	ProcessedDateFY__c <= \'' + String.escapeSingleQuotes(strFiscalYear) + '\' ' +
	                    'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
	                    'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
	                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
	                    'And 	ProjectStatus__c <> \'Cancelled\' ';
		} else {
			strSOQL =  'Select  Sum(EscalARentNOA__c) EscalationNOA, Sum(CancelARentNOA__c) CancellationNOA, Sum(ExpanARentNOA__c) ExpansionNOA, ' +
						'		Sum(EscalARentIA__c) EscalationIA, Sum(CancelARentIA__c) CancellationIA, Sum(ExpanARentIA__c) ExpansionIA ' +
	                    'From   Glxy_LeaseProjects__c ' +
	                    'Where 	ProcessedDateFY__c = \'' + String.escapeSingleQuotes(strFiscalYear) + '\' ' +
	                    'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
	                    'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
	                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
	                    'And 	ProjectStatus__c <> \'Cancelled\' ';
		}       
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug SQL = ' + strSOQL);
	}
	
	Private void subLoadLumpSumData(Integer intCurrentFYParameter){
		
		strSOQL =  'Select  FiscalYear__c, Sum(FY_Obligation_IA__c) LumpSumIAAmount, Sum(FY_Obligation_NOA__c) LumpSumNOAAmount ' +
                    'From   Glxy_LumpSumObligations__c ' +
                    'Where 	FiscalYear__c >= \'' + String.Valueof(intCurrentFYParameter - 2) + '\' ' +
                    'And 	FiscalYear__c <= \'' + String.Valueof(intCurrentFYParameter + 2) + '\' ' +
                    'And    LumpSum__r.LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    LumpSum__r.LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                    'And    LumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                    'Group by FiscalYear__c ' + 
                    'Order by FiscalYear__c ';
		
		strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LS-SQL = ' + strSOQL);
        
        AgR = Database.Query(strSOQL);
        
        for (AggregateResult RowData : AgR) { 
        	If (String.ValueOf(RowData.get('FiscalYear__c')) == String.ValueOf(intCurrentFYParameter - 2)){
        		LumpSumIA1 = (Decimal) RowData.get('LumpSumIAAmount');
        		LumpSumNOA1 = (Decimal) RowData.get('LumpSumNOAAmount');
        	} else If (String.ValueOf(RowData.get('FiscalYear__c')) == String.ValueOf(intCurrentFYParameter - 1)){
        		LumpSumIA2 = (Decimal) RowData.get('LumpSumIAAmount');
        		LumpSumNOA2 = (Decimal) RowData.get('LumpSumNOAAmount');
        	} else If  (String.ValueOf(RowData.get('FiscalYear__c')) == String.ValueOf(intCurrentFYParameter)){
        		LumpSumIA3 = (Decimal) RowData.get('LumpSumIAAmount');
        		LumpSumNOA3 = (Decimal) RowData.get('LumpSumNOAAmount');
        	} else If  (String.ValueOf(RowData.get('FiscalYear__c')) == String.ValueOf(intCurrentFYParameter + 1)){
        		LumpSumIA4 = (Decimal) RowData.get('LumpSumIAAmount');
        		LumpSumNOA4 = (Decimal) RowData.get('LumpSumNOAAmount');
        	} else If  (String.ValueOf(RowData.get('FiscalYear__c')) == String.ValueOf(intCurrentFYParameter + 2)){
        		LumpSumIA5 = (Decimal) RowData.get('LumpSumIAAmount');
        		LumpSumNOA5 = (Decimal) RowData.get('LumpSumNOAAmount');	
        	}
        }
       
	} 
	
	
	// **** RUN all the TEST methods for code coverage ... ****//    
   	private static testmethod void testGlxy_BC_TrendAnalysis() {
        PageReference pageRef = Page.Glxy_rptBudgetTrends;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Region', '\'1\'');
        
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
        objPro.EffectiveDate__c = myDate;
        objPro.AnnualRent__c = 1000.0;
        objPro.RegionCd__c = '1';
        objPro.DelegatedProject__c = true;
        objPro.ProjectStatus__c = 'Active';
        objPro.eEorA__c = 'ACTUAL';
        objPro.Old_Annual_Rent__c = 1000.0;
        insert objPro;
         
        Glxy_LeaseProjects__c objPro1 = new Glxy_LeaseProjects__c();
        objPro1.Name='123456799';
        Date myDate1 = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
        objPro1.EffectiveDate__c = myDate1;
        objPro1.AnnualRent__c = 1000.0;
        objPro1.RegionCd__c = '1';
        objPro.DelegatedProject__c = true;
        objPro1.ProjectStatus__c = 'Active';
        objPro1.eEorA__c = 'ESTIMATE';
        objPro1.Old_Annual_Rent__c = 1000.0;
        insert objPro1;
        
       	Date myDate2 = date.newinstance(Datetime.Now().Date().Year(), 10, 10);  
              	 
	    Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c = 'Active',
            BaseLeaseEffectiveDate__c = Datetime.Now().Date(),
            ExpirationDateofLease__c = Datetime.Now().Date().addYears(10),
            IAConverstionDate__c = Datetime.Now().Date().addYears(5),
            RegionCD__c = '1',
            DelegatedLease__c = false,
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='LNV00374',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
	    Glxy_LumpSum__c objTestLS = new Glxy_LumpSum__c();
	    objTestLS.LeaseNumber__c = objleaseEntry.id;
	    objTestLS.EffectiveDate__c = myDate2.addyears(-5);
	    objTestLS.ExpirationDate__c = myDate2.addyears(+5);
	    objTestLS.BDGFlag__c = true;
	    objTestLS.amount__c = 200;
	    insert objTestLS;
	    System.Assert(objTestLS!=NULL);
        
        Glxy_BC_TrendAnalysis objTest = new Glxy_BC_TrendAnalysis();
        
        objTest.strRegion = '1';
    	objTest.blnIncludeinBudgetFlag = true;
    	objTest.strCurrrentFY = string.valueof(myDate2.Year());
    
		objTest.strFiscalYear1	 = '0';
		objTest.EscalationNOA1	 = 0;
		objTest.CancellationNOA1 = 0;
		objTest.LumpSumNOA1		 = 0;
		objTest.ExpansionNOA1	 = 0;
		objTest.EscalationIA1	 = 0;
		objTest.CancellationIA1	 = 0;
		objTest.ExpansionIA1	 = 0;
		objTest.LumpSumIA1		 = 0;
		
		objTest.strFiscalYear2	 = '0';
		objTest.EscalationNOA2	 = 0;
		objTest.CancellationNOA2 = 0;
		objTest.LumpSumNOA2		 = 0;
		objTest.ExpansionNOA2	 = 0;
		objTest.EscalationIA2	 = 0;
		objTest.CancellationIA2	 = 0;
		objTest.ExpansionIA2	 = 0;
		objTest.LumpSumIA2		 = 0;
		
		objTest.strFiscalYear3	 = '0';
		objTest.EscalationNOA3	 = 0;
		objTest.CancellationNOA3 = 0;
		objTest.LumpSumNOA3		 = 0;
		objTest.ExpansionNOA3	 = 0;
		objTest.EscalationIA3	 = 0;
		objTest.CancellationIA3	 = 0;
		objTest.ExpansionIA3	 = 0;
		objTest.LumpSumIA3		 = 0;
		
		objTest.strFiscalYear4	 = '0';
		objTest.EscalationNOA4	 = 0;
		objTest.CancellationNOA4 = 0;
		objTest.LumpSumNOA4		 = 0;
		objTest.ExpansionNOA4	 = 0;
		objTest.EscalationIA4	 = 0;
		objTest.CancellationIA4	 = 0;
		objTest.ExpansionIA4	 = 0;
		objTest.LumpSumIA4		 = 0;
		
		objTest.strFiscalYear5	 = '0';
		objTest.EscalationNOA5	 = 0;
		objTest.CancellationNOA5 = 0;
		objTest.LumpSumNOA5		 = 0;
		objTest.ExpansionNOA5	 = 0;
		objTest.EscalationIA5	 = 0;
		objTest.CancellationIA5	 = 0;
		objTest.ExpansionIA5	 = 0;
		objTest.LumpSumIA5		 = 0;
	
        Decimal inputDD = 0.0;
        Decimal outputD =  objTest.fnCheckNull(inputDD);
        Decimal outputD2 =  objTest.fnCheckNull(null);
        System.Assert(objTest!=NULL);
        
    }
	
}