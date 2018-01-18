public with sharing class GLXY_clsReportDetails {
        
    string strSOQLSelect = 'Select r.Name, r.IsDeleted, r.Id, r.Description From Report r Where r.Description = ';
    string strSOQLWhere = ' and IsDeleted = false Order By r.Name';
    
    // **** Retrieve the BASE Reports . ****//
    public Report[] getLeaseReportsBase() {
        string strSOQL = strSOQLSelect + '\'LEASE BASE\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }   
    
    // **** Retrieve the reports from the Reports object. ****//
    public Report[] getLeaseReports() {
        string strSOQL = strSOQLSelect + '\'LEASE\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    // **** Retrieve the reports from the Reports object. ****//
    public Report[] getLeaseProjectsReports() {
        string strSOQL = strSOQLSelect + '\'LEASE-PROJECTS\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }  
    
    public Report[] getLeaseReportsParam() {
        string strSOQL = strSOQLSelect + '\'LEASE-PARAM\'' + strSOQLWhere;
        //system.debug(strSOQL);
        return Database.query(strSOQL);
    }
    
     public Report[] getLeaseReportsParamDate() {
        string strSOQL = strSOQLSelect + '\'LEASE-PARAM-DATE\'' + strSOQLWhere;
        //system.debug(strSOQL);
        return Database.query(strSOQL);
    }
    
    public Report[] getChargesReports() {
        string strSOQL = strSOQLSelect + '\'CHARGES\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
     public Report[] getAgenciesReports() {
        string strSOQL = strSOQLSelect + '\'AGENCIES\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getProjectsReports() {
        string strSOQL = strSOQLSelect + '\'PROJECTS\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getProjectsReportsMisc() {
        string strSOQL = strSOQLSelect + '\'PROJECTS-MISC\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getProjectsReportsMisc2() {
        string strSOQL = strSOQLSelect + '\'PROJECTS-MISC2\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getProjectsReportsMisc3() {
        string strSOQL = strSOQLSelect + '\'PROJECTS-MISC3\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getProjectsReportsMisc4() {
        string strSOQL = strSOQLSelect + '\'PROJECTS-MISC4\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }      
    
    public Report[] getProjectsIAReports() {
        string strSOQL = strSOQLSelect + '\'PROJECTS IA\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getProjectsNOAReports() {
        string strSOQL = strSOQLSelect + '\'PROJECTS NOA\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getTotalReports() {
        string strSOQL = strSOQLSelect + '\'TOTAL\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
     public Report[] getDelegatedReports() {
        string strSOQL = strSOQLSelect + '\'DELEGATED\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getReconciliationReports() {
        string strSOQL = strSOQLSelect + '\'RECONCILIATION\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
   public Report[] getAccrualReports() {
        string strSOQL = strSOQLSelect + '\'ACCRUAL\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getDataFileReports() {
        string strSOQL = strSOQLSelect + '\'DATAFILE\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getCutOffReports() {
        string strSOQL = strSOQLSelect + '\'CUTOFF\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getExceptionReports() {
        string strSOQL = strSOQLSelect + '\'EXCEPTION\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getBudgetCallReports() {
        string strSOQL = strSOQLSelect + '\'BUDGETCALL\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getHighRiskReports() {
        string strSOQL = strSOQLSelect + '\'HIGHRISK\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getBudgetTrendReports() {
        string strSOQL = strSOQLSelect + '\'TRENDS\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getFundCertReports() {
        string strSOQL = strSOQLSelect + '\'FUNDCERT\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getSnapShotReports() {
        string strSOQL = strSOQLSelect + '\'SNAPSHOT\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getSnapShotDataReports() {
        string strSOQL = strSOQLSelect + '\'SNAPSHOTDATA\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    public Report[] getPDUPReports() {
        string strSOQL = strSOQLSelect + '\'PDUP\'' + strSOQLWhere;
        return Database.query(strSOQL);
    }
    
    // **** Retrieve the dropdowns values for "Region" dropdown. ****//
    public List<SelectOption> getRegions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('\'1\',\'2\',\'3\',\'4\',\'5\',\'6\',\'7\',\'8\',\'9\',\'10\',\'11\'', '- All Regions -'));
        options.add(new SelectOption('\'1\'', 'Region 01'));
        options.add(new SelectOption('\'2\'', 'Region 02'));
        options.add(new SelectOption('\'3\'', 'Region 03'));
        options.add(new SelectOption('\'4\'', 'Region 04'));
        options.add(new SelectOption('\'5\'', 'Region 05'));
        options.add(new SelectOption('\'6\'', 'Region 06'));
        options.add(new SelectOption('\'7\'', 'Region 07'));
        options.add(new SelectOption('\'8\'', 'Region 08'));
        options.add(new SelectOption('\'9\'', 'Region 09'));
        options.add(new SelectOption('\'10\'', 'Region 10'));
        options.add(new SelectOption('\'11\'', 'Region 11'));
        return options;
    }
    
    public String getCurrentFY() {
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        return string.valueOf(intCurrentFy);
    }
    
    public void setCurrentFY(String s) {
        
    }
    
    public String getCurrentFY1() {
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        return string.valueOf(intCurrentFy+1);
    }
    public void setCurrentFY1(String s) {
        
    }
    
    public String getCurrentFY2() {
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        return string.valueOf(intCurrentFy+2);
    }
    public void setCurrentFY2(String s) {
        
    }
    
    // **** Get the REGION associated with the Current Logged in User ... ****//
    String strUserRegionValue = [Select Glxy_Region_Code__c from User where id = :UserInfo.getUserId()].Glxy_Region_Code__c;
    //String strUserRegionValue = String.valueOf(dcmUserRegion); //Use this line of code if region is a drop-down in the USER Object.
        
    public String getUserRegionValue() {
        return '\'' + strUserRegionValue + '\'';
    }
    
    public void setUserRegionValue(String s) {
        this.strUserRegionValue = s;
    }
    
    // **** Get the Current Month
    string strMonth = String.valueOf(Datetime.Now().Date().Month());
    public String getCurrentMonth() {
        return strMonth;
    }
    
    public void setCurrentMonth(String s) {
        this.strMonth = s;
    }
    
    // **** Get the Previous Month
    string strPreviousMonth = String.valueOf(Datetime.Now().Date().Month() -  1);
    public String getPreviousMonth() {
        return strPreviousMonth;
    }
    
    public void setPreviousMonth(String s) {
        this.strPreviousMonth = s;
    }
    
    // **** Retrieve the dropdowns for "Fiscal Year" dropdown. ****//
    public List<SelectOption> getFiscalYears(){
        List<SelectOption> options = new List<SelectOption>();
        
        Integer intFy; 
                
        Integer intCurrentFy = date.today().Year(); //Current Fiscal Year, add +1 after September 
        Integer intCurrentYearMonth = date.today().Month();
        if (intCurrentYearMonth > 9){
            intCurrentFy +=1;
        }
        intFy = intCurrentFy;
        
        String intFy1 = String.valueOf(intFy);
        String intFy2 = String.valueOf(intFy + 1);
        String intFy3 = String.valueOf(intFy + 2);
        String intFy4 = intFy1 + ',' + intFy2 + ',' + intFy3;
        /*for (intFy = intCurrentFy; intFy <= intCurrentFy + 2; intFy++) {
            //System.debug('intFy = ' + intFy);
            options.add(new SelectOption(String.valueOf(intFy), String.valueOf(intFy)));
        }*/
        options.add(new SelectOption(intFy1, intFy1));
        options.add(new SelectOption(intFy2, intFy2));
        options.add(new SelectOption(intFy3, intFy3));
        options.add(new SelectOption(intFy4, 'All' ));
        
        return options;
    }
    
    // **** Retrieve the dropdowns for "NOA/IA" dropdown. ****//
    public List<SelectOption> getSpaceTypes(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('NOA, IA', 'Total'));
        options.add(new SelectOption('NOA', 'NOA'));
        options.add(new SelectOption('IA', 'IA'));
        return options;
    }
    
    // **** Retrieve the dropdowns for "Delegated/Non-Delegated" dropdown. ****//
    public List<SelectOption> getDelegatedTypes(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('\'True\',\'False\'', 'Both'));
        options.add(new SelectOption('\'False\'', 'False'));
        options.add(new SelectOption('\'True\'', 'True'));
        return options;
    }
    
    // **** Retrieve the dropdowns for "Delegated/Non-Delegated" as a FLAG, reconciliation reports ... ****//
    public List<SelectOption> getDelegatedFlag(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0', 'Non-Delegated'));
        options.add(new SelectOption('1', 'Delegated'));
        return options;
    }
    
    // **** "Include in Budget" dropdown. ****//
    public List<SelectOption> getBudgetStatus(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1', 'True'));
        options.add(new SelectOption('0', 'False'));
        return options;
    }
    
    // **** Retrieve the dropdowns for "Estimate/Actual" dropdown. ****//
    public List<SelectOption> getEstimateActual(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('\'Estimate\',\'Actual\'', 'All'));
        options.add(new SelectOption('\'Estimate\'', 'Estimate'));
        options.add(new SelectOption('\'Actual\'', 'Actual'));
        //options.add(new SelectOption('Voided', 'Voided'));
        return options;
    }
    
    // **** Retrieve the dropdowns for "FY/Snapshot" dropdown. ****// --added for release 2.6PF3
    public List<SelectOption> getFYSnapshot(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Fiscal Year', 'Fiscal Year'));
        options.add(new SelectOption('Snapshot', 'Snapshot'));
        return options;
    }
    
     // **** Get the snapshot date from master galaxy snapshot ... ****//   
    public List<SelectOption> getSnapshotDate(){ 
        List<SelectOption> options = new List<SelectOption>();
        List<Galaxy_Snapshot__c> objSnapshotDatelist = [Select Snapshot_Date__c from Galaxy_Snapshot__c Order by Snapshot_Date__c desc];
        
        for(Galaxy_Snapshot__c objSS: objSnapshotDatelist){
            options.add(new SelectOption(string.valueOf(objSS.Snapshot_Date__c), string.valueOf(objSS.Snapshot_Date__c)));
        }
        return options ;
    }
    
    public List<SelectOption> getDataFormat(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('\'RAW\',\'Adjustment\'', 'All'));
        options.add(new SelectOption('\'RAW\'', 'RAW'));
        options.add(new SelectOption('\'Adjustment\'', 'Adjustment'));
       return options;
    }
    
    public List<SelectOption> getSubmissionType(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('\'Budget Call\'', 'Budget Call'));
        options.add(new SelectOption('\'OMB\'', 'OMB'));
        options.add(new SelectOption('\'Congressional Justification\'', 'CJ'));
       return options;
    }
    
    // **** Retrieve the dropdowns for "Months" dropdown. ****//
    public List<SelectOption> getMonths(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1', 'January'));
        options.add(new SelectOption('2', 'February'));
        options.add(new SelectOption('3', 'March'));
        options.add(new SelectOption('4', 'April'));
        options.add(new SelectOption('5', 'May'));
        options.add(new SelectOption('6', 'June'));
        options.add(new SelectOption('7', 'July'));
        options.add(new SelectOption('8', 'August'));
        options.add(new SelectOption('9', 'September'));
        options.add(new SelectOption('10', 'October'));
        options.add(new SelectOption('11', 'November'));
        options.add(new SelectOption('12', 'December'));
        return options;
    }
    
    // **** Retrieve Historical Data Periods for Snapshot reports. ****//
    /*
    public List<SelectOption> getSnapshotPeriods(){
        List<SelectOption> options = new List<SelectOption>();
        Integer intCounter;
        Date dtFirstSnapShotDate = Date.newInstance(2013, 02, 12);
        string strFirstSnapShotDate = dtFirstSnapShotDate.format();
        string strNextSnapshotDate;
        Date dtNextSnapshotDate;
        options.add(new SelectOption(strFirstSnapShotDate, strFirstSnapShotDate));
        
        for (intCounter = 1; intCounter <= 10 ; intCounter++) {
            dtNextSnapshotDate = dtFirstSnapShotDate.addDays(intCounter);
            strNextSnapshotDate = dtNextSnapshotDate.format();
            if (dtNextSnapshotDate > datetime.now()){
                break;
            } else {
                
                options.add(new SelectOption(strNextSnapshotDate, strNextSnapshotDate));    
            }
        }
        return options;
    }
    */
    
    // **** RUN all the TEST methods for code coverage ... ****//    
    private static testmethod void testclsReportDetailsController() {
            
            GLXY_clsReportDetails objTest = new GLXY_clsReportDetails();
            
            Report[] reportResults;
            List<SelectOption> objSelectOptions; 
            string strTempString; 
            
            reportResults = objTest.getLeaseReportsBase();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getLeaseReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getLeaseProjectsReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getLeaseReportsParam();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getLeaseReportsParamDate();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getAgenciesReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getChargesReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getProjectsReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getProjectsReportsMisc();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getProjectsReportsMisc2();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getProjectsReportsMisc3();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getProjectsReportsMisc4();
            System.Assert(objTest!=NULL);              
            reportResults = objTest.getProjectsIAReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getProjectsNOAReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getTotalReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getDelegatedReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getReconciliationReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getAccrualReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getDataFileReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getCutOffReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getExceptionReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getBudgetCallReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getHighRiskReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getFundCertReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getSnapshotReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getSnapshotDataReports();
            System.Assert(objTest!=NULL);
            reportResults = objTest.getPDUPReports();
            System.Assert(objTest!=NULL);
             
            strTempString = objTest.getUserRegionValue();
            System.Assert(objTest!=NULL);
            //System.assertEquals(NULL,strTempString);
            objSelectOptions = objTest.getRegions();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getFiscalYears();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getSpaceTypes();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getDelegatedTypes();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getDelegatedFlag();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getBudgetStatus();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getEstimateActual();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getFYSnapshot();  // added for release 2.6PF3
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getSnapshotDate();  // added for release 2.6PF3
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getDataFormat();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getSubmissionType();
            System.Assert(objTest!=NULL);
            objSelectOptions = objTest.getMonths();
            System.Assert(objTest!=NULL);
            string strFY = objTest.getCurrentFY();
            System.Assert(objTest!=NULL);
            string strFY1 = objTest.getCurrentFY1();
            System.Assert(objTest!=NULL);
            string strFY2 = objTest.getCurrentFY2();
            System.Assert(objTest!=NULL);
    }
}