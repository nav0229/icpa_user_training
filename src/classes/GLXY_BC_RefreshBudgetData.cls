global with sharing class GLXY_BC_RefreshBudgetData {
		
		Decimal PriorYearCostAmount;
		Decimal PriorYearCostSqFt;
		Decimal AnnualRentIncreaseAmount;
		Decimal AnnualRentIncreaseSqFt;
		Decimal AnnualLumpSumAmount;
		Decimal AnnualCancellationsAmount;
		Decimal AnnualCancellationsSqFt;
		Decimal AnnualExpansionNOAAmount;
		Decimal AnnualExpansionNOASqFt;
		Decimal AnnualExpansionIAAmount;
		Decimal AnnualExpansionIASqft;
		Decimal IAToNOAAmount;
		Decimal IAToNOASqFt;
		Decimal RentIncreaseNOAAmount;
		Decimal RentIncreaseNOASqFt;
		Decimal LumpSumNOAAmount;
		Decimal CancellationsNOAAmount;
		Decimal CancellationsNOASqFt;
		Decimal ExpansionNOAAmount;
		Decimal ExpansionNOASqFt;
		Decimal RentIncreaseIAAmount;
		Decimal RentIncreaseIASqFt;
		Decimal LumpSumIAAmount;
		Decimal CancellationsIAAmount;
		Decimal CancellationsIASqFt;
		Decimal ExpansionIAAmount;
		Decimal ExpansionIASqFt;
		Decimal IASqFt;
		Decimal IAObligations;
		Decimal IAObligationsMinus;
				
		//Previous Year CJ Numbers ...
		Decimal CJPriorYearCostAmount = 0.0; 
		Decimal CJPriorYearCostSqFt = 0.0;
		Decimal CJAnnualRentIncreaseAmount = 0.0; 
		Decimal CJAnnualRentIncreaseSqFt = 0.0;  
		Decimal CJAnnualLumpSumAmount = 0.0; 
		Decimal CJAnnualCancellationsAmount = 0.0; 
		Decimal CJAnnualCancellationsSqFt = 0.0; 
		Decimal CJAnnualExpansionIAAmount = 0.0; 
		Decimal CJAnnualExpansionIASqft = 0.0; 
		Decimal CJAnnualExpansionNOAAmount = 0.0; 
		Decimal CJAnnualExpansionNOASqFt = 0.0;
		Decimal CJIAToNOAAmount = 0.0; 
		Decimal CJIAToNOASqFt = 0.0;
		
		Decimal CJIASqFt = 0.0;
		Decimal CJIAObligations = 0.0;
		Decimal CJIAObligationsMinus = 0.0;
		
		Decimal MFAnnualRentIncreaseAmount = 0.0;// MF --> Move Forward to next column on the chart ...
		Decimal MFAnnualLumpSumAmount= 0.0;
		Decimal MFAnnualCancellationsAmount = 0.0;
		Decimal MFAnnualExpansionNOAAmount = 0.0;
		Decimal MFAnnualExpansionIAAmount = 0.0;
		Decimal MFIAToNOAAmount = 0.0;
		
		Decimal MFIASqFt = 0.0;
		Decimal MFIAObligations = 0.0;
		Decimal MFIAObligationsMinus = 0.0;	
		
	public void CalculateNumbers(String strReportingFiscalYear, String strSubmissionType, String strRegion){
		
		List<Glxy_BudgetSubmissionData__c> objBudgetSubmissionDataRecords = New List<Glxy_BudgetSubmissionData__c>();
    	subLoadPreviousCJNumbers(strReportingFiscalYear, strRegion);
    	strRegion = String.escapeSingleQuotes(strRegion);
    	strSubmissionType = String.escapeSingleQuotes(strSubmissionType);
    	
		for (Glxy_BudgetSubmissionData__c objSubmissionData : 
				[Select ID, BudgetSubmissionID__c, ReportColumnIdentifier__c, FiscalYear__c
		     	From    Glxy_BudgetSubmissionData__c 
		        Where   ReportingFiscalYear__c = :strReportingFiscalYear
		        And 	SubmissionType__c = :strSubmissionType
		        And 	Region__c = :strRegion
		        And 	DataFormat__c = 'RAW'
		        Order By ReportColumnIdentifier__c])
		{//Loop through these 3 records, and calculate the numbers
			
			subInitializeAllNumbers(Integer.ValueOf(objSubmissionData.ReportColumnIdentifier__c));
			subLoadProjectNumbers(objSubmissionData.FiscalYear__c, strRegion);
			subLoadLumpSumNumbers(objSubmissionData.FiscalYear__c, strRegion);
			subLoadIANumbers(Integer.ValueOf(objSubmissionData.ReportColumnIdentifier__c));
			
			objBudgetSubmissionDataRecords.Add(new Glxy_BudgetSubmissionData__c(
		        ID = objSubmissionData.ID,
		        PriorYearCostAmount__c = PriorYearCostAmount,
				PriorYearCostSqFt__c = PriorYearCostSqFt,
				AnnualRentIncreaseAmount__c = AnnualRentIncreaseAmount,
				AnnualRentIncreaseSqFt__c = AnnualRentIncreaseSqFt, 
				AnnualLumpSumAmount__c = AnnualLumpSumAmount, 
				AnnualCancellationsAmount__c  = AnnualCancellationsAmount,
				AnnualCancellationsSqFt__c  = AnnualCancellationsSqFt,
				AnnualExpansionNOAAmount__c = AnnualExpansionNOAAmount,
				AnnualExpansionNOASqFt__c = AnnualExpansionNOASqFt,
				AnnualExpansionIAAmount__c  = AnnualExpansionIAAmount,
				AnnualExpansionIASqft__c  = AnnualExpansionIASqft,
				IAToNOAAmount__c  = IAToNOAAmount, 
				IAToNOASqFt__c = IAToNOASqFt,
				RentIncreaseNOAAmount__c = RentIncreaseNOAAmount, 
				RentIncreaseNOASqFt__c = RentIncreaseNOASqFt,
				LumpSumNOAAmount__c = LumpSumNOAAmount,
				CancellationsNOAAmount__c  = CancellationsNOAAmount,
				CancellationsNOASqFt__c = CancellationsNOASqFt,
				ExpansionNOAAmount__c = ExpansionNOAAmount,
				ExpansionNOASqFt__c = ExpansionNOASqFt,
				RentIncreaseIAAmount__c = RentIncreaseIAAmount,
				RentIncreaseIASqFt__c = RentIncreaseIASqFt,
				LumpSumIAAmount__c = LumpSumIAAmount,
				CancellationsIAAmount__c = CancellationsIAAmount,
				CancellationsIASqFt__c  = CancellationsIASqFt,
				ExpansionIAAmount__c  = ExpansionIAAmount,
				ExpansionIASqFt__c  = ExpansionIASqFt,
				IASqFt__c  = IASqFt,
				IAObligations__c = IAObligations,
				IAObligationsMinus__c = IAObligationsMinus,
				SystemCalculatedDateTime__c = Datetime.Now()
	   		));         
			       	
           			
      	 }//Loop through these 3 records, and calculate the numbers  
   		
   		// Final bulk Update here ...
        Database.Update(objBudgetSubmissionDataRecords);      
	}
	
	Private void subInitializeAllNumbers(integer intColumnIdentifier){
		
		if (intColumnIdentifier == 1){ // Data for Column 1 (Annual) is the CJ numbers from previous Reporting Year ...
			PriorYearCostAmount = CJPriorYearCostAmount;
			PriorYearCostSqFt = CJPriorYearCostSqFt;
			AnnualRentIncreaseAmount = CJAnnualRentIncreaseAmount;
			AnnualRentIncreaseSqFt = CJAnnualRentIncreaseSqFt;
			AnnualLumpSumAmount= CJAnnualLumpSumAmount;
			AnnualCancellationsAmount = CJAnnualCancellationsAmount;
			AnnualCancellationsSqFt = CJAnnualCancellationsSqFt;
			AnnualExpansionNOAAmount = CJAnnualExpansionNOAAmount;
			AnnualExpansionNOASqFt = CJAnnualExpansionNOASqFt;
			AnnualExpansionIAAmount = CJAnnualExpansionIAAmount;
			AnnualExpansionIASqft = CJAnnualExpansionIASqft;
			//IAToNOAAmount = CJIAToNOAAmount;
			//IAToNOASqFt = CJIAToNOASqFt;
		} else {
			//Move Forwards, the come from previous year column ...
			//PriorYearCostSqFt --> These are derived or should match the formulas defined on the object itself; since we had to do it for previous year, we need to rewrite the formulas here ...
			PriorYearCostSqFt = PriorYearCostSqFt + IAToNOASqFt + CancellationsNOASqFt + CancellationsIASqFt + ExpansionNOASqFt + ExpansionIASqFt;
			AnnualRentIncreaseSqFt = RentIncreaseNOASqFt + RentIncreaseIASqFt;
			AnnualCancellationsSqFt = CancellationsNOASqFt + CancellationsIASqFt;
			AnnualExpansionNOASqFt = ExpansionNOASqFt;
			AnnualExpansionIASqft = ExpansionIASqFt;
			//IAToNOASqFt = 0.0;
			
			//PriorYearCostAmount --> These are derived or should match the formulas defined on the object itself; since we had to do it for previous year, we need to rewrite the formulas here ...
			PriorYearCostAmount = PriorYearCostAmount + IAToNOAAmount + RentIncreaseNOAAmount + RentIncreaseIAAmount + LumpSumNOAAmount + LumpSumIAAmount + CancellationsNOAAmount + CancellationsIAAmount + ExpansionNOAAmount + ExpansionIAAmount ;
			AnnualRentIncreaseAmount = MFAnnualRentIncreaseAmount;
			AnnualLumpSumAmount = MFAnnualLumpSumAmount;
			AnnualCancellationsAmount = MFAnnualCancellationsAmount;
			AnnualExpansionNOAAmount = MFAnnualExpansionNOAAmount;
			AnnualExpansionIAAmount = MFAnnualExpansionIAAmount;
			//IAToNOAAmount = 0.0; 
		}
		
		RentIncreaseNOAAmount = 0.0;
		RentIncreaseNOASqFt = 0.0;
		CancellationsNOAAmount = 0.0;
		CancellationsNOASqFt = 0.0;
		ExpansionNOAAmount = 0.0;
		ExpansionNOASqFt = 0.0;
		RentIncreaseIAAmount = 0.0;
		RentIncreaseIASqFt = 0.0;
		CancellationsIAAmount = 0.0;
		CancellationsIASqFt = 0.0;
		ExpansionIAAmount = 0.0;
		ExpansionIASqFt = 0.0;
		
		LumpSumNOAAmount = 0.0;
		LumpSumIAAmount = 0.0;
		
		IASqFt = 0.0; 
		IAObligations = 0.0; 
		IAObligationsMinus = 0.0; 
		
	}
	
	Private void subLoadPreviousCJNumbers(String strReportingFiscalYear, String strRegion){
		
		strReportingFiscalYear = String.ValueOf(Integer.ValueOf(strReportingFiscalYear) - 1);
		
		List<Glxy_BudgetSubmissionData__c> objSubmissionData =
				[Select ID, PriorYearCostAmount__c, PriorYearCostSqFt__c, AnnualRentIncreaseAmount__c,
						AnnualRentIncreaseSqFt__c, AnnualLumpSumAmount__c, AnnualCancellationsAmount__c,
						AnnualCancellationsSqFt__c, AnnualExpansionIAAmount__c, AnnualExpansionIASqft__c,
						AnnualExpansionNOAAmount__c, AnnualExpansionNOASqFt__c, IAToNOAAmount__c, IAToNOASqFt__c,
						IASqFt__c, IAObligations__c, IAObligationsMinus__c
		     	From    Glxy_BudgetSubmissionData__c 
		        Where   ReportingFiscalYear__c = :strReportingFiscalYear
		        And 	SubmissionType__c = 'Congressional Justification'
		        And 	Region__c = :strRegion
		        And 	DataFormat__c = 'RAW'
		        And 	ReportColumnIdentifier__c = 2
		        Order By ReportColumnIdentifier__c];
		
		If (objSubmissionData.Size() > 0 ){
			Glxy_BudgetSubmissionData__c objCJPreviousYear = objSubmissionData.get(0);
			CJPriorYearCostAmount = objCJPreviousYear.PriorYearCostAmount__c; 
			CJPriorYearCostSqFt = objCJPreviousYear.PriorYearCostSqFt__c;
			CJAnnualRentIncreaseAmount = objCJPreviousYear.AnnualRentIncreaseAmount__c; 
			CJAnnualRentIncreaseSqFt = objCJPreviousYear.AnnualRentIncreaseSqFt__c;  
			CJAnnualLumpSumAmount = objCJPreviousYear.AnnualLumpSumAmount__c; 
			CJAnnualCancellationsAmount = objCJPreviousYear.AnnualCancellationsAmount__c; 
			CJAnnualCancellationsSqFt = objCJPreviousYear.AnnualCancellationsSqFt__c; 
			CJAnnualExpansionIAAmount = objCJPreviousYear.AnnualExpansionIAAmount__c; 
			CJAnnualExpansionIASqft = objCJPreviousYear.AnnualExpansionIASqft__c; 
			CJAnnualExpansionNOAAmount = objCJPreviousYear.AnnualExpansionNOAAmount__c; 
			CJAnnualExpansionNOASqFt = objCJPreviousYear.AnnualExpansionNOASqFt__c;
			CJIAToNOAAmount = objCJPreviousYear.IAToNOAAmount__c; 
			CJIAToNOASqFt = objCJPreviousYear.IAToNOASqFt__c;
			
			CJIASqFt = objCJPreviousYear.IASqFt__c;
			CJIAObligations = objCJPreviousYear.IAObligations__c;
			CJIAObligationsMinus  = objCJPreviousYear.IAObligationsMinus__c;
		}        
		
	}
	
	Private void subLoadProjectNumbers(String strFiscalYear, String strRegion){
		
		String strSOQL;
		strSOQL = 'Select  Sum(EscalSqFtNOA__c) EscalSqFtNOA, Sum(EscalPYCostNOA__c) EscalPYCostNOA,  ' +
							'Sum(CancelSqFtNOA__c) CancelSqFtNOA, Sum(CancelPYCostNOA__c) CancelPYCostNOA,  ' +
							'Sum(ExpanSqFtNOA__c) ExpanSqFtNOA, Sum(ExpanPYCostNOA__c) ExpanPYCostNOA,  ' +
							'Sum(EscalSqFtIA__c) EscalSqFtIA, Sum(EscalPYCostIA__c) EscalPYCostIA,  ' +
							'Sum(CancelSqFtIA__c) CancelSqFtIA, Sum(CancelPYCostIA__c) CancelPYCostIA,  ' +
							'Sum(ExpanSqFtIA__c) ExpanSqFtIA, Sum(ExpanPYCostIA__c) ExpanPYCostIA,  ' +
							'Sum(EscalARentNOA__c) EscalARentNOA, Sum(EscalARentIA__c) EscalARentIA,  ' +
							'Sum(CancelARentNOA__c) CancelARentNOA, Sum(CancelARentIA__c) CancelARentIA,  ' +
							'Sum(ExpanARentNOA__c) ExpanARentNOA, Sum(ExpanARentIA__c) ExpanARentIA  ' +
							'From Glxy_LeaseProjects__c  ' +
							'Where ProcessedDateFY__c = :strFiscalYear  ' +
							'And BDGFlag__c = True  ' +
							'And DelegatedProject__c = False  ' +
							'And ProjectStatus__c != \'Cancelled\'  ';
							
		If (strRegion != 'CO'){
			strSOQL = strSOQL + 'And RegionCd__c = :strRegion  ';
		}
		
		strSOQL = strSOQL + 'Group By BDGFlag__c '; // The group by Budget flag is to allow us to sum the aggregates. Group by FISCAL_YEAR is not relaible SF function, as it return 1 year less than actual.
							
		System.debug('MyDebug = ' + strSOQL);
        AggregateResult[] AgR = Database.Query(strSOQL);
        
		for (AggregateResult RowData : AgR) { 
			RentIncreaseNOAAmount = Decimal.ValueOf(String.valueOf(RowData.get('EscalPYCostNOA')));
			RentIncreaseNOASqFt = Decimal.ValueOf(String.valueOf(RowData.get('EscalSqFtNOA')));
			CancellationsNOAAmount = Decimal.ValueOf(String.valueOf(RowData.get('CancelPYCostNOA')));
			CancellationsNOASqFt = Decimal.ValueOf(String.valueOf(RowData.get('CancelSqFtNOA')));
			ExpansionNOAAmount = Decimal.ValueOf(String.valueOf(RowData.get('ExpanPYCostNOA')));
			ExpansionNOASqFt = Decimal.ValueOf(String.valueOf(RowData.get('ExpanSqFtNOA')));
			
			RentIncreaseIAAmount = Decimal.ValueOf(String.valueOf(RowData.get('EscalPYCostIA')));
			RentIncreaseIASqFt = Decimal.ValueOf(String.valueOf(RowData.get('EscalSqFtIA')));
			CancellationsIAAmount = Decimal.ValueOf(String.valueOf(RowData.get('CancelPYCostIA')));
			CancellationsIASqFt = Decimal.ValueOf(String.valueOf(RowData.get('CancelSqFtIA')));
			ExpansionIAAmount = Decimal.ValueOf(String.valueOf(RowData.get('ExpanPYCostIA')));
			ExpansionIASqFt = Decimal.ValueOf(String.valueOf(RowData.get('ExpanSqFtIA')));
			
			MFAnnualRentIncreaseAmount = (Decimal.ValueOf(String.valueOf(RowData.get('EscalARentNOA'))) - Decimal.ValueOf(String.valueOf(RowData.get('EscalPYCostNOA')))) + (Decimal.ValueOf(String.valueOf(RowData.get('EscalARentIA'))) - Decimal.ValueOf(String.valueOf(RowData.get('EscalPYCostIA'))));
			MFAnnualCancellationsAmount = (Decimal.ValueOf(String.valueOf(RowData.get('CancelARentNOA'))) - Decimal.ValueOf(String.valueOf(RowData.get('CancelPYCostNOA')))) + (Decimal.ValueOf(String.valueOf(RowData.get('CancelARentIA'))) - Decimal.ValueOf(String.valueOf(RowData.get('CancelPYCostIA'))));
			MFAnnualExpansionNOAAmount = Decimal.ValueOf(String.valueOf(RowData.get('ExpanARentNOA'))) - Decimal.ValueOf(String.valueOf(RowData.get('ExpanPYCostNOA')));
			MFAnnualExpansionIAAmount = Decimal.ValueOf(String.valueOf(RowData.get('ExpanARentIA'))) - Decimal.ValueOf(String.valueOf(RowData.get('ExpanPYCostIA')));
        }
        
	}
	
	Private void subLoadLumpSumNumbers(String strFiscalYear, String strRegion){
		
		String strSOQL;
		strSOQL = 'Select  Sum(FY_Obligation_NOA__c) LumpSumNOA, Sum(FY_Obligation_IA__c) LumpSumIA ' +
							'From Glxy_LumpSumObligations__c  ' +
							'Where FiscalYear__c = :strFiscalYear  ' +
							'And LumpSum__r.BDGFlag__c = True  ' +
							'And LumpSum__r.LeaseNumber__r.DelegatedLease__c = False  ' ;
							
		If (strRegion != 'CO'){
			strSOQL = strSOQL + 'And LumpSum__r.RegionCD__c = :strRegion  ';
		}
		
		strSOQL = strSOQL + 'Group By LumpSum__r.BDGFlag__c '; // The group by Budget flag is to allow us to sum the aggregates. Group by FISCAL_YEAR is not relaible SF function, as it return 1 year less than actual.
							
		System.debug('MyDebug = ' + strSOQL);
        AggregateResult[] AgR = Database.Query(strSOQL);
        
		for (AggregateResult RowData : AgR) { 
			LumpSumNOAAmount = Decimal.ValueOf(String.valueOf(RowData.get('LumpSumNOA')));
			LumpSumIAAmount = Decimal.ValueOf(String.valueOf(RowData.get('LumpSumIA')));
			MFAnnualLumpSumAmount = 0 - (Decimal.ValueOf(String.valueOf(RowData.get('LumpSumNOA'))) + Decimal.ValueOf(String.valueOf(RowData.get('LumpSumIA'))));
        }

	}
	
	Private void subLoadIANumbers(integer intColumnIdentifier){
		
		if (intColumnIdentifier == 1){
			IASqFt = CJIASqFt + AnnualExpansionIASqFt + ExpansionIASqFt; 
			IAObligations = CJIAObligations + AnnualExpansionIAAmount + ExpansionIAAmount; 
			IAObligationsMinus = CJIAObligationsMinus + AnnualExpansionIAAmount + ExpansionIAAmount; 
		} else {
			IASqFt = MFIASqFt + AnnualExpansionIASqFt + ExpansionIASqFt; 
			IAObligations = MFIAObligations + AnnualExpansionIAAmount + ExpansionIAAmount; 
			IAObligationsMinus = MFIAObligationsMinus + AnnualExpansionIAAmount + ExpansionIAAmount; 
		}
		
		MFIASqFt = IASqFt;
		MFIAObligations = IAObligations;
		MFIAObligationsMinus = IAObligationsMinus;
		
		//Row 10:  We could take row 21 and subtract row 16. Email Date: 01/31/2014
		IAToNOASqFt = IASqFt - ExpansionIASqft;
		IAToNOAAmount = IAObligations - ExpansionIAAmount;
	}

}