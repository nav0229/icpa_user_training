public with sharing class GLXY_ReconciliationSummaryTotals {
    
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
        //Galaxy 2.2 - Provide capability to run the process for previous months
        
        Date dtGSACurrentFYStartDate;
        if ((dtProcessRunDate.Month() == 10 || dtProcessRunDate.Month() == 11 || dtProcessRunDate.Month() == 12)) { // Runs for Oct Nov Dec data, add FY +=1
        	dtGSACurrentFYStartDate = Date.newinstance(dtProcessRunDate.Year(),10,01);
        } else { 	
            dtGSACurrentFYStartDate = Date.newinstance(dtProcessRunDate.Year() - 1,10,01);
        }
        
        //Loop to sum data by Lease Number
        string strLoopCurrentLease;
        string strLoopPreviousLease;
        Boolean blnHasData;
        //Lump Sum related fields ...
        Decimal dblCalculatedAmount = 0.0;
        Decimal dblTaxes = 0.0;
        Decimal dblLumpSum = 0.0;
        //Project related fields ...
        Decimal dblIAExpansionRent = 0.0;
        Decimal dblNOAExpansionRent= 0.0;
        Decimal dblIACancelAmount = 0.0;
        Decimal dblNOACancelAmount= 0.0;
        Decimal dblChangeinSQFtRent = 0.0;
        Decimal dblRentDifference = 0.0;
        Decimal dblRentIncreaseLumpSum = 0.0;
        //CPI related fields ...
        Decimal dblCPIAmount = 0.0;
        Decimal dblCPILumpSum = 0.0;
       
        //G2 Release 2.2
        Integer PreviousMonthYear = dtProcessRunDate.Year();
        if (dtProcessRunDate.Month() == 1 ) {
            PreviousMonthYear -= 1; 
        }
        Integer DaysinThisMonth = date.daysInMonth(dtProcessRunDate.Year(), dtProcessRunDate.Month());
        Integer DaysinPreviousMonth = date.daysInMonth(PreviousMonthYear, dtProcessRunDate.addMonths(-1).Month());
        Date StartPreviousMonth =  Date.newInstance(PreviousMonthYear, dtProcessRunDate.addMonths(-1).Month(), 01);
        Date EndPreviousMonth =  Date.newInstance(PreviousMonthYear, dtProcessRunDate.addMonths(-1).Month(), DaysinPreviousMonth);
        System.Debug ('StartPreviousMonth' + StartPreviousMonth);
        System.Debug ('EndPreviousMonth' + EndPreviousMonth);
        //G2 Release 2.2
        
        // Make a list of all Leases that will be used as sub-queries as move through the other Objects ...
        Set<String> LeaseNames = New Set<String>();
        Set<String> LeaseIds = New Set<String>();
        List<Glxy_Lease__c> objGetLeasesList = [Select ID, Name From  Glxy_Lease__c WHERE REXUSStatusCode__c  = 'Active']; 
        for (Glxy_Lease__c objtemp : objGetLeasesList) {
            LeaseNames.add(objtemp.Name);
            LeaseIds.add(objtemp.ID);
        }
        
        // Lump Sum related field updates ...
        strLoopPreviousLease = '-';
        blnHasData = false;
        List<Glxy_LumpSum__c> objLumpSumData = [    
            Select  LeaseNumber__r.Name, LumSumType__c, Amount__c, EffectiveDate__c, ExpirationDate__c, Acceptance620Date__c
            From    Glxy_LumpSum__c  
            Where   LeaseNumber__c in :LeaseIds
            And     StatusCd__c = 'Actual' 
            And 	BDGFlag__c = true 
            AND     EffectiveDate__c  <= :EndPreviousMonth       //G2 R2.2
            AND     Acceptance620Date__c != NULL
            AND     Acceptance620Date__c <= :EndPreviousMonth    //G2 R2.2
            AND     Acceptance620Date__c <= THIS_FISCAL_YEAR     //G2 R2.2, post fix OM
            AND 	(ExpirationDate__c    >= :dtGSACurrentFYStartDate OR (CALENDAR_MONTH(ExpirationDate__c) = 9 AND CALENDAR_MONTH(EffectiveDate__c) = 9)) //G2 R2.2, post fix OM
            Order by LeaseNumber__r.Name
            ];
            
        for (Glxy_LumpSum__c RowData : objLumpSumData) { 
            strLoopCurrentLease = RowData.LeaseNumber__r.Name;
            blnHasData = true;
            if ((strLoopCurrentLease <> strLoopPreviousLease) && (strLoopPreviousLease <> '-')){
                objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                    LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                    Tax__c = dblTaxes,
                    LumpSumsAmount__c = dblLumpSum
                ));
                dblTaxes = 0.0;
                dblLumpSum= 0.0;
            }
            //Lump Sum, broken down by Months
            dblCalculatedAmount = RowData.Amount__c/(RowData.EffectiveDate__c.MonthsBetween(RowData.ExpirationDate__c) + 1);
            if (RowData.LumSumType__c.equalsIgnoreCase('Tax Escalation')){
                If ((dtProcessRunDate.addMonths(-1).Month() == RowData.Acceptance620Date__c.Month()) && (RowData.ExpirationDate__c <= EndPreviousMonth) ){ 
                    dblTaxes += RowData.Amount__c;
                }
                else If ((dtProcessRunDate.addMonths(-1).Month() == RowData.Acceptance620Date__c.Month()) && (RowData.ExpirationDate__c > EndPreviousMonth) ){ 
                    dblTaxes += (RowData.EffectiveDate__c.MonthsBetween(RowData.Acceptance620Date__c) * dblCalculatedAmount);
                }
                else If (RowData.ExpirationDate__c >= EndPreviousMonth){
                    dblTaxes += dblCalculatedAmount;
                }
            } else {
            	If ((dtProcessRunDate.addMonths(-1).Month() == RowData.Acceptance620Date__c.Month()) && (RowData.ExpirationDate__c <= EndPreviousMonth) ){ 
                    dblLumpSum += RowData.Amount__c;
                }
                else If ((dtProcessRunDate.addMonths(-1).Month() == RowData.Acceptance620Date__c.Month()) && (RowData.ExpirationDate__c > EndPreviousMonth) ){ 
                    dblLumpSum += (RowData.EffectiveDate__c.MonthsBetween(RowData.Acceptance620Date__c) * dblCalculatedAmount);
                }
                else If (RowData.ExpirationDate__c >= EndPreviousMonth){
                    dblLumpSum += dblCalculatedAmount;
                }
            }
            strLoopPreviousLease = strLoopCurrentLease; 
        }
        if (blnHasData){ // Run one last time, for the last record ...
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                Tax__c = dblTaxes,
                LumpSumsAmount__c = dblLumpSum
            ));
        }
        
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationSummaryTotals - Lump Sum Data Update error - ' + e.getMessage());
        }
        objReconciliationUpdatedRecords.clear();
            
       // Project Related Field updates ...
       strLoopPreviousLease = '-';
       blnHasData = false;
        List<Glxy_LeaseProjects__c> objProjectData = [  
            SELECT  NewLease__c, Project_Type__c, AnnualRent__c, Old_Annual_Rent__c, Acceptance620Date__c, 
                    SquareFeet__c, Old_Square_Feet__c, EffectiveDate__c, NOA_or_IA__c,
                    ExpanARentIA__c, ExpanARentNOA__c, ExpansionAnnualRent__c,
                    EscalARentIA__c, EscalARentNOA__c, EscalationAnnualRent__c,
                    CancelARentIA__c, CancelARentNOA__c, CancellationAnnualRent__c
            From    Glxy_LeaseProjects__c
            Where   Acceptance620Date__c <= :EndPreviousMonth //G2 R2.2
            And     Acceptance620Date__c = THIS_FISCAL_YEAR   //G2 R2.2
            And     NOA_or_IA__c in ('NOA', 'IA', 'BOTH')
            And 	BDGFlag__c = true
            And     CheckCOApproval__c = false
            And     NewLease__c in :LeaseNames
            ORDER BY NewLease__c
            ];
          
        for (Glxy_LeaseProjects__c RowData : objProjectData) { 
            strLoopCurrentLease = RowData.NewLease__c;
            blnHasData = true;
            if ((strLoopCurrentLease <> strLoopPreviousLease) && (strLoopPreviousLease <> '-')){
                objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                    LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                    ExpansionAnnualRentIA__c = dblIAExpansionRent/12,
                    ExpansionAnnualRentNOA__c = dblNOAExpansionRent/12,
                    ChangeInSFRent__c = dblChangeinSQFtRent/12,
                    CancelAnnualRentIA__c = dblIACancelAmount/12,
                    CancelAnnualRentNOA__c =  dblNOACancelAmount/12,
                    RentDifference__c = dblRentDifference/12,
                    RentIncreaseLumpSum__c = dblRentIncreaseLumpSum
                ));
                dblIAExpansionRent = 0.0;
                dblNOAExpansionRent= 0.0;
                dblChangeinSQFtRent = 0.0;
                dblIACancelAmount = 0.0;
                dblNOACancelAmount = 0.0;
                dblRentDifference = 0.0;
                dblRentIncreaseLumpSum = 0.0;
            }
            
            dblCalculatedAmount = (RowData.AnnualRent__c - RowData.Old_Annual_Rent__c);
            dblIAExpansionRent += RowData.ExpanARentIA__c;
            dblNOAExpansionRent += RowData.ExpanARentNOA__c;
            dblChangeinSQFtRent += RowData.EscalationAnnualRent__c;
            dblIACancelAmount += RowData.CancelARentIA__c;
            dblNOACancelAmount += RowData.CancelARentNOA__c;
            dblRentDifference += RowData.ExpansionAnnualRent__c;
            If ((dtProcessRunDate.addMonths(-1).Month() == RowData.Acceptance620Date__c.Month()) && (RowData.SquareFeet__c != 0 || RowData.Old_Square_Feet__c !=0) ){ //Accrual - Run only When Reconciliation Run Month = Acceptance Month
                //dblRentIncreaseLumpSum += (RowData.EffectiveDate__c.MonthsBetween(RowData.Acceptance620Date__c)) * (dblCalculatedAmount/12); //Accrual  
                dblRentIncreaseLumpSum += fnReturnCPILumpSum(RowData.EffectiveDate__c, RowData.Acceptance620Date__c, (dblCalculatedAmount/12));
            }
            
            strLoopPreviousLease = strLoopCurrentLease; 
        }
        if (blnHasData){ // Run one last time, for the last record ...
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                ExpansionAnnualRentIA__c = dblIAExpansionRent/12,
                ExpansionAnnualRentNOA__c = dblNOAExpansionRent/12,
                ChangeInSFRent__c = dblChangeinSQFtRent/12,
                CancelAnnualRentIA__c = dblIACancelAmount/12,
                CancelAnnualRentNOA__c =  dblNOACancelAmount/12,
                RentDifference__c = dblRentDifference/12,
                RentIncreaseLumpSum__c = dblRentIncreaseLumpSum
            ));
        }
        
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationSummaryTotals - Project Data Update error - ' + e.getMessage());
        }
        objReconciliationUpdatedRecords.clear();
        
        /*
        // CPI Related Field updates ......
        strLoopPreviousLease = '-';
        blnHasData = false;
        List<Glxy_ConsumerPriceIndex__c> objCPIData = [ 
            Select  LeaseNumber__r.Name, AnnualAmount__c, EffectiveDate__c, EffectiveDateFY__c, Acceptance620Date__c
            From    Glxy_ConsumerPriceIndex__c
            Where   LeaseNumber__c in :LeaseIds
            And     StatusCd__c = 'Actual' 
            And 	BDGFlag__c = true 
            And     Acceptance620Date__c <= :EndPreviousMonth //G2 R2.2
            AND     Acceptance620Date__c = THIS_FISCAL_YEAR   //G2 R2.2
            And     EffectiveDate__c <= :EndPreviousMonth     //G2 R2.2
            Order by LeaseNumber__r.Name
            ];

        for (Glxy_ConsumerPriceIndex__c RowData : objCPIData) { 
            strLoopCurrentLease = RowData.LeaseNumber__r.Name;
            blnHasData = true;
            if ((strLoopCurrentLease <> strLoopPreviousLease) && (strLoopPreviousLease <> '-')){
                objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                    LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                    CPIAmount__c = dblCPIAmount,
                    CPILumpSum__c = dblCPILumpSum
                ));
                dblCPIAmount = 0.0;
                dblCPILumpSum = 0.0;
            }
            If (dtProcessRunDate.addMonths(-1).Month() == RowData.Acceptance620Date__c.Month()){ //Accrual - Run only When Reconciliation Run Month = Acceptance Month
                 System.debug('dblRentIncreaseLumpSum After - ' + dblRentIncreaseLumpSum);
                 dblCPILumpSum += fnReturnCPILumpSum(RowData.EffectiveDate__c, RowData.Acceptance620Date__c, (RowData.AnnualAmount__c/12));
            }
            dblCPIAmount += RowData.AnnualAmount__c/12;    
            strLoopPreviousLease = strLoopCurrentLease; 
        }
        
        if (blnHasData){ // Run one last time, for the last record ...
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = strCurrentMonth + strLoopPreviousLease,
                CPIAmount__c = dblCPIAmount,
                CPILumpSum__c = dblCPILumpSum
            ));
        }
        
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationSummaryTotals - CPI Data Update error - ' + e.getMessage());
        }
        objReconciliationUpdatedRecords.clear();
        */
        
        // Calculate RWA Amounts ...
        AgR = [ SELECT  LeaseNumber__r.Name LeaseNumber, Sum(Amount__c) AnnualAmount
                From    Glxy_ReimbursableWorkAuthorization__c
                Where   Acceptance620Date__c >= :StartPreviousMonth //G2 R2.2
                AND     Acceptance620Date__c <= :EndPreviousMonth   //G2 R2.2
                And     StatusCd__c = 'Actual'
                And     LeaseNumber__c in :LeaseIDs
                GROUP BY LeaseNumber__r.Name
              ];
      
        for (AggregateResult RowData : AgR) { 
            objReconciliationUpdatedRecords.Add(new Glxy_Reconciliation__c(
                LeaseNumberMonth__c = strCurrentMonth + String.valueOf(RowData.get('LeaseNumber')),
                RWAsAmount__c = (Decimal) RowData.get('AnnualAmount')
            ));
        }
        try{    
            Database.UpsertResult[] results = Database.Upsert(objReconciliationUpdatedRecords, Schema.Glxy_Reconciliation__c.LeaseNumberMonth__c, false);
        }catch (DmlException e){
            System.debug('GLXY_ReconciliationSummaryTotals - RWA Data Update error - ' + e.getMessage());
        }
        objReconciliationUpdatedRecords.clear();
        
        //Delete this job from Scheduled Jobs ...
        try{    
            GalaxyReconciliationBatch__c objCustomSettings = GalaxyReconciliationBatch__c.getOrgDefaults();
            System.abortJob(objCustomSettings.Schedule3_ID__c);
        }catch (Exception e){
            System.debug('GLXY_ReconciliationSummaryTotals - Delete Job error - ' + e.getMessage());
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
        objCustomSettings2.Schedule3B_ID__c = System.Schedule('GLXY_ReconciliationSummaryTotals2', cron, new GLXY_ReconciliationJobSchedule3B());
        try{    
            Update objCustomSettings2;
        }catch (Exception e){
            System.debug('GLXY_ReconciliationSummaryTotals - Create Job error - ' + e.getMessage());
        }
        
    }
    
    Private Decimal fnReturnCPILumpSum(Date EffectiveDate, Date AcceptanceDate, Decimal MonthlyAmount){
        Decimal dblCPILumpSum = 0.0;
        Integer DaysinThisMonth = date.daysInMonth(EffectiveDate.Year(), EffectiveDate.Month());
        Integer DaysDiff = EffectiveDate.daysBetween(date.newInstance(EffectiveDate.Year(), EffectiveDate.Month(), DaysinThisMonth)) + 1;
        dblCPILumpSum = (EffectiveDate.MonthsBetween(AcceptanceDate.AddMonths(-1)) * MonthlyAmount);
        dblCPILumpSum += (DaysDiff * MonthlyAmount)/DaysinThisMonth; //Effective Month proration 
        Return dblCPILumpSum;
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
        
        List<Glxy_ConsumerPriceIndex__c> objCPIRecords = New List<Glxy_ConsumerPriceIndex__c>();
        Glxy_ConsumerPriceIndex__c objTest1 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            FY_Obligation__c = 0,
            StatusCd__c = 'Actual',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objCPIRecords.Add(objTest1);
        Glxy_ConsumerPriceIndex__c objTest12 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objLease2.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            FY_Obligation__c = 0,
            StatusCd__c = 'Actual',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objCPIRecords.Add(objTest12);
        insert objCPIRecords;
        
        List<Glxy_LumpSum__c> objLSRecords = New List<Glxy_LumpSum__c>();
        Glxy_LumpSum__c objTest0 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            StatusCd__c = 'Actual',
            LumSumType__c= 'Tax Escalation',
            ExpirationDate__c = Datetime.Now().Date(),
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objLSRecords.Add(objTest0);
        Glxy_LumpSum__c objTest02 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease2.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            StatusCd__c = 'Actual',
            LumSumType__c= 'Tax Escalation',
            ExpirationDate__c = Datetime.Now().Date(),
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objLSRecords.Add(objTest02);
         Glxy_LumpSum__c objTest03 = new Glxy_LumpSum__c (
            LeaseNumber__c = objLease2.id,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            StatusCd__c = 'Actual',
            LumSumType__c= 'Interest',
            ExpirationDate__c = Datetime.Now().Date(),
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objLSRecords.Add(objTest03);
        insert objLSRecords;
  
        
        List<Glxy_ReimbursableWorkAuthorization__c> objRWARecords = New List<Glxy_ReimbursableWorkAuthorization__c>();
        Glxy_ReimbursableWorkAuthorization__c objTest2 = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease.id,
            FY_Obligation__c = 0,
            StatusCd__c = 'Actual',
            EffectiveDate__c = Datetime.Now().Date()
        );
        objRWARecords.Add(objTest2);
        Glxy_ReimbursableWorkAuthorization__c objTest22 = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease2.id,
            FY_Obligation__c = 0,
            StatusCd__c = 'Actual',
            EffectiveDate__c = Datetime.Now().Date()
        );
        objRWARecords.Add(objTest22);
        insert objRWARecords;
        
        List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
                
        Glxy_LeaseProjects__c pro = new Glxy_LeaseProjects__c(
            ProjectID__c = '11',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31),
            AnnualRent__c= 22,
            Old_Annual_Rent__c = 11,
            SquareFeet__c = 222,
            Old_Square_Feet__c = 222,
            NewLease__c = objlease.name,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            Project_Type__c = 'Termination',
            RegionCd__c = '1',
            NOA_or_IA__c = 'NOA'
        );
        objLeaseProjectsRecords.Add(pro);
        
        Glxy_LeaseProjects__c pro2 = new Glxy_LeaseProjects__c(
            ProjectID__c = '1111',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31),
            AnnualRent__c= 22,
            Old_Annual_Rent__c = 11,
            SquareFeet__c = 240,
            Old_Square_Feet__c = 222,
            NewLease__c = objlease.name,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            Project_Type__c = 'Change in sf',
            RegionCd__c = '1',
            NOA_or_IA__c = 'IA'
        );
         objLeaseProjectsRecords.Add(pro2);
        
        Glxy_LeaseProjects__c pro3 = new Glxy_LeaseProjects__c(
            ProjectID__c = '111122',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31),
            AnnualRent__c= 22,
            Old_Annual_Rent__c = 11,
            SquareFeet__c = 240,
            Old_Square_Feet__c = 222,
            NewLease__c = objlease2.name,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            Project_Type__c = 'New',
            RegionCd__c = '1',
            NOA_or_IA__c = 'IA'
        );
        objLeaseProjectsRecords.Add(pro3);
        
         Glxy_LeaseProjects__c pro4 = new Glxy_LeaseProjects__c(
            ProjectID__c = '111124',
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31),
            AnnualRent__c= 22,
            Old_Annual_Rent__c = 11,
            SquareFeet__c = 240,
            Old_Square_Feet__c = 222,
            NewLease__c = objlease2.name,
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            Project_Type__c = 'Other',
            RegionCd__c = '1',
            NOA_or_IA__c = 'NOA'
        );
        objLeaseProjectsRecords.Add(pro4);
        
        Insert objLeaseProjectsRecords;
        
        Glxy_ReimbursableWorkAuthorization__c objRWA2 = new Glxy_ReimbursableWorkAuthorization__c (
            LeaseNumber__c = objLease2.id,
            Amount__c = 100,
            FY_Obligation_NOA__c = 50,
            FY_Obligation_IA__c = 50,
            ProcessedDate__c = Datetime.Now().Date().adddays(-31),
            StatusCD__c = 'ACTUAL',
            EffectiveDate__c = Datetime.Now().Date().adddays(-31),
            Acceptance620Date__c = Datetime.Now().Date().adddays(-31)
        );
        objRWARecords.Add(objRWA2);
          
        GLXY_ReconciliationSummaryTotals objTest3 = new GLXY_ReconciliationSummaryTotals();
        objTest3.CalculateTotals();
        System.Assert(objTest3!=NULL);
        Decimal outputD =  objTest3.fnReturnCPILumpSum(Datetime.Now().Date().adddays(-31), Datetime.Now().Date().adddays(-10), 100);
       
    } 
}