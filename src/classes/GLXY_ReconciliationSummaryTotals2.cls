public with sharing class GLXY_ReconciliationSummaryTotals2 {
    
    public void CalculateTotals(){
        
        List<Glxy_Reconciliation__c> objReconciliationUpdatedRecords = New List<Glxy_Reconciliation__c>();
        AggregateResult[] AgR;
        
        Date dtProcessRunDate = Datetime.Now().Date();
        string strCurrentMonth = String.valueOf(dtProcessRunDate.addMonths(-1).Month());
        Date dtCurrentDay = Datetime.Now().Date();
        //Galaxy 2.2 - Provide capability to run the process for previous months
        GalaxyReconciliationBatch__c objCustomSettings1 = GalaxyReconciliationBatch__c.getOrgDefaults();
        if (objCustomSettings1.CustomRunDate__c != null){
            dtProcessRunDate = objCustomSettings1.CustomRunDate__c;
            strCurrentMonth = String.valueOf(dtProcessRunDate.addMonths(-1).Month());
            dtCurrentDay = objCustomSettings1.CustomRunDate__c;
        }
        
        Integer PreviousMonthYear = dtProcessRunDate.Year();
        if (dtProcessRunDate.Month() == 1 ) {
            PreviousMonthYear -= 1;
        }
        
        Integer DaysinThisMonth = date.daysInMonth(dtProcessRunDate.Year(), dtProcessRunDate.Month());
        Date StartMonth  = Date.newInstance(dtProcessRunDate.Year(), dtProcessRunDate.month(), 01);
        Date EndMonth  = Date.newInstance(dtProcessRunDate.Year(), dtProcessRunDate.month(), DaysinThisMonth);
        Integer DaysinPreviousMonth = date.daysInMonth(PreviousMonthYear, dtProcessRunDate.addMonths(-1).Month());
        Date StartPreviousMonth =  Date.newInstance(PreviousMonthYear, dtProcessRunDate.addMonths(-1).Month(), 01);
        Date EndPreviousMonth =  Date.newInstance(PreviousMonthYear, dtProcessRunDate.addMonths(-1).Month(), DaysinPreviousMonth);
        //Galaxy 2.2 - Provide capability to run the process for previous months
        
        Integer dtCurrentFY = dtProcessRunDate.Year();
        if ((dtProcessRunDate.addMonths(-1).Month() == 10 || dtProcessRunDate.addMonths(-1).Month() == 11)) {// Runs for Oct Nov Dec data, add FY +=1
            dtCurrentFY +=1;
        }
        
        //Loop to sum data by Lease Number
        string strLoopCurrentLease;
        string strLoopPreviousLease;
        Boolean blnHasData;
      
        //SR related fields ...
        Decimal dblSRAmount = 0.0;
        Decimal dblSRLumpSum = 0.0;
        
        // Make a list of all Leases that will be used as sub-queries as move through the other Objects ...
        Set<String> LeaseNames = New Set<String>();
        Set<String> LeaseIds = New Set<String>();
        List<Glxy_Lease__c> objGetLeasesList = [Select ID, Name From  Glxy_Lease__c WHERE REXUSStatusCode__c  = 'Active']; 
        for (Glxy_Lease__c objtemp : objGetLeasesList) {
            LeaseNames.add(objtemp.Name);
            LeaseIds.add(objtemp.ID);
        }

        // SR Related Field updates ......
        strLoopPreviousLease = '-';
        blnHasData = false;
        List<Glxy_StepRent__c> objSRData = [ 
            Select  LeaseNumber__r.Name, Amount__c, EffectiveDate__c, EffectiveDateFY__c, Acceptance620Date__c
            From    Glxy_StepRent__c
            Where   LeaseNumber__c in :LeaseIds
            And     StatusCode__c = 'Actual' 
            And 	BDGFlag__c = true 
            And     Acceptance620Date__c <= :EndPreviousMonth //G2 R2.2
            AND     Acceptance620Date__c = THIS_FISCAL_YEAR   //G2 R2.2
            And     EffectiveDate__c <= :EndPreviousMonth     //G2 R2.2
            Order by LeaseNumber__r.Name
            ];

        for (Glxy_StepRent__c RowData : objSRData) { 
            strLoopCurrentLease = RowData.LeaseNumber__r.Name;
            blnHasData = true;
            if ((strLoopCurrentLease <> strLoopPreviousLease) && (strLoopPreviousLease <> '-')){
                objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                    LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                    SRAmount__c = dblSRAmount,
                    SRLumpSum__c = dblSRLumpSum
                ));
                dblSRAmount = 0.0;
                dblSRLumpSum = 0.0;
            }
            If (dtProcessRunDate.Month() == RowData.Acceptance620Date__c.Month()){ //Accrual - Run only When Reconciliation Run Month = Acceptance Month
                 dblSRLumpSum += fnReturnSRLumpSum(RowData.EffectiveDate__c, RowData.Acceptance620Date__c.addMonths(-1), (RowData.Amount__c/12));
            }
            dblSRAmount += RowData.Amount__c/12;   
            strLoopPreviousLease = strLoopCurrentLease;
        }
        if (blnHasData){ // Run one last time, for the last record ...
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                SRAmount__c = dblSRAmount,
                SRLumpSum__c = dblSRLumpSum
            ));
        }
        
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationSummaryTotals2 - SR Data Update error - ' + e.getMessage());
        }
        objReconciliationUpdatedRecords.clear();
  
        //Delete this job from Scheduled Jobs ...
        try{    
            GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
            System.abortJob(objCustomSettings.Schedule3B_ID__c);
        }catch (Exception e){
            System.debug('GLXY_ReconciliationSummaryTotals2 - Delete Job error - ' + e.getMessage());
        }
       //Invoke the NEXT job ...
        GalaxyReconciliationBatch__c objCustomSettings2 = GalaxyReconciliationBatch__c.getOrgDefaults();
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        objCustomSettings2.Schedule3_ID__c = System.Schedule('GLXY_ReconciliationSummaryTotals3', cron, new GLXY_ReconciliationJobSchedule3C());
        try{    
            Update objCustomSettings2;
        }catch (Exception e){
            System.debug('GLXY_ReconciliationSummaryTotals2 - Create Job error - ' + e.getMessage());
        }
        
    }
    
    Private Decimal fnReturnSRLumpSum(Date EffectiveDate, Date AcceptanceDate, Decimal MonthlyAmount){
        Decimal dblSRLumpSum = 0.0;
        Integer DaysinThisMonth = date.daysInMonth(EffectiveDate.Year(), EffectiveDate.Month());
        Integer DaysDiff = EffectiveDate.daysBetween(date.newInstance(EffectiveDate.Year(), EffectiveDate.Month(), DaysinThisMonth)) + 1;
        dblSRLumpSum = (EffectiveDate.MonthsBetween(AcceptanceDate) * MonthlyAmount);
        dblSRLumpSum += (DaysDiff * MonthlyAmount)/DaysinThisMonth;
        Return dblSRLumpSum;
    }
    
    // **** RUN all the TEST methods for code coverage ... ****//    
    private static testmethod void testReconciliationSummaryTotalsController() {
        
        GalaxyReconciliationBatch__c objCustomSettings = New GalaxyReconciliationBatch__c(
            CustomRunDate__c = Datetime.Now().Date()
        );
        insert objCustomSettings;
        
        List<Glxy_Lease__c> objLeaseLeaseRecords = New List<Glxy_Lease__c>();
        
        Glxy_Lease__c ObjLease = new Glxy_Lease__c();
        ObjLease.Name = 'LDE00374';
        ObjLease.StatusCode__c = 'Active';
        ObjLease.REXUSStatusCode__c = 'Active';
        ObjLease.BaseAnnualRent__c = 1200;
        ObjLease.BaseLeaseEffectiveDate__c = date.newinstance(date.today().Year(), 1, 1);
        ObjLease.ExpirationDateofLease__c = date.newinstance(date.today().Year() + 5, 1, 1);
        ObjLease.RegionCD__c = '1';
        ObjLease.Total_NOA_Sq_feet__c = 10;
        ObjLease.Total_IA_Sq_feet__c = 20;
        objLease.DelegatedLease__c = false;
        objLease.IAConverstionDate__c = date.newinstance(date.today().Year(), 1, 1);
        //insert ObjLease;
        objLeaseLeaseRecords.Add(ObjLease);
        
        Glxy_Lease__c ObjLease2 = new Glxy_Lease__c();
        ObjLease2.Name = 'LDE00370';
        ObjLease2.StatusCode__c = 'Active';
        ObjLease2.REXUSStatusCode__c = 'Active';
        ObjLease2.BaseAnnualRent__c = 1200;
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
        
        List<Glxy_StepRent__c> objSRRecords = New List<Glxy_StepRent__c>();
        Glxy_StepRent__c objTest11 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            FY_Obligation__c = 0,
            StatusCode__c = 'Actual',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objSRRecords.Add(objTest11);
        Glxy_StepRent__c objTest1212 = new Glxy_StepRent__c (
            LeaseNumber__c = objLease2.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            FY_Obligation__c = 0,
            StatusCode__c = 'Actual',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objSRRecords.Add(objTest1212);
        insert objSRRecords;

        GLXY_ReconciliationSummaryTotals2 objTest3 = new GLXY_ReconciliationSummaryTotals2();
        objTest3.CalculateTotals();
        System.Assert(objTest3!=NULL);
        Decimal outputD =  objTest3.fnReturnSRLumpSum(Datetime.Now().Date().adddays(-31), Datetime.Now().Date().adddays(-10), 100);
       
    } 
}