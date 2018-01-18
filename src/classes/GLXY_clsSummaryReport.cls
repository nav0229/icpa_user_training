public with sharing class GLXY_clsSummaryReport {
    
    public String strFiscalYear             {get; set;}
    public String strFiscalYearUserInput    {get; set;}
    public String strNextFiscalYear         {get; set;}
    public String strRegion                 {get; set;}
    public String strIncludeinBudgetFlag    {get; set;}
    public Boolean blnIncludeinBudgetFlag   {get; set;}
    public String strDelegatedFlag          {get; set;} 
    public date   strSnapshotDate           {get; set;}   
    public String strFYSS                   {get; set;}   // added for galaxy2 release 2.6 PF3
    
    //Row 1
    public Decimal BaseSqFtNOA_A        {get; set;}
    public Decimal BaseAnnualRentNOA_A  {get; set;}
    public Decimal BasePYCostNOA_A      {get; set;}
    public Decimal BaseSqFtNOA_E        {get; set;}
    public Decimal BaseAnnualRentNOA_E  {get; set;}
    public Decimal BasePYCostNOA_E      {get; set;} 
    
    //Row 2
    public Decimal ExpanSqFtNOA_A   {get; set;}
    public Decimal ExpanARentNOA_A  {get; set;}
    public Decimal ExpanPYCostNOA_A {get; set;}
    public Decimal ExpanSqFtNOA_E   {get; set;}
    public Decimal ExpanARentNOA_E  {get; set;}
    public Decimal ExpanPYCostNOA_E {get; set;}
    
    //Row 3
    public Decimal CancelSqFtNOA_A      {get; set;}
    public Decimal CancelARentNOA_A     {get; set;}
    public Decimal CancelPYCostNOA_A    {get; set;}
    public Decimal CancelSqFtNOA_E      {get; set;}
    public Decimal CancelARentNOA_E     {get; set;}
    public Decimal CancelPYCostNOA_E    {get; set;}
    
    //Row 4
    //public Decimal EscalSqFtNOA_A {get; set;}
    public Decimal EscalARentNOA_A  {get; set;}
    public Decimal EscalPYCostNOA_A {get; set;}
    //public Decimal EscalSqFtNOA_E {get; set;}
    public Decimal EscalARentNOA_E  {get; set;}
    public Decimal EscalPYCostNOA_E {get; set;}
    
    //Row 5
    public Decimal AnnualAmountCPI_A    {get; set;}
    public Decimal PYCostCPI_A          {get; set;}
    public Decimal AnnualAmountCPI_E    {get; set;}
    public Decimal PYCostCPI_E          {get; set;}
    
    //Row 6
    public Decimal AnnualAmountStepRent_A    {get; set;}
    public Decimal PYCostStepRent_A          {get; set;}
    public Decimal AnnualAmountStepRent_E    {get; set;}
    public Decimal PYCostStepRent_E          {get; set;}
    
    //Row 7
    public Decimal PYCostLS_A   {get; set;}
    public Decimal PYCostLS_E   {get; set;}
    
    //Row 8
    public Decimal PYCostIBAA_A {get; set;}
    public Decimal PYCostIBAA_E {get; set;}
    
    //Row 9
    public Decimal PYCostRWA_A  {get; set;}
    public Decimal PYCostRWA_E  {get; set;}
    
    //Row 10
    public Decimal DoubleRentNOA_A {get; set;}
    public Decimal DoubleRentNOA_E {get; set;}
    
    //Row 11
    public Decimal PrjAnnualAmountStepRent_A    {get; set;}
    public Decimal PrjPYCostStepRent_A          {get; set;}
    public Decimal PrjAnnualAmountStepRent_E    {get; set;}
    public Decimal PrjPYCostStepRent_E          {get; set;}
    
    //Row 12
    public Decimal PrjPYCostLS_A   {get; set;}
    public Decimal PrjPYCostLS_E   {get; set;}
        
    //Row 13 - Totals
    public Decimal NOATotalSqFt_A       {get; set;}
    public Decimal NOATotalAnnualRent_A {get; set;}
    public Decimal NOATotalPYCost_A     {get; set;}
    public Decimal NOATotalSqFt_E       {get; set;}
    public Decimal NOATotalAnnualRent_E {get; set;}
    public Decimal NOATotalPYCost_E     {get; set;}
    public Decimal NOATotalSqFt         {get; set;}
    public Decimal NOATotalAnnualRent   {get; set;}
    public Decimal NOATotalPYCost       {get; set;}
    
    //Row 14
    public Decimal BaseSqFtIA_A        {get; set;}
    public Decimal BaseAnnualRentIA_A  {get; set;}
    public Decimal BasePYCostIA_A      {get; set;}
    public Decimal BaseSqFtIA_E        {get; set;}
    public Decimal BaseAnnualRentIA_E  {get; set;}
    public Decimal BasePYCostIA_E      {get; set;} 
    
    //Row 15
    public Decimal ExpanSqFtIA_A    {get; set;}
    public Decimal ExpanARentIA_A   {get; set;}
    public Decimal ExpanPYCostIA_A  {get; set;}
    public Decimal ExpanSqFtIA_E    {get; set;}
    public Decimal ExpanARentIA_E   {get; set;}
    public Decimal ExpanPYCostIA_E  {get; set;}
    
    //Row 16
    public Decimal CancelSqFtIA_A      {get; set;}
    public Decimal CancelARentIA_A     {get; set;}
    public Decimal CancelPYCostIA_A    {get; set;}
    public Decimal CancelSqFtIA_E      {get; set;}
    public Decimal CancelARentIA_E     {get; set;}
    public Decimal CancelPYCostIA_E    {get; set;}
    
    //Row 17
    //public Decimal EscalSqFtIA_A {get; set;}
    public Decimal EscalARentIA_A  {get; set;}
    public Decimal EscalPYCostIA_A {get; set;}
    //public Decimal EscalSqFtIA_E {get; set;}
    public Decimal EscalARentIA_E  {get; set;}
    public Decimal EscalPYCostIA_E {get; set;}
    
    //Row 18
    public Decimal IA_AnnualAmountCPI_A    {get; set;}
    public Decimal IA_PYCostCPI_A          {get; set;}
    public Decimal IA_AnnualAmountCPI_E    {get; set;}
    public Decimal IA_PYCostCPI_E          {get; set;}
    
    //Row 19
    public Decimal IA_AnnualAmountStepRent_A    {get; set;}
    public Decimal IA_PYCostStepRent_A          {get; set;}
    public Decimal IA_AnnualAmountStepRent_E    {get; set;}
    public Decimal IA_PYCostStepRent_E          {get; set;}
    
    //Row 20
    public Decimal IA_PYCostLS_A   {get; set;}
    public Decimal IA_PYCostLS_E   {get; set;}
    
    //Row 21
    public Decimal IA_PYCostIBAA_A {get; set;}
    public Decimal IA_PYCostIBAA_E {get; set;}
    
    //Row 22
    public Decimal IA_PYCostRWA_A  {get; set;}
    public Decimal IA_PYCostRWA_E  {get; set;}
    
    //Row 23
    public Decimal DoubleRentIA_A {get; set;}
    public Decimal DoubleRentIA_E {get; set;}
    
    //Row 24
    public Decimal PrjIA_AnnualAmountStepRent_A    {get; set;}
    public Decimal PrjIA_PYCostStepRent_A          {get; set;}
    public Decimal PrjIA_AnnualAmountStepRent_E    {get; set;}
    public Decimal PrjIA_PYCostStepRent_E          {get; set;}
    
    //Row 25
    public Decimal PrjIA_PYCostLS_A   {get; set;}
    public Decimal PrjIA_PYCostLS_E   {get; set;}
    
    //Row 26 - Totals IA
    public Decimal IATotalSqFt_A       {get; set;}
    public Decimal IATotalAnnualRent_A {get; set;}
    public Decimal IATotalPYCost_A     {get; set;}
    public Decimal IATotalSqFt_E       {get; set;}
    public Decimal IATotalAnnualRent_E {get; set;}
    public Decimal IATotalPYCost_E     {get; set;}
    public Decimal IATotalSqFt         {get; set;}
    public Decimal IATotalAnnualRent   {get; set;}
    public Decimal IATotalPYCost       {get; set;}
    
    //Allowance and Base Targets
    public Decimal AllowanceIA      {get; set;}
    public Decimal AllowanceNOA     {get; set;}
    public Decimal IABaseTarget     {get; set;}
    public Decimal NOABaseTarget    {get; set;}
        
    Public Decimal fnCheckNull(Decimal DataInput) {
        if (DataInput == null){
            return 0;
        } else {
            return DataInput;
        }   
    }

    public GLXY_clsSummaryReport(){
        
        strFYSS = System.currentPageReference().getParameters().get('FiscalSSSelectedType');
        if(strFYSS == 'Snapshot') {
            StrSnapShotDate  = date.valueof(System.currentPageReference().getParameters().get('SelectedSnapShotDate'));
        }
        if (System.currentPageReference().getParameters().get('Region')!=null){
            strRegion = System.currentPageReference().getParameters().get('Region');
            strIncludeinBudgetFlag = System.currentPageReference().getParameters().get('IncludeInBudgetFlag');
            strDelegatedFlag = System.currentPageReference().getParameters().get('DelegatedFlag');
            strFiscalYearUserInput = System.currentPageReference().getParameters().get('FY');
            If (strIncludeinBudgetFlag == '1'){ 
                strIncludeinBudgetFlag = 'True';
                blnIncludeinBudgetFlag = True;
            } else {
                strIncludeinBudgetFlag = 'False';
                blnIncludeinBudgetFlag = False;
            }
        }else{
            strRegion = '\'3\'';
            strIncludeinBudgetFlag = 'True';
            strDelegatedFlag = '\'False\'';
            strFiscalYearUserInput = '2016';
        }
        
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        strFiscalYear = string.valueof(intCurrentFy);
        strNextFiscalYear = String.valueOf(intCurrentFy + 1);
        String strSOQL;
        
        Decimal dbMultiplier;
        Decimal dbTotalSqFt;
        
        BaseSqFtNOA_A = 0.00;
        BaseAnnualRentNOA_A = 0.00;
        BasePYCostNOA_A = 0.00;
        BaseSqFtNOA_E = 0.00;
        BaseAnnualRentNOA_E = 0.00;
        BasePYCostNOA_E = 0.00;
                
        BaseSqFtIA_A = 0.00;
        BaseAnnualRentIA_A = 0.00;
        BasePYCostIA_A = 0.00;
        BaseSqFtIA_E = 0.00;
        BaseAnnualRentIA_E = 0.00;
        BasePYCostIA_E = 0.00;
        
        AggregateResult[] AgR;
                     
        //#################################################################
        // Note 1:  Dynamic SOQL was used because SOQL could not process
        //          multiple values in the 'Regions' parameter. It does
        //          well when a single value is passed in the 'Regions'
        //          parameter, but has issues with multiple values.
        //#################################################################

        //Row 1 - Base Rent NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Sum(TotalNOASqft__c) SumOfNOASquareFeet, Sum(Total_NOA_Annual_Rent__c) SumOfNOAAnnualRent ' +
                        'From   Glxy_LeaseSnapshot__c ' +
                        'Where  RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    NextFYLeases__c = False ' + 
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    StatusCode__c = \'Active\' ' +  
                        'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ';
        }else{
            strSOQL =   'Select Sum(Total_NOA_Sq_feet__c) SumOfNOASquareFeet, Sum(Total_NOA_Annual_Rent__c) SumOfNOAAnnualRent, ' +
                        'Sum(REXUSNOASqft__c) REXUSSumOfNOASquareFeet, Sum (REXUS_NOA_Annual_Rent__c) REXUSSumOfNOAAnnualRent ' + 
                        'From   Glxy_Lease__c ' +
                        'Where  RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Next_FY_Leases__c = False ' + 
                        'And    StatusCode__c = \'Active\' ' +  
                        'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ';
        }
         
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Row 1a = ' + strSOQL); 
        
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            if (strFiscalYearUserInput == strFiscalYear){
                BaseSqFtNOA_A = (Decimal) RowData.get('SumOfNOASquareFeet');
                BaseAnnualRentNOA_A = (Decimal) RowData.get('SumOfNOAAnnualRent');
                BasePYCostNOA_A = (Decimal) RowData.get('SumOfNOAAnnualRent');
            } else {
                BaseSqFtNOA_E = (Decimal) RowData.get('SumOfNOASquareFeet');
                BaseAnnualRentNOA_E = (Decimal) RowData.get('SumOfNOAAnnualRent');
                BasePYCostNOA_E = (Decimal) RowData.get('SumOfNOAAnnualRent');
            }
        }

        //Row 1 - Query 2 - Roll IA into NOA for future FY's
        If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select Sum(TotalIASqft__c) SumOfIASquareFeet, Sum(Total_IA_Annual_Rent__c) SumOfIAAnnualRent ' + 
                            'From   Glxy_LeaseSnapshot__c ' +
                            'Where  RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    NextFYLeases__c = False ' + 
                            'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                            'And    StatusCode__c = \'Active\' ' +                     
                            'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                            'And    IAConverstionFY__c <= :strFiscalYearUserInput';
            }else{
                strSOQL =   'Select Sum(Total_IA_Sq_feet__c) SumOfIASquareFeet, Sum(Total_IA_Annual_Rent__c) SumOfIAAnnualRent, ' + 
                            'Sum(REXUSIASq_ft__c) REXUSSumOfIASquareFeet, Sum (REXUS_IA_Annual_Rent__c) REXUSSumOfIAAnnualRent ' +
                            'From   Glxy_Lease__c ' +
                            'Where  RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Next_FY_Leases__c = False ' + 
                            'And    StatusCode__c = \'Active\' ' +                     
                            'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                            'And    IAConverstionFY__c <= :strFiscalYearUserInput';
            }
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1b = ' + strSOQL);   
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) {
                BaseSqFtNOA_E += (Decimal) RowData.get('SumOfIASquareFeet');
                BaseAnnualRentNOA_E += (Decimal) RowData.get('SumOfIAAnnualRent');
                BasePYCostNOA_E += (Decimal) RowData.get('SumOfIAAnnualRent');
            }   
        }
        //Row 1 - Query 2 - Roll IA into NOA for future FY's
        
        //Row 1 - Query 3 - Add all Active Projects from Previous FYs to the Base estimates
        If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select eEorA__c, Sum(ChangeinIASQFt__c) ChangeinIASFt, Sum(ChangeinNOASQFt__c) ChangeinNOASFt, ' + 
                            'Sum(ExpanARentNOA__c) ExpanCostNOAFY, Sum(CancelARentNOA__c) CancelCostNOAFY, Sum(EscalARentNOA__c) EscalCostNOAFY ' +
                            'From   GLXY_LeaseProjectforSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                            'And    RegionCd__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    ProjectStatus__c <> \'Cancelled\' ' + 
                            'And    eEorA__c in (\'Estimate\', \'Actual\') ' + 
                            'Group By eEorA__c ';
            }else{
                strSOQL =   'Select eEorA__c, Sum(ChangeinIASQFt__c) ChangeinIASFt, Sum(ChangeinNOASQFt__c) ChangeinNOASFt, ' + 
                            'Sum(ExpanARentNOA__c) ExpanCostNOAFY, Sum(CancelARentNOA__c) CancelCostNOAFY, Sum(EscalARentNOA__c) EscalCostNOAFY ' +
                            'From   Glxy_LeaseProjects__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    ProjectStatus__c <> \'Cancelled\' ' + 
                            'And    eEorA__c in (\'Estimate\', \'Actual\') ' + 
                            'Group By eEorA__c ';
            }
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1c = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    BaseSqFtNOA_E += (Decimal) RowData.get('ChangeinNOASFt');
                    BaseAnnualRentNOA_E += (Decimal) RowData.get('ExpanCostNOAFY') + (Decimal) RowData.get('CancelCostNOAFY') + (Decimal) RowData.get('EscalCostNOAFY');
                    BasePYCostNOA_E += (Decimal) RowData.get('ExpanCostNOAFY') + (Decimal) RowData.get('CancelCostNOAFY') + (Decimal) RowData.get('EscalCostNOAFY'); 
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    BaseSqFtNOA_E += (Decimal) RowData.get('ChangeinNOASFt');
                    BaseAnnualRentNOA_E += (Decimal) RowData.get('ExpanCostNOAFY') + (Decimal) RowData.get('CancelCostNOAFY') + (Decimal) RowData.get('EscalCostNOAFY');
                    BasePYCostNOA_E += (Decimal) RowData.get('ExpanCostNOAFY') + (Decimal) RowData.get('CancelCostNOAFY') + (Decimal) RowData.get('EscalCostNOAFY');
                }
            }

            If(strFYSS == 'Snapshot'){
                strSOQL =  'Select eEorA__c, Sum(ChangeinIASQFt__c) ChangeinIASFt, Sum(ChangeinNOASQFt__c) ChangeinNOASFt, ' + 
                            'Sum(ExpanARentIA__c)  ExpanCostIAFY,  Sum(CancelARentIA__c)  CancelCostIAFY,  Sum(EscalARentIA__c)  EscalCostIAFY ' +
                            'From   GLXY_LeaseProjectforSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                            'And    RegionCd__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    ProjectStatus__c <> \'Cancelled\' ' + 
                            'And    eEorA__c in (\'Estimate\', \'Actual\') ' + 
                            'And    IAConverstionFY__c <= :strFiscalYearUserInput ' + 
                            'Group By eEorA__c ';
            }else{
                strSOQL =  'Select eEorA__c, Sum(ChangeinIASQFt__c) ChangeinIASFt, Sum(ChangeinNOASQFt__c) ChangeinNOASFt, ' + 
                            'Sum(ExpanARentIA__c)  ExpanCostIAFY,  Sum(CancelARentIA__c)  CancelCostIAFY,  Sum(EscalARentIA__c)  EscalCostIAFY ' +
                            'From   Glxy_LeaseProjects__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    ProjectStatus__c <> \'Cancelled\' ' + 
                            'And    eEorA__c in (\'Estimate\', \'Actual\') ' + 
                            'And    IAConverstionFY__c <= :strFiscalYearUserInput ' + 
                            'Group By eEorA__c ';
            }
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1c = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    BaseSqFtNOA_E += (Decimal) RowData.get('ChangeinIASFt');
                    BaseAnnualRentNOA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY');
                    BasePYCostNOA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY'); 
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    BaseSqFtNOA_E += (Decimal) RowData.get('ChangeinIASFt');
                    BaseAnnualRentNOA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY');
                    BasePYCostNOA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY');
                }
            }
        }
        //Row 1 - Query 3 - Add all active projects from Current FY to the base estimates

        //Row 1 - Query 4 - Add all Active CPI's from Previous FYs to the Base estimates
        If (strFiscalYearUserInput > strFiscalYear){
             If(strFYSS == 'Snapshot'){
                 strSOQL =  'Select IncludeinBudgetFlag__c, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   GLXY_LeasePaymentsSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    Payment_Category__c = \'Consumer Price Index\' ' +
                            'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                            'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    Status_Code__c in (\'Estimate\', \'Actual\') ' + 
                            'And    ParentRecord__r.IAConverstionFY__c <= :strFiscalYearUserInput ' +
                            'Group by IncludeinBudgetFlag__c ';
             }else{
                strSOQL =  'Select BDGFlag__c, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   Glxy_ConsumerPriceIndex__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                            'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    StatusCD__c in (\'Estimate\', \'Actual\') ' + 
                            'And    LeaseNumber__r.IAConverstionFY__c <= :strFiscalYearUserInput ' +
                            'Group by BDGFlag__c '; 
             }
                   
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1d = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                BaseAnnualRentNOA_E += (Decimal) RowData.get('AnnualAmountCPI');
                BasePYCostNOA_E += (Decimal) RowData.get('AnnualAmountCPI');
            }
            
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select IncludeinBudgetFlag__c, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   GLXY_LeasePaymentsSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    Payment_Category__c = \'Consumer Price Index\' ' +
                            'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                            'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    Status_Code__c in (\'Estimate\', \'Actual\') ' + 
                            'And    ParentRecord__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                            'Group by IncludeinBudgetFlag__c ';
            }else{
                strSOQL =   'Select BDGFlag__c, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   Glxy_ConsumerPriceIndex__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            //'And  LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                            'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    StatusCD__c in (\'Estimate\', \'Actual\') ' + 
                            'And    LeaseNumber__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                            'Group by BDGFlag__c ';
            }
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1d = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                //dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                //dbMultiplier = (Decimal) RowData.get('NOASqFt')/dbTotalSqFt;
                BaseAnnualRentNOA_E +=  (Decimal) RowData.get('NOAAnnualObligation');
                BasePYCostNOA_E +=  (Decimal) RowData.get('NOAAnnualObligation');
            }
            
        }
        //Row 1 - Query 4 - Add all Active CPI's from Previous FYs to the Base estimates

        //Row 1 - Query 5 - Add all Active Step Rents's from Previous FYs to the Base estimates
        If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =  'Select IncludeinBudgetFlag__c, Sum(AnnualAmount__c) AnnualAmountSR, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   GLXY_LeasePaymentsSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    Payment_Category__c = \'Step Rent\' ' +
                            'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                              'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    Status_Code__c in (\'Estimate\', \'Actual\') ' +
                            'And    ParentRecord__r.IAConverstionFY__c <= :strFiscalYearUserInput ' +
                            'Group by IncludeinBudgetFlag__c ';
            }else{
                 strSOQL =  'Select BDGFlag__c, Sum(Amount__c) AnnualAmountSR, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   Glxy_StepRent__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            //'And  LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                            'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    StatusCode__c in (\'Estimate\', \'Actual\') ' +
                            'And    LeaseNumber__r.IAConverstionFY__c <= :strFiscalYearUserInput ' +
                            'Group by BDGFlag__c ';
            }
                    
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1e = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                BaseAnnualRentNOA_E += (Decimal) RowData.get('AnnualAmountSR');
                BasePYCostNOA_E += (Decimal) RowData.get('AnnualAmountSR');
            }
            
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select IncludeinBudgetFlag__c, Sum(AnnualAmount__c) AnnualAmountSR, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                        '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                        'And    ProcessedDateFY__c >= :strFiscalYear '  +
                        'And    Payment_Category__c = \'Step Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    Status_Code__c in (\'Estimate\', \'Actual\') ' +
                        'And    ParentRecord__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                        'Group by IncludeinBudgetFlag__c ';
            }else{
                strSOQL =   'Select BDGFlag__c, Sum(Amount__c) AnnualAmountSR, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                        '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                        'From   Glxy_StepRent__c ' +
                        'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                        'And    ProcessedDateFY__c >= :strFiscalYear '  +
                        //'And  LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    StatusCode__c in (\'Estimate\', \'Actual\') ' +
                        'And    LeaseNumber__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                        'Group by BDGFlag__c ';
            }
                    
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1e = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                //dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                //dbMultiplier = (Decimal) RowData.get('NOASqFt')/dbTotalSqFt;
                BaseAnnualRentNOA_E += (Decimal) RowData.get('NOAAnnualObligation');
                BasePYCostNOA_E += (Decimal) RowData.get('NOAAnnualObligation');
            }
        }
        //Row 1 - Query 5 - Add all Active Step Rents's from Previous FYs to the Base estimates

       //Row 1 - Query 6 - Add all Active LPSR's from Previous FYs to the Base estimates
        If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select Status_Code__c, Sum(AnnualAmount__c) AnnualAmountSR, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput ' +
                            'And    ProcessedDateFY__c >= :strFiscalYear ' +
                            'And    Payment_Category__c = \'Lease Proj. Step Rent\' ' +
                            'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                            'And    ParentRecord__r.RegionCd__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                            'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                            'And    Status_Code__c in (\'Estimate\', \'Actual\') ' +
                            'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' + 
                            'Group by Status_Code__c ';
            }else{
                strSOQL =   'Select StatusCode__c, Sum(Amount__c) AnnualAmountSR, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   Glxy_LPStepRent__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput ' +
                            'And    ProcessedDateFY__c >= :strFiscalYear ' +
                            'And    ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                            'And    ProjectNumber__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                            'And    StatusCode__c in (\'Estimate\', \'Actual\') ' +
                            'And    ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' + 
                            'Group by StatusCode__c ';
            }
                    
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1e = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                If (String.ValueOf(RowData.get('StatusCode__c')).toUpperCase() == 'ACTUAL' || String.ValueOf(RowData.get('StatusCode__c')).toUpperCase() == 'ESTIMATE'){
                    //dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                    //dbMultiplier = (Decimal) RowData.get('NOASqFt')/dbTotalSqFt;
                    BaseAnnualRentNOA_E += (Decimal) RowData.get('NOAAnnualObligation');
                    BasePYCostNOA_E += (Decimal) RowData.get('NOAAnnualObligation');
                    //dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                    BaseAnnualRentIA_E += (Decimal) RowData.get('IAAnnualObligation');
                    BasePYCostIA_E += (Decimal) RowData.get('IAAnnualObligation'); 
                } 
            }
        }
        //Row 1 - Query 6 - Add all Active LPSR's from Previous FYs to the Base estimates
 
        //G2 Release 2.4 - Address future FY's
        String strSOQLProcessedDate = ' ';
        String strStringNOAProject = ' ';
        String strStringNOALease = ' ';
        String strStringIAProject = ' ';
        String strStringIALease = ' ';
        Boolean blnFutureFY = false;
        
        If (strFiscalYear == strFiscalYearUserInput){
            strSOQLProcessedDate = 'Where ProcessedDateFY__c = :strFiscalYear ';
            strStringNOAProject = ' And IAConverstionFY__c >= \'2500\' ';              //The second IA Query should not be fired for current FY
            If(strFYSS == 'Snapshot'){
                strStringNOALease = ' And ParentRecord__r.IAConverstionFY__c >= \'2500\' ';
            }else{
                strStringNOALease = ' And LeaseNumber__r.IAConverstionFY__c >= \'2500\' '; //The second IA Query should not be fired for current FY
            }
            //strStringIAProject = '';
            //strStringIALease = '';
        } else {
            blnFutureFY = true;
            strSOQLProcessedDate = ' Where ProcessedDateFY__c = :strFiscalYearUserInput ';
            strStringNOAProject = ' And IAConverstionFY__c <= :strFiscalYearUserInput ';
            If(strFYSS == 'Snapshot'){
                strStringNOALease = ' And ParentRecord__r.IAConverstionFY__c <= :strFiscalYearUserInput ';
                strStringIALease = ' And ParentRecord__r.IAConverstionFY__c > :strFiscalYearUserInput ';
            }else{
                strStringNOALease = ' And LeaseNumber__r.IAConverstionFY__c <= :strFiscalYearUserInput ';
                strStringIALease = ' And LeaseNumber__r.IAConverstionFY__c > :strFiscalYearUserInput ';
            }
            
            strStringIAProject = ' And IAConverstionFY__c > :strFiscalYearUserInput  ';
            
        }
        //G2 Release 2.4 - Address future FY's
        
        //Row 2 - Expansion NOA
        ExpanSqFtNOA_A = 0.0;
        ExpanARentNOA_A = 0.0;
        ExpanPYCostNOA_A = 0.0;
        ExpanSqFtNOA_E = 0.0;
        ExpanARentNOA_E = 0.0;
        ExpanPYCostNOA_E = 0.0;
        // Release 2.0 <-- IA NOA Conversion Date movement added as part of this release. This Query is now spilt as two ...
        // Query 1
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select eEorA__c, sum(ExpanSqFtNOA__c) ExpanSqFtNOA, sum(ExpanARentNOA__c) ExpanCostNOAFY, sum(ExpanPYCostNOA__c) ExpanCostNOAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    ExpanARentNOA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select eEorA__c, sum(ExpanSqFtNOA__c) ExpanSqFtNOA, sum(ExpanARentNOA__c) ExpanCostNOAFY, sum(ExpanPYCostNOA__c) ExpanCostNOAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    ExpanARentNOA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group By eEorA__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Row 2a = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                ExpanSqFtNOA_A   = (Decimal) RowData.get('ExpanSqFtNOA');
                ExpanARentNOA_A  = (Decimal) RowData.get('ExpanCostNOAFY');
                ExpanPYCostNOA_A = (Decimal) RowData.get('ExpanCostNOAPY');
            } 
            If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                ExpanSqFtNOA_E   = (Decimal) RowData.get('ExpanSqFtNOA');
                ExpanARentNOA_E  = (Decimal) RowData.get('ExpanCostNOAFY');
                ExpanPYCostNOA_E = (Decimal) RowData.get('ExpanCostNOAPY');
            }
        }
        
        // Query 2
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select  eEorA__c, Sum(ExpanSqFtNOA__c) ExpanSqFtNOA, Sum(ExpanSqFtIA__c) ExpanSqFtIA, Sum(ExpanARentNOA__c) ExpanCostNOAFY, Sum(ExpanARentIA__c) ExpanCostIAFY, Sum(ExpanPYCostNOA__c) ExpanCostNOAPY, Sum(ExpanPYCostIA__c) ExpanCostIAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    ExpanARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        strStringNOAProject + 
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select  eEorA__c, Sum(ExpanSqFtNOA__c) ExpanSqFtNOA, Sum(ExpanSqFtIA__c) ExpanSqFtIA, Sum(ExpanARentNOA__c) ExpanCostNOAFY, Sum(ExpanARentIA__c) ExpanCostIAFY, Sum(ExpanPYCostNOA__c) ExpanCostNOAPY, Sum(ExpanPYCostIA__c) ExpanCostIAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    ExpanARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        strStringNOAProject + 
                        'Group By eEorA__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Row 2b = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                ExpanSqFtNOA_A   += (Decimal) RowData.get('ExpanSqFtIA');
                ExpanARentNOA_A  += (Decimal) RowData.get('ExpanCostIAFY');
                ExpanPYCostNOA_A += (Decimal) RowData.get('ExpanCostIAPY');
            } 
            If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                ExpanSqFtNOA_E   += (Decimal) RowData.get('ExpanSqFtIA');
                ExpanARentNOA_E  += (Decimal) RowData.get('ExpanCostIAFY');
                ExpanPYCostNOA_E += (Decimal) RowData.get('ExpanCostIAPY');
            }
        }
        
        //Row 3 - Cancellation NOA
        CancelSqFtNOA_A = 0.0;
        CancelARentNOA_A = 0.0;
        CancelPYCostNOA_A = 0.0;
        CancelSqFtNOA_E = 0.0;
        CancelARentNOA_E = 0.0;
        CancelPYCostNOA_E = 0.0;
        // Release 2.0 <-- IA NOA Conversion Date movement added as part of this release. This Query is now spilt as two ...
        // Query 1
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select eEorA__c, sum(CancelSqFtNOA__c) CancelSqFtNOA, sum(CancelARentNOA__c) CancelCostNOAFY, sum(CancelPYCostNOA__c) CancelCostNOAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    CancelARentNOA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select eEorA__c, sum(CancelSqFtNOA__c) CancelSqFtNOA, sum(CancelARentNOA__c) CancelCostNOAFY, sum(CancelPYCostNOA__c) CancelCostNOAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    CancelARentNOA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group By eEorA__c ';
        }
                    
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    CancelSqFtNOA_A   = (Decimal) RowData.get('CancelSqFtNOA');
                    CancelARentNOA_A  = (Decimal) RowData.get('CancelCostNOAFY');
                    CancelPYCostNOA_A = (Decimal) RowData.get('CancelCostNOAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    CancelSqFtNOA_E   = (Decimal) RowData.get('CancelSqFtNOA');
                    CancelARentNOA_E  = (Decimal) RowData.get('CancelCostNOAFY');
                    CancelPYCostNOA_E = (Decimal) RowData.get('CancelCostNOAPY');
                }
            }
        }
        
        // Query 2
        If(strFYSS == 'Snapshot'){
            strSOQL =    'Select eEorA__c, Sum(CancelSqFtNOA__c) CancelSqFtNOA, Sum(CancelSqFtIA__c) CancelSqFtIA, Sum(CancelARentNOA__c) CancelCostNOAFY, Sum(CancelARentIA__c) CancelCostIAFY, ' + 
                        '       Sum(CancelPYCostNOA__c) CancelCostNOAPY, Sum(CancelPYCostIA__c) CancelCostIAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    CancelARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        strStringNOAProject +
                        'Group By eEorA__c ';
        }else{
           strSOQL =    'Select eEorA__c, Sum(CancelSqFtNOA__c) CancelSqFtNOA, Sum(CancelSqFtIA__c) CancelSqFtIA, Sum(CancelARentNOA__c) CancelCostNOAFY, Sum(CancelARentIA__c) CancelCostIAFY, ' + 
                        '       Sum(CancelPYCostNOA__c) CancelCostNOAPY, Sum(CancelPYCostIA__c) CancelCostIAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    CancelARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        strStringNOAProject +
                        'Group By eEorA__c ';
        }
                    
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    CancelSqFtNOA_A   += (Decimal) RowData.get('CancelSqFtIA');
                    CancelARentNOA_A  += (Decimal) RowData.get('CancelCostIAFY');
                    CancelPYCostNOA_A += (Decimal) RowData.get('CancelCostIAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    CancelSqFtNOA_E   += (Decimal) RowData.get('CancelSqFtIA');
                    CancelARentNOA_E  += (Decimal) RowData.get('CancelCostIAFY');
                    CancelPYCostNOA_E += (Decimal) RowData.get('CancelCostIAPY');
                }
            }
        }
        
        //Row 4 - Rent Increase (Escalation) - NOA
        EscalARentNOA_A = 0.0;
        EscalPYCostNOA_A = 0.0;
        EscalARentNOA_E = 0.0;
        EscalPYCostNOA_E = 0.0;
        // Release 2.0 <-- IA NOA Conversion Date movement added as part of this release. This Query is now spilt as two ...
        // Query 1
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select  eEorA__c, Sum(EscalSqFtNOA__c) EscalSqFtNOA, Sum(EscalARentNOA__c) EscalCostNOAFY, Sum(EscalPYCostNOA__c) EscalCostNOAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        //'And    EscalARentNOA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select  eEorA__c, Sum(EscalSqFtNOA__c) EscalSqFtNOA, Sum(EscalARentNOA__c) EscalCostNOAFY, Sum(EscalPYCostNOA__c) EscalCostNOAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    EscalARentNOA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group By eEorA__c ';
        }

        strSOQL = strSOQL.Replace('\\',''); 
        //System.debug('MyDebug Row 4 = ' + strSOQL);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    //EscalSqFtNOA_A   = (Decimal) RowData.get('EscalSqFtNOA');
                    EscalARentNOA_A  = (Decimal) RowData.get('EscalCostNOAFY');
                    EscalPYCostNOA_A = (Decimal) RowData.get('EscalCostNOAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    //EscalSqFtNOA_E   = (Decimal) RowData.get('EscalSqFtNOA');
                    EscalARentNOA_E  = (Decimal) RowData.get('EscalCostNOAFY');
                    EscalPYCostNOA_E = (Decimal) RowData.get('EscalCostNOAPY');
                }
            }
        }
        
        // Query 2
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select eEorA__c, Sum(EscalSqFtNOA__c) EscalSqFtNOA, Sum(EscalSqFtIA__c) EscalSqFtIA,  Sum(EscalARentNOA__c) EscalCostNOAFY, '+ 
                        '       Sum(EscalARentIA__c) EscalCostIAFY, Sum(EscalPYCostNOA__c) EscalCostNOAPY, Sum(EscalPYCostIA__c) EscalCostIAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        //'And    EscalARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        strStringNOAProject + 
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select eEorA__c, Sum(EscalSqFtNOA__c) EscalSqFtNOA, Sum(EscalSqFtIA__c) EscalSqFtIA,  Sum(EscalARentNOA__c) EscalCostNOAFY, '+ 
                        '       Sum(EscalARentIA__c) EscalCostIAFY, Sum(EscalPYCostNOA__c) EscalCostNOAPY, Sum(EscalPYCostIA__c) EscalCostIAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    EscalARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' + 
                        strStringNOAProject + 
                        'Group By eEorA__c ';
        }

        strSOQL = strSOQL.Replace('\\',''); 
        //System.debug('MyDebug Row 4 = ' + strSOQL);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    //EscalSqFtNOA_A   += (Decimal) RowData.get('EscalSqFtNOA');
                    If ( RowData.get('EscalCostIAFY') != null)
                    EscalARentNOA_A  += (Decimal) RowData.get('EscalCostIAFY');
                    EscalPYCostNOA_A += (Decimal) RowData.get('EscalCostIAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    //EscalSqFtNOA_E   += (Decimal) RowData.get('EscalSqFtNOA');
                    EscalARentNOA_E  += (Decimal) RowData.get('EscalCostIAFY');
                    EscalPYCostNOA_E += (Decimal) RowData.get('EscalCostIAPY');
                }
            }
        }
        
        //Row 5 - Operating Cost Escalation - CPI - NOA
        AnnualAmountCPI_A = 0.0;
        PYCostCPI_A = 0.0;
        AnnualAmountCPI_E = 0.0;
        PYCostCPI_E = 0.0;
        // Release 2.0 <-- IA NOA Conversion Date movement added as part of this release. This Query is now spilt as two ...
        // Query 1
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(FYObligationNOA__c) PYCostCPI, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    Payment_Category__c = \'Consumer Price Index\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(FY_Obligation_NOA__c) PYCostCPI, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_ConsumerPriceIndex__c ' +
                        strSOQLProcessedDate +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'Group by StatusCD__c ';
        }
                    
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Row 5a = ' + strSOQL);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('NOASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    AnnualAmountCPI_A  = (Decimal) RowData.get('AnnualAmountCPI') * dbMultiplier;
                    PYCostCPI_A = (Decimal) RowData.get('PYCostCPI');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    AnnualAmountCPI_E  = (Decimal) RowData.get('AnnualAmountCPI') * dbMultiplier;
                    PYCostCPI_E = (Decimal) RowData.get('PYCostCPI');
                }
            }            
        }
        
        // Query 2
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(FYObligationNOA__c) NOAPYCostCPI, Sum(FYObligationIA__c) IAPYCostCPI, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        strSOQLProcessedDate  +
                        'And    Payment_Category__c = \'Consumer Price Index\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        strStringNOALease +      
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(FY_Obligation_NOA__c) NOAPYCostCPI, Sum(FY_Obligation_IA__c) IAPYCostCPI, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_ConsumerPriceIndex__c ' +
                        strSOQLProcessedDate  +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        strStringNOALease +
                        'Group by StatusCD__c ';
        }
                    
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Row 5b = ' + strSOQL);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    AnnualAmountCPI_A  += (Decimal) RowData.get('AnnualAmountCPI') * dbMultiplier;
                    PYCostCPI_A += (Decimal) RowData.get('IAPYCostCPI');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    AnnualAmountCPI_E  += (Decimal) RowData.get('AnnualAmountCPI') * dbMultiplier;
                    PYCostCPI_E += (Decimal) RowData.get('IAPYCostCPI');
                }
            }            
        }
        
        //Row 6 - Step Rent - NOA
        AnnualAmountStepRent_A = 0.0;
        PYCostStepRent_A = 0.0;
        AnnualAmountStepRent_E = 0.0;
        PYCostStepRent_E = 0.0;
        // Release 2.0 <-- IA NOA Conversion Date movement added as part of this release. This Query is now spilt as two ...
        // Query 1
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountStepRent, Sum(FYObligationNOA__c) PYCostStepRent, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        strSOQLProcessedDate  +
                        'And    Payment_Category__c = \'Step Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCode__c StatusCode, Sum(Amount__c) AnnualAmountStepRent, Sum(FY_Obligation_NOA__c) PYCostStepRent, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_StepRent__c ' +
                        strSOQLProcessedDate  +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by StatusCode__c ';
        }
        
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('NOASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    AnnualAmountStepRent_A  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PYCostStepRent_A = (Decimal) RowData.get('PYCostStepRent');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    AnnualAmountStepRent_E  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PYCostStepRent_E = (Decimal) RowData.get('PYCostStepRent');
                }
            }
        }
        // Query 2
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountStepRent, Sum(FYObligationNOA__c) NOAPYCostStepRent, Sum(FYObligationIA__c) IAPYCostStepRent, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        strSOQLProcessedDate  +
                        'And    Payment_Category__c = \'Step Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                         strStringNOALease +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCode__c StatusCode, Sum(Amount__c) AnnualAmountStepRent, Sum(FY_Obligation_NOA__c) NOAPYCostStepRent, Sum(FY_Obligation_IA__c) IAPYCostStepRent, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_StepRent__c ' +
                        strSOQLProcessedDate  +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                         strStringNOALease +
                        'Group by StatusCode__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    AnnualAmountStepRent_A  += (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PYCostStepRent_A += (Decimal) RowData.get('IAPYCostStepRent') ;
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    AnnualAmountStepRent_E  += (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PYCostStepRent_E += (Decimal) RowData.get('IAPYCostStepRent');
                }
            }            
        }
        
        //Row 7 - Lump Sums - NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationNOA__c) PYCostLS ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        //'Where  ProcessedDateFY__c  = :strFiscalYearUserInput ' +
                        'Where  Payment_Category__c = \'Lump Sum\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select LumpSum__r.StatusCD__c StatusCode, Sum(FY_Obligation_NOA__c) PYCostLS ' +
                        'From   Glxy_LumpSumObligations__c ' +
                        'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                        //'And    LumpSum__r.LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LumpSum__r.LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    LumpSum__r.LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    LumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by LumpSum__r.StatusCD__c ';
        }
                    
        strSOQL = strSOQL.Replace('\\',''); 
        //ystem.debug('MyDebug Row 4 = ' + strSOQL);
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PYCostLS_A  = (Decimal) RowData.get('PYCostLS');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PYCostLS_E  = (Decimal) RowData.get('PYCostLS');
                }
            }
        }
        
        //Row 8 - IBAA's - NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationNOA__c) PYCostIBAA ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    Payment_Category__c = \'IBAA\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +  
                       // 'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(FY_Obligation_NOA__c) PYCostIBAA ' +
                        'From   Glxy_IntraBudgetActivityAuthorization__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'Group by StatusCD__c ';
        }
        
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PYCostIBAA_A  = (Decimal) RowData.get('PYCostIBAA');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PYCostIBAA_E  = (Decimal) RowData.get('PYCostIBAA');
                }
            }
        }
        
        //Row 9 - RWA's - NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationNOA__c) PYCostRWA ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    Payment_Category__c = \'RWA\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        //'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(FY_Obligation_NOA__c) PYCostRWA ' +
                        'From   Glxy_ReimbursableWorkAuthorization__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'Group by StatusCD__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) {
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PYCostRWA_A  = (Decimal) RowData.get('PYCostRWA');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PYCostRWA_E  = (Decimal) RowData.get('PYCostRWA');
                }
            }
        }
        
        //Row 10 - Double Rent NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Sum(FYObligationNOA__c) DoubleRentNOA, ParentRecord__r.eEorA__c eEorA__c ' +
                        'From   GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                        //'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'Where  Payment_Category__c = \'Double Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCd__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__c <> \'\'' +
                        'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group By ParentRecord__r.eEorA__c ';
        }else{
            strSOQL =   'Select Sum(FY_Obligation_NOA__c) DoubleRentNOA, Associated_Leases_Projects_ID__r.Project__r.eEorA__c eEorA__c ' +
                        'From   Glxy_DoubleRent__c ' +
                        'Where  Fiscal_Year__c = :strFiscalYearUserInput ' +
                        'And    Associated_Leases_Projects_ID__r.Project__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Associated_Leases_Projects_ID__r.Project__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    Associated_Leases_Projects_ID__c <> \'\'' +
                        'And    Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'Group By Associated_Leases_Projects_ID__r.Project__r.eEorA__c ';
        }
        
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    DoubleRentNOA_A   = (Decimal) RowData.get('DoubleRentNOA');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    DoubleRentNOA_E   = (Decimal) RowData.get('DoubleRentNOA');
                }
            }
        }
        
        //Row 11 - Project Step Rent - NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountStepRent, Sum(FYObligationNOA__c) PYCostStepRent, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    Payment_Category__c = \'Lease Proj. Step Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' + 
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCode__c StatusCode, Sum(Amount__c) AnnualAmountStepRent, Sum(FY_Obligation_NOA__c) PYCostStepRent, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_LPStepRent__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    ProjectNumber__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' + 
                        'Group by StatusCode__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('NOASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PrjAnnualAmountStepRent_A  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PrjPYCostStepRent_A = (Decimal) RowData.get('PYCostStepRent');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PrjAnnualAmountStepRent_E  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PrjPYCostStepRent_E = (Decimal) RowData.get('PYCostStepRent');
                }
            }
        }
        
        //Row 12 - Project Lump Sums - NOA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationNOA__c) PYCostLS ' +
                        'From   GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                        //'Where  ProcessedDateFY__c  = :strFiscalYearUserInput ' +
                        'Where  Payment_Category__c = \'Lease Proj. Lump Sum\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select LPLumpSum__r.StatusCD__c StatusCode, Sum(FY_Obligation_NOA__c) PYCostLS ' +
                        'From   Glxy_LPLumpSumObligations__c ' +
                        'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                        'And    LPLumpSum__r.ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    LPLumpSum__r.ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    LPLumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    LPLumpSum__r.ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'Group by LPLumpSum__r.StatusCD__c ';
        }
        
                    
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PrjPYCostLS_A  = (Decimal) RowData.get('PYCostLS');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PrjPYCostLS_E  = (Decimal) RowData.get('PYCostLS');
                }
            }
        }
        
        //Row 13 - Total - NOA
        NOATotalSqFt_A = fnCheckNull(BaseSqFtNOA_A) + fnCheckNull(ExpanSqFtNOA_A) + fnCheckNull(CancelSqFtNOA_A);
        NOATotalAnnualRent_A = fnCheckNull(BaseAnnualRentNOA_A) + fnCheckNull(ExpanARentNOA_A) + fnCheckNull(CancelARentNOA_A) + fnCheckNull(EscalARentNOA_A) + fnCheckNull(AnnualAmountCPI_A) + fnCheckNull(AnnualAmountStepRent_A) + fnCheckNull(PrjAnnualAmountStepRent_A);
        NOATotalPYCost_A = fnCheckNull(BasePYCostNOA_A) + fnCheckNull(ExpanPYCostNOA_A) + fnCheckNull(CancelPYCostNOA_A) + fnCheckNull(EscalPYCostNOA_A) + fnCheckNull(PYCostCPI_A) + fnCheckNull(PYCostStepRent_A) + fnCheckNull(PrjPYCostStepRent_A) + fnCheckNull(PYCostLS_A) + fnCheckNull(PrjPYCostLS_A) + fnCheckNull(PYCostIBAA_A) + fnCheckNull(PYCostRWA_A) + fnCheckNull(DoubleRentNOA_A);
        NOATotalSqFt_E = fnCheckNull(BaseSqFtNOA_E) + fnCheckNull(ExpanSqFtNOA_E) + fnCheckNull(CancelSqFtNOA_E);
        NOATotalAnnualRent_E = fnCheckNull(BaseAnnualRentNOA_E) + fnCheckNull(ExpanARentNOA_E) + fnCheckNull(CancelARentNOA_E) + fnCheckNull(EscalARentNOA_E) + fnCheckNull(AnnualAmountCPI_E) + fnCheckNull(AnnualAmountStepRent_E) + fnCheckNull(PrjAnnualAmountStepRent_E);
        NOATotalPYCost_E = fnCheckNull(BasePYCostNOA_E) + fnCheckNull(ExpanPYCostNOA_E) + fnCheckNull(CancelPYCostNOA_E) + fnCheckNull(EscalPYCostNOA_E) + fnCheckNull(PYCostCPI_E)  + fnCheckNull(PYCostStepRent_E) + fnCheckNull(PrjPYCostStepRent_E) + fnCheckNull(PYCostLS_E) + fnCheckNull(PrjPYCostLS_E) + fnCheckNull(PYCostIBAA_E) + fnCheckNull(PYCostRWA_E) + fnCheckNull(DoubleRentNOA_E);
        NOATotalSqFt = fnCheckNull(NOATotalSqFt_A) + fnCheckNull(NOATotalSqFt_E);
        NOATotalAnnualRent = fnCheckNull(NOATotalAnnualRent_A) + fnCheckNull(NOATotalAnnualRent_E);
        NOATotalPYCost = fnCheckNull(NOATotalPYCost_A) + fnCheckNull(NOATotalPYCost_E);

        //Row 14 - Base Rent IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Sum(TotalIASqft__c) SumOfIASquareFeet, Sum(Total_IA_Annual_Rent__c) SumOfIAAnnualRent ' + 
                        'From   Glxy_LeaseSnapshot__c ' +
                        'Where  RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    NextFYLeases__c = False ' + 
                        'And    StatusCode__c = \'Active\' ' +                     
                        'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ';
        }else{
            strSOQL =   'Select Sum(Total_IA_Sq_feet__c) SumOfIASquareFeet, Sum(Total_IA_Annual_Rent__c) SumOfIAAnnualRent, ' + 
                        'Sum(REXUSIASq_ft__c) REXUSSumOfIASquareFeet, Sum (REXUS_IA_Annual_Rent__c) REXUSSumOfIAAnnualRent ' +
                        'From   Glxy_Lease__c ' +
                        'Where  RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Next_FY_Leases__c = False ' + 
                        'And    StatusCode__c = \'Active\' ' +                     
                        'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ';
        }
        if (strFiscalYearUserInput != strFiscalYear){
            strSOQL += 'And IAConverstionFY__c > :strFiscalYearUserInput';
        } 
                    
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        
        for (AggregateResult RowData : AgR) {
            If (RowData.get('SumOfIASquareFeet') != Null){
                If (strFiscalYearUserInput == strFiscalYear){
                    BaseSqFtIA_A = (Decimal) RowData.get('SumOfIASquareFeet');
                    BaseAnnualRentIA_A = (Decimal) RowData.get('SumOfIAAnnualRent');
                    BasePYCostIA_A = (Decimal) RowData.get('SumOfIAAnnualRent');
                } else {
                    BaseSqFtIA_E += (Decimal) RowData.get('SumOfIASquareFeet');
                    BaseAnnualRentIA_E += (Decimal) RowData.get('SumOfIAAnnualRent');
                    BasePYCostIA_E += (Decimal) RowData.get('SumOfIAAnnualRent');
                }
            }
        }

        //Row 14 - Query 2 - Add all Active Projects from Previous FYs to the Base estimates
        If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =  'Select eEorA__c, Sum(ChangeinIASQFt__c) ChangeinIASFt, Sum(ChangeinNOASQFt__c) ChangeinNOASFt, ' + 
                            'Sum(ExpanARentIA__c)  ExpanCostIAFY,  Sum(CancelARentIA__c)  CancelCostIAFY,  Sum(EscalARentIA__c)  EscalCostIAFY ' +
                            'From   GLXY_LeaseProjectforSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                            'And    RegionCd__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    ProjectStatus__c <> \'Cancelled\' ' + 
                            'And    eEorA__c in (\'Estimate\',\'Actual\') ' + 
                            'And    IAConverstionFY__c > :strFiscalYearUserInput ' + 
                            'Group By eEorA__c ';   
            }else{
                 strSOQL =  'Select eEorA__c, Sum(ChangeinIASQFt__c) ChangeinIASFt, Sum(ChangeinNOASQFt__c) ChangeinNOASFt, ' + 
                            'Sum(ExpanARentIA__c)  ExpanCostIAFY,  Sum(CancelARentIA__c)  CancelCostIAFY,  Sum(EscalARentIA__c)  EscalCostIAFY ' +
                            'From   Glxy_LeaseProjects__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                            'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    ProjectStatus__c <> \'Cancelled\' ' + 
                            'And    eEorA__c in (\'Estimate\',\'Actual\') ' + 
                            'And    IAConverstionFY__c > :strFiscalYearUserInput ' + 
                            'Group By eEorA__c ';
            }
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1c = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    BaseSqFtIA_E += (Decimal) RowData.get('ChangeinIASFt');
                    BaseAnnualRentIA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY');
                    BasePYCostIA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY'); 
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    BaseSqFtIA_E += (Decimal) RowData.get('ChangeinIASFt');
                    BaseAnnualRentIA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY');
                    BasePYCostIA_E += (Decimal) RowData.get('ExpanCostIAFY') + (Decimal) RowData.get('CancelCostIAFY') + (Decimal) RowData.get('EscalCostIAFY');
                }
            }
        }
        //Row 14 - Query 2 - Add all Active Projects from Previous FYs to the Base estimates
        
        //Row 14 - Query 3 - Add all CPIs from Previous FYs to the Base estimates
         If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select IncludeinBudgetFlag__c, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   GLXY_LeasePaymentsSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            'And    Payment_Category__c = \'Consumer Price Index\' ' +
                            'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                            'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    Status_Code__c in (\'Estimate\', \'Actual\') ' + 
                            'And    ParentRecord__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                            'Group by IncludeinBudgetFlag__c ';
            }else{
                strSOQL =   'Select BDGFlag__c, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   Glxy_ConsumerPriceIndex__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                            'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    StatusCD__c in (\'Estimate\', \'Actual\') ' + 
                            'And    LeaseNumber__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                            'Group by BDGFlag__c ';
            }
                   
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1d = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                //dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                //dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                BaseAnnualRentIA_E += (Decimal) RowData.get('IAAnnualObligation');
                BasePYCostIA_E += (Decimal) RowData.get('IAAnnualObligation'); 
            }
            
         }   
         //Row 14 - Query 3 - Add all CPIs from Previous FYs to the Base estimates   
        
        //Row 14 - Query 4 - Add all SR from Previous FYs to the Base estimates
         If (strFiscalYearUserInput > strFiscalYear){
            If(strFYSS == 'Snapshot'){
                strSOQL =   'Select IncludeinBudgetFlag__c, Sum(AnnualAmount__c) AnnualAmountSR, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   GLXY_LeasePaymentsSnapshot__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            //'And  LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                            'And    Payment_Category__c = \'Step Rent\' ' +
                            'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                            'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    Status_Code__c in (\'Estimate\', \'Actual\') ' +
                            'And    ParentRecord__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                            'Group by IncludeinBudgetFlag__c ';
            }else{
                strSOQL =   'Select BDGFlag__c, Sum(Amount__c) AnnualAmountSR, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
                            '       Sum(Annual_Obligation_IA__c) IAAnnualObligation, Sum(Annual_Obligation_NOA__c) NOAAnnualObligation ' +
                            'From   Glxy_StepRent__c ' +
                            'Where  ProcessedDateFY__c < :strFiscalYearUserInput '  +
                            'And    ProcessedDateFY__c >= :strFiscalYear '  +
                            //'And  LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                            'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                            'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                            'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                            'And    StatusCode__c in (\'Estimate\', \'Actual\') ' +
                            'And    LeaseNumber__r.IAConverstionFY__c > :strFiscalYearUserInput ' +
                            'Group by BDGFlag__c ';
            }
            
            strSOQL = strSOQL.Replace('\\',''); 
            System.debug('MyDebug Row 1e = ' + strSOQL);           
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                //dbTotalSqFt = (((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0)? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                //dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                BaseAnnualRentIA_E += (Decimal) RowData.get('IAAnnualObligation');
                BasePYCostIA_E += (Decimal) RowData.get('IAAnnualObligation'); 
            }
         }   
         //Row 14 - Query 3 - Add all SR from Previous FYs to the Base estimates   
         
        //Row 15 - Expansion IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select  eEorA__c, sum(ExpanSqFtIA__c) ExpanSqFtIA, sum(ExpanARentIA__c) ExpanCostIAFY, sum(ExpanPYCostIA__c) ExpanCostIAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    ExpanARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' +
                        strStringIAProject +
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select  eEorA__c, sum(ExpanSqFtIA__c) ExpanSqFtIA, sum(ExpanARentIA__c) ExpanCostIAFY, sum(ExpanPYCostIA__c) ExpanCostIAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    ExpanARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' +
                        strStringIAProject +
                        'Group By eEorA__c ';
        }
                    
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){ 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    ExpanSqFtIA_A   = (Decimal) RowData.get('ExpanSqFtIA');
                    ExpanARentIA_A  = (Decimal) RowData.get('ExpanCostIAFY');
                    ExpanPYCostIA_A = (Decimal) RowData.get('ExpanCostIAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    ExpanSqFtIA_E   = (Decimal) RowData.get('ExpanSqFtIA');
                    ExpanARentIA_E  = (Decimal) RowData.get('ExpanCostIAFY');
                    ExpanPYCostIA_E = (Decimal) RowData.get('ExpanCostIAPY');
                }
            }
        }
        
        //Row 16 - Cancellation IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select  eEorA__c, sum(CancelSqFtIA__c) CancelSqFtIA, sum(CancelARentIA__c) CancelCostIAFY, sum(CancelPYCostIA__c) CancelCostIAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    CancelARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' +
                        strStringIAProject +
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select  eEorA__c, sum(CancelSqFtIA__c) CancelSqFtIA, sum(CancelARentIA__c) CancelCostIAFY, sum(CancelPYCostIA__c) CancelCostIAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    CancelARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' +
                        strStringIAProject +
                        'Group By eEorA__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    CancelSqFtIA_A   = (Decimal) RowData.get('CancelSqFtIA');
                    CancelARentIA_A  = (Decimal) RowData.get('CancelCostIAFY');
                    CancelPYCostIA_A = (Decimal) RowData.get('CancelCostIAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    CancelSqFtIA_E   = (Decimal) RowData.get('CancelSqFtIA');
                    CancelARentIA_E  = (Decimal) RowData.get('CancelCostIAFY');
                    CancelPYCostIA_E = (Decimal) RowData.get('CancelCostIAPY');
                }
            }
        }
        
        //Row 17 - Rent Increase (Escalation)
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select  eEorA__c, Sum(EscalSqFtIA__c) EscalSqFtIA, Sum(EscalARentIA__c) EscalCostIAFY, Sum(EscalPYCostIA__c) EscalCostIAPY ' +
                        'From   GLXY_LeaseProjectforSnapshot__c ' +
                        strSOQLProcessedDate +
                        'And    SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    EscalARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' +
                        strStringIAProject +
                        'Group By eEorA__c ';
        }else{
            strSOQL =   'Select  eEorA__c, Sum(EscalSqFtIA__c) EscalSqFtIA, Sum(EscalARentIA__c) EscalCostIAFY, Sum(EscalPYCostIA__c) EscalCostIAPY ' +
                        'From   Glxy_LeaseProjects__c ' +
                        strSOQLProcessedDate +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        //'And    EscalARentIA__c <> 0 ' +
                        'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
                        'And    ProjectStatus__c <> \'Cancelled\' ' +
                        strStringIAProject +
                        'Group By eEorA__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                //EscalSqFtIA_A   = (Decimal) RowData.get('EscalSqFtIA');
                EscalARentIA_A  = (Decimal) RowData.get('EscalCostIAFY');
                EscalPYCostIA_A = (Decimal) RowData.get('EscalCostIAPY');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    //EscalSqFtIA_E   = (Decimal) RowData.get('EscalSqFtIA');
                    EscalARentIA_E  = (Decimal) RowData.get('EscalCostIAFY');
                    EscalPYCostIA_E = (Decimal) RowData.get('EscalCostIAPY');
                }
            }
        }
       
        //Row 18 - Operating Cost Escalation - CPI - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(FYObligationIA__c) PYCostCPI, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        strSOQLProcessedDate +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    Payment_Category__c = \'Consumer Price Index\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        strStringIALease + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(AnnualAmount__c) AnnualAmountCPI, Sum(FY_Obligation_IA__c) PYCostCPI, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_ConsumerPriceIndex__c ' +
                        strSOQLProcessedDate +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        strStringIALease + 
                        'Group by StatusCD__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    IA_AnnualAmountCPI_A  = (Decimal) RowData.get('AnnualAmountCPI') * dbMultiplier;
                    //IA_AnnualAmountCPI_A = AnnualAmountCPI_A; // Annual Amount is the SUM after the INA/NOA Conversion movement, So use from above ...
                    IA_PYCostCPI_A = (Decimal) RowData.get('PYCostCPI');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    IA_AnnualAmountCPI_E  = (Decimal) RowData.get('AnnualAmountCPI')* dbMultiplier;
                    //IA_AnnualAmountCPI_E = AnnualAmountCPI_E; // Annual Amount is the SUM after the INA/NOA Conversion movement, So use from above ...
                    IA_PYCostCPI_E = (Decimal) RowData.get('PYCostCPI');
                }
            }
        }
        
        //Row 19 - Step Rent - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountStepRent, Sum(FYObligationIA__c) PYCostStepRent, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        strSOQLProcessedDate +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    Payment_Category__c = \'Step Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        strStringIALease + 
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCode__c StatusCode, Sum(Amount__c) AnnualAmountStepRent, Sum(FY_Obligation_IA__c) PYCostStepRent, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_StepRent__c ' +
                        strSOQLProcessedDate +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        strStringIALease + 
                        'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by StatusCode__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    IA_AnnualAmountStepRent_A  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    IA_PYCostStepRent_A = (Decimal) RowData.get('PYCostStepRent');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    IA_AnnualAmountStepRent_E  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    IA_PYCostStepRent_E = (Decimal) RowData.get('PYCostStepRent');
                }
            }
        }
        
        //Row 20 - Lump Sums - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationIA__c) PYCostLS ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        //'Where  ProcessedDateFY__c  = :strFiscalYearUserInput ' +
                        //'And    LumpSum__r.LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'Where  Payment_Category__c = \'Lump Sum\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select LumpSum__r.StatusCD__c StatusCode, Sum(FY_Obligation_IA__c) PYCostLS ' +
                        'From   Glxy_LumpSumObligations__c ' +
                        'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                        //'And    LumpSum__r.LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LumpSum__r.LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    LumpSum__r.LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    LumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by LumpSum__r.StatusCD__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    IA_PYCostLS_A  = (Decimal) RowData.get('PYCostLS');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    IA_PYCostLS_E  = (Decimal) RowData.get('PYCostLS');
                }
            }
        }
        
        //Row 21 - IBAA's - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationIA__c) PYCostIBAA ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    Payment_Category__c = \'IBAA\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +  
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                      //  'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(FY_Obligation_IA__c) PYCostIBAA ' +
                        'From   Glxy_IntraBudgetActivityAuthorization__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'Group by StatusCD__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    IA_PYCostIBAA_A  = (Decimal) RowData.get('PYCostIBAA');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    IA_PYCostIBAA_E  = (Decimal) RowData.get('PYCostIBAA');
                }
            }
        }
        
        //Row 22 - RWA's - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationIA__c) PYCostRWA ' +
                        'From   GLXY_LeasePaymentsSnapshot__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    Payment_Category__c = \'RWA\' ' +
                        //'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' + 
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    ParentRecord__r.RegionCode__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCD__c StatusCode, Sum(FY_Obligation_IA__c) PYCostRWA ' +
                        'From   Glxy_ReimbursableWorkAuthorization__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                        'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'Group by StatusCD__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) {
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    IA_PYCostRWA_A  = (Decimal) RowData.get('PYCostRWA');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    IA_PYCostRWA_E  = (Decimal) RowData.get('PYCostRWA');
                }
            }
        }
        
        //Row 23 - Double Rent IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Sum(FYObligationIA__c) DoubleRentIA, ParentRecord__r.eEorA__c eEorA__c ' +
                        'From GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                        //'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'Where  Payment_Category__c = \'Double Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__c <> \'\'' +
                        'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group By ParentRecord__r.eEorA__c ';
        }else{
            strSOQL =   'Select Sum(FY_Obligation_IA__c) DoubleRentIA, Associated_Leases_Projects_ID__r.Project__r.eEorA__c eEorA__c ' +
                        'From Glxy_DoubleRent__c ' +
                        'Where Fiscal_Year__c = :strFiscalYearUserInput ' +
                        'And    Associated_Leases_Projects_ID__r.Project__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    Associated_Leases_Projects_ID__r.Project__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                        'And    Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    Associated_Leases_Projects_ID__c <> \'\'' +
                        'And    Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'Group By Associated_Leases_Projects_ID__r.Project__r.eEorA__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('eEorA__c') != null){
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ACTUAL'){
                    DoubleRentIA_A   = (Decimal) RowData.get('DoubleRentIA');
                } 
                If (String.ValueOf(RowData.get('eEorA__c')).toUpperCase() == 'ESTIMATE'){
                    DoubleRentIA_E   = (Decimal) RowData.get('DoubleRentIA');
                }
            }
        }
        
        //Row 24 - Project Step Rent - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(AnnualAmount__c) AnnualAmountStepRent, Sum(FYObligationIA__c) PYCostStepRent, Sum(IASqFt__c) IASqFt, Sum(NOASqFt__c) NOASqFt ' +
                        'From   GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    Payment_Category__c = \'Lease Proj. Step Rent\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                        'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select StatusCode__c StatusCode, Sum(Amount__c) AnnualAmountStepRent, Sum(FY_Obligation_IA__c) PYCostStepRent, Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt ' +
                        'From   Glxy_LPStepRent__c ' +
                        'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                        'And    ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                        'And    ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                        'And    ProjectNumber__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'Group by StatusCode__c ';
        }
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                dbTotalSqFt = ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt')) == 0? 1 : ((Decimal) RowData.get('IASqFt') + (Decimal) RowData.get('NOASqFt'));
                dbMultiplier = (Decimal) RowData.get('IASqFt')/dbTotalSqFt;
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PrjIA_AnnualAmountStepRent_A  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PrjIA_PYCostStepRent_A = (Decimal) RowData.get('PYCostStepRent');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PrjIA_AnnualAmountStepRent_E  = (Decimal) RowData.get('AnnualAmountStepRent') * dbMultiplier;
                    PrjIA_PYCostStepRent_E = (Decimal) RowData.get('PYCostStepRent');
                }
            }
        }
        
        //Row 25 - Project Lump Sums - IA
        If(strFYSS == 'Snapshot'){
            strSOQL =   'Select Status_Code__c StatusCode, Sum(FYObligationIA__c) PYCostLS ' +
                        'From   GLXY_LeaseProjectPaymentsForSnapshot__c ' +
                        //'Where  ProcessedDateFY__c  = :strFiscalYearUserInput ' +
                        'Where  Payment_Category__c = \'Lease Proj. Lump Sum\' ' +
                        'And    ParentRecord__r.SnapshotName__r.Snapshot_Date__c = :strSnapshotDate ' +
                        'And    ParentRecord__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    ParentRecord__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    ParentRecord__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    ParentRecord__r.ProjectStatus__c <> \'Cancelled\' ' +
                         'And    IncludeinBudgetFlag__c = :blnIncludeinBudgetFlag ' + 
                        'Group by Status_Code__c ';
        }else{
            strSOQL =   'Select LPLumpSum__r.StatusCD__c StatusCode, Sum(FY_Obligation_IA__c) PYCostLS ' +
                        'From   Glxy_LPLumpSumObligations__c ' +
                        'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
    'And    LPLumpSum__r.ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                        'And    LPLumpSum__r.ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                        'And    LPLumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                        'And    LPLumpSum__r.ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' +
                        'Group by LPLumpSum__r.StatusCD__c ';
        }          
        strSOQL = strSOQL.Replace('\\',''); 
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            If (RowData.get('StatusCode') != null){
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ACTUAL'){
                    PrjIA_PYCostLS_A  = (Decimal) RowData.get('PYCostLS');
                } 
                If (String.ValueOf(RowData.get('StatusCode')).toUpperCase() == 'ESTIMATE'){
                    PrjIA_PYCostLS_E  = (Decimal) RowData.get('PYCostLS');
                }
            }
        }
        
        //Row 26 - Total - IA
        IATotalSqFt_A = fnCheckNull(BaseSqFtIA_A) + fnCheckNull(ExpanSqFtIA_A) + fnCheckNull(CancelSqFtIA_A);
        IATotalAnnualRent_A = fnCheckNull(BaseAnnualRentIA_A) + fnCheckNull(ExpanARentIA_A) + fnCheckNull(CancelARentIA_A) + fnCheckNull(EscalARentIA_A) + fnCheckNull(IA_AnnualAmountCPI_A) + fnCheckNull(IA_AnnualAmountStepRent_A) + fnCheckNull(PrjIA_AnnualAmountStepRent_A);
        IATotalPYCost_A = fnCheckNull(BasePYCostIA_A) + fnCheckNull(ExpanPYCostIA_A) + fnCheckNull(CancelPYCostIA_A) + fnCheckNull(EscalPYCostIA_A) + fnCheckNull(IA_PYCostCPI_A) + fnCheckNull(IA_PYCostStepRent_A) + fnCheckNull(PrjIA_PYCostStepRent_A) + fnCheckNull(IA_PYCostLS_A) + fnCheckNull(PrjIA_PYCostLS_A) + fnCheckNull(IA_PYCostIBAA_A) + fnCheckNull(IA_PYCostRWA_A) + fnCheckNull(DoubleRentIA_A);
        IATotalSqFt_E = fnCheckNull(BaseSqFtIA_E) + fnCheckNull(ExpanSqFtIA_E) + fnCheckNull(CancelSqFtIA_E);
        IATotalAnnualRent_E = fnCheckNull(BaseAnnualRentIA_E) + fnCheckNull(ExpanARentIA_E) + fnCheckNull(CancelARentIA_E) + fnCheckNull(EscalARentIA_E) + fnCheckNull(IA_AnnualAmountCPI_E) + fnCheckNull(IA_AnnualAmountStepRent_E) + fnCheckNull(PrjIA_AnnualAmountStepRent_E);
        IATotalPYCost_E = fnCheckNull(BasePYCostIA_E) + fnCheckNull(ExpanPYCostIA_E) + fnCheckNull(CancelPYCostIA_E) + fnCheckNull(EscalPYCostIA_E) + fnCheckNull(IA_PYCostCPI_E)  + fnCheckNull(IA_PYCostStepRent_E) + fnCheckNull(PrjIA_PYCostStepRent_E) + fnCheckNull(IA_PYCostLS_E) + fnCheckNull(PrjIA_PYCostLS_E) + fnCheckNull(IA_PYCostIBAA_E) + fnCheckNull(IA_PYCostRWA_E) + fnCheckNull(DoubleRentIA_E);
        IATotalSqFt = fnCheckNull(IATotalSqFt_A) + fnCheckNull(IATotalSqFt_E);
        IATotalAnnualRent = fnCheckNull(IATotalAnnualRent_A) + fnCheckNull(IATotalAnnualRent_E);
        IATotalPYCost = fnCheckNull(IATotalPYCost_A) + fnCheckNull(IATotalPYCost_E);
        
       //Allowances and Base Targets ...
       If(strFYSS != 'Snapshot'){
            strSOQL =   'Select Sum(IA_Total_Allowance__c) AllowanceIA, Sum(NOA_Total_Allowance__c) AllowanceNOA, ' +
                        'Sum(IATarget__c) IABaseTarget, Sum(NOATarget__c) NOABaseTarget ' + 
                        'From   Glxy_Allowance__c ' +
                        'Where  FiscalYear__c = :strFiscalYearUserInput ' +
                        'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')';
       
            strSOQL = strSOQL.Replace('\\',''); 
            AgR = Database.Query(strSOQL);
            for (AggregateResult RowData : AgR) { 
                AllowanceIA   = (Decimal) RowData.get('AllowanceIA');
                AllowanceNOA  = (Decimal) RowData.get('AllowanceNOA');
                IABaseTarget  = (Decimal) RowData.get('IABaseTarget');
                NOABaseTarget = (Decimal) RowData.get('NOABaseTarget');
            }
       }

    }
     
    // **** RUN all the TEST methods for code coverage ... ****//    
    @isTest(SeeAllData=false)    
    
    Static void testclsSummaryReportControllerMain() {
        createData();
        Test.StartTest();
        testclsSummaryReportController();
        Test.StopTest();
    }
    
    Static testMethod void testclsSummaryReportControllerMain1() {
        createData();
        Test.StartTest();
        testclsSummaryReportController1();
        Test.StopTest();
    }
    
    static void createData(){
        integer intFY;
        Date myCommonDate = date.newinstance(date.today().Year(), 01, 01);
        intFY = myCommonDate.year();
        If  (date.today().month() > 9){
            myCommonDate = date.newinstance(date.today().Year(), 10, 10);
            intFY = myCommonDate.year() + 1;
        }
        intFY +=1;
        
        List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
        
        Glxy_LeaseProjects__c objPro0 = new Glxy_LeaseProjects__c();
        objPro0.Name='1234567899';
        objPro0.Project_Type__c = 'New/Replacing';
        objPro0.IASquareFeet__c = 200;
        objPro0.NOASquareFeet__c = 200;
        objPro0.OldIASqFt__c = 50;
        objPro0.OldNOASqFt__c = 50;
        objpro0.Old_Square_Feet__c = 100;
        objpro0.SquareFeet__c = 400;
        objPro0.EffectiveDate__c = myCommonDate;
        objPro0.ProcessedDate__c = myCommonDate;
        objPro0.BDGFlag__c = true;
        objPro0.AnnualRent__c=1000.0;
        objPro0.RegionCd__c='1';
        objPro0.DelegatedProject__c = false;
        objPro0.ProjectStatus__c='Active';
        objPro0.eEorA__c = 'ACTUAL';
        objPro0.Old_Annual_Rent__c=100.0;
        objPro0.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objPro0.ExpanSqFtNOA__c = 50;
        objPro0.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro0);
        
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        objPro.Project_Type__c = 'New/Replacing';
        objPro.IASquareFeet__c = 200;
        objPro.NOASquareFeet__c = 200;
        objPro.OldIASqFt__c = 50;
        objPro.OldNOASqFt__c = 50;
        objpro.Old_Square_Feet__c = 100;
        objpro.SquareFeet__c = 400;
        Date myDate = date.newinstance(date.today().Year(), 10, 10);
        objPro.EffectiveDate__c = myCommonDate.addYears(+1);
        objPro.ProcessedDate__c =  myCommonDate.addYears(+1);
        objPro.BDGFlag__c = true;
        objPro.AnnualRent__c=1000.0;
        objPro.RegionCd__c='1';
        objPro.DelegatedProject__c = false;
        objPro.ProjectStatus__c='Active';
        objPro.eEorA__c = 'ACTUAL';
        objPro.Old_Annual_Rent__c=100.0;
        objPro.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro.ExpanSqFtNOA__c = 50;
        objPro.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro);
        //insert objPro;
        
        Glxy_LeaseProjects__c objPro2 = new Glxy_LeaseProjects__c();
        objPro2.Name='1234567892';
        objPro2.Project_Type__c = 'New/Replacing';
        objPro2.IASquareFeet__c = 200;
        objPro2.NOASquareFeet__c = 200;
        objPro2.OldIASqFt__c = 50;
        objPro2.OldNOASqFt__c = 50;
        objpro2.Old_Square_Feet__c = 100;
        objpro2.SquareFeet__c = 400;
        Date myDate2 = date.newinstance(date.today().Year(), 10, 10);
        objPro2.EffectiveDate__c = myCommonDate;
        objPro2.ProcessedDate__c = myCommonDate;
        objPro2.BDGFlag__c = true;
        objPro2.AnnualRent__c=1000.0;
        objPro2.RegionCd__c='1';
        objPro2.DelegatedProject__c = false;
        objPro2.ProjectStatus__c='Active';
        objPro2.eEorA__c = 'ESTIMATE';
        objPro2.Old_Annual_Rent__c=100.0;
        objPro2.IAConversionDate__c = date.newinstance(date.today().Year() + 5 , 1, 10);
        objPro2.ExpanSqFtNOA__c = 50;
        objPro2.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro2);
        //insert objPro2;
        
        Glxy_LeaseProjects__c objPro3 = new Glxy_LeaseProjects__c();
        objPro3.Name='1234567893';
        objPro3.Project_Type__c = 'New/Replacing';
        objPro3.IASquareFeet__c = 200;
        objPro3.NOASquareFeet__c = 200;
        objPro3.OldIASqFt__c = 50;
        objPro3.OldNOASqFt__c = 50;
        objpro3.Old_Square_Feet__c = 100;
        objpro3.SquareFeet__c = 400;
        Date myDate3 = date.newinstance(date.today().Year(), 10, 10);
        objPro3.EffectiveDate__c = myCommonDate;
        objPro3.ProcessedDate__c = myCommonDate;
        objPro3.BDGFlag__c = true;
        objPro3.AnnualRent__c=1000.0;
        objPro3.RegionCd__c='1';
        objPro3.DelegatedProject__c = false;
        objPro3.ProjectStatus__c='Active';
        objPro3.eEorA__c = 'ACTUAL';
        objPro3.Old_Annual_Rent__c=100.0;
        objPro3.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objPro3.ExpanSqFtNOA__c = 50;
        objPro3.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro3);
        //insert objPro3;
        
        Glxy_LeaseProjects__c objPro3a = new Glxy_LeaseProjects__c();
        objPro3a.Name='1234aaa';
        objPro3a.Project_Type__c = 'New/Replacing';
        objPro3a.IASquareFeet__c = 20;
        objPro3a.NOASquareFeet__c = 20;
        objPro3a.OldIASqFt__c = 50;
        objPro3a.OldNOASqFt__c = 50;
        objpro3a.Old_Square_Feet__c = 100;
        objpro3a.SquareFeet__c = 40;
        objPro3a.EffectiveDate__c = myCommonDate;
        objPro3a.ProcessedDate__c = myCommonDate;
        objPro3a.BDGFlag__c = true;
        objPro3a.AnnualRent__c=1000.0;
        objPro3a.RegionCd__c='1';
        objPro3a.DelegatedProject__c = false;
        objPro3a.ProjectStatus__c='Active';
        objPro3a.eEorA__c = 'ACTUAL';
        objPro3a.Old_Annual_Rent__c=100.0;
        objPro3a.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objPro3a.ExpanSqFtNOA__c = 50;
        objPro3a.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro3a);
        
        Glxy_LeaseProjects__c objPro3a1 = new Glxy_LeaseProjects__c();
        objPro3a1.Name='1234aab';
        objPro3a1.Project_Type__c = 'New/Replacing';
        objPro3a1.IASquareFeet__c = 20;
        objPro3a1.NOASquareFeet__c = 20;
        objPro3a1.OldIASqFt__c = 50;
        objPro3a1.OldNOASqFt__c = 50;
        objpro3a1.Old_Square_Feet__c = 100;
        objpro3a1.SquareFeet__c = 40;
        objPro3a1.EffectiveDate__c = myCommonDate;
        objPro3a1.ProcessedDate__c = myCommonDate;
        objPro3a1.BDGFlag__c = true;
        objPro3a1.AnnualRent__c=1000.0;
        objPro3a1.RegionCd__c='1';
        objPro3a1.DelegatedProject__c = false;
        objPro3a1.ProjectStatus__c='Active';
        objPro3a1.eEorA__c = 'ESTIMATE';
        objPro3a1.Old_Annual_Rent__c=100.0;
        objPro3a1.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objPro3a1.ExpanSqFtNOA__c = 50;
        objPro3a1.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro3a1);
        
        Glxy_LeaseProjects__c objPro4 = new Glxy_LeaseProjects__c();
        objPro4.Name='12345678924';
        objPro4.Project_Type__c = 'New/Replacing';
        objPro4.IASquareFeet__c = 200;
        objPro4.NOASquareFeet__c = 200;
        objPro4.OldIASqFt__c = 50;
        objPro4.OldNOASqFt__c = 50;
        objpro4.Old_Square_Feet__c = 100;
        objpro4.SquareFeet__c = 400;
        Date myDate4 = date.newinstance(date.today().Year(), 10, 10);
        objPro4.EffectiveDate__c = myCommonDate;
        objPro4.ProcessedDate__c = myCommonDate;
        objPro4.BDGFlag__c = true;
        objPro4.AnnualRent__c=1000.0;
        objPro4.RegionCd__c='1';
        objPro4.DelegatedProject__c = false;
        objPro4.ProjectStatus__c='Active';
        objPro4.eEorA__c = 'ESTIMATE';
        objPro4.Old_Annual_Rent__c=100.0;
        objPro4.IAConversionDate__c = date.newinstance(date.today().Year() - 2 , 1, 10);
        objPro4.ExpanSqFtNOA__c = 50;
        objPro4.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro4);
        //insert objPro4;
        
        Glxy_LeaseProjects__c objPro5 = new Glxy_LeaseProjects__c();
        objPro5.Name='1234567895';
        objPro5.Project_Type__c = 'Reduction';
        objPro5.IASquareFeet__c = 10;
        objPro5.NOASquareFeet__c = 10;
        objPro5.OldIASqFt__c = 50;
        objPro5.OldNOASqFt__c = 50;
        objpro5.Old_Square_Feet__c = 100;
        objpro5.SquareFeet__c = 20;
        Date myDate5 = date.newinstance(date.today().Year(), 10, 10);
        objPro5.EffectiveDate__c = myCommonDate;
        objPro5.ProcessedDate__c = myCommonDate;
        objPro5.BDGFlag__c = true;
        objPro5.AnnualRent__c=1000.0;
        objPro5.RegionCd__c='1';
        objPro5.DelegatedProject__c = false;
        objPro5.ProjectStatus__c='Active';
        objPro5.eEorA__c = 'ACTUAL';
        objPro5.Old_Annual_Rent__c=100.0;
        objPro5.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro5.CancelSqFtIA__c = -40;
        objPro5.CancelSqFtNOA__c = -40;
        objLeaseProjectsRecords.Add(objPro5);
        //insert objPro5;
        
        Glxy_LeaseProjects__c objPro6 = new Glxy_LeaseProjects__c();
        objPro6.Name='1234567896';
        objPro6.Project_Type__c = 'Reduction';
        objPro6.IASquareFeet__c = 10;
        objPro6.NOASquareFeet__c = 10;
        objPro6.OldIASqFt__c = 50;
        objPro6.OldNOASqFt__c = 50;
        objpro6.Old_Square_Feet__c = 100;
        objpro6.SquareFeet__c = 20;
        Date myDate6 = date.newinstance(date.today().Year(), 10, 10);
        objPro6.EffectiveDate__c = myCommonDate;
        objPro6.ProcessedDate__c = myCommonDate;
        objPro6.BDGFlag__c = true;
        objPro6.AnnualRent__c=1000.0;
        objPro6.RegionCd__c='1';
        objPro6.DelegatedProject__c = false;
        objPro6.ProjectStatus__c='Active';
        objPro6.eEorA__c = 'ESTIMATE';
        objPro6.Old_Annual_Rent__c=100.0;
        objPro6.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro6.CancelSqFtIA__c = -40;
        objPro6.CancelSqFtNOA__c = -40;
        objLeaseProjectsRecords.Add(objPro6);
        //insert objPro6;
        
        Glxy_LeaseProjects__c objPro8 = new Glxy_LeaseProjects__c();
        objPro8.Name='1234567898';
        objPro8.Project_Type__c = 'Reduction';
        objPro8.IASquareFeet__c = 10;
        objPro8.NOASquareFeet__c = 10;
        objPro8.OldIASqFt__c = 50;
        objPro8.OldNOASqFt__c = 50;
        objpro8.Old_Square_Feet__c = 100;
        objpro8.SquareFeet__c = 20;
        Date myDate8 = date.newinstance(date.today().Year(), 10, 10);
        objPro8.EffectiveDate__c = myCommonDate;
        objPro8.ProcessedDate__c = myCommonDate;
        objPro8.BDGFlag__c = true;
        objPro8.AnnualRent__c=1000.0;
        objPro8.RegionCd__c='1';
        objPro8.DelegatedProject__c = false;
        objPro8.ProjectStatus__c='Active';
        objPro8.eEorA__c = 'ESTIMATE';
        objPro8.Old_Annual_Rent__c=100.0;
        objPro8.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objPro8.CancelSqFtIA__c = -40;
        objPro8.CancelSqFtNOA__c = -40;
        objLeaseProjectsRecords.Add(objPro8);
        //insert objPro8;
        
        Insert objLeaseProjectsRecords;
        
        List<Glxy_Lease__c> objLeaseLeaseRecords = New List<Glxy_Lease__c>();
        
        Glxy_Lease__c ObjLease = new Glxy_Lease__c();
        ObjLease.StatusCode__c = 'Active';
        ObjLease.BaseLeaseEffectiveDate__c = date.newinstance(date.today().Year(), 10, 1);
        ObjLease.ExpirationDateofLease__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLease.RegionCD__c = '1';
        ObjLease.Total_NOA_Sq_feet__c = 10;
        ObjLease.Total_IA_Sq_feet__c = 20;
        objLease.DelegatedLease__c = false;
        objLease.BaseAnnualRent__c = 1000;
        objLease.IAConverstionDate__c = date.newinstance(date.today().Year(), 10, 1);
        //insert ObjLease;
        objLeaseLeaseRecords.Add(ObjLease);
        
        Glxy_Lease__c ObjLease2 = new Glxy_Lease__c();
        ObjLease2.StatusCode__c = 'Active';
        ObjLease2.BaseLeaseEffectiveDate__c = date.newinstance(date.today().Year(), 10, 1);
        ObjLease2.ExpirationDateofLease__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLease2.RegionCD__c = '1';
        ObjLease2.Total_NOA_Sq_feet__c = 10;
        ObjLease2.Total_IA_Sq_feet__c = 20;
        objLease2.DelegatedLease__c = false;
        objLease2.IAConverstionDate__c = date.newinstance(date.today().Year() + 5, 10, 1);
        objLeaseLeaseRecords.Add(ObjLease2);
        
        Insert objLeaseLeaseRecords;
        
        List<Glxy_LumpSum__c> objLSRecords = New List<Glxy_LumpSum__c>();
        
        Glxy_LumpSum__c objTestLS1 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = myCommonDate,
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            StatusCd__c = 'Actual',
            LumSumType__c = 'Claim'

        );
        objLSRecords.Add(objTestLS1);
        System.Assert(objTestLS1!=NULL);
        
        Glxy_LumpSum__c objTestLS2 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = myCommonDate,
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            StatusCd__c = 'Estimate',
            LumSumType__c = 'Claim'

        );
        objLSRecords.Add(objTestLS2);
        System.Assert(objTestLS2!=NULL);
        insert objLSRecords;    
        
        List<Glxy_LPLumpSum__c> objLPLSRecords = New List<Glxy_LPLumpSum__c>();
        Glxy_LPLumpSum__c objTestLPLS1 = new Glxy_LPLumpSum__c (
            ProjectNumber__c = objPro8.id,
            EffectiveDate__c = myCommonDate,
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            StatusCd__c = 'Actual',
            LumSumType__c = 'Claim'

        );
        objLPLSRecords.Add(objTestLPLS1);
        System.Assert(objTestLPLS1!=NULL);
        
        Glxy_LPLumpSum__c objTestLPLS2 = new Glxy_LPLumpSum__c (
            ProjectNumber__c = objPro8.id,
            EffectiveDate__c = myCommonDate,
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            StatusCd__c = 'Estimate',
            LumSumType__c = 'Claim'

        );
        objLPLSRecords.Add(objTestLPLS2);
        System.Assert(objTestLPLS2!=NULL);
        insert objLPLSRecords;    
            
        List<Glxy_ConsumerPriceIndex__c> objCPIRecords = New List<Glxy_ConsumerPriceIndex__c>(); 
        Glxy_ConsumerPriceIndex__c objCPI = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            AnnualAmount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessedDate__c = myCommonDate,
            StatusCD__c = 'ACTUAL'
        );
        //insert objCPI;
        objCPIRecords.Add(objCPI);
        
        Glxy_ConsumerPriceIndex__c objCPI2 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            AnnualAmount__c = 200,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessedDate__c = myCommonDate,
            StatusCD__c = 'ESTIMATE'
        );
        //insert objCPI2;
        objCPIRecords.Add(objCPI2);
        
        Glxy_ConsumerPriceIndex__c objCPI3 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease2.id,
            AnnualAmount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c =  myCommonDate.addYears(+1),
            ProcessedDate__c =  myCommonDate.addYears(+1),
            StatusCD__c = 'ACTUAL'
        );
        //insert objCPI3;
        objCPIRecords.Add(objCPI3);
        
        Glxy_ConsumerPriceIndex__c objCPI4 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease2.id,
            AnnualAmount__c = 200,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c =  myCommonDate.addYears(+1),
            ProcessedDate__c =  myCommonDate.addYears(+1),
            StatusCD__c = 'ESTIMATE'
        );
        //insert objCPI4;
        objCPIRecords.Add(objCPI4);
        
        insert objCPIRecords;
        
        List<Glxy_StepRent__c> objStepRentRecords = New List<Glxy_StepRent__c>();
           
        Glxy_StepRent__c objSR = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessedDate__c = myCommonDate,
            StatusCode__c = 'ACTUAL'
        );
        objStepRentRecords.Add(objSR);
        
        Glxy_StepRent__c objSR2 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessedDate__c = myCommonDate,
            StatusCode__c = 'ESTIMATE'
        );
        objStepRentRecords.Add(objSR2);
        
        Glxy_StepRent__c objSR3 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c = myCommonDate.addYears(+1),
            ProcessedDate__c = myCommonDate.addYears(+1),
            StatusCode__c = 'ACTUAL'
        );
        objStepRentRecords.Add(objSR3);
        
        Glxy_StepRent__c objSR4 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            EffectiveDate__c = myCommonDate.addYears(+1),
            ProcessedDate__c = myCommonDate.addYears(+1),
            StatusCode__c = 'ESTIMATE'
        );
        objStepRentRecords.Add(objSR4);
        
        insert objStepRentRecords;
        
        Glxy_LPStepRent__c objTestPSR = new Glxy_LPStepRent__c (
            ProjectNumber__c = objPro2.id,
            StatusCode__c = 'ACTUAL',
            EffectiveDate__c = myCommonDate,
            ProcessedDate__c = myCommonDate,
            IA_Sq_Ft__c =  0,
            NOA_Sq_Ft__c = 0        
        );
        insert objTestPSR;  
        
        Glxy_IntraBudgetActivityAuthorization__c IBAA = new Glxy_IntraBudgetActivityAuthorization__c();
        IBAA.LeaseNumber__c = ObjLease.id;
        IBAA.Overwrite__c = false;
        IBAA.StatusCD__c = 'Actual';
        insert IBAA;
        
        // for snapshot test data
        List<Galaxy_Snapshot__c> objSnapShotRecords = New List<Galaxy_Snapshot__c>();
        Galaxy_Snapshot__c objSnapshot = New Galaxy_Snapshot__c(
            Name = 'Snapshot11302016',
            Snapshot_Date__c = Datetime.Now().Date(),
            SnapshotReason__c = 'Description',
            SnapshotType__c = 'Other',
            Status__c = 'Completed',
            StatusMessage__c = ''
        );
        objSnapShotRecords.add(objSnapshot);
        System.Assert(objSnapshot!=NULL);
        
        Insert objSnapShotRecords;
        
        List<GLXY_LeaseProjectforSnapshot__c> objLeaseProjectsSnapshotRecords = New List<GLXY_LeaseProjectforSnapshot__c>();
        
        GLXY_LeaseProjectforSnapshot__c objSSPro0 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro0.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro0.UniqueID__c = 'SS1';
        objSSPro0.ProjectID__c='1234567899';
        objSSPro0.Project_Type__c = 'New/Replacing';
        objSSPro0.IASquareFeet__c = 200;
        objSSPro0.NOASquareFeet__c = 200;
        objSSPro0.OldIASqFt__c = 50;
        objSSPro0.OldNOASqFt__c = 50;
        objSSpro0.Old_Square_Feet__c = 100;
        objSSpro0.SquareFeet__c = 400;
        objSSPro0.EffectiveDate__c = myCommonDate;
        objSSPro0.ProcessedDate__c = myCommonDate;
        objSSPro0.BDGFlag__c = true;
        objSSPro0.AnnualRent__c=1000.0;
        objSSPro0.RegionCd__c='1';
        objSSPro0.DelegatedProject__c = false;
        objSSPro0.ProjectStatus__c='Active';
        objSSPro0.eEorA__c = 'ACTUAL';
        objSSPro0.Old_Annual_Rent__c=100.0;
        objSSPro0.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objSSPro0.ExpanSqFtNOA__c = 50;
        objSSPro0.ExpanSqFtIA__c = 50;
        objSSPro0.ExpanARentNOA__c = 100;
        objSSPro0.CancelARentNOA__c = 50;
        objSSPro0.EscalARentNOA__c = 10;
        objSSPro0.ExpanARentIA__c = 100;
        objSSPro0.CancelARentIA__c = 50;
        objSSPro0.EscalARentIA__c = 10;
        objSSPro0.ExpanPYCostIA__c = 100;
        objSSPro0.ExpanPYCostNOA__c = 100;
        objSSPro0.CancelPYCostIA__c = 40;
        objSSPro0.CancelSqFtIA__c = -40;
        objSSPro0.EscalPYCostIA__c = 80;
        objSSPro0.CancelSqFtNOA__c = -40;
        objSSPro0.CancelPYCostNOA__c = 90;
        objSSPro0.EscalPYCostNOA__c = 80;
        objSSPro0.EscalSqFtIA__c  = 100;
        objSSPro0.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro0);
        System.Assert(objSSPro0!=NULL);
        
        GLXY_LeaseProjectforSnapshot__c objSSPro = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro.UniqueID__c = 'SS2';
        objSSPro.ProjectID__c='123456789';
        objSSPro.Project_Type__c = 'New/Replacing';
        objSSPro.IASquareFeet__c = 200;
        objSSPro.NOASquareFeet__c = 200;
        objSSPro.OldIASqFt__c = 50;
        objSSPro.OldNOASqFt__c = 50;
        objSSPro.Old_Square_Feet__c = 100;
        objSSPro.SquareFeet__c = 400;
        Date myDateSS = date.newinstance(date.today().Year(), 10, 10);
        objSSPro.EffectiveDate__c = myCommonDate.addYears(+1);
        objSSPro.ProcessedDate__c =  myCommonDate.addYears(+1);
        objSSPro.BDGFlag__c = true;
        objSSPro.AnnualRent__c=1000.0;
        objSSPro.RegionCd__c='1';
        objSSPro.DelegatedProject__c = false;
        objSSPro.ProjectStatus__c='Active';
        objSSPro.eEorA__c = 'ACTUAL';
        objSSPro.Old_Annual_Rent__c=100.0;
        objSSPro.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objSSPro.ExpanSqFtNOA__c = 50;
        objSSPro.ExpanSqFtIA__c = 50;
        objSSPro.ExpanARentNOA__c = 100;
        objSSPro.CancelARentNOA__c = 50;
        objSSPro.EscalARentNOA__c = 10;
        objSSPro.ExpanARentIA__c = 100;
        objSSPro.CancelARentIA__c = 50;
        objSSPro.EscalARentIA__c = 10;
        objSSPro.ExpanPYCostIA__c = 100;
        objSSPro.ExpanPYCostNOA__c = 100;
        objSSPro.CancelPYCostIA__c = 40;
        objSSPro.CancelSqFtIA__c = -40;
        objSSPro.EscalPYCostIA__c = 80;
        objSSPro.CancelSqFtNOA__c = -40;
        objSSPro.CancelPYCostNOA__c = 90;
        objSSPro.EscalPYCostNOA__c = 80;
        objSSPro.EscalSqFtIA__c  = 100;
        objSSPro.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro);
        System.Assert(objSSPro!=NULL);
        //insert objPro;
        
        GLXY_LeaseProjectforSnapshot__c objSSPro2 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro2.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro2.UniqueID__c = 'SS3';
        objSSPro2.ProjectID__c='1234567892';
        objSSPro2.Project_Type__c = 'New/Replacing';
        objSSPro2.IASquareFeet__c = 200;
        objSSPro2.NOASquareFeet__c = 200;
        objSSPro2.OldIASqFt__c = 50;
        objSSPro2.OldNOASqFt__c = 50;
        objSSPro2.Old_Square_Feet__c = 100;
        objSSPro2.SquareFeet__c = 400;
        Date myDateSS2 = date.newinstance(date.today().Year(), 10, 10);
        objSSPro2.EffectiveDate__c = myCommonDate;
        objSSPro2.ProcessedDate__c = myCommonDate;
        objSSPro2.BDGFlag__c = true;
        objSSPro2.AnnualRent__c=1000.0;
        objSSPro2.RegionCd__c='1';
        objSSPro2.DelegatedProject__c = false;
        objSSPro2.ProjectStatus__c='Active';
        objSSPro2.eEorA__c = 'ESTIMATE';
        objSSPro2.Old_Annual_Rent__c=100.0;
        objSSPro2.IAConversionDate__c = date.newinstance(date.today().Year() + 5 , 1, 10);
        objSSPro2.ExpanSqFtNOA__c = 50;
        objSSPro2.ExpanSqFtIA__c = 50;
        objSSPro2.ExpanARentNOA__c = 100;
        objSSPro2.CancelARentNOA__c = 50;
        objSSPro2.EscalARentNOA__c = 10;
        objSSPro2.ExpanARentIA__c = 100;
        objSSPro2.CancelARentIA__c = 50;
        objSSPro2.EscalARentIA__c = 10;
        objSSPro2.ExpanPYCostIA__c = 100;
        objSSPro2.ExpanPYCostNOA__c = 100;
        objSSPro2.CancelPYCostIA__c = 40;
        objSSPro2.CancelSqFtIA__c = -40;
        objSSPro2.EscalPYCostIA__c = 80;
        objSSPro2.CancelSqFtNOA__c = -40;
        objSSPro2.CancelPYCostNOA__c = 90;
        objSSPro2.EscalPYCostNOA__c = 80;
        objSSPro2.EscalSqFtIA__c  = 100;
        objSSPro2.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro2);
        System.Assert(objSSPro2!=NULL);
        //insert objPro2;
        
        GLXY_LeaseProjectforSnapshot__c objSSPro3 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro3.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro3.UniqueID__c = 'SS4';
        objSSPro3.ProjectID__c='1234567893';
        objSSPro3.Project_Type__c = 'New/Replacing';
        objSSPro3.IASquareFeet__c = 200;
        objSSPro3.NOASquareFeet__c = 200;
        objSSPro3.OldIASqFt__c = 50;
        objSSPro3.OldNOASqFt__c = 50;
        objSSPro3.Old_Square_Feet__c = 100;
        objSSPro3.SquareFeet__c = 400;
        Date myDateSS3 = date.newinstance(date.today().Year(), 10, 10);
        objSSPro3.EffectiveDate__c = myCommonDate;
        objSSPro3.ProcessedDate__c = myCommonDate;
        objSSPro3.BDGFlag__c = true;
        objSSPro3.AnnualRent__c=1000.0;
        objSSPro3.RegionCd__c='1';
        objSSPro3.DelegatedProject__c = false;
        objSSPro3.ProjectStatus__c='Active';
        objSSPro3.eEorA__c = 'ACTUAL';
        objSSPro3.Old_Annual_Rent__c=100.0;
        objSSPro3.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objSSPro3.ExpanSqFtNOA__c = 50;
        objSSPro3.ExpanSqFtIA__c = 50;
        objSSPro3.ExpanARentNOA__c = 100;
        objSSPro3.CancelARentNOA__c = 50;
        objSSPro3.EscalARentNOA__c = 10;
        objSSPro3.ExpanARentIA__c = 100;
        objSSPro3.CancelARentIA__c = 50;
        objSSPro3.EscalARentIA__c = 10;
        objSSPro3.ExpanPYCostIA__c = 100;
        objSSPro3.ExpanPYCostNOA__c = 100;
        objSSPro3.CancelPYCostIA__c = 40;
        objSSPro3.CancelSqFtIA__c = -40;
        objSSPro3.EscalPYCostIA__c = 80;
        objSSPro3.CancelSqFtNOA__c = -40;
        objSSPro3.CancelPYCostNOA__c = 90;
        objSSPro3.EscalPYCostNOA__c = 80;
        objSSPro3.EscalSqFtIA__c  = 100;
        objSSPro3.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro3);
        System.Assert(objSSPro3!=NULL);
        //insert objPro3;
        
        GLXY_LeaseProjectforSnapshot__c objSSPro3a = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro3a.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro3a.UniqueID__c = 'SS5';
        objSSPro3a.ProjectID__c='1234aaa';
        objSSPro3a.Project_Type__c = 'New/Replacing';
        objSSPro3a.IASquareFeet__c = 20;
        objSSPro3a.NOASquareFeet__c = 20;
        objSSPro3a.OldIASqFt__c = 50;
        objSSPro3a.OldNOASqFt__c = 50;
        objSSPro3a.Old_Square_Feet__c = 100;
        objSSPro3a.SquareFeet__c = 40;
        objSSPro3a.EffectiveDate__c = myCommonDate;
        objSSPro3a.ProcessedDate__c = myCommonDate;
        objSSPro3a.BDGFlag__c = true;
        objSSPro3a.AnnualRent__c=1000.0;
        objSSPro3a.RegionCd__c='1';
        objSSPro3a.DelegatedProject__c = false;
        objSSPro3a.ProjectStatus__c='Active';
        objSSPro3a.eEorA__c = 'ACTUAL';
        objSSPro3a.Old_Annual_Rent__c=100.0;
        objSSPro3a.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objSSPro3a.ExpanSqFtNOA__c = 50;
        objSSPro3a.ExpanSqFtIA__c = 50;
        objSSPro3a.ExpanARentNOA__c = 100;
        objSSPro3a.CancelARentNOA__c = 50;
        objSSPro3a.EscalARentNOA__c = 10;
        objSSPro3a.ExpanARentIA__c = 100;
        objSSPro3a.CancelARentIA__c = 50;
        objSSPro3a.EscalARentIA__c = 10;
        objSSPro3a.ExpanPYCostIA__c = 100;
        objSSPro3a.ExpanPYCostNOA__c = 100;
        objSSPro3a.CancelPYCostIA__c = 40;
        objSSPro3a.CancelSqFtIA__c = -40;
        objSSPro3a.EscalPYCostIA__c = 80;
        objSSPro3a.CancelSqFtNOA__c = -40;
        objSSPro3a.CancelPYCostNOA__c = 90;
        objSSPro3a.EscalPYCostNOA__c = 80;
        objSSPro3a.EscalSqFtIA__c  = 100;
        objSSPro3a.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro3a);
        System.Assert(objSSPro3a!=NULL);
        
        GLXY_LeaseProjectforSnapshot__c objSSPro3a1 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro3a1.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro3a1.UniqueID__c = 'SS6';
        objSSPro3a1.ProjectID__c='1234aab';
        objSSPro3a1.Project_Type__c = 'New/Replacing';
        objSSPro3a1.IASquareFeet__c = 20;
        objSSPro3a1.NOASquareFeet__c = 20;
        objSSPro3a1.OldIASqFt__c = 50;
        objSSPro3a1.OldNOASqFt__c = 50;
        objSSPro3a1.Old_Square_Feet__c = 100;
        objSSPro3a1.SquareFeet__c = 40;
        objSSPro3a1.EffectiveDate__c = myCommonDate;
        objSSPro3a1.ProcessedDate__c = myCommonDate;
        objSSPro3a1.BDGFlag__c = true;
        objSSPro3a1.AnnualRent__c=1000.0;
        objSSPro3a1.RegionCd__c='1';
        objSSPro3a1.DelegatedProject__c = false;
        objSSPro3a1.ProjectStatus__c='Active';
        objSSPro3a1.eEorA__c = 'ESTIMATE';
        objSSPro3a1.Old_Annual_Rent__c=100.0;
        objSSPro3a1.IAConversionDate__c = date.newinstance(date.today().Year() + 3, 1, 10);
        objSSPro3a1.ExpanSqFtNOA__c = 50;
        objSSPro3a1.ExpanSqFtIA__c = 50;
        objSSPro3a1.ExpanARentIA__c = 100;
        objSSPro3a1.CancelARentIA__c = 50;
        objSSPro3a1.EscalARentIA__c = 10;
        objSSPro3a1.ExpanPYCostIA__c = 100;
        objSSPro3a1.ExpanPYCostNOA__c = 100;
        objSSPro3a1.CancelPYCostIA__c = 40;
        objSSPro3a1.CancelSqFtIA__c = -40;
        objSSPro3a1.EscalPYCostIA__c = 80;
        objSSPro3a1.CancelSqFtNOA__c = -40;
        objSSPro3a1.CancelPYCostNOA__c = 90;
        objSSPro3a1.EscalPYCostNOA__c = 80;
        objSSPro3a1.EscalSqFtIA__c  = 100;
        objSSPro3a1.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro3a1);
        System.Assert(objSSPro3a1!=NULL);
        
        GLXY_LeaseProjectforSnapshot__c objSSPro4 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro4.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro4.UniqueID__c = 'SS7';
        objSSPro4.ProjectID__c='12345678924';
        objSSPro4.Project_Type__c = 'New/Replacing';
        objSSPro4.IASquareFeet__c = 200;
        objSSPro4.NOASquareFeet__c = 200;
        objSSPro4.OldIASqFt__c = 50;
        objSSPro4.OldNOASqFt__c = 50;
        objSSPro4.Old_Square_Feet__c = 100;
        objSSPro4.SquareFeet__c = 400;
        Date myDateSS4 = date.newinstance(date.today().Year(), 10, 10);
        objSSPro4.EffectiveDate__c = myCommonDate;
        objSSPro4.ProcessedDate__c = myCommonDate;
        objSSPro4.BDGFlag__c = true;
        objSSPro4.AnnualRent__c=1000.0;
        objSSPro4.RegionCd__c='1';
        objSSPro4.DelegatedProject__c = false;
        objSSPro4.ProjectStatus__c='Active';
        objSSPro4.eEorA__c = 'ESTIMATE';
        objSSPro4.Old_Annual_Rent__c=100.0;
        objSSPro4.IAConversionDate__c = date.newinstance(date.today().Year() - 2 , 1, 10);
        objSSPro4.ExpanSqFtNOA__c = 50;
        objSSPro4.ExpanSqFtIA__c = 50;
        objSSPro4.ExpanARentNOA__c = 100;
        objSSPro4.CancelARentNOA__c = 50;
        objSSPro4.EscalARentNOA__c = 10;
        objSSPro4.ExpanARentIA__c = 100;
        objSSPro4.CancelARentIA__c = 50;
        objSSPro4.EscalARentIA__c = 10;
        objSSPro4.ExpanPYCostIA__c = 100;
        objSSPro4.ExpanPYCostNOA__c = 100;
        objSSPro4.CancelPYCostIA__c = 40;
        objSSPro4.CancelSqFtIA__c = -40;
        objSSPro4.EscalPYCostIA__c = 80;
        objSSPro4.CancelSqFtNOA__c = -40;
        objSSPro4.CancelPYCostNOA__c = 90;
        objSSPro4.EscalPYCostNOA__c = 80;
        objSSPro4.EscalSqFtIA__c  = 100;
        objSSPro4.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro4);
        System.Assert(objSSPro4!=NULL);
        //insert objPro4;
        
        GLXY_LeaseProjectforSnapshot__c objSSPro5 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro5.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro5.UniqueID__c = 'SS8';
        objSSPro5.ProjectID__c='1234567895';
        objSSPro5.Project_Type__c = 'Reduction';
        objSSPro5.IASquareFeet__c = 10;
        objSSPro5.NOASquareFeet__c = 10;
        objSSPro5.OldIASqFt__c = 50;
        objSSPro5.OldNOASqFt__c = 50;
        objSSPro5.Old_Square_Feet__c = 100;
        objSSPro5.SquareFeet__c = 20;
        Date myDateSS5 = date.newinstance(date.today().Year(), 10, 10);
        objSSPro5.EffectiveDate__c = myCommonDate;
        objSSPro5.ProcessedDate__c = myCommonDate;
        objSSPro5.BDGFlag__c = true;
        objSSPro5.AnnualRent__c=1000.0;
        objSSPro5.RegionCd__c='1';
        objSSPro5.DelegatedProject__c = false;
        objSSPro5.ProjectStatus__c='Active';
        objSSPro5.eEorA__c = 'ACTUAL';
        objSSPro5.Old_Annual_Rent__c=100.0;
        objSSPro5.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objSSPro5.CancelSqFtIA__c = -40;
        objSSPro5.CancelSqFtNOA__c = -40;
        objSSPro5.ExpanARentNOA__c = 100;
        objSSPro5.CancelARentNOA__c = 50;
        objSSPro5.EscalARentNOA__c = 10;
        objSSPro5.ExpanARentIA__c = 100;
        objSSPro5.CancelARentIA__c = 50;
        objSSPro5.EscalARentIA__c = 10;
        objSSPro5.ExpanPYCostIA__c = 100;
        objSSPro5.ExpanPYCostNOA__c = 100;
        objSSPro5.CancelPYCostIA__c = 40;
        objSSPro5.CancelSqFtIA__c = -40;
        objSSPro5.EscalPYCostIA__c = 80;
        objSSPro5.CancelPYCostNOA__c = 80;
        objSSPro5.EscalPYCostNOA__c = 80;
        objSSPro5.EscalSqFtIA__c  = 100;
        objSSPro5.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro5);
        System.Assert(objSSPro5!=NULL);
        //insert objPro5;
        
        GLXY_LeaseProjectforSnapshot__c objSSPro6 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro6.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro6.UniqueID__c = 'SS9';
        objSSPro6.ProjectID__c='1234567896';
        objSSPro6.Project_Type__c = 'Reduction';
        objSSPro6.IASquareFeet__c = 10;
        objSSPro6.NOASquareFeet__c = 10;
        objSSPro6.OldIASqFt__c = 50;
        objSSPro6.OldNOASqFt__c = 50;
        objSSPro6.Old_Square_Feet__c = 100;
        objSSPro6.SquareFeet__c = 20;
        Date myDateSS6 = date.newinstance(date.today().Year(), 10, 10);
        objSSPro6.EffectiveDate__c = myCommonDate;
        objSSPro6.ProcessedDate__c = myCommonDate;
        objSSPro6.BDGFlag__c = true;
        objSSPro6.AnnualRent__c=1000.0;
        objSSPro6.RegionCd__c='1';
        objSSPro6.DelegatedProject__c = false;
        objSSPro6.ProjectStatus__c='Active';
        objSSPro6.eEorA__c = 'ESTIMATE';
        objSSPro6.Old_Annual_Rent__c=100.0;
        objSSPro6.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objSSPro6.CancelSqFtIA__c = -40;
        objSSPro6.CancelSqFtNOA__c = -40;
        objSSPro6.ExpanARentNOA__c = 100;
        objSSPro6.CancelARentNOA__c = 50;
        objSSPro6.EscalARentNOA__c = 10;
        objSSPro6.ExpanARentIA__c = 100;
        objSSPro6.CancelARentIA__c = 50;
        objSSPro6.EscalARentIA__c = 10;
        objSSPro6.ExpanPYCostIA__c = 100;
        objSSPro6.ExpanPYCostNOA__c = 100;
        objSSPro6.CancelPYCostIA__c = 40;
        objSSPro6.CancelSqFtIA__c = -40;
        objSSPro6.EscalPYCostIA__c = 80;
        objSSPro6.CancelPYCostNOA__c = 90;
        objSSPro6.EscalPYCostNOA__c = 80;
        objSSPro6.EscalSqFtIA__c  = 100;
        objSSPro6.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro6);
        System.Assert(objSSPro6!=NULL);
        //insert objPro6;
        
        GLXY_LeaseProjectforSnapshot__c objSSPro8 = new GLXY_LeaseProjectforSnapshot__c();
        objSSPro8.snapshotname__c = objSnapShotRecords[0].id;
        objSSPro8.UniqueID__c = 'SS10';
        objSSPro8.ProjectID__c='1234567898';
        objSSPro8.Project_Type__c = 'Reduction';
        objSSPro8.IASquareFeet__c = 10;
        objSSPro8.NOASquareFeet__c = 10;
        objSSPro8.OldIASqFt__c = 50;
        objSSPro8.OldNOASqFt__c = 50;
        objSSPro8.Old_Square_Feet__c = 100;
        objSSPro8.SquareFeet__c = 20;
        Date myDateSS8 = date.newinstance(date.today().Year(), 10, 10);
        objSSPro8.EffectiveDate__c = myCommonDate;
        objSSPro8.ProcessedDate__c = myCommonDate;
        objSSPro8.BDGFlag__c = true;
        objSSPro8.AnnualRent__c=1000.0;
        objSSPro8.RegionCd__c='1';
        objSSPro8.DelegatedProject__c = false;
        objSSPro8.ProjectStatus__c='Active';
        objSSPro8.eEorA__c = 'ESTIMATE';
        objSSPro8.Old_Annual_Rent__c=100.0;
        objSSPro8.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objSSPro8.CancelSqFtIA__c = -40;
        objSSPro8.CancelSqFtNOA__c = -40;
        objSSPro8.ExpanARentNOA__c = 100;
        objSSPro8.CancelARentNOA__c = 50;
        objSSPro8.EscalARentNOA__c = 10;
        objSSPro8.ExpanARentIA__c = 100;
        objSSPro8.CancelARentIA__c = 50;
        objSSPro8.EscalARentIA__c = 10;
        objSSPro8.ExpanPYCostIA__c = 100;
        objSSPro8.ExpanPYCostNOA__c = 100;
        objSSPro8.CancelPYCostIA__c = 40;
        objSSPro8.CancelSqFtIA__c = -40;
        objSSPro8.EscalPYCostIA__c = 80;
        objSSPro8.CancelPYCostNOA__c = 80;
        objSSPro8.EscalPYCostNOA__c = 80;
        objSSPro8.EscalSqFtIA__c  = 100;
        objSSPro8.EscalSqFtNOA__c = 100;
        objLeaseProjectsSnapshotRecords.Add(objSSPro8);
        System.Assert(objSSPro8!=NULL);
        
        Insert objLeaseProjectsSnapshotRecords;
        
        List<Glxy_LeaseSnapshot__c> objLeaseSnapshotRecords = New List<Glxy_LeaseSnapshot__c>();
        
        Glxy_LeaseSnapshot__c ObjLeaseSS = new Glxy_LeaseSnapshot__c();
        ObjLeaseSS.snapshotname__c = objSnapShotRecords[0].id;
        ObjLeaseSS.LeaseNumber__c = 'LA1234';
        ObjLeaseSS.StatusCode__c = 'Active';
        ObjLeaseSS.LeaseEffectiveDate__c = date.newinstance(date.today().Year(), 10, 1);
        ObjLeaseSS.LeaseExpirationDate__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLeaseSS.RegionCode__c = '1';
        ObjLeaseSS.TotalNOASqft__c = 10;
        ObjLeaseSS.TotalIASqft__c = 20;
        ObjLeaseSS.DelegatedLease__c = false;
        ObjLeaseSS.BaseAnnualRent__c = 1000;
        ObjLeaseSS.IAConverstionDate__c = date.newinstance(date.today().Year(), 10, 1);
        objLeaseSnapshotRecords.Add(ObjLeaseSS);
        System.Assert(ObjLeaseSS!=NULL);
        
        Glxy_LeaseSnapshot__c ObjLeaseSS2 = new Glxy_LeaseSnapshot__c();
        ObjLeaseSS2.snapshotname__c = objSnapShotRecords[0].id;
        ObjLeaseSS2.LeaseNumber__c = 'LA1234';
        ObjLeaseSS2.StatusCode__c = 'Active';
        ObjLeaseSS2.LeaseEffectiveDate__c = date.newinstance(date.today().Year(), 10, 1);
        ObjLeaseSS2.LeaseExpirationDate__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLeaseSS2.RegionCode__c = '1';
        ObjLeaseSS2.TotalNOASqft__c = 10;
        ObjLeaseSS2.TotalIASqft__c = 20;
        ObjLeaseSS2.DelegatedLease__c = false;
        ObjLeaseSS2.IAConverstionDate__c = date.newinstance(date.today().Year() + 5, 10, 1);
        objLeaseSnapshotRecords.Add(ObjLeaseSS2);
        System.Assert(ObjLeaseSS2!=NULL);
        
        Insert objLeaseSnapshotRecords;
        
        List<GLXY_LeasePaymentsSnapshot__c> objLeasePaymentSnapshotRecords = New List<GLXY_LeasePaymentsSnapshot__c>();
        
        GLXY_LeasePaymentsSnapshot__c objTestLSS1 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[0].id,
            EffectiveDate__c = myCommonDate,
            FYObligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            Status_Code__c = 'Actual',
            Payment_Category__c = 'Lump Sum',
            PaymentDescription__c = 'Claim',
            NOASqFt__c = 100,
            IASqFt__c = 100

        );
        objLeasePaymentSnapshotRecords.Add(objTestLSS1);
        System.Assert(objTestLSS1!=NULL);
        
        GLXY_LeasePaymentsSnapshot__c objTestLSS2 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[0].id,
            EffectiveDate__c = myCommonDate,
            FYObligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            Status_Code__c = 'Estimate',
            Payment_Category__c = 'Lump Sum',
            PaymentDescription__c = 'Claim',
            NOASqFt__c = 100,
            IASqFt__c = 100

        );
        objLeasePaymentSnapshotRecords.Add(objTestLSS2);
        System.Assert(objTestLSS2!=NULL);
        
        GLXY_LeasePaymentsSnapshot__c objSSCPI = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[0].id,
            AnnualAmount__c = 100,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessDate__c = myCommonDate,
            Status_Code__c = 'ACTUAL',
            Payment_Category__c = 'Consumer Price Index',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        
        objLeasePaymentSnapshotRecords.Add(objSSCPI);
        System.Assert(objSSCPI!=NULL);
        
        GLXY_LeasePaymentsSnapshot__c objSSCPI2 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[0].id,
            AnnualAmount__c = 200,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessDate__c = myCommonDate,
            Status_Code__c = 'ESTIMATE',
            Payment_Category__c = 'Consumer Price Index',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        
        objLeasePaymentSnapshotRecords.Add(objSSCPI2);
        System.Assert(objSSCPI2!=NULL);
        
        GLXY_LeasePaymentsSnapshot__c objSSCPI3 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[1].id,
            AnnualAmount__c = 100,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c =  myCommonDate.addYears(+1),
            ProcessDate__c =  myCommonDate.addYears(+1),
            Status_Code__c = 'ACTUAL',
            Payment_Category__c = 'Consumer Price Index',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        
        objLeasePaymentSnapshotRecords.Add(objSSCPI3);
        System.Assert(objSSCPI3!=NULL);
        
        GLXY_LeasePaymentsSnapshot__c objSSCPI4 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[1].id,
            AnnualAmount__c = 200,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c =  myCommonDate.addYears(+1),
            ProcessDate__c =  myCommonDate.addYears(+1),
            Status_Code__c = 'ESTIMATE',
            Payment_Category__c = 'Consumer Price Index',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        
        objLeasePaymentSnapshotRecords.Add(objSSCPI4);
        System.Assert(objSSCPI4!=NULL);   
        
        GLXY_LeasePaymentsSnapshot__c objSSSR = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[0].id,
            AnnualAmount__c = 100,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessDate__c = myCommonDate,
            Status_Code__c = 'ACTUAL',
            Payment_Category__c = 'Step Rent',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        objLeasePaymentSnapshotRecords.Add(objSSSR);
        System.Assert(objSSSR!=NULL); 
        
        GLXY_LeasePaymentsSnapshot__c objSSSR2 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[0].id,
            AnnualAmount__c = 100,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c = myCommonDate,
            ProcessDate__c = myCommonDate,
            Status_Code__c = 'ESTIMATE',
            Payment_Category__c = 'Step Rent',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        objLeasePaymentSnapshotRecords.Add(objSSSR2);
        System.Assert(objSSSR2!=NULL); 
        
        GLXY_LeasePaymentsSnapshot__c objSSSR3 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[1].id,
            AnnualAmount__c = 100,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c = myCommonDate.addYears(+1),
            ProcessDate__c = myCommonDate.addYears(+1),
            Status_Code__c = 'ACTUAL',
            Payment_Category__c = 'Step Rent',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        objLeasePaymentSnapshotRecords.Add(objSSSR3);
        System.Assert(objSSSR3!=NULL); 
        
        GLXY_LeasePaymentsSnapshot__c objSSSR4 = new GLXY_LeasePaymentsSnapshot__c (
            ParentRecord__c = objLeaseSnapshotRecords[1].id,
            AnnualAmount__c = 100,
            FYObligationNOA__c = 50,
            FYObligationIA__c = 50,
            IncludeinBudgetFlag__c = true,
            EffectiveDate__c = myCommonDate.addYears(+1),
            ProcessDate__c = myCommonDate.addYears(+1),
            Status_Code__c = 'ESTIMATE',
            Payment_Category__c = 'Step Rent',
            NOASqFt__c = 100,
            IASqFt__c = 100
        );
        objLeasePaymentSnapshotRecords.Add(objSSSR4);  
        System.Assert(objSSSR4!=NULL); 
        
        GLXY_LeasePaymentsSnapshot__c objSSIBAA = new GLXY_LeasePaymentsSnapshot__c(
        ParentRecord__c = objLeaseSnapshotRecords[0].id,
        Payment_Category__c = 'IBAA',
        Status_Code__c = 'Actual',
        NOASqFt__c = 100,
        IASqFt__c = 100
        );
        objLeasePaymentSnapshotRecords.Add(objSSIBAA); 
        System.Assert(objSSIBAA!=NULL);
        
        insert objLeasePaymentSnapshotRecords;    
        
        List<GLXY_LeaseProjectPaymentsForSnapshot__c> objLPPSSRecords = New List<GLXY_LeaseProjectPaymentsForSnapshot__c>();
        GLXY_LeaseProjectPaymentsForSnapshot__c objTestLPLSS1 = new GLXY_LeaseProjectPaymentsForSnapshot__c (
            ParentRecord__c = objSSPro8.id,
            EffectiveDate__c = myCommonDate,
            FYObligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            Status_Code__c = 'Actual',
            PaymentDescription__c = 'Claim',
            Payment_Category__c = 'Lease Proj. Lump Sum'

        );
        objLPPSSRecords.Add(objTestLPLSS1);
        System.Assert(objTestLPLSS1!=NULL);
        
        GLXY_LeaseProjectPaymentsForSnapshot__c objTestLPLSS2 = new GLXY_LeaseProjectPaymentsForSnapshot__c (
            ParentRecord__c = objSSPro8.id,
            EffectiveDate__c = myCommonDate,
            FYObligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 10, 1),
            Status_Code__c = 'Estimate',
            PaymentDescription__c = 'Claim',
            Payment_Category__c = 'Lease Proj. Lump Sum'

        );
        objLPPSSRecords.Add(objTestLPLSS2);
        System.Assert(objTestLPLSS2!=NULL);
        
        GLXY_LeaseProjectPaymentsForSnapshot__c objTestSSPSR = new GLXY_LeaseProjectPaymentsForSnapshot__c (
            ParentRecord__c = objSSPro2.id,
            Status_Code__c = 'ACTUAL',
            EffectiveDate__c = myCommonDate,
            ProcessDate__c = myCommonDate,
            IASqFt__c =  0,
            NOASqFt__c = 0,
            Payment_Category__c = 'Lease Proj. Step Rent'        
        );
        objLPPSSRecords.Add(objTestSSPSR);
        System.Assert(objTestSSPSR!=NULL);
        
        insert objLPPSSRecords;           
        
    }
    
        Static void  testclsSummaryReportController() {
        integer intFY;
        Date myCommonDate = date.newinstance(date.today().Year(), 01, 01);
        intFY = myCommonDate.year();
        If  (date.today().month() > 9){
            myCommonDate = date.newinstance(date.today().Year(), 10, 10);
            intFY = myCommonDate.year() + 1;
        }
        intFY +=1;
                
        PageReference pageRef = Page.GLXY_rptFYProjections;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Region', '\'1\',\'2\',\'3\',\'4\',\'5\',\'6\',\'7\',\'8\',\'9\',\'10\',\'11\'');
        ApexPages.currentPage().getParameters().put('IncludeInBudgetFlag', '1');
        ApexPages.currentPage().getParameters().put('DelegatedFlag', '\'False\'');
        ApexPages.currentPage().getParameters().put('FY', string.valueof(intFY+1));
        
        GLXY_clsSummaryReport objTest2 = new GLXY_clsSummaryReport();
        objTest2.strFiscalYear      = '0';
        objTest2.strFiscalYearUserInput = '0';
        objTest2.strNextFiscalYear  = '0';
        objTest2.strRegion          = '0';
        objTest2.strIncludeinBudgetFlag  = 'True';
        objTest2.blnIncludeinBudgetFlag  = True;
        objTest2.strDelegatedFlag        = '1';
    
        //Row 1
        objTest2.BaseSqFtNOA_A    = 0;
        objTest2.BaseAnnualRentNOA_A    = 0;
        objTest2.BasePYCostNOA_A    = 0;
        objTest2.BaseSqFtNOA_E  = 0;
        objTest2.BaseAnnualRentNOA_E    = 0;
        objTest2.BasePYCostNOA_E    = 0;
        
        //Row 2
        objTest2.ExpanSqFtNOA_A    = 0;
        objTest2.ExpanARentNOA_A   = 0;
        objTest2.ExpanPYCostNOA_A  = 0;
        objTest2.ExpanSqFtNOA_E    = 0;
        objTest2.ExpanARentNOA_E   = 0;
        objTest2.ExpanPYCostNOA_E  = 0;
        
        //Row 3
        objTest2.CancelSqFtNOA_A       = 0;
        objTest2.CancelARentNOA_A      = 0;
        objTest2.CancelPYCostNOA_A     = 0;
        objTest2.CancelSqFtNOA_E       = 0;
        objTest2.CancelARentNOA_E      = 0;
        objTest2.CancelPYCostNOA_E     = 0;
        
        //Row 4
        //objTest2.EscalSqFtNOA_A  = 0;
        objTest2.EscalARentNOA_A   = 0;
        objTest2.EscalPYCostNOA_A  = 0;
        //objTest2.EscalSqFtNOA_E  = 0;
        objTest2.EscalARentNOA_E   = 0;
        objTest2.EscalPYCostNOA_E  = 0;
        
        //Row 5
        objTest2.AnnualAmountCPI_A     = 0;
        objTest2.PYCostCPI_A           = 0;
        objTest2.AnnualAmountCPI_E     = 0;
        objTest2.PYCostCPI_E           = 0;
        
        //Row 6
        objTest2.PYCostLS_A    = 0;
        objTest2.PYCostLS_E    = 0;
        
        //Row 7
        objTest2.PYCostIBAA_A  = 0;
        objTest2.PYCostIBAA_E  = 0;
        
        //Row 8
        objTest2.PYCostRWA_A   = 0;
        objTest2.PYCostRWA_E   = 0;
        
        //Row 9
        objTest2.DoubleRentNOA_A  = 0;
        objTest2.DoubleRentNOA_E  = 0;
        
        //Row 10 - Totals
        objTest2.NOATotalSqFt_A        = 0;
        objTest2.NOATotalAnnualRent_A  = 0;
        objTest2.NOATotalPYCost_A      = 0;
        objTest2.NOATotalSqFt_E        = 0;
        objTest2.NOATotalAnnualRent_E  = 0;
        objTest2.NOATotalPYCost_E      = 0;
        objTest2.NOATotalSqFt          = 0;
        objTest2.NOATotalAnnualRent    = 0;
        objTest2.NOATotalPYCost        = 0;
        
        //Row 11
        objTest2.BaseSqFtIA_A     = 0;
        objTest2.BaseAnnualRentIA_A     = 0;
        objTest2.BasePYCostIA_A   = 0;
        objTest2.BaseSqFtIA_E     = 0;
        objTest2.BaseAnnualRentIA_E     = 0;
        objTest2.BasePYCostIA_E   = 0;
        
        //Row 12
        objTest2.ExpanSqFtIA_A     = 0;
        objTest2.ExpanARentIA_A    = 0;
        objTest2.ExpanPYCostIA_A   = 0;
        objTest2.ExpanSqFtIA_E     = 0;
        objTest2.ExpanARentIA_E    = 0;
        objTest2.ExpanPYCostIA_E   = 0;
        
          //Row 14
        objTest2.CancelSqFtIA_A  = 0;
        objTest2.CancelARentIA_A = 0;
        objTest2.CancelPYCostIA_A = 0;
        objTest2.CancelSqFtIA_E = 0;
        objTest2.CancelARentIA_E = 0;
        objTest2.CancelPYCostIA_E = 0;
        
        //Row 15
        //objTest2.EscalSqFtIA_A = 0;
        objTest2.EscalARentIA_A = 0;
        objTest2.EscalPYCostIA_A = 0;
        //objTest2.EscalSqFtIA_E = 0;
        objTest2.EscalARentIA_E = 0;
        objTest2.EscalPYCostIA_E = 0;
        
        //Row 16
        objTest2.IA_AnnualAmountCPI_A = 0;
        objTest2.IA_PYCostCPI_A       = 0;
        objTest2.IA_AnnualAmountCPI_E = 0;
        objTest2.IA_PYCostCPI_E       = 0;
        
        //Row 17
        objTest2.IA_AnnualAmountStepRent_A = 0;
        objTest2.IA_PYCostStepRent_A       = 0;
        objTest2.IA_AnnualAmountStepRent_E = 0;
        objTest2.IA_PYCostStepRent_E       = 0;
        
        //Row 18
        objTest2.IA_PYCostLS_A  = 0;
        objTest2.IA_PYCostLS_E  = 0;
        
        //Row 19
        objTest2.IA_PYCostIBAA_A  = 0;
        objTest2.IA_PYCostIBAA_E  = 0;
        
        //Row 20
        objTest2.IA_PYCostRWA_A   = 0;
        objTest2.IA_PYCostRWA_E   = 0;
        
        //Row 21 - Totals
        objTest2.IATotalSqFt_A        = 0;
        objTest2.IATotalAnnualRent_A  = 0;
        objTest2.IATotalPYCost_A      = 0;
        objTest2.IATotalSqFt_E        = 0;
        objTest2.IATotalAnnualRent_E  = 0;
        objTest2.IATotalPYCost_E      = 0;
        objTest2.IATotalSqFt          = 0;
        objTest2.IATotalAnnualRent    = 0;
        objTest2.IATotalPYCost        = 0;
        
        //Allowance and Base Targets
        objTest2.AllowanceIA       = 0;
        objTest2.AllowanceNOA      = 0;
        objTest2.IABaseTarget      = 0;
        objTest2.NOABaseTarget     = 0;
        
        Decimal inputDD2 = 0.0;
        Decimal outputD2 =  objTest2.fnCheckNull(inputDD2);
        System.Assert(objTest2!=NULL);
        
        
        ApexPages.currentPage().getParameters().put('FiscalSSSelectedType','Snapshot');
        ApexPages.currentPage().getParameters().put('SelectedSnapShotDate',string.valueof(Datetime.Now().Date()));
        GLXY_clsSummaryReport objTest1 = new GLXY_clsSummaryReport();   
        
        objTest1.strFiscalYear      = '0';
        objTest1.strFiscalYearUserInput = '0';
        objTest1.strNextFiscalYear  = '0';
        objTest1.strRegion          = '0';
        objTest1.strIncludeinBudgetFlag  = 'True';
        objTest1.blnIncludeinBudgetFlag  = True;
        objTest1.strDelegatedFlag        = '1';
    
        //Row 1
        objTest1.BaseSqFtNOA_A    = 0;
        objTest1.BaseAnnualRentNOA_A    = 0;
        objTest1.BasePYCostNOA_A    = 0;
        objTest1.BaseSqFtNOA_E  = 0;
        objTest1.BaseAnnualRentNOA_E    = 0;
        objTest1.BasePYCostNOA_E    = 0;
        
        //Row 2
        objTest1.ExpanSqFtNOA_A    = 0;
        objTest1.ExpanARentNOA_A   = 0;
        objTest1.ExpanPYCostNOA_A  = 0;
        objTest1.ExpanSqFtNOA_E    = 0;
        objTest1.ExpanARentNOA_E   = 0;
        objTest1.ExpanPYCostNOA_E  = 0;
        
        //Row 3
        objTest1.CancelSqFtNOA_A       = 0;
        objTest1.CancelARentNOA_A      = 0;
        objTest1.CancelPYCostNOA_A     = 0;
        objTest1.CancelSqFtNOA_E       = 0;
        objTest1.CancelARentNOA_E      = 0;
        objTest1.CancelPYCostNOA_E     = 0;
        
        //Row 4
        //objTest.EscalSqFtNOA_A  = 0;
        objTest1.EscalARentNOA_A   = 0;
        objTest1.EscalPYCostNOA_A  = 0;
        //objTest.EscalSqFtNOA_E  = 0;
        objTest1.EscalARentNOA_E   = 0;
        objTest1.EscalPYCostNOA_E  = 0;
        
        //Row 5
        objTest1.AnnualAmountCPI_A     = 0;
        objTest1.PYCostCPI_A           = 0;
        objTest1.AnnualAmountCPI_E     = 0;
        objTest1.PYCostCPI_E           = 0;
        
        //Row 6
        objTest1.PYCostLS_A    = 0;
        objTest1.PYCostLS_E    = 0;
        
        //Row 7
        objTest1.PYCostIBAA_A  = 0;
        objTest1.PYCostIBAA_E  = 0;
        
        //Row 8
        objTest1.PYCostRWA_A   = 0;
        objTest1.PYCostRWA_E   = 0;
        
        //Row 9
        objTest1.DoubleRentNOA_A  = 0;
        objTest1.DoubleRentNOA_E  = 0;
        
        //Row 10 - Totals
        objTest1.NOATotalSqFt_A        = 0;
        objTest1.NOATotalAnnualRent_A  = 0;
        objTest1.NOATotalPYCost_A      = 0;
        objTest1.NOATotalSqFt_E        = 0;
        objTest1.NOATotalAnnualRent_E  = 0;
        objTest1.NOATotalPYCost_E      = 0;
        objTest1.NOATotalSqFt          = 0;
        objTest1.NOATotalAnnualRent    = 0;
        objTest1.NOATotalPYCost        = 0;
        
        //Row 11
        objTest1.BaseSqFtIA_A     = 0;
        objTest1.BaseAnnualRentIA_A     = 0;
        objTest1.BasePYCostIA_A   = 0;
        objTest1.BaseSqFtIA_E     = 0;
        objTest1.BaseAnnualRentIA_E     = 0;
        objTest1.BasePYCostIA_E   = 0;
        
        //Row 12
        objTest1.ExpanSqFtIA_A     = 0;
        objTest1.ExpanARentIA_A    = 0;
        objTest1.ExpanPYCostIA_A   = 0;
        objTest1.ExpanSqFtIA_E     = 0;
        objTest1.ExpanARentIA_E    = 0;
        objTest1.ExpanPYCostIA_E   = 0;
        
          //Row 14
        objTest1.CancelSqFtIA_A  = 0;
        objTest1.CancelARentIA_A = 0;
        objTest1.CancelPYCostIA_A = 0;
        objTest1.CancelSqFtIA_E = 0;
        objTest1.CancelARentIA_E = 0;
        objTest1.CancelPYCostIA_E = 0;
        
        //Row 15
        //objTest.EscalSqFtIA_A = 0;
        objTest1.EscalARentIA_A = 0;
        objTest1.EscalPYCostIA_A = 0;
        //objTest.EscalSqFtIA_E = 0;
        objTest1.EscalARentIA_E = 0;
        objTest1.EscalPYCostIA_E = 0;
        
        //Row 16
        objTest1.IA_AnnualAmountCPI_A = 0;
        objTest1.IA_PYCostCPI_A       = 0;
        objTest1.IA_AnnualAmountCPI_E = 0;
        objTest1.IA_PYCostCPI_E       = 0;
        
        //Row 17
        objTest1.IA_AnnualAmountStepRent_A = 0;
        objTest1.IA_PYCostStepRent_A       = 0;
        objTest1.IA_AnnualAmountStepRent_E = 0;
        objTest1.IA_PYCostStepRent_E       = 0;
        
        //Row 18
        objTest1.IA_PYCostLS_A  = 0;
        objTest1.IA_PYCostLS_E  = 0;
        
        //Row 19
        objTest1.IA_PYCostIBAA_A  = 0;
        objTest1.IA_PYCostIBAA_E  = 0;
        
        //Row 20
        objTest1.IA_PYCostRWA_A   = 0;
        objTest1.IA_PYCostRWA_E   = 0;
        
        //Row 21 - Totals
        objTest1.IATotalSqFt_A        = 0;
        objTest1.IATotalAnnualRent_A  = 0;
        objTest1.IATotalPYCost_A      = 0;
        objTest1.IATotalSqFt_E        = 0;
        objTest1.IATotalAnnualRent_E  = 0;
        objTest1.IATotalPYCost_E      = 0;
        objTest1.IATotalSqFt          = 0;
        objTest1.IATotalAnnualRent    = 0;
        objTest1.IATotalPYCost        = 0;
        
        //Allowance and Base Targets
        objTest1.AllowanceIA       = 0;
        objTest1.AllowanceNOA      = 0;
        objTest1.IABaseTarget      = 0;
        objTest1.NOABaseTarget     = 0;   
        
        Decimal inputDD1 = 0.0;
        Decimal outputD1 =  objTest1.fnCheckNull(inputDD1);
        System.Assert(objTest1!=NULL);
       
    }
 
    Static void  testclsSummaryReportController1() {
        integer intFY;
        Date myCommonDate = date.newinstance(date.today().Year(), 01, 01);
        intFY = myCommonDate.year();
        If  (date.today().month() > 9){
            myCommonDate = date.newinstance(date.today().Year(), 10, 10);
            intFY = myCommonDate.year() + 1;
        }
        intFY +=1;
                
        PageReference pageRef = Page.GLXY_rptFYProjections;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Region', '\'1\',\'2\',\'3\',\'4\',\'5\',\'6\',\'7\',\'8\',\'9\',\'10\',\'11\'');
        ApexPages.currentPage().getParameters().put('IncludeInBudgetFlag', '1');
        ApexPages.currentPage().getParameters().put('DelegatedFlag', '\'False\'');
        ApexPages.currentPage().getParameters().put('FY', string.valueof(intFY));
        
        GLXY_clsSummaryReport objTest = new GLXY_clsSummaryReport();
        objTest.strFiscalYear           = '0';
        objTest.strFiscalYearUserInput  = '0';
        objTest.strNextFiscalYear       = '0';
        objTest.strRegion               = '0';
        objTest.strIncludeinBudgetFlag  = 'True';
        objTest.blnIncludeinBudgetFlag  = True;
        objTest.strDelegatedFlag        = '1';
    
        //Row 1
        objTest.BaseSqFtNOA_A        = 0;
        objTest.BaseAnnualRentNOA_A  = 0;
        objTest.BasePYCostNOA_A      = 0;
        objTest.BaseSqFtNOA_E        = 0;
        objTest.BaseAnnualRentNOA_E  = 0;
        objTest.BasePYCostNOA_E      = 0;
        
        //Row 2
        objTest.ExpanSqFtNOA_A    = 0;
        objTest.ExpanARentNOA_A   = 0;
        objTest.ExpanPYCostNOA_A  = 0;
        objTest.ExpanSqFtNOA_E    = 0;
        objTest.ExpanARentNOA_E   = 0;
        objTest.ExpanPYCostNOA_E  = 0;
        
        //Row 3
        objTest.CancelSqFtNOA_A       = 0;
        objTest.CancelARentNOA_A      = 0;
        objTest.CancelPYCostNOA_A     = 0;
        objTest.CancelSqFtNOA_E       = 0;
        objTest.CancelARentNOA_E      = 0;
        objTest.CancelPYCostNOA_E     = 0;
        
        //Row 4
        //objTest.EscalSqFtNOA_A  = 0;
        objTest.EscalARentNOA_A   = 0;
        objTest.EscalPYCostNOA_A  = 0;
        //objTest.EscalSqFtNOA_E  = 0;
        objTest.EscalARentNOA_E   = 0;
        objTest.EscalPYCostNOA_E  = 0;
        
        //Row 5
        objTest.AnnualAmountCPI_A     = 0;
        objTest.PYCostCPI_A           = 0;
        objTest.AnnualAmountCPI_E     = 0;
        objTest.PYCostCPI_E           = 0;
        
        //Row 6
        objTest.PYCostLS_A    = 0;
        objTest.PYCostLS_E    = 0;
        
        //Row 7
        objTest.PYCostIBAA_A  = 0;
        objTest.PYCostIBAA_E  = 0;
        
        //Row 8
        objTest.PYCostRWA_A   = 0;
        objTest.PYCostRWA_E   = 0;
        
        //Row 9
        objTest.DoubleRentNOA_A  = 0;
        objTest.DoubleRentNOA_E  = 0;
        
        //Row 10 - Totals
        objTest.NOATotalSqFt_A        = 0;
        objTest.NOATotalAnnualRent_A  = 0;
        objTest.NOATotalPYCost_A      = 0;
        objTest.NOATotalSqFt_E        = 0;
        objTest.NOATotalAnnualRent_E  = 0;
        objTest.NOATotalPYCost_E      = 0;
        objTest.NOATotalSqFt          = 0;
        objTest.NOATotalAnnualRent    = 0;
        objTest.NOATotalPYCost        = 0;
        
        //Row 11
        objTest.BaseSqFtIA_A          = 0;
        objTest.BaseAnnualRentIA_A    = 0;
        objTest.BasePYCostIA_A        = 0;
        objTest.BaseSqFtIA_E          = 0;
        objTest.BaseAnnualRentIA_E    = 0;
        objTest.BasePYCostIA_E        = 0;
        
        //Row 12
        objTest.ExpanSqFtIA_A     = 0;
        objTest.ExpanARentIA_A    = 0;
        objTest.ExpanPYCostIA_A   = 0;
        objTest.ExpanSqFtIA_E     = 0;
        objTest.ExpanARentIA_E    = 0;
        objTest.ExpanPYCostIA_E   = 0;
        
          //Row 14
        objTest.CancelSqFtIA_A    = 0;
        objTest.CancelARentIA_A   = 0;
        objTest.CancelPYCostIA_A  = 0;
        objTest.CancelSqFtIA_E    = 0;
        objTest.CancelARentIA_E   = 0;
        objTest.CancelPYCostIA_E  = 0;
        
        //Row 15
        //objTest.EscalSqFtIA_A  = 0;
        objTest.EscalARentIA_A   = 0;
        objTest.EscalPYCostIA_A  = 0;
        //objTest.EscalSqFtIA_E  = 0;
        objTest.EscalARentIA_E   = 0;
        objTest.EscalPYCostIA_E  = 0;
        
        //Row 16
        objTest.IA_AnnualAmountCPI_A = 0;
        objTest.IA_PYCostCPI_A       = 0;
        objTest.IA_AnnualAmountCPI_E = 0;
        objTest.IA_PYCostCPI_E       = 0;
        
        //Row 17
        objTest.IA_AnnualAmountStepRent_A = 0;
        objTest.IA_PYCostStepRent_A       = 0;
        objTest.IA_AnnualAmountStepRent_E = 0;
        objTest.IA_PYCostStepRent_E       = 0;
        
        //Row 18
        objTest.IA_PYCostLS_A  = 0;
        objTest.IA_PYCostLS_E  = 0;
        
        //Row 19
        objTest.IA_PYCostIBAA_A  = 0;
        objTest.IA_PYCostIBAA_E  = 0;
        
        //Row 20
        objTest.IA_PYCostRWA_A   = 0;
        objTest.IA_PYCostRWA_E   = 0;
        
        //Row 21 - Totals
        objTest.IATotalSqFt_A        = 0;
        objTest.IATotalAnnualRent_A  = 0;
        objTest.IATotalPYCost_A      = 0;
        objTest.IATotalSqFt_E        = 0;
        objTest.IATotalAnnualRent_E  = 0;
        objTest.IATotalPYCost_E      = 0;
        objTest.IATotalSqFt          = 0;
        objTest.IATotalAnnualRent    = 0;
        objTest.IATotalPYCost        = 0;
        
        //Allowance and Base Targets
        objTest.AllowanceIA       = 0;
        objTest.AllowanceNOA      = 0;
        objTest.IABaseTarget      = 0;
        objTest.NOABaseTarget     = 0;
        
        Decimal inputDD = 0.0;
        Decimal outputD =  objTest.fnCheckNull(inputDD);
        System.Assert(objTest!=NULL);
        
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }        
        ApexPages.currentPage().getParameters().put('Region', '\'1\',\'2\',\'3\',\'4\',\'5\',\'6\',\'7\',\'8\',\'9\',\'10\',\'11\'');
        ApexPages.currentPage().getParameters().put('IncludeInBudgetFlag', '1');
        ApexPages.currentPage().getParameters().put('DelegatedFlag', '\'False\'');
        ApexPages.currentPage().getParameters().put('FY', string.valueof(intCurrentFy));
        
        GLXY_clsSummaryReport objTest2 = new GLXY_clsSummaryReport();
        objTest2.strFiscalYear      = '0';
        objTest2.strFiscalYearUserInput = '0';
        objTest2.strNextFiscalYear  = '0';
        objTest2.strRegion          = '0';
        objTest2.strIncludeinBudgetFlag  = 'True';
        objTest2.blnIncludeinBudgetFlag  = True;
        objTest2.strDelegatedFlag        = '1';
    
        //Row 1
        objTest2.BaseSqFtNOA_A    = 0;
        objTest2.BaseAnnualRentNOA_A    = 0;
        objTest2.BasePYCostNOA_A    = 0;
        objTest2.BaseSqFtNOA_E  = 0;
        objTest2.BaseAnnualRentNOA_E    = 0;
        objTest2.BasePYCostNOA_E    = 0;
        
        //Row 2
        objTest2.ExpanSqFtNOA_A    = 0;
        objTest2.ExpanARentNOA_A   = 0;
        objTest2.ExpanPYCostNOA_A  = 0;
        objTest2.ExpanSqFtNOA_E    = 0;
        objTest2.ExpanARentNOA_E   = 0;
        objTest2.ExpanPYCostNOA_E  = 0;
        
        //Row 3
        objTest2.CancelSqFtNOA_A       = 0;
        objTest2.CancelARentNOA_A      = 0;
        objTest2.CancelPYCostNOA_A     = 0;
        objTest2.CancelSqFtNOA_E       = 0;
        objTest2.CancelARentNOA_E      = 0;
        objTest2.CancelPYCostNOA_E     = 0;
        
        //Row 4
        //objTest2.EscalSqFtNOA_A  = 0;
        objTest2.EscalARentNOA_A   = 0;
        objTest2.EscalPYCostNOA_A  = 0;
        //objTest2.EscalSqFtNOA_E  = 0;
        objTest2.EscalARentNOA_E   = 0;
        objTest2.EscalPYCostNOA_E  = 0;
        
        //Row 5
        objTest2.AnnualAmountCPI_A     = 0;
        objTest2.PYCostCPI_A           = 0;
        objTest2.AnnualAmountCPI_E     = 0;
        objTest2.PYCostCPI_E           = 0;
        
        //Row 6
        objTest2.PYCostLS_A    = 0;
        objTest2.PYCostLS_E    = 0;
        
        //Row 7
        objTest2.PYCostIBAA_A  = 0;
        objTest2.PYCostIBAA_E  = 0;
        
        //Row 8
        objTest2.PYCostRWA_A   = 0;
        objTest2.PYCostRWA_E   = 0;
        
        //Row 9
        objTest2.DoubleRentNOA_A  = 0;
        objTest2.DoubleRentNOA_E  = 0;
        
        //Row 10 - Totals
        objTest2.NOATotalSqFt_A        = 0;
        objTest2.NOATotalAnnualRent_A  = 0;
        objTest2.NOATotalPYCost_A      = 0;
        objTest2.NOATotalSqFt_E        = 0;
        objTest2.NOATotalAnnualRent_E  = 0;
        objTest2.NOATotalPYCost_E      = 0;
        objTest2.NOATotalSqFt          = 0;
        objTest2.NOATotalAnnualRent    = 0;
        objTest2.NOATotalPYCost        = 0;
        
        //Row 11
        objTest2.BaseSqFtIA_A     = 0;
        objTest2.BaseAnnualRentIA_A     = 0;
        objTest2.BasePYCostIA_A   = 0;
        objTest2.BaseSqFtIA_E     = 0;
        objTest2.BaseAnnualRentIA_E     = 0;
        objTest2.BasePYCostIA_E   = 0;
        
        //Row 12
        objTest2.ExpanSqFtIA_A     = 0;
        objTest2.ExpanARentIA_A    = 0;
        objTest2.ExpanPYCostIA_A   = 0;
        objTest2.ExpanSqFtIA_E     = 0;
        objTest2.ExpanARentIA_E    = 0;
        objTest2.ExpanPYCostIA_E   = 0;
        
          //Row 14
        objTest2.CancelSqFtIA_A  = 0;
        objTest2.CancelARentIA_A = 0;
        objTest2.CancelPYCostIA_A = 0;
        objTest2.CancelSqFtIA_E = 0;
        objTest2.CancelARentIA_E = 0;
        objTest2.CancelPYCostIA_E = 0;
        
        //Row 15
        //objTest2.EscalSqFtIA_A = 0;
        objTest2.EscalARentIA_A = 0;
        objTest2.EscalPYCostIA_A = 0;
        //objTest2.EscalSqFtIA_E = 0;
        objTest2.EscalARentIA_E = 0;
        objTest2.EscalPYCostIA_E = 0;
        
        //Row 16
        objTest2.IA_AnnualAmountCPI_A = 0;
        objTest2.IA_PYCostCPI_A       = 0;
        objTest2.IA_AnnualAmountCPI_E = 0;
        objTest2.IA_PYCostCPI_E       = 0;
        
        //Row 17
        objTest2.IA_AnnualAmountStepRent_A = 0;
        objTest2.IA_PYCostStepRent_A       = 0;
        objTest2.IA_AnnualAmountStepRent_E = 0;
        objTest2.IA_PYCostStepRent_E       = 0;
        
        //Row 18
        objTest2.IA_PYCostLS_A  = 0;
        objTest2.IA_PYCostLS_E  = 0;
        
        //Row 19
        objTest2.IA_PYCostIBAA_A  = 0;
        objTest2.IA_PYCostIBAA_E  = 0;
        
        //Row 20
        objTest2.IA_PYCostRWA_A   = 0;
        objTest2.IA_PYCostRWA_E   = 0;
        
        //Row 21 - Totals
        objTest2.IATotalSqFt_A        = 0;
        objTest2.IATotalAnnualRent_A  = 0;
        objTest2.IATotalPYCost_A      = 0;
        objTest2.IATotalSqFt_E        = 0;
        objTest2.IATotalAnnualRent_E  = 0;
        objTest2.IATotalPYCost_E      = 0;
        objTest2.IATotalSqFt          = 0;
        objTest2.IATotalAnnualRent    = 0;
        objTest2.IATotalPYCost        = 0;
        
        //Allowance and Base Targets
        objTest2.AllowanceIA       = 0;
        objTest2.AllowanceNOA      = 0;
        objTest2.IABaseTarget      = 0;
        objTest2.NOABaseTarget     = 0;
        
        Decimal inputDD2 = 0.0;
        Decimal outputD2 =  objTest2.fnCheckNull(inputDD2);
        System.Assert(objTest2!=NULL);   
    }
}