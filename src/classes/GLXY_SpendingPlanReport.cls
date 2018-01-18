public with sharing class GLXY_SpendingPlanReport {
    
    public String strFiscalYear             {get; set;}
    public String strFiscalYearUserInput    {get; set;}
    public String strNextFiscalYear         {get; set;}
    public String strRegion                 {get; set;}
    public String strIncludeinBudgetFlag    {get; set;}
    Public Boolean blnIncludeinBudgetFlag   {get; set;}
    Public String strDelegatedFlag          {get; set;}
    Public String strStatusCode             {get; set;}
    
    public List<Decimal> BaseRentNOA{get; set;}
    public List<Decimal> BaseRentIA{get; set;}
    public List<Decimal> LeaseProjectNOA{get; set;}
    public List<Decimal> LeaseProjectIA{get; set;}
    public List<Decimal> CPINOA{get; set;}
    public List<Decimal> CPIIA{get; set;}
    public List<Decimal> StepRentNOA{get; set;}
    public List<Decimal> StepRentIA{get; set;}
    public List<Decimal> LumpSumNOA{get; set;}
    public List<Decimal> LumpSumIA{get; set;}
    public List<Decimal> IBAANOA{get; set;}
    public List<Decimal> IBAAIA{get; set;}
    public List<Decimal> RWANOA{get; set;}
    public List<Decimal> RWAIA{get; set;}
    public List<Decimal> DoubleRentNOA{get; set;}
    public List<Decimal> DoubleRentIA{get; set;}
    public List<Decimal> LPLSNOA{get; set;}
    public List<Decimal> LPLSIA{get; set;}
    public List<Decimal> LPSRNOA{get; set;}
    public List<Decimal> LPSRIA{get; set;}
    public Decimal NOATotalOct {set;get;}
                public Decimal NOATotalNov {set;get;}
                public Decimal NOATotalDec {set;get;}
                public Decimal NOATotalJan {set;get;}
                public Decimal NOATotalFeb {set;get;}
                public Decimal NOATotalMar {set;get;}
                public Decimal NOATotalApr {set;get;}
                public Decimal NOATotalMay {set;get;}
                public Decimal NOATotalJun {set;get;}
                public Decimal NOATotalJul {set;get;}
                public Decimal NOATotalAug {set;get;}
                public Decimal NOATotalSep {set;get;}
    public Decimal IATotalOct {set;get;}
                public Decimal IATotalNov {set;get;}
                public Decimal IATotalDec {set;get;}
                public Decimal IATotalJan {set;get;}
                public Decimal IATotalFeb {set;get;}
                public Decimal IATotalMar {set;get;}
                public Decimal IATotalApr {set;get;}
                public Decimal IATotalMay {set;get;}
                public Decimal IATotalJun {set;get;}
                public Decimal IATotalJul {set;get;}
                public Decimal IATotalAug {set;get;}
                public Decimal IATotalSep {set;get;}
    
    public List<Integer> intMonthCounter{
        get{ 
            return new List<Integer>{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,12};
        }
        set;
    }
    
    public GLXY_SpendingPlanReport(){
        
        if (System.currentPageReference().getParameters().get('Region')!=null){
            strRegion = System.currentPageReference().getParameters().get('Region');
            strIncludeinBudgetFlag = System.currentPageReference().getParameters().get('IncludeInBudgetFlag');
            strDelegatedFlag = System.currentPageReference().getParameters().get('DelegatedFlag');
            strFiscalYearUserInput = System.currentPageReference().getParameters().get('FY');
            strStatusCode = System.currentPageReference().getParameters().get('StatusCode');
            If (strIncludeinBudgetFlag == '1'){ 
                strIncludeinBudgetFlag = 'True';
                blnIncludeinBudgetFlag = True;
            } else {
                strIncludeinBudgetFlag = 'False';
                blnIncludeinBudgetFlag = False;
            }
        }else{
            strRegion = '\'3\'';
            blnIncludeinBudgetFlag = True;
            strIncludeinBudgetFlag = 'True';
            strDelegatedFlag = '\'False\'';
            strFiscalYearUserInput = '2015';
            strStatusCode = '\'Estimate\', \'Actual\'';
        }
        
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        strFiscalYear = string.valueof(intCurrentFy);
        strNextFiscalYear = String.valueOf(intCurrentFy + 1);
        String strSOQL;
        
        String strStringNOAProject;
        String strStringNOALease;
        String strStringIAProject;
        String strStringIALease;
        
        If (strFiscalYear == strFiscalYearUserInput){
            strStringNOAProject = ' And IAConverstionFY__c >= \'2500\' ';              //The second IA Query should not be fired for current FY
            strStringNOALease = ' And LeaseNumber__r.IAConverstionFY__c >= \'2500\' '; //The second IA Query should not be fired for current FY
            strStringIAProject = '';
            strStringIALease = '';
        } else {
            strStringNOAProject = 'And IAConverstionFY__c <= :strFiscalYearUserInput ';
            strStringNOALease = 'And LeaseNumber__r.IAConverstionFY__c <= :strFiscalYearUserInput ';
            strStringIAProject = 'And IAConverstionFY__c > :strFiscalYearUserInput  ';
            strStringIALease = 'And LeaseNumber__r.IAConverstionFY__c > :strFiscalYearUserInput ';
        }
    NOATotalOct=0.00;
                NOATotalNov=0.00;
                NOATotalDec=0.00;
                NOATotalJan=0.00;
                NOATotalFeb=0.00;
                NOATotalMar=0.00;
                NOATotalApr=0.00;
                NOATotalMay=0.00;
                NOATotalJun=0.00;
                NOATotalJul=0.00;
                NOATotalAug=0.00;
                NOATotalSep=4.00;
    IATotalOct=0.00;
                IATotalNov=0.00;
                IATotalDec=0.00;
                IATotalJan=0.00;
                IATotalFeb=0.00;
                IATotalMar=0.00;
                IATotalApr=0.00;
                IATotalMay=0.00;
                IATotalJun=0.00;
                IATotalJul=0.00;
                IATotalAug=0.00;
                IATotalSep=2.00;
        
        Decimal monJan = 0.0;
        Decimal monFeb = 0.0;
        Decimal monMar = 0.0;
        Decimal monApr = 0.0;
        Decimal monMay = 0.0;
        Decimal monJun = 0.0;
        Decimal monJul = 0.0;
        Decimal monAug = 0.0;
        Decimal monSep = 0.0;
        Decimal monOct = 0.0;
        Decimal monNov = 0.0;
        Decimal monDec = 0.0;
        
        //Base Rent
        strSOQL =   'Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                    '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA, ' +
                    '       Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' +  
                    'From   Glxy_Lease__c ' +
                    'Where  RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    Next_FY_Leases__c = False ' + 
                    'And    StatusCode__c = \'Active\' ' +  
                    'And    Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')';
                    
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Row 1 = ' + strSOQL);   
        AggregateResult[] AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
            BaseRentNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
            
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep;
            BaseRentiA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
            
        }
        
        // Lease Project NOA
        // Query 1 - NOAs
        strSOQL =   'Select  Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                    '        Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' +
                    'From   Glxy_LeaseProjects__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    eEorA__c In (' + String.escapeSingleQuotes(strStatusCode) + ') ' + 
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    'And    ProjectStatus__c <> \'Cancelled\' ' ; 

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Lease Project NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
        
        // Query 2 < IA to NOA Conversions ...
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_LeaseProjects__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    eEorA__c In (' + String.escapeSingleQuotes(strStatusCode) + ') ' + 
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    'And    ProjectStatus__c <> \'Cancelled\' ' + 
                    strStringNOAProject ; 
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Lease Project NOA Q2 = ' + strSOQL);               
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) {     
            monJan += (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb += (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar += (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr += (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay += (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun += (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul += (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug += (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep += (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct += (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov += (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec += (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        LeaseProjectNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //Lease Project NOA
        
        // Lease Project IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_LeaseProjects__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    eEorA__c In (' + String.escapeSingleQuotes(strStatusCode) + ') ' +
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    'And    ProjectStatus__c <> \'Cancelled\' ' +
                    strStringIAProject ;
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Lease Project IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep; 
        LeaseProjectIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // Lease Project IA
    
       // CPI NOA
       // Query 1 - NOAs
       strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                'From   Glxy_ConsumerPriceIndex__c ' +
                'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                'And    StatusCD__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug CPI NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
        
        // Query 2 < IA to NOA Conversions ...
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_ConsumerPriceIndex__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                    'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    strStringNOALease +
                    'And    StatusCD__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug CPI NOA Q2 = ' + strSOQL);               
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) {     
            monJan += (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb += (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar += (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr += (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay += (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun += (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul += (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug += (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep += (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct += (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov += (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec += (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        CPINOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //CPI NOA
        
        // CPI IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_ConsumerPriceIndex__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                    'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    strStringIALease + 
                    'And    StatusCD__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug CPI IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep; 
        CPIIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // CPIIA
        
        // Steps NOA
        // Query 1 - NOAs
       strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                'From   Glxy_StepRent__c ' +
                'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                'And    StatusCode__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Steps NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
        
        // Query 2 < IA to NOA Conversions ...
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_StepRent__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                    'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                    strStringNOALease + 
                    'And    StatusCode__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Steps NOA Q2 = ' + strSOQL);               
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) {     
            monJan += (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb += (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar += (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr += (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay += (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun += (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul += (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug += (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep += (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct += (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov += (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec += (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        StepRentNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //Steps NOA
        
        // Steps IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_StepRent__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                    'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                    strStringIALease  + 
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                    'And    StatusCode__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug Steps IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep; 
        StepRentIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // Steps IA
        
        // LS NOA
        strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                'From   Glxy_LumpSumObligations__c ' +
                'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                //'And    LumpSum__r.LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                'And    LumpSum__r.LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                'And    LumpSum__r.LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                'And    LumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                'And    LumpSum__r.StatusCd__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LS NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        LumpSumNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //LS NOA
        
        // LS IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_LumpSumObligations__c ' +
                    'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                    //'And    LumpSum__r.LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LumpSum__r.LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    LumpSum__r.LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                    'And    LumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                    'And    LumpSum__r.StatusCd__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LS IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep; 
        LumpSumIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // LS IA
        
        // IBAA NOA
        strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                 '      Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                 'From   Glxy_IntraBudgetActivityAuthorization__c ' +
                 'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                 //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                 'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                 'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                 'And    StatusCd__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug IBAA NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        IBAANOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //IBAA NOA
        
        // IBAA IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_IntraBudgetActivityAuthorization__c ' +
                    'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                    //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                    'And    StatusCd__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug IBAA IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        } 
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep;
        IBAAIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // IBAA IA
        
        // RWA NOA
        strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                 '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                 'From   Glxy_ReimbursableWorkAuthorization__c ' +
                 'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                 //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                 'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                 'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                 'And    StatusCd__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug RWA NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        RWANOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //RWA NOA
        
        // RWA IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_ReimbursableWorkAuthorization__c ' +
                    'Where  ProcessedDateFY__c = :strFiscalYearUserInput ' +
                    //'And    LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                    'And    LeaseNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ')' +
                    'And    LeaseNumber__r.Delegated_Lease_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ')' +
                    'And    StatusCd__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug RWA IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep; 
        RWAIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // RWA IA
        
        // DR NOA
        strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                 '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                 'From Glxy_DoubleRent__c ' +
                 'Where Fiscal_Year__c = :strFiscalYearUserInput ' +
                 'And    Associated_Leases_Projects_ID__r.Project__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                 'And    Associated_Leases_Projects_ID__r.Project__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                 'And    Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                 'And    Associated_Leases_Projects_ID__c <> \'\'' +
                 'And    Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c <> \'Cancelled\' ' +
                 'And    Associated_Leases_Projects_ID__r.Project__r.eEorA__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug DR NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        DoubleRentNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //DR NOA
        
        // DR IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From Glxy_DoubleRent__c ' +
                    'Where Fiscal_Year__c = :strFiscalYearUserInput ' +
                    'And    Associated_Leases_Projects_ID__r.Project__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    Associated_Leases_Projects_ID__r.Project__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' + 
                    'And    Associated_Leases_Projects_ID__r.Project__r.BDGFlag__c = :blnIncludeinBudgetFlag ' +
                    'And    Associated_Leases_Projects_ID__c <> \'\'' +
                    'And    Associated_Leases_Projects_ID__r.Project__r.ProjectStatus__c <> \'Cancelled\' ' +
                    'And    Associated_Leases_Projects_ID__r.Project__r.eEorA__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug DR IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep;        
        DoubleRentIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // DR IA
        
        // LPLS NOA
        strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                 '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                 'From   Glxy_LPLumpSumObligations__c ' +
                 'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                 'And    LPLumpSum__r.ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                 'And    LPLumpSum__r.ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                 'And    LPLumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                 'And    LPLumpSum__r.ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' + 
                 'And    LPLumpSum__r.StatusCD__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LPLS NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        LPLSNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //LPLS NOA
        
        // LPLS IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_LPLumpSumObligations__c ' +
                    'Where  FiscalYear__c  = :strFiscalYearUserInput ' +
                    'And    LPLumpSum__r.ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    LPLumpSum__r.ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                    'And    LPLumpSum__r.BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                    'And    LPLumpSum__r.ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' + 
                    'And    LPLumpSum__r.StatusCD__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LPLS IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }   
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep;
        LPLSIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // LPLS IA
        
        // LPSR NOA
        strSOQL ='Select Sum(Jan_NOA__c) JanNOA, Sum(Feb_NOA__c) FebNOA, Sum(Mar_NOA__c) MarNOA, Sum(Apr_NOA__c) AprNOA, Sum(May_NOA__c) MayNOA, Sum(Jun_NOA__c) JunNOA, ' + 
                 '       Sum(Jul_NOA__c) JulNOA, Sum(Aug_NOA__c) AugNOA, Sum(Sep_NOA__c) SepNOA, Sum(Oct_NOA__c) OctNOA, Sum(Nov_NOA__c) NovNOA, Sum(Dec_NOA__c) DecNOA ' + 
                 'From   Glxy_LPStepRent__c ' +
                 'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                 'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                 'And    ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                 'And    ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                 'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                 'And    ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' + 
                 'And    StatusCode__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';

        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LPSR NOA Q1 = ' + strSOQL);           
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanNOA') != null ? (Decimal) RowData.get('JanNOA') : 0.0);
            monFeb = (RowData.get('FebNOA') != null ? (Decimal) RowData.get('FebNOA') : 0.0);
            monMar = (RowData.get('MarNOA') != null ? (Decimal) RowData.get('MarNOA') : 0.0);
            monApr = (RowData.get('AprNOA') != null ? (Decimal) RowData.get('AprNOA') : 0.0);
            monMay = (RowData.get('MayNOA') != null ? (Decimal) RowData.get('MayNOA') : 0.0);
            monJun = (RowData.get('JunNOA') != null ? (Decimal) RowData.get('JunNOA') : 0.0);
            monJul = (RowData.get('JulNOA') != null ? (Decimal) RowData.get('JulNOA') : 0.0);
            monAug = (RowData.get('AugNOA') != null ? (Decimal) RowData.get('AugNOA') : 0.0);
            monSep = (RowData.get('SepNOA') != null ? (Decimal) RowData.get('SepNOA') : 0.0);
            monOct = (RowData.get('OctNOA') != null ? (Decimal) RowData.get('OctNOA') : 0.0);
            monNov = (RowData.get('NovNOA') != null ? (Decimal) RowData.get('NovNOA') : 0.0);
            monDec = (RowData.get('DecNOA') != null ? (Decimal) RowData.get('DecNOA') : 0.0);
        }
    NOATotalOct+=monOct;NOATotalNov+=monNov;NOATotalDec+=monDec; NOATotalJan+=monJan;NOATotalFeb+=monFeb;NOATotalMar+=monMar;
    NOATotalApr+=monApr;NOATotalMay+=monMay;NOATotalJun+=monJun; NOATotalJul+=monJul;NOATotalAug+=monAug;NOATotalSep+=monSep;
        LPSRNOA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        //LPSR NOA
        
        // LPSR IA
        strSOQL =   'Select Sum(Jan_IA__c) JanIA, Sum(Feb_IA__c) FebIA, Sum(Mar_IA__c) MarIA, Sum(Apr_IA__c) AprIA, Sum(May_IA__c) MayIA, Sum(Jun_IA__c) JunIA, ' + 
                    '       Sum(Jul_IA__c) JulIA, Sum(Aug_IA__c) AugIA, Sum(Sep_IA__c) SepIA, Sum(Oct_IA__c) OctIA, Sum(Nov_IA__c) NovIA, Sum(Dec_IA__c) DecIA ' + 
                    'From   Glxy_LPStepRent__c ' +
                    'Where  ProcessedDateFY__c >= :strFiscalYear ' +
                    'And    ProcessedDateFY__c <= :strFiscalYearUserInput ' +
                    'And    ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    ProjectNumber__r.Delegated_Project_Rep_lkp__c In (' + String.escapeSingleQuotes(strDelegatedFlag) + ') ' +
                    'And    BDGFlag__c = :blnIncludeinBudgetFlag ' + 
                    'And    ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' + 
                    'And    StatusCode__c In (' + String.escapeSingleQuotes(strStatusCode) + ')';
        strSOQL = strSOQL.Replace('\\',''); 
        System.debug('MyDebug LPSR IA = ' + strSOQL);    
        AgR = Database.Query(strSOQL);
        for (AggregateResult RowData : AgR) { 
            monJan = (RowData.get('JanIA') != null ? (Decimal) RowData.get('JanIA') : 0.0);
            monFeb = (RowData.get('FebIA') != null ? (Decimal) RowData.get('FebIA') : 0.0);
            monMar = (RowData.get('MarIA') != null ? (Decimal) RowData.get('MarIA') : 0.0);
            monApr = (RowData.get('AprIA') != null ? (Decimal) RowData.get('AprIA') : 0.0);
            monMay = (RowData.get('MayIA') != null ? (Decimal) RowData.get('MayIA') : 0.0);
            monJun = (RowData.get('JunIA') != null ? (Decimal) RowData.get('JunIA') : 0.0);
            monJul = (RowData.get('JulIA') != null ? (Decimal) RowData.get('JulIA') : 0.0);
            monAug = (RowData.get('AugIA') != null ? (Decimal) RowData.get('AugIA') : 0.0);
            monSep = (RowData.get('SepIA') != null ? (Decimal) RowData.get('SepIA') : 0.0);
            monOct = (RowData.get('OctIA') != null ? (Decimal) RowData.get('OctIA') : 0.0);
            monNov = (RowData.get('NovIA') != null ? (Decimal) RowData.get('NovIA') : 0.0);
            monDec = (RowData.get('DecIA') != null ? (Decimal) RowData.get('DecIA') : 0.0);
        }
    IATotalOct+=monOct;IATotalNov+=monNov;IATotalDec+=monDec; IATotalJan+=monJan;IATotalFeb+=monFeb;IATotalMar+=monMar;
    IATotalApr+=monApr;IATotalMay+=monMay;IATotalJun+=monJun; IATotalJul+=monJul;IATotalAug+=monAug;IATotalSep+=monSep; 
        LPSRIA = new List<Decimal>{monOct, monNov, monDec, monJan, monFeb, monMar, monApr, monMay, monJun, monJul, monAug, monSep,monOct + monNov + monDec + monJan + monFeb + monMar + monApr + monMay + monJun + monJul + monAug + monSep};
        // LPSR IA
        
    }// Function
    
    
    
    // **** RUN all the TEST methods for code coverage ... ****//    
    @isTest(SeeAllData=false) Static void  testGLXY_SpendingPlanReport() {
        PageReference pageRef = Page.GLXY_SpendingPlanReport;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Region', '\'1\',\'2\',\'3\',\'4\',\'5\',\'6\',\'7\',\'8\',\'9\',\'10\',\'11\'');
        ApexPages.currentPage().getParameters().put('IncludeInBudgetFlag', '1');
        ApexPages.currentPage().getParameters().put('DelegatedFlag', '\'False\'');
        ApexPages.currentPage().getParameters().put('StatusCode', '\'Actual\', \'Estimate\'');
        ApexPages.currentPage().getParameters().put('FY', string.valueof(date.today().Year()));
        if (date.today().Month() > 9){
           ApexPages.currentPage().getParameters().put('FY', string.valueof(date.today().Year() + 1));
        }   
        List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
        
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        objPro.Project_Type__c = 'New/Replacing';
        objPro.IASquareFeet__c = 200;
        objPro.NOASquareFeet__c = 200;
        objPro.OldIASqFt__c = 50;
        objPro.OldNOASqFt__c = 50;
        objpro.Old_Square_Feet__c = 100;
        objpro.SquareFeet__c = 400;
        Date myDate = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro.EffectiveDate__c = myDate;
        objPro.ProcessedDate__c = myDate;
        objPro.BDGFlag__c = true;
        objPro.AnnualRent__c=1000.0;
        objPro.RegionCd__c='1';
        objPro.DelegatedProject__c = false;
        objPro.ProjectStatus__c='Active';
        objPro.eEorA__c = 'Actual';
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
        Date myDate2 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate2 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro2.EffectiveDate__c = myDate2;
        objPro2.ProcessedDate__c = myDate2;
        objPro2.BDGFlag__c = true;
        objPro2.AnnualRent__c=1000.0;
        objPro2.RegionCd__c='1';
        objPro2.DelegatedProject__c = false;
        objPro2.ProjectStatus__c='Active';
        objPro2.eEorA__c = 'Estimate';
        objPro2.Old_Annual_Rent__c=100.0;
        objPro2.IAConversionDate__c = date.newinstance(date.today().Year() + 2 , 1, 10);
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
        Date myDate3 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate3 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro3.EffectiveDate__c = myDate3;
        objPro3.ProcessedDate__c = myDate3;
        objPro3.BDGFlag__c = true;
        objPro3.AnnualRent__c=1000.0;
        objPro3.RegionCd__c='1';
        objPro3.DelegatedProject__c = false;
        objPro3.ProjectStatus__c='Active';
        objPro3.eEorA__c = 'Actual';
        objPro3.Old_Annual_Rent__c=100.0;
        objPro3.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objPro3.ExpanSqFtNOA__c = 50;
        objPro3.ExpanSqFtIA__c = 50;
        objLeaseProjectsRecords.Add(objPro3);
        //insert objPro3;
        
        Glxy_LeaseProjects__c objPro4 = new Glxy_LeaseProjects__c();
        objPro4.Name='12345678924';
        objPro4.Project_Type__c = 'New/Replacing';
        objPro4.IASquareFeet__c = 200;
        objPro4.NOASquareFeet__c = 200;
        objPro4.OldIASqFt__c = 50;
        objPro4.OldNOASqFt__c = 50;
        objpro4.Old_Square_Feet__c = 100;
        objpro4.SquareFeet__c = 400;
        Date myDate4 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate4 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro4.EffectiveDate__c = myDate4;
        objPro4.ProcessedDate__c = myDate4;
        objPro4.BDGFlag__c = true;
        objPro4.AnnualRent__c=1000.0;
        objPro4.RegionCd__c='1';
        objPro4.DelegatedProject__c = false;
        objPro4.ProjectStatus__c='Active';
        objPro4.eEorA__c = 'Estimate';
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
        Date myDate5 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate5 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro5.EffectiveDate__c = myDate5;
        objPro5.ProcessedDate__c = myDate5;
        objPro5.BDGFlag__c = true;
        objPro5.AnnualRent__c=1000.0;
        objPro5.RegionCd__c='1';
        objPro5.DelegatedProject__c = false;
        objPro5.ProjectStatus__c='Active';
        objPro5.eEorA__c = 'Actual';
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
        Date myDate6 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate6 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro6.EffectiveDate__c = myDate6;
        objPro6.ProcessedDate__c = myDate6;
        objPro6.BDGFlag__c = true;
        objPro6.AnnualRent__c=1000.0;
        objPro6.RegionCd__c='1';
        objPro6.DelegatedProject__c = false;
        objPro6.ProjectStatus__c='Active';
        objPro6.eEorA__c = 'Estimate';
        objPro6.Old_Annual_Rent__c=100.0;
        objPro6.IAConversionDate__c = date.newinstance(date.today().Year() + 2, 1, 10);
        objPro6.CancelSqFtIA__c = -40;
        objPro6.CancelSqFtNOA__c = -40;
        objLeaseProjectsRecords.Add(objPro6);
        //insert objPro6;
        
        Glxy_LeaseProjects__c objPro7 = new Glxy_LeaseProjects__c();
        objPro7.Name='1234567897';
        objPro7.Project_Type__c = 'Reduction';
        objPro7.IASquareFeet__c = 10;
        objPro7.NOASquareFeet__c = 10;
        objPro7.OldIASqFt__c = 50;
        objPro7.OldNOASqFt__c = 50;
        objpro7.Old_Square_Feet__c = 100;
        objpro7.SquareFeet__c = 20;
        Date myDate7 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate7 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro7.EffectiveDate__c = myDate5;
        objPro7.ProcessedDate__c = myDate5;
        objPro7.BDGFlag__c = true;
        objPro7.AnnualRent__c=1000.0;
        objPro7.RegionCd__c='1';
        objPro7.DelegatedProject__c = false;
        objPro7.ProjectStatus__c='Active';
        objPro7.eEorA__c = 'Actual';
        objPro7.Old_Annual_Rent__c=100.0;
        objPro7.IAConversionDate__c = date.newinstance(date.today().Year() - 2, 1, 10);
        objPro7.CancelSqFtIA__c = -40;
        objPro7.CancelSqFtNOA__c = -40;
        objLeaseProjectsRecords.Add(objPro7);
        //insert objPro7;
        
        Glxy_LeaseProjects__c objPro8 = new Glxy_LeaseProjects__c();
        objPro8.Name='1234567898';
        objPro8.Project_Type__c = 'Reduction';
        objPro8.IASquareFeet__c = 10;
        objPro8.NOASquareFeet__c = 10;
        objPro8.OldIASqFt__c = 50;
        objPro8.OldNOASqFt__c = 50;
        objpro8.Old_Square_Feet__c = 100;
        objpro8.SquareFeet__c = 20;
        Date myDate8 = date.newinstance(date.today().Year(), 01, 01);
        if (date.today().Month() > 9){
          myDate8 = date.newinstance(date.today().Year() + 1, 01, 01);
        }   
        objPro8.EffectiveDate__c = myDate6;
        objPro8.ProcessedDate__c = myDate6;
        objPro8.BDGFlag__c = true;
        objPro8.AnnualRent__c=1000.0;
        objPro8.RegionCd__c='1';
        objPro8.DelegatedProject__c = false;
        objPro8.ProjectStatus__c='Active';
        objPro8.eEorA__c = 'Estimate';
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
        ObjLease.BaseLeaseEffectiveDate__c = date.newinstance(date.today().Year(), 1, 1);
        ObjLease.ExpirationDateofLease__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLease.RegionCD__c = '1';
        ObjLease.Total_NOA_Sq_feet__c = 10;
        ObjLease.Total_IA_Sq_feet__c = 20;
        objLease.DelegatedLease__c = false;
        objLease.BaseAnnualRent__c = 1000;
        objLease.IAConverstionDate__c = date.newinstance(date.today().Year(), 1, 1);
        //insert ObjLease;
        objLeaseLeaseRecords.Add(ObjLease);
        
        Glxy_Lease__c ObjLease2 = new Glxy_Lease__c();
        ObjLease2.StatusCode__c = 'Active';
        ObjLease2.BaseLeaseEffectiveDate__c = date.newinstance(date.today().Year(), 1, 1);
        ObjLease2.ExpirationDateofLease__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLease2.RegionCD__c = '1';
        ObjLease2.Total_NOA_Sq_feet__c = 10;
        ObjLease2.Total_IA_Sq_feet__c = 20;
        objLease2.DelegatedLease__c = false;
        objLease2.IAConverstionDate__c = date.newinstance(date.today().Year() + 2, 1, 1);
        //insert ObjLease2;
        objLeaseLeaseRecords.Add(ObjLease2);
        
        Insert objLeaseLeaseRecords;
        
        List<Glxy_LumpSum__c> objLSRecords = New List<Glxy_LumpSum__c>();
        Glxy_LumpSum__c objTestLS1 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = date.newinstance(date.today().Year(), 1, 1),
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 1, 1),
            StatusCd__c = 'Actual',
            LumSumType__c = 'Claim'

        );
        objLSRecords.Add(objTestLS1);
        System.Assert(objTestLS1!=NULL);
        
        Glxy_LumpSum__c objTestLS2 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = date.newinstance(date.today().Year(), 1, 1),
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 1, 1),
            StatusCd__c = 'Estimate',
            LumSumType__c = 'Claim'

        );
        objLSRecords.Add(objTestLS2);
        System.Assert(objTestLS2!=NULL);
        insert objLSRecords;    
        
        List<Glxy_LPLumpSum__c> objLPLSRecords = New List<Glxy_LPLumpSum__c>();
        Glxy_LPLumpSum__c objTestLPLS1 = new Glxy_LPLumpSum__c (
            ProjectNumber__c = objPro8.id,
            EffectiveDate__c = date.newinstance(date.today().Year(), 1, 1),
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 1, 1),
            StatusCd__c = 'Actual',
            LumSumType__c = 'Claim'

        );
        objLPLSRecords.Add(objTestLPLS1);
        System.Assert(objTestLPLS1!=NULL);
        
        Glxy_LPLumpSum__c objTestLPLS2 = new Glxy_LPLumpSum__c (
            ProjectNumber__c = objPro8.id,
            EffectiveDate__c = date.newinstance(date.today().Year(), 1, 1),
            FY_Obligation__c = 1000,
            ExpirationDate__c = date.newinstance(date.today().addyears(+2).Year(), 1, 1),
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
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Actual'
        );
        //insert objCPI;
        objCPIRecords.Add(objCPI);
        
        Glxy_ConsumerPriceIndex__c objCPI2 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            AnnualAmount__c = 200,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Estimate'
        );
        //insert objCPI2;
        objCPIRecords.Add(objCPI2);
        
        Glxy_ConsumerPriceIndex__c objCPI3 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease2.id,
            AnnualAmount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Actual'
        );
        //insert objCPI3;
        objCPIRecords.Add(objCPI3);
        
        Glxy_ConsumerPriceIndex__c objCPI4 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease2.id,
            AnnualAmount__c = 200,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Estimate'
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
            ProcessedDate__c = myDate8,
            StatusCode__c = 'Actual'
        );
        objStepRentRecords.Add(objSR);
        
        Glxy_StepRent__c objSR2 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = myDate8,
            StatusCode__c = 'Estimate'
        );
        objStepRentRecords.Add(objSR2);
        
        Glxy_StepRent__c objSR3 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = myDate8,
            StatusCode__c = 'Actual'
        );
        objStepRentRecords.Add(objSR3);
        
        Glxy_StepRent__c objSR4 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            BDGFlag__c = true,
            ProcessedDate__c = myDate8,
            StatusCode__c = 'Estimate'
        );
        objStepRentRecords.Add(objSR4);
        
        insert objStepRentRecords;
        
        List<Glxy_IntraBudgetActivityAuthorization__c> objIBAARecords = New List<Glxy_IntraBudgetActivityAuthorization__c>();
        Glxy_IntraBudgetActivityAuthorization__c objIBAA = new Glxy_IntraBudgetActivityAuthorization__c (
            LeaseNumber__c = objLease2.id,
            AuthorizedAmount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Estimate'
        );
        objIBAARecords.Add(objIBAA);
        
        Glxy_IntraBudgetActivityAuthorization__c objIBAA2 = new Glxy_IntraBudgetActivityAuthorization__c (
            LeaseNumber__c = objLease2.id,
            AuthorizedAmount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Actual'
        );
        objIBAARecords.Add(objIBAA2);
        
        insert objIBAARecords;
        
        List<Glxy_ReimbursableWorkAuthorization__c> objRWARecords = New List<Glxy_ReimbursableWorkAuthorization__c>();
        Glxy_ReimbursableWorkAuthorization__c objRWA = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Estimate',
            EffectiveDate__C = date.newinstance(date.today().Year(), 1, 1)
        );
        objRWARecords.Add(objRWA);
        
        Glxy_ReimbursableWorkAuthorization__c objRWA2 = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            ProcessedDate__c = myDate8,
            StatusCD__c = 'Actual',
            EffectiveDate__C = date.newinstance(date.today().Year(), 1, 1)
        );
        objRWARecords.Add(objRWA2);
        
        insert objRWARecords;
        
         Glxy_Allowance__c objAllowance = new Glxy_Allowance__c (
            FiscalYear__c = String.valueOf(date.today().Year()),
            RegionCD__c = '1',
            IATarget__c = 50,
            NOATarget__c = 50
        );
        Insert objAllowance;
        
        GLXY_SpendingPlanReport objTest = new GLXY_SpendingPlanReport();
        objTest.strFiscalYear      = '0';
        objTest.strFiscalYearUserInput = '0';
        objTest.strNextFiscalYear  = '0';
        objTest.strRegion          = '0';
        objTest.strIncludeinBudgetFlag  = 'True';
        objTest.blnIncludeinBudgetFlag  = True;
        objTest.strDelegatedFlag        = '1';
        System.Assert(objTest!=NULL);
       
    }        
}//Class